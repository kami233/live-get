const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

async function fetchData() {
  try {   
    const response = await fetch('https://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=4ca11037d86f4131b46e0b5e1b15bd74&client=flash&im=0&tsp=1679475979&vn=2049&vc=C5EF012BF28EA7FB86FB4DE2CB2B95D0&uid=8E131D27B470F9CD737B936398E59547&wlan=');
    if (!response.ok) {
      throw new Error('Network response was not ok.');
    }
    const data = await response.json();
    return data.video.chapters4.sort((a, b) => a.seq - b.seq).map(item => item.url); // ����������򲢷�����Ƶ��ַ
  } catch (error) {
    console.error('There has been a problem with your fetch operation:', error);
  }
}

async function downloadVideos() {
  const videos = await fetchData();
  console.log(videos); // ��ӡ������Ƶ��ַ

  const videoNames = []; // ��¼��Ƶ��
  // ������������
  const command = 'aria2c';
  const options = [
    '-d', 'C:/Users/Administrator/Desktop/temp', // ����Ŀ¼
    '-x4', '-s4', // ���߳�����
  ];

  const downloadTasks = videos.map((video, index) => { // ��¼��Ƶ��������
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

  await Promise.all(downloadTasks); // �ȴ�������Ƶ�������
  videoNames.sort(); // ������������

  await mergeFiles(videoNames, 'C:/Users/Administrator/Desktop/temp'); // ���úϲ�����
}


function mergeFiles(videoNames, dir) {
  const outputFile = 'output.mp4'; // �ϲ�������ļ���·��

  const sortedFiles = videoNames.sort((a, b) => { // �������ִ�С���򣬲���ȫǰ��0
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

  const files = sortedFiles.map((name) => { // ֻ�����ļ�����
    return name;
  });

  // ���ļ�����д�뵽input.txt�ļ���
  const inputTxt = files.map((file) => {
    return `file '${file.replace(/\\/g, '/')}'`; // ƴ�����·��
  }).join('\n');

  const inputTxtPath = './Desktop/temp/input.txt';
  fs.writeFileSync(inputTxtPath, inputTxt);

  // ʹ��ffmpeg�ϲ��ļ�
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
