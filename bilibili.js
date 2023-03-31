javascript: (() => {
  const currentUrl = window.location.href;
  const bvReg = /BV\w+/;
  const bvMatch = currentUrl.match(bvReg);
  if (!bvMatch) {
    alert("当前页面不是B站视频页面！");
    return;
  }
  const bvId = bvMatch[0];
  const apiUrl = `https://api.bilibili.com/x/web-interface/view?bvid=${bvId}`;
  fetch(apiUrl)
    .then(response => response.json())
    .then(data => {
      const cid = data.data.cid;
      const url = `https://api.bilibili.com/x/player/playurl?cid=${cid}&bvid=${bvId}&qn=80&type=&otype=json&fourk=1&fnver=0&fnval=16`;
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const videoUrl = data.data.dash.video.map(({baseUrl}) => `"${baseUrl}"`).join(",");
          const audioUrl = data.data.dash.audio.map(({baseUrl}) => `"${baseUrl}"`).join(",");
          navigator.clipboard.writeText(`[${videoUrl}], [${audioUrl}]`);
        });
    });
})();


javascript: (() => {
  const currentUrl = window.location.href;
  const bvReg = /BV\w+/;
  const bvMatch = currentUrl.match(bvReg);
  if (!bvMatch) {
    alert("当前页面不是B站视频页面！");
    return;
  }
  const bvId = bvMatch[0];
  const apiUrl = `https://api.bilibili.com/x/web-interface/view?bvid=${bvId}`;
  fetch(apiUrl)
    .then(response => response.json())
    .then(data => {
      const cid = data.data.cid;
      const url = `https://api.bilibili.com/x/player/playurl?cid=${cid}&bvid=${bvId}&qn=80&type=&otype=json&fourk=1&fnver=0&fnval=16`;
      fetch(url)
        .then(response => response.json())
        .then(data => {
          const videoUrl = `"${data.data.dash.video[0].baseUrl}"`;
          const audioUrl = `"${data.data.dash.audio[0].baseUrl}"`;
          navigator.clipboard.writeText(`${videoUrl}, ${audioUrl}`);
        });
    });
})();



javascript: (()=>{
    const currentUrl = window.location.href;
    const bvReg = /BV\w+/;
    const bvMatch = currentUrl.match(bvReg);
    if (!bvMatch) {
        alert("当前页面不是B站视频页面！");
        return;
    }
    const bvId = bvMatch[0];
    const apiUrl = `https://api.bilibili.com/x/web-interface/view?bvid=${bvId}`;
    fetch(apiUrl).then(response=>response.json()).then(data=>{
        const cid = data.data.cid;
        const url = `https://api.bilibili.com/x/player/playurl?cid=${cid}&bvid=${bvId}&qn=80&type=&otype=json&fourk=1&fnver=0&fnval=16`;
        fetch(url).then(response=>response.json()).then(data=>{
            const videoUrl = data.data.dash.video[1].baseUrl;
            const audioUrl = data.data.dash.audio[1].baseUrl;
            const aria2Url = "http://localhost:6800/jsonrpc";
            const params = {
                jsonrpc: "2.0",
                id: new Date().getTime(),
                method: "aria2.addUri",
                params: [[`${videoUrl}`], {
                    "referer": "https://www.bilibili.com/"
                }],
            };
            fetch(aria2Url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json;charset=UTF-8"
                },
                body: JSON.stringify(params)
            }).then(()=>{
                const params = {
                    jsonrpc: "2.0",
                    id: new Date().getTime(),
                    method: "aria2.addUri",
                    params: [[`${audioUrl}`], {
                        "referer": "https://www.bilibili.com/"
                    }],
                };
                fetch(aria2Url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json;charset=UTF-8"
                    },
                    body: JSON.stringify(params)
                }).then((response)=>{
                    if (response.ok) {
                        console.log("下载任务添加成功");
                    } else {
                        console.log("下载任务添加失败");
                    }
                }
                );
            }
            );

        }
        );
    }
    );
}
)();




javascript: (()=>{
    const currentUrl = window.location.href;
    const bvReg = /BV\w+/;
    const bvMatch = currentUrl.match(bvReg);
    if (!bvMatch) {
        alert("当前页面不是B站视频页面！");
        return;
    }
    const bvId = bvMatch[0];
    const apiUrl = `https://api.bilibili.com/x/web-interface/view?bvid=${bvId}`;
    fetch(apiUrl).then(response=>response.json()).then(data=>{
        const cid = data.data.cid;
        const url = `https://api.bilibili.com/x/player/playurl?cid=${cid}&bvid=${bvId}&qn=80&type=&otype=json&fourk=1&fnver=0&fnval=16`;
        const headers = {
            "accept": "application/json, text/plain, */*",
            "accept-language": "zh-CN,zh;q=0.9",
            "sec-ch-ua": "\"Chromium\";v=\"106\", \"Google Chrome\";v=\"106\", \"Not;A=Brand\";v=\"99\"",
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": "\"Windows\"",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-site"
        };
        const options = {
            method: 'GET',
            headers: headers,
            mode: 'cors',
            credentials: 'include'
        };
        fetch(url, options).then(response=>response.json()).then(data=>{
            const videoUrl = data.data.dash.video[1].baseUrl;
            const audioUrl = data.data.dash.audio[1].baseUrl;
            const aria2Url = "http://localhost:6800/jsonrpc";
            const params = {
                jsonrpc: "2.0",
                id: new Date().getTime(),
                method: "aria2.addUri",
                params: [[`${videoUrl}`], {
                    "referer": "https://www.bilibili.com/"
                }],
            };
            fetch(aria2Url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json;charset=UTF-8"
                },
                body: JSON.stringify(params)
            }).then(()=>{
                const params = {
                    jsonrpc: "2.0",
                    id: new Date().getTime(),
                    method: "aria2.addUri",
                    params: [[`${audioUrl}`], {
                        "referer": "https://www.bilibili.com/"
                    }],
                };
                fetch(aria2Url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json;charset=UTF-8"
                    },
                    body: JSON.stringify(params)
                }).then((response)=>{
                    if (response.ok) {
                        console.log("下载任务添加成功");
                    } else {
                        console.log("下载任务添加失败");
                    }
                });
            });

        });
    });
})();
