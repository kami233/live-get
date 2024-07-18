// ==UserScript==
// @name         Douyu Stream Downloader
// @namespace    http://tampermonkey.net/
// @version      2.1
// @description  Copies the value of 'S' from the specified line in the Douyu player script.
// @author       You
// @match        https://www.douyu.com/topic/qrsj*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Use window instead of unsafeWindow
    const win = typeof unsafeWindow !== 'undefined' ? unsafeWindow : window;

    let sValue = '';
    let fValue = '';

    // Function to handle S and f values
    function handleValues(s, f) {
        sValue = s;
        fValue = f;
        console.log("S value:", s);
        console.log("f value (Room ID):", f);

        // Parse S value
        let sParts = Object.fromEntries(s.split('&').map(item => item.split('=')));

        // Construct request data
        let data = {
            v: sParts.v,
            did: sParts.did,
            tt: sParts.tt,
            sign: sParts.sign,
            cdn: "",
            rate: "-1",
            ver: "Douyu_224071505",
            iar: "1",
            ive: "0",
            hevc: "1",
            fa: "0"
        };

        // Make request to get stream URL
        fetch(`https://www.douyu.com/lapi/live/getH5Play/${f}`, {
            method: 'POST',
            headers: {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
                'Content-Type': 'application/x-www-form-urlencoded',
                'Origin': 'https://www.douyu.com',
                'Referer': `https://www.douyu.com/${f}`
            },
            body: new URLSearchParams(data)
        })
        .then(response => response.json())
        .then(content => {
            let rtmpUrl = content.data.rtmp_url;
            let rtmpLive = content.data.rtmp_live;
            let url = `${rtmpUrl}/${rtmpLive}`;
            console.log("Stream URL:", url);

            // Download using aria2 via WebSocket
            const ws = new WebSocket('ws://localhost:6800/jsonrpc');
            ws.onopen = () => {
                const headers = [
                    'Accept: */*',
                    'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8',
                    'Connection: keep-alive',
                    'Origin: https://www.douyu.com',
                    'Referer: https://www.douyu.com/',
                    'Sec-Fetch-Dest: empty',
                    'Sec-Fetch-Mode: cors',
                    'Sec-Fetch-Site: cross-site',
                    'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
                    'sec-ch-ua: "Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
                    'sec-ch-ua-mobile: ?0',
                    'sec-ch-ua-platform: "Windows"'
                ];

                const filename = `${f}_${new Date().toISOString().replace(/[:.]/g, '-')}.flv`;

                const message = {
                    jsonrpc: '2.0',
                    id: 'douyu',
                    method: 'aria2.addUri',
                    params: [[url], {
                        out: filename,
                        header: headers
                    }]
                };

                ws.send(JSON.stringify(message));
            };

            ws.onmessage = (event) => {
                console.log('Aria2 response:', event.data);
                ws.close();
            };
        });
    }

    // Function to intercept ub98484234
	function interceptUb98484234() {
		if (typeof win.ub98484234 !== 'function' || typeof win._ === 'undefined') {
			setTimeout(interceptUb98484234, 100);
			return;
		}

		const originalUb98484234 = win.ub98484234;
		win.ub98484234 = function(f, m, y) {
			const result = originalUb98484234.apply(this, arguments);
			// 使用传入的 f 参数，而不是尝试从 $ROOM 获取
			handleValues(result, f);
			return result;
		};

		// 尝试直接获取 f 值
		const f = win._.i(["app", "rid"]);
		if (f) {
			console.log("Initial f value:", f);
		}
	}

    // Start interception
    interceptUb98484234();

    // Intercept XMLHttpRequest
    const originalXHR = win.XMLHttpRequest;
    win.XMLHttpRequest = function() {
        const xhr = new originalXHR();
        const originalOpen = xhr.open;

        xhr.open = function() {
            const url = arguments[1];
            if (url.includes('h5_video_58347d8.js')) {
                const originalSend = xhr.send;
                xhr.send = function() {
                    const originalOnLoad = xhr.onload;
                    xhr.onload = function() {
                        if (originalOnLoad) {
                            originalOnLoad.apply(this, arguments);
                        }
                    };
                    originalSend.apply(this, arguments);
                };
            }
            originalOpen.apply(this, arguments);
        };

        return xhr;
    };

    // Rewrite fetch method
    const originalFetch = win.fetch;
    win.fetch = function(input, init) {
        if (typeof input === 'string' && input.includes('h5_video_58347d8.js')) {
            return originalFetch(input, init);
        }
        return originalFetch(input, init);
    };
})();