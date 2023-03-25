const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

async function fetchData() {
  const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
  });

  return new Promise((resolve, reject) => {
    readline.question('Enter the link:', async (url) => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok.');
        }
        const data = await response.json();
        resolve(data.video.chapters4.sort((a, b) => a.seq - b.seq).map(item => item.url)); // 按照序号排序并返回视频地址
      } catch (error) {
        console.error('There has been a problem with your fetch operation:', error);
        reject(error);
      } finally {
        readline.close();
      }
    });
  });
}

async function downloadVideos() {
  const tempFolderPath = 'C:/Users/Administrator/Desktop/temp';
  if (!fs.existsSync(tempFolderPath)) { // 检查目录是否存在
    fs.mkdirSync(tempFolderPath); // 如果不存在则创建目录
  }

  const videos = await fetchData();
  console.log(videos); // 打印所有视频地址

  const videoNames = []; // 记录视频名
  // 创建下载任务
  const command = 'aria2c';
  const options = [
    '-d', 'C:/Users/Administrator/Desktop/temp', // 下载目录
    '-x4', '-s4', // 多线程下载
  ];

  const downloadTasks = videos.map((video, index) => { // 记录视频名并排序
    const videoName = `video-${index + 1}.mp4`;
    videoNames.push(videoName);
    const args = options.concat('-o', videoName, video);
    const child = spawn(command, args);

    child.stdout.on('data', (data) => {
      console.log(`stdout: ${data}`);
    });

    child.stderr.on('data', (data) => {
      console.error(`stderr: ${data}`);
    });

    return new Promise(resolve => {
      child.on('close', (code) => {
        console.log(`child process exited with code ${code}`);
        resolve();
      });
    });
  });

  await Promise.all(downloadTasks); // 等待所有视频下载完成
  videoNames.sort(); // 按照名称排序

  await mergeFiles(videoNames, 'C:/Users/Administrator/Desktop/temp'); // 调用合并函数
}


function mergeFiles(videoNames, dir) {
  const outputFile = 'output.mp4'; // 合并后输出文件的路径

  const sortedFiles = videoNames.sort((a, b) => { // 根据数字大小排序，并补全前导0
    const regex = /(\d+)/;
    const aMatch = a.match(regex);
    const bMatch = b.match(regex);
    if (aMatch === null || bMatch === null) {
      return 0;
    } else {
      const aNum = parseInt(aMatch[1]).toString().padStart(6, '0');
      const bNum = parseInt(bMatch[1]).toString().padStart(6, '0');
      return aNum.localeCompare(bNum);
    }
  });

  const files = sortedFiles.map((name) => { // 只返回文件名称
    return name;
  });

  // 将文件名称写入到input.txt文件中
  const inputTxt = files.map((file) => {
    return `file '${file.replace(/\\/g, '/')}'`; // 拼接相对路径
  }).join('\n');

  const inputTxtPath = 'C:/Users/Administrator/Desktop/temp/input.txt';
  fs.writeFileSync(inputTxtPath, inputTxt);

  // 使用ffmpeg合并文件
  const command = 'ffmpeg';
  const args = [
    '-f', 'concat',
    '-safe', '0',
    '-i', inputTxtPath,
    '-c', 'copy',
    path.join(dir, outputFile),
  ];

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
}



downloadVideos();
