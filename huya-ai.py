import requests
import json
import subprocess
from datetime import datetime
import re

room_id = input("请输入房间号：")
headers = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Cache-Control": "no-cache",
    "Pragma": "no-cache",
    "Referer": "https://www.huya.com/g/bns",
    "Sec-Fetch-Dest": "document",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Site": "same-origin",
    "Sec-Fetch-User": "?1",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36",
}
cookies = {
    "game_did": "K8ud7UwLuH4r7qhTGM7yofaZczR4-4psO7j",
    "guid": "0a70e9d288bc276458014a674b67a280",
    "__yasmid": "0.02692243323934962",
    "__yamid_tt1": "0.02692243323934962",
    "__yamid_new": "CA3A3EB63D10000191E07AC01D90E510",
    "_yasids": "__rootsid%3DCA3A3EB63DA0000119A41E701ED7CA80",
    "udb_passdata": "3",
    "SoundValue": "0.50",
    "alphaValue": "0.80",
    "isInLiveRoom": "true",
    "huya_ua": "webh5&0.0.1&websocket",
    "huya_flash_rep_cnt": "65",
    "rep_cnt": "38",
    "huya_web_rep_cnt": "6116"
}
session = requests.Session()
session.headers.update(headers)
session.cookies.update(cookies)

response = session.get(f"https://www.huya.com/{room_id}")
content = response.text

json_start = content.find("var hyPlayerConfig = {")
json_end = content.find("};", json_start) + 1
json_length = json_end - json_start
data = content[json_start:json_end]

# 使用异常处理来避免因为找不到匹配结果而导致程序出错
try:
    # 获取sFlvUrlSuffix、sFlvAntiCode和sStreamName的值
    pattern = r'"sStreamName":"(.*?)".*?"sFlvUrlSuffix":"(\w+)","sFlvAntiCode":"(wsSecret=[^"]+)"'
    match = re.search(pattern, data)
    suffix = match.group(2)
    anti_code = match.group(3)
    stream_name = match.group(1)

    # 获取域名
    pattern = r'"sFlvUrl":"(.*?)"'
    match = re.search(pattern, data)
    domain = match.group(1)

    # 组合URL并输出
    url = f"{domain}/{stream_name}.{suffix}?{anti_code}"
    now = datetime.now().strftime('%Y-%m-%d %H_%M')
    filename = f"{room_id}_{now}.flv"
    print(filename)
    cmd = f'aria2c -o "{filename}" "{url}" --referer=https://www.huya.com/'
    subprocess.call(cmd, shell=True)
except AttributeError:
    print("Cannot find matching results.")
