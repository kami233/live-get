import re
import subprocess
import requests
from datetime import datetime

room_id = input("Enter the room:")

headers = {
    "authority": "live.douyin.com",
    "method": "GET",
    "path": "/{room_id}",
    "scheme": "https",
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "accept-encoding": "text/plain;charset=UTF-8",
    "accept-language": "zh-CN,zh;q=0.9",
    "cache-control": "no-cache",
    "pragma": "no-cache",
    "referer": "https://live.douyin.com/{room_id}",
    "sec-ch-ua": '"Chromium";v="106", "Google Chrome";v="106", "Not;A=Brand";v="99"',
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "Windows",
    "sec-fetch-dest": "document",
    "sec-fetch-mode": "navigate",
    "sec-fetch-site": "same-origin",
    "sec-fetch-user": "?1",
    "upgrade-insecure-requests": "1",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36",
}

cookies = {
	"ttwid": "1%7CYdGCFksWiVLlu_mPRaMPB-q7R-rBMnL5n14503SPzAg%7C1681346146%7C0657f07fc89bb4eb7945fdf81c9d28e9f76240f2aa7ed4c5af5e26eb49cab011",
	"passport_csrf_token": "766fd2e8a3261a01a39b20ca82113980",
	"passport_csrf_token_default": "766fd2e8a3261a01a39b20ca82113980",
	"d_ticket": "c807b5bd142ad6455d69cc167106eee671819",
	"passport_assist_user": "CkGf46bT66ltj6z6YBWICYIt_CZwdBudwQEI_kAmNwqSo5clsIH-dwC6K7n7PAF3G-upWv3_0vI74Ubht-VrSiX8FBpICjwcPXuJebkIhAgg_fMqcQqrgl9GDR2GPHUFmq2onon1TsLtIE00PZi3GsmE7NrnqFzI-FRa3t1qXcwHc7UQpquuDRiJr9ZUIgED8hAmig%3D%3D",
	"n_mh": "AXaHxMwpGrgcSDs9lLcMNCtNH2gYFoo_IeeeK5SPKL4",
	"sso_auth_status": "e857684dc555e125972e06e4f9a4a977",
	"sso_auth_status_ss": "e857684dc555e125972e06e4f9a4a977",
	"sso_uid_tt": "6e88f79d1af951e6c82f3a2a46d60661",
	"sso_uid_tt_ss": "6e88f79d1af951e6c82f3a2a46d60661",
	"toutiao_sso_user": "31f697173621255d98444078832976a4",
	"toutiao_sso_user_ss": "31f697173621255d98444078832976a4",
	"sid_ucp_sso_v1": "1.0.0-KDhhMDMwMDNiZjU1MGE5NDFhMDAyYzk2ODdkMTJhZjNlNzU3YTk5YjYKHwjbgPC704zvBBCWnd2hBhjvMSAMMNfwzZoGOAJA8QcaAmxmIiAzMWY2OTcxNzM2MjEyNTVkOTg0NDQwNzg4MzI5NzZhNA",
	"ssid_ucp_sso_v1": "1.0.0-KDhhMDMwMDNiZjU1MGE5NDFhMDAyYzk2ODdkMTJhZjNlNzU3YTk5YjYKHwjbgPC704zvBBCWnd2hBhjvMSAMMNfwzZoGOAJA8QcaAmxmIiAzMWY2OTcxNzM2MjEyNTVkOTg0NDQwNzg4MzI5NzZhNA",
	"passport_auth_status": "a947abc391e70fb78adc69bba5787084%2Cd08fabd27a14e6cfa5a0ddbc1eac5035",
	"passport_auth_status_ss": "a947abc391e70fb78adc69bba5787084%2Cd08fabd27a14e6cfa5a0ddbc1eac5035",
	"uid_tt": "eece2d2aa4329ba00cdd75b512615a15",
	"uid_tt_ss": "eece2d2aa4329ba00cdd75b512615a15",
	"sid_tt": "01101e245a2381199abb7185748ef855",
	"sessionid": "01101e245a2381199abb7185748ef855",
	"sessionid_ss": "01101e245a2381199abb7185748ef855",
	"LOGIN_STATUS": "1",
	"store-region": "cn-gx",
	"store-region-src": "uid",
	"sid_guard": "01101e245a2381199abb7185748ef855%7C1681346203%7C5183997%7CMon%2C+12-Jun-2023+00%3A36%3A40+GMT",
	"sid_ucp_v1": "1.0.0-KGMwZmJkZDg3OTc4ODgzMzkxNmNmOTI3MjMzOGI1Njg4YzA1NDgxZWIKGwjbgPC704zvBBCbnd2hBhjvMSAMOAJA8QdIBBoCaGwiIDAxMTAxZTI0NWEyMzgxMTk5YWJiNzE4NTc0OGVmODU1",
	"ssid_ucp_v1": "1.0.0-KGMwZmJkZDg3OTc4ODgzMzkxNmNmOTI3MjMzOGI1Njg4YzA1NDgxZWIKGwjbgPC704zvBBCbnd2hBhjvMSAMOAJA8QdIBBoCaGwiIDAxMTAxZTI0NWEyMzgxMTk5YWJiNzE4NTc0OGVmODU1",
	"pwa2": "%220%7C1%22",
	"my_rd": "1",
	"download_guide": "%223%2F20230421%22",
	"SEARCH_RESULT_LIST_TYPE": "%22single%22",
	"FOLLOW_LIVE_POINT_INFO": "%22MS4wLjABAAAAZ7OmBHdPs1PWYJyKXs0tIXoipXJpINut9xjwmkrovbDuXJN42Hy9af0EhfFnzr49%2F1682179200000%2F0%2F1682169540468%2F0%22",
	"strategyABtestKey": "%221682571304.684%22",
	"FOLLOW_NUMBER_YELLOW_POINT_INFO": "%22MS4wLjABAAAAZ7OmBHdPs1PWYJyKXs0tIXoipXJpINut9xjwmkrovbDuXJN42Hy9af0EhfFnzr49%2F1682611200000%2F1682571309302%2F1682571305361%2F0%22",
	"publish_badge_show_info": "%221%2C0%2C0%2C1682571310671%22",
	"VIDEO_FILTER_MEMO_SELECT": "%7B%22expireTime%22%3A1683176881558%2C%22type%22%3A0%7D",
	"odin_tt": "e358ef25bd19cd6d41c17dbd83adb460c997604be5ae96f8d9418919b3efe1e83af6fed20905d49a9211a710c6efd508",
	"device_web_cpu_core": "4",
	"device_web_memory_size": "8",
	"csrf_session_id": "7a425075d921605adceee1d9b60b552a",
	"webcast_local_quality": "origin",
	"xgplayer_user_id": "440566915584",
	"passport_fe_beating_status": "true",
	"home_can_add_dy_2_desktop": "%221%22",
	"__live_version__": "%221.1.0.9036%22",
	"live_can_add_dy_2_desktop": "%220%22",
	"__ac_nonce": "0644a366c007701b9f30d",
	"__ac_signature": "_02B4Z6wo00f01viYEhAAAIDDm5LSeD7fcpL4uBaAANp5vgPZ4kvID0tCFTvDoh0URodpZBvUi19il7Wj5zoLDlBmbD-9n1Q2yZGKNRdzekLhwDOnt3d.cG7fPKyp0I28uZB8dax2IjQ0rtMB2c",
	"webcast_leading_last_show_time": "1682585207858",
	"webcast_leading_total_show_times": "1",
	"msToken": "OWTnLWZCnBBLvoTbzzKecFT0z9haO4QcjksmYnDHHKyOjYla1f7qusrcs_TFqhyj2mYY-gi-2G4p7F9yXwvk_OPWepfWtGIiEyY6sWECtaP21oKF2fwChQ==",
	"msToken": "sgB7qgEYrtFfqHAyX8DJ_7UcONUDtU0-E08-mfARSg8NYR4bicql9H3ie2tB0FPrtXzNkG2iboXA_sU6-vXRPlLDZgu02VPQ5UiEZWgYskjUUIuM_pPuGw==",
	"tt_scid": "KPFKg6hWjr1pCaXUX1RdvBjhhRXnIYD3jrWyBBcUORY-OiuVVOaSDoYhgQlOYFHV82cf"
}

response = requests.get(f"https://live.douyin.com/{room_id}", headers=headers, cookies=cookies)
content = response.text
content = requests.utils.unquote(content)

regex = r'"origin":{"main":{"flv":"(https?://[^"]+)","hls"'
matches = re.findall(regex, content)

if len(matches) >= 2:
    link = matches[1]
    # print(link)

file_name = f"{room_id}_{datetime.now().strftime('%Y-%m-%d %H_%M')}.flv"
command = f'aria2c --referer=https://www.douyin.com/ -o "{file_name}" "{link}"'
subprocess.call(command, shell=True)
