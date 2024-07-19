import requests
import json
import subprocess
from datetime import datetime
import pyperclip

# 从剪贴板获取数据
clipboard_data = pyperclip.paste().split('\n')
room_id = clipboard_data[0]
s_value = clipboard_data[1]

# 解析 S 值
s_parts = dict(item.split("=") for item in s_value.split("&"))

# 设置请求头
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
    "authority": "www.douyu.com",
    "accept": "application/json, text/plain, */*",
    "accept-encoding": "gzip, deflate, br, zstd",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8",
    "origin": "https://www.douyu.com",
    "referer": f"https://www.douyu.com/topic/qrsj?rid={room_id}&dyshid=0-a069867836ce83eddbaceff600051501",
    "sec-ch-ua": '"Google Chrome";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": '"Windows"',
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-origin",
    "x-requested-with": "XMLHttpRequest"
}

# 设置 cookies
cookies = {
    "dy_did": s_parts["did"],
    "acf_ssid": "1729707712355189079",
    "acf_web_id": "7380507939301242639",
    "acf_ab_pmt": "1479#cover_select_web#B",
    "acf_ab_ver_all": "1479",
    "acf_ab_vs": "cover_select_web%3DB",
    "acf_did": s_parts["did"]
}

# 设置请求体
data = {
    "v": s_parts["v"],
    "did": s_parts["did"],
    "tt": s_parts["tt"],
    "sign": s_parts["sign"],
    "cdn": "",
    "rate": "-1",
    "ver": "Douyu_224071505",
    "iar": "1",
    "ive": "0",
    "hevc": "1",
    "fa": "0"
}

# 发送请求
response = requests.post(f"https://www.douyu.com/lapi/live/getH5Play/{room_id}", 
                         headers=headers, 
                         cookies=cookies, 
                         data=data)

# 解析响应
content = response.json()

# 提取 URL
rtmp_url = content['data']['rtmp_url']
rtmp_live = content['data']['rtmp_live']
url = f"{rtmp_url}/{rtmp_live}"

# 打印 URL（可选）
print(f"Stream URL: {url}")

# 使用 ffmpeg 下载流
current_time = datetime.now().strftime("%Y-%m-%d_%H%M")
output_filename = f"{room_id}_{current_time}.flv"

ffmpeg_command = [
    "ffmpeg",
    "-i", url,
    "-c", "copy",
    "-y",
    output_filename
]

subprocess.run(ffmpeg_command)