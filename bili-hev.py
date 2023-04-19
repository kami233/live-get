import requests
import json
import time
import re
import os
import subprocess

url = input("请输入视频链接或BV号：")
if 'BV' not in url:
    bvMatch = re.findall(r'BV\w+', url)
    if not bvMatch:
        print("当前页面不是B站视频页面！")
        exit()
    bvId = bvMatch[0]
else:
    bvId = url.split('/')[-1]

apiUrl = f'https://api.bilibili.com/x/web-interface/view?bvid={bvId}'
response = requests.get(apiUrl)
data = json.loads(response.text)
cid = data['data']['cid']

headers = {
    "accept": "application/json, text/plain, */*",
    "accept-language": "zh-CN,zh;q=0.9",
    "sec-ch-ua": "\"Chromium\";v=\"106\", \"Google Chrome\";v=\"106\", \"Not;A=Brand\";v=\"99\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"Windows\"",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-site",
    "cookie": "_uuid=B57CD7EF-210FB-F13C-F2109-101013FFAA63E151641infoc;b_lsid=4937D342_187956B2E16;b_nut=1681345761;b_ut=5;bili_jct=cbfb7f7ae64a44018250cf34003739aa;bp_video_offset_1269157638=777265351389872100;bsource=search_google;buvid_fp=0e598ec6ee7a06e9744e6860cfe9f600;buvid_fp_plain=undefined;buvid3=02B06C9D-BEAC-4764-5293-34955D53E02C53542infoc;buvid4=DDDDC97D-C607-F69B-5FFF-12BDF03C967220139-022122814-fsij6J2Zq2mkTn6Ea%2FXX%2BA%3D%3D;CURRENT_FNVAL=4048;CURRENT_PID=452eeff0-d992-11ed-b875-f71a38678038;DedeUserID=1269157638;DedeUserID__ckMd5=c8b88cc3f6c6ea97;FEED_LIVE_VERSION=V8;fingerprint=574a027a5106d694b3e821f885819089;header_theme_version=CLOSE;home_feed_column=5;i-wanna-go-back=-1;innersign=1;LIVE_BUVID=AUTO2316813539787557;nostalgia_conf=-1;rpdid=|(umRYm|)J)~0J'uY)uJ~~R)|;SESSDATA=44c427b3%2C1696897780%2C173ed%2A41;sid=6302ik5l;"
 }

url = f'https://api.bilibili.com/x/player/playurl?cid={cid}&bvid={bvId}&qn=80&type=&otype=json&fourk=1&fnver=0&fnval=16'
response = requests.get(url, headers=headers)
data = json.loads(response.text)

videoUrl = data['data']['dash']['video'][1]['baseUrl']
audioUrl = data['data']['dash']['audio'][1]['baseUrl']

aria2Url = "http://localhost:6800/jsonrpc"
params = {
    "jsonrpc": "2.0",
    "id": str(int(time.time())),
    "method": "aria2.addUri",
    "params": [[f"{videoUrl}"], {
        "referer": "https://www.bilibili.com/",
        "header": "Cookie: %s" % headers.get("cookie")
    }],
}
headers = {
    "Content-Type": "application/json;charset=UTF-8"
}
response = requests.post(aria2Url, headers=headers, data=json.dumps(params))
params = {
    "jsonrpc": "2.0",
    "id": str(int(time.time())),
    "method": "aria2.addUri",
    "params": [[f"{audioUrl}"], {
        "referer": "https://www.bilibili.com/",
        "header": "Cookie: %s" % headers.get("cookie")
    }],
}
response = requests.post(aria2Url, headers=headers, data=json.dumps(params))

if response.ok:
    print("下载任务添加成功")
else:
    print("下载任务添加失败")

# 等待下载完成
while True:
    params = {
        "jsonrpc": "2.0",
        "id": str(int(time.time())),
        "method": "aria2.tellActive",
        "params": [],
    }
    response = requests.post(aria2Url, headers=headers, data=json.dumps(params))
    activeTasks = json.loads(response.text)['result']
    if not activeTasks:
        break
    for task in activeTasks:
        taskId = task['gid']
        params = {
            "jsonrpc": "2.0",
            "id": str(int(time.time())),
            "method": "aria2.tellStatus",
            "params": [taskId, ["status"]],
        }
        response = requests.post(aria2Url, headers=headers, data=json.dumps(params))
        status = json.loads(response.text)['result']['status']
        if status == "error":
            message = json.loads(response.text)['result']['errorMessage']
            print(f"任务{taskId}下载出错，错误信息：{message}")
            exit()
        time.sleep(1)
        
# 获取下载后的视频和音频文件名
video_file_name = ""
audio_file_name = ""
for file in os.listdir("C:\\Users\\Administrator\\Desktop\\temp"):
    if ".m4s" in file:
        if "30077" in file:
            video_file_name = file
        elif "30216" in file:
            audio_file_name = file

# 调用ffmpeg进行音视频合并
currentPath = os.path.dirname(os.path.abspath(__file__))
videoName = os.path.join(currentPath, f'temp\\{video_file_name}')
audioName = os.path.join(currentPath, f'temp\\{audio_file_name}')
outputFile = os.path.join(currentPath, f'{bvId}.mp4')
subprocess.run(f'ffmpeg -i "{videoName}" -i "{audioName}" -c:v copy -c:a copy "{outputFile}"', shell=True)

# 删除临时文件
os.remove(videoName)
os.remove(audioName)

print("下载完成并合并成功！")
