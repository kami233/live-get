# 安装Aria2c
# if (!Test-Path $aria2_path) {
    # Write-Host "Installing Aria2c..."
    # Invoke-WebRequest -Uri "https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip" -OutFile "$temp\aria2.zip"
    # Expand-Archive "$temp\aria2.zip" -DestinationPath $aria2_path
    # Remove-Item "$temp\aria2.zip"
# }

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("buvid3", "114055B1-E4AA-64E1-8086-4E2AE7DCC3EB35313infoc", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("b_nut", "1680098635", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("CURRENT_FNVAL", "4048", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_uuid", "11FEEF53-21FF-7A76-3678-EC86BF781096136365infoc", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("CURRENT_PID", "8db29730-ce3a-11ed-b5c9-21a47f794b0e", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("rpdid", "|(J~J)~um)J)0J'uY)||m)YRk", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("fingerprint", "574a027a5106d694b3e821f885819089", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("buvid_fp_plain", "undefined", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("SESSDATA", "e807101e%2C1695650662%2C295ca%2A32", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("bili_jct", "e4696fbade98b95a9595e743c3a5177a", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("DedeUserID", "1269157638", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("DedeUserID__ckMd5", "c8b88cc3f6c6ea97", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("buvid4", "DDDDC97D-C607-F69B-5FFF-12BDF03C967220139-022122814-fsij6J2Zq2mkTn6Ea%2FXX%2BA%3D%3D", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sid", "55xqyv70", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("bsource", "search_google", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("i-wanna-go-back", "-1", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("b_ut", "5", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("header_theme_version", "CLOSE", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("home_feed_column", "5", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("bp_video_offset_1269157638", "777265351389872100", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("nostalgia_conf", "-1", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("LIVE_BUVID", "AUTO8716804204807492", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("buvid_fp", "0e598ec6ee7a06e9744e6860cfe9f600", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("b_lsid", "F438B576_1876F4BB096", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("innersign", "1", "/", ".bilibili.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_dfcaptcha", "4a78657e3ffb54825a11d923a905715b", "/", ".bilibili.com")))

# 输入哔哩哔哩房间号
$room_id = Read-Host "Enter bilibili room id"

# 获取哔哩哔哩API返回的数据
# $url = "https://api.live.bilibili.com/room/v1/Room/playUrl?cid=$room_id&play_url=1&mask=1&qn=0&platform=web"
$url = "https://api.live.bilibili.com/xlive/web-room/v2/index/getRoomPlayInfo?room_id=$room_id&protocol=0,1&format=0,1,2&codec=0,1&qn=10000&platform=html5&ptype=8&dolby=5&panorama=1"
$response = Invoke-WebRequest -Uri $url -UseBasicParsing -WebSession $session `
-Headers @{
    "authority"="api.live.bilibili.com"
    "method"="GET"
    "path"="/xlive/web-room/v2/index/getRoomPlayInfo?room_id=$room_id&protocol=0,1&format=0,1,2&codec=0,1&qn=10000&platform=html5&ptype=8&dolby=5&panorama=1"
    "scheme"="https"
    "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    "accept-encoding"="text/plain;charset=UTF-8"
    "accept-language"="zh-CN,zh;q=0.9"
    "cache-control"="no-cache"
    "pragma"="no-cache"
    "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
    "sec-ch-ua-mobile"="?0"
    "sec-ch-ua-platform"="`"Windows`""
    "sec-fetch-dest"="document"
    "sec-fetch-mode"="navigate"
    "sec-fetch-site"="none"
    "sec-fetch-user"="?1"
    "upgrade-insecure-requests"="1"
}

# 解析数据中的参数
$data = ConvertFrom-Json $response.Content
$path = $data.data.playurl_info.playurl.stream[0].format[0].codec[0]
$sStreamName = $path.base_url
$sAntiCode = $path.url_info[0].extra.Replace("`r`n", "")  # 剔除不可见字符
$sHost = $path.url_info[0].host
$stream_url = "$sHost$sStreamName$sAntiCode"
$fileName = "{0}_{1}.flv" -f $room_id, (Get-Date -Format 'yyyy-MM-dd HH_mm')
$command = "aria2c --referer=https://www.bilibili.com/ -o ""$fileName"" ""$stream_url"""
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", $command

# 输出流媒体地址
# Write-Output "The stream url is: $stream_url"

# cmd /c "pause"
