// ==UserScript==
// @name         Copy S Value from Douyu
// @namespace    http://tampermonkey.net/
// @version      0.3
// @description  Copy the value of S to clipboard when visiting Douyu
// @match        https://www.douyu.com/topic/qrsj*
// @grant        GM_setClipboard
// @grant        unsafeWindow
// ==/UserScript==

(function() {
    'use strict';

    // 创建一个函数来处理 S 值
    function handleSValue(value) {
        console.log("S value:", value);
        if (typeof GM_setClipboard === "function") {
            GM_setClipboard(value);
        }
    }

    // 使用 Proxy 拦截 window.ub98484234 函数
    var originalUb98484234 = unsafeWindow.ub98484234;
    unsafeWindow.ub98484234 = new Proxy(originalUb98484234, {
        apply: function(target, thisArg, argumentsList) {
            var result = target.apply(thisArg, argumentsList);
            handleSValue(result);
            return result;
        }
    });

    // 拦截原始的 XMLHttpRequest
    var originalXHR = unsafeWindow.XMLHttpRequest;

    unsafeWindow.XMLHttpRequest = function() {
        var xhr = new originalXHR();
        var originalOpen = xhr.open;

        xhr.open = function() {
            var url = arguments[1];
            if (url.includes('h5_video_58347d8.js')) {
                var originalSend = xhr.send;
                xhr.send = function() {
                    var originalOnLoad = xhr.onload;
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

    // 重写 fetch 方法
    var originalFetch = unsafeWindow.fetch;
    unsafeWindow.fetch = function(input, init) {
        if (typeof input === 'string' && input.includes('h5_video_58347d8.js')) {
            return originalFetch(input, init);
        }
        return originalFetch(input, init);
    };
})();