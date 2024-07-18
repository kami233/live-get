// ==UserScript==
// @name         斗鱼直播页面优化 - 增强版
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  优化斗鱼直播页面加载，只加载必要资源
// @match        https://www.douyu.com/topic/qrsj*
// @grant        GM_webRequest
// @webRequest   [{"selector":"https://www.douyu.com/*","action":"allow"}]
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    const allowedPatterns = [
        /^https:\/\/www\.douyu\.com\/topic\/qrsj/,
        /playerSDK-room_[a-f0-9]+\.js/,
        /h5_video_[a-f0-9]+\.js/,
        /shark-file-loader_[a-f0-9]+\.js/,
        /playerInit-room_[a-f0-9]+\.js/,
        /webm-pc-vendor_[a-f0-9]+\.js/,
	/room-webm_[a-f0-9]+\.js/
    ];

    function shouldAllowRequest(details) {
        const url = details.url;
        return allowedPatterns.some(pattern => pattern.test(url));
    }

    GM_webRequest([
        {
            selector: "*",
            action: "cancel",
            onload: false,
            block: !shouldAllowRequest
        }
    ]);

    // 移除已加载的不必要元素
    function removeUnnecessaryElements() {
        const elements = document.querySelectorAll('link[rel="stylesheet"], img, script:not([src*="playerSDK-room_"]):not([src*="h5_video_"])');
        elements.forEach(el => el.remove());
    }

    // 在 DOMContentLoaded 事件后执行清理
    document.addEventListener('DOMContentLoaded', removeUnnecessaryElements);

    // 持续观察 DOM 变化并移除新添加的不必要元素
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.type === 'childList') {
                mutation.addedNodes.forEach((node) => {
                    if (node.nodeName === 'LINK' || node.nodeName === 'IMG' ||
                        (node.nodeName === 'SCRIPT' && node.src &&
                         !allowedPatterns.some(pattern => pattern.test(node.src)))) {
                        node.remove();
                    }
                });
            }
        });
    });

    observer.observe(document.documentElement, { childList: true, subtree: true });
})();
