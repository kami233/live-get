$roomId = Read-Host "请输入房间号"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("game_did", "K8ud7UwLuH4r7qhTGM7yofaZczR4-4psO7j", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("guid", "0a70e9d288bc276458014a674b67a280", "/", "www.huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__yasmid", "0.02692243323934962", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__yamid_tt1", "0.02692243323934962", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__yamid_new", "CA3A3EB63D10000191E07AC01D90E510", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("_yasids", "__rootsid%3DCA3A3EB63DA0000119A41E701ED7CA80", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("udb_passdata", "3", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("SoundValue", "0.50", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("alphaValue", "0.80", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("isInLiveRoom", "true", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("guid", "0a70e9d288bc276458014a674b67a280", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("huya_ua", "webh5&0.0.1&websocket", "/", "www.huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("huya_flash_rep_cnt", "65", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("rep_cnt", "38", "/", ".huya.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("huya_web_rep_cnt", "6116", "/", ".huya.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://www.huya.com/$roomId" `
-WebSession $session `
-Headers @{
"Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="zh-CN,zh;q=0.9"
  "Cache-Control"="no-cache"
  "Pragma"="no-cache"
  "Referer"="https://www.huya.com/g/bns"
  "Sec-Fetch-Dest"="document"
  "Sec-Fetch-Mode"="navigate"
  "Sec-Fetch-Site"="same-origin"
  "Sec-Fetch-User"="?1"
  "Upgrade-Insecure-Requests"="1"
  "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
}

$content = $response.Content

$json_start = $content.IndexOf("var hyPlayerConfig = {")
$json_end = $content.IndexOf("};", $json_start) + 1
$json_length = $json_end - $json_start
$json_content = $content.Substring($json_start, $json_length)

$hyPlayerConfig = ConvertFrom-Json (($json_content -replace 'var hyPlayerConfig = ','' -replace ';',''))

foreach ($streamInfo in $hyPlayerConfig.stream.data[0].gameStreamInfoList) {
    if ($streamInfo.sCdnType -eq "AL") {
        $sFlvUrl = $streamInfo.sFlvUrl
        $sStreamName = $streamInfo.sStreamName
        $sFlvUrlSuffix = $streamInfo.sFlvUrlSuffix
        $sFlvAntiCode = $streamInfo.sFlvAntiCode
        break
    }
}

$url = "$sFlvUrl/$sStreamName.$($sFlvUrlSuffix)?$sFlvAntiCode" 
$fileName = "{0}_{1}.flv" -f $roomId, (Get-Date -Format 'yyyy-MM-dd HH_mm')
$command = "aria2c --referer=https://www.huya.com/ -o ""$fileName"" ""$url"""
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", $command

# Write-Host $url
cmd /c "pause"