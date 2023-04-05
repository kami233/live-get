$ttAndSign = Read-Host "请输入房间号、tt和sign（格式：9722705 v=xx&did=xx&tt=xx&sign=xx）"
$ttAndSignArray = $ttAndSign.Split(' ')
$roomId = $ttAndSignArray[0]
# $tt = $ttAndSignArray[1].Replace('tt=','')
# $sign = $ttAndSignArray[2].Replace('sign=','')

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("dy_did", "653ce128e32a8862491385fe00061601", "/", ".douyu.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("acf_did", "653ce128e32a8862491385fe00061601", "/", "www.douyu.com")))

$requestUri = "https://www.douyu.com/lapi/live/getH5Play/$($roomId)?$($ttAndSignArray[1])&cdn=&rate=-1&ver=Douyu_222082905&iar=1&ive=0&hevc=0&fa=0"

$headers = @{
    "authority"="www.douyu.com"
    "method"="POST"
    "path"="/lapi/live/getH5Play/$($roomId)?$($ttAndSignArray[1])&cdn=&rate=-1&ver=Douyu_222082905&iar=1&ive=0&hevc=0&fa=0"
    "scheme"="https"
    "accept"="*/*"
    "accept-encoding"="gzip, deflate, br"
    "accept-language"="zh-CN,zh;q=0.9"
    "origin"="https://www.douyu.com"
    "referer"="https://www.douyu.com/$roomId"
    "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
    "sec-ch-ua-mobile"="?0"
    "sec-ch-ua-platform"="`"Windows`""
    "sec-fetch-dest"="empty"
    "sec-fetch-mode"="cors"
    "sec-fetch-site"="same-origin"
}

$response = Invoke-WebRequest -UseBasicParsing -Uri $requestUri -Method "POST" -WebSession $session -Headers $headers

$url = ($response.Content | ConvertFrom-Json | Select-Object -ExpandProperty data | Select-Object -ExpandProperty rtmp_url), ($response.Content | ConvertFrom-Json | Select-Object -ExpandProperty data | Select-Object -ExpandProperty rtmp_live) -join '/'

Write-Host $url

cmd /c "pause"
