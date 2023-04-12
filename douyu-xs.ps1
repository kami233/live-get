$url = Read-Host "请输入链接："
# $roomId = [regex]::Matches($ttAndSign, '(?<=getH5Play\/)\d+').Value

# 提取 tt 和 sign 等参数的值
$did = [regex]::Match($url, "(?<=did=)[^&]+").Value
$sign = [regex]::Match($url, "(?<=sign=)[^&]+").Value
$tt = [regex]::Match($url, "(?<=tt=)[^&]+").Value
$v = [regex]::Match($url, "(?<=v=)[^&]+").Value
$room = [regex]::Match($url, '(?<=token=web-cph-0-)\d+').Value
# $room = [regex]::Match($url, "(?<=/)\d+(?=[^/]*$)").Value

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("dy_did", "$did", "/", ".douyu.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("acf_did", "$did", "/", "www.douyu.com")))

$requestUri = "https://www.douyu.com/lapi/live/getH5Play/$($room)?v=$v&did=$did&tt=$tt&sign=$sign&cdn=&rate=-1&ver=Douyu_222082905&iar=1&ive=0&hevc=0&fa=0"

Write-Host $requestUri
$headers = @{
    "authority"="www.douyu.com"
    "method"="POST"
    "path"="/lapi/live/getH5Play/$($room)?$($requestUri.Split("?")[1])"
    "scheme"="https"
    "accept"="*/*"
    "accept-encoding"="gzip, deflate, br"
    "accept-language"="zh-CN,zh;q=0.9"
    "origin"="https://www.douyu.com"
    "referer"="https://www.douyu.com/$room"
    "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
    "sec-ch-ua-mobile"="?0"
    "sec-ch-ua-platform"="`"Windows`""
    "sec-fetch-dest"="empty"
    "sec-fetch-mode"="cors"
    "sec-fetch-site"="same-origin"
}

$response = Invoke-WebRequest -UseBasicParsing -Uri $requestUri -Method "POST" -WebSession $session -Headers $headers

$url = ($response.Content | ConvertFrom-Json | Select-Object -ExpandProperty data | Select-Object -ExpandProperty rtmp_url), ($response.Content | ConvertFrom-Json | Select-Object -ExpandProperty data | Select-Object -ExpandProperty rtmp_live) -join '/' | ForEach {ffmpeg -i $_ -c copy -y "$($room)_$(Get-Date -Format 'yyyy-MM-dd HH_mm').flv"}

# Write-Host $url

cmd /c "pause"
