
const { spawn } = require('child_process');

async function fetchData() {
  try {   
    const response = await fetch('https://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=4ca11037d86f4131b46e0b5e1b15bd74&client=flash&im=0&tsp=1679475979&vn=2049&vc=C5EF012BF28EA7FB86FB4DE2CB2B95D0&uid=8E131D27B470F9CD737B936398E59547&wlan=');
    if (!response.ok) {
      throw new Error('Network response was not ok.');
    }
    const data = await response.json();
    return data.video.chapters4.map(item => item.url);
  } catch (error) {
    console.error('There has been a problem with your fetch operation:', error);
  }
}

async function downloadVideos() {
  const videos = await fetchData();
  console.log(videos); // 打印所有视频地址
    
  // 创建下载任务
  const command = 'aria2c';
  const options = [
    '-d', './Desktop', // 下载目录
    '-x4', '-s4', // 多线程下载
  ];

  videos.forEach((video) => {
    const args = options.concat(video);
    const child = spawn(command, args);

    child.stdout.on('data', (data) => {
      console.log(`stdout: ${data}`);
    });

    child.stderr.on('data', (data) => {
      console.error(`stderr: ${data}`);
    });

    child.on('close', (code) => {
      console.log(`child process exited with code ${code}`);
    });
  });
}

downloadVideos();

