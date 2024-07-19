// ==UserScript==
// @name         Douyu Room Info Extractor
// @namespace    http://tampermonkey.net/
// @version      0.3
// @description  Extract room_id and ub98484234 result from Douyu live room
// @match        https://www.douyu.com/*
// @grant        GM_setClipboard
// @grant        unsafeWindow
// ==/UserScript==

(function() {
    'use strict';

    function getRoomId() {
        // 首先尝试从 window.room_id 获取
        if (unsafeWindow.room_id) {
            return unsafeWindow.room_id;
        }

        // 如果 window.room_id 不存在，则尝试从 URL 提取
        const match = window.location.pathname.match(/\/(\d+)(?:r)?/);
        if (match) {
            return match[1];
        }

        // 如果都没有找到，返回 null
        return null;
    }

    function extractInfo() {
        const roomId = getRoomId();
        if (!roomId) {
            alert('Room ID not found. Please make sure you are on a Douyu live room page.');
            return;
        }

        const did = 'a069867836ce83eddbaceff600051501'; // 你可能需要更新这个值
        const timestamp = Math.floor(Date.now() / 1000);

        if (typeof unsafeWindow.ub98484234 !== 'function') {
            alert('ub98484234 function not found. Please wait for the page to fully load and try again.');
            return;
        }

        const result = unsafeWindow.ub98484234(roomId, did, timestamp);
        const output = `${roomId}\n${result}`;
        console.log('Extracted info:', output);
        GM_setClipboard(output, 'text');
        alert('Room ID and S value have been copied to clipboard!');
    }

    function addButton() {
        const button = document.createElement('button');
        button.textContent = 'Extract Room Info';
        button.style.position = 'fixed';
        button.style.top = '10px';
        button.style.right = '10px';
        button.style.zIndex = '9999';
        button.addEventListener('click', extractInfo);
        document.body.appendChild(button);
    }

    // 等待页面加载完成
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', addButton);
    } else {
        addButton();
    }
})();