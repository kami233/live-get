fetch('https://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=4ca11037d86f4131b46e0b5e1b15bd74&client=flash&im=0&tsp=1679475979&vn=2049&vc=C5EF012BF28EA7FB86FB4DE2CB2B95D0&uid=8E131D27B470F9CD737B936398E59547&wlan=')
  .then(response => {
    if (response.ok) {
      return response.json(); // 解析 JSON 类型的响应体
    }
    throw new Error('Network response was not ok.');
  })
  .then(data => {
    const videos = data.video.chapters4.map(item => item.url); // 获取所有分段视频的地址
    console.log(videos); // 打印所有视频地址
    
    // 创建一个 WebSocket 对象，用于与 Aria2 服务器通信
    const ws = new WebSocket('ws://localhost:6800/jsonrpc');
    
    // 发送请求，添加下载任务
    ws.onopen = function() {
      videos.forEach(url => {
        ws.send(`{
          "jsonrpc": "2.0",
          "method": "aria2.addUri",
          "id": "1",
          "params": [
            ["${url}"]
          ]
        }`);
      });
    };
    
    // 监听服务端返回的消息
    ws.onmessage = function(event) {
      console.log(event.data);
    };
  })
  .catch(error => {
    console.error('There has been a problem with your fetch operation:', error);
  });
