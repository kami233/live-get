$roomId = Read-Host "Enter the room"
Add-Type -AssemblyName System.Web
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("ttwid", "1%7CYdGCFksWiVLlu_mPRaMPB-q7R-rBMnL5n14503SPzAg%7C1681346146%7C0657f07fc89bb4eb7945fdf81c9d28e9f76240f2aa7ed4c5af5e26eb49cab011", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_csrf_token", "766fd2e8a3261a01a39b20ca82113980", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_csrf_token_default", "766fd2e8a3261a01a39b20ca82113980", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("d_ticket", "c807b5bd142ad6455d69cc167106eee671819", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_assist_user", "CkGf46bT66ltj6z6YBWICYIt_CZwdBudwQEI_kAmNwqSo5clsIH-dwC6K7n7PAF3G-upWv3_0vI74Ubht-VrSiX8FBpICjwcPXuJebkIhAgg_fMqcQqrgl9GDR2GPHUFmq2onon1TsLtIE00PZi3GsmE7NrnqFzI-FRa3t1qXcwHc7UQpquuDRiJr9ZUIgED8hAmig%3D%3D", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("n_mh", "AXaHxMwpGrgcSDs9lLcMNCtNH2gYFoo_IeeeK5SPKL4", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sso_auth_status", "e857684dc555e125972e06e4f9a4a977", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sso_auth_status_ss", "e857684dc555e125972e06e4f9a4a977", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sso_uid_tt", "6e88f79d1af951e6c82f3a2a46d60661", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sso_uid_tt_ss", "6e88f79d1af951e6c82f3a2a46d60661", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("toutiao_sso_user", "31f697173621255d98444078832976a4", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("toutiao_sso_user_ss", "31f697173621255d98444078832976a4", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sid_ucp_sso_v1", "1.0.0-KDhhMDMwMDNiZjU1MGE5NDFhMDAyYzk2ODdkMTJhZjNlNzU3YTk5YjYKHwjbgPC704zvBBCWnd2hBhjvMSAMMNfwzZoGOAJA8QcaAmxmIiAzMWY2OTcxNzM2MjEyNTVkOTg0NDQwNzg4MzI5NzZhNA", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ssid_ucp_sso_v1", "1.0.0-KDhhMDMwMDNiZjU1MGE5NDFhMDAyYzk2ODdkMTJhZjNlNzU3YTk5YjYKHwjbgPC704zvBBCWnd2hBhjvMSAMMNfwzZoGOAJA8QcaAmxmIiAzMWY2OTcxNzM2MjEyNTVkOTg0NDQwNzg4MzI5NzZhNA", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_auth_status", "a947abc391e70fb78adc69bba5787084%2Cd08fabd27a14e6cfa5a0ddbc1eac5035", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_auth_status_ss", "a947abc391e70fb78adc69bba5787084%2Cd08fabd27a14e6cfa5a0ddbc1eac5035", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("uid_tt", "eece2d2aa4329ba00cdd75b512615a15", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("uid_tt_ss", "eece2d2aa4329ba00cdd75b512615a15", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sid_tt", "01101e245a2381199abb7185748ef855", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sessionid", "01101e245a2381199abb7185748ef855", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sessionid_ss", "01101e245a2381199abb7185748ef855", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("LOGIN_STATUS", "1", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("store-region", "cn-gx", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("store-region-src", "uid", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sid_guard", "01101e245a2381199abb7185748ef855%7C1681346203%7C5183997%7CMon%2C+12-Jun-2023+00%3A36%3A40+GMT", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("sid_ucp_v1", "1.0.0-KGMwZmJkZDg3OTc4ODgzMzkxNmNmOTI3MjMzOGI1Njg4YzA1NDgxZWIKGwjbgPC704zvBBCbnd2hBhjvMSAMOAJA8QdIBBoCaGwiIDAxMTAxZTI0NWEyMzgxMTk5YWJiNzE4NTc0OGVmODU1", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("ssid_ucp_v1", "1.0.0-KGMwZmJkZDg3OTc4ODgzMzkxNmNmOTI3MjMzOGI1Njg4YzA1NDgxZWIKGwjbgPC704zvBBCbnd2hBhjvMSAMOAJA8QdIBBoCaGwiIDAxMTAxZTI0NWEyMzgxMTk5YWJiNzE4NTc0OGVmODU1", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("pwa2", "%220%7C1%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("my_rd", "1", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("download_guide", "%223%2F20230421%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("SEARCH_RESULT_LIST_TYPE", "%22single%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("FOLLOW_LIVE_POINT_INFO", "%22MS4wLjABAAAAZ7OmBHdPs1PWYJyKXs0tIXoipXJpINut9xjwmkrovbDuXJN42Hy9af0EhfFnzr49%2F1682179200000%2F0%2F1682169540468%2F0%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("strategyABtestKey", "%221682571304.684%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("FOLLOW_NUMBER_YELLOW_POINT_INFO", "%22MS4wLjABAAAAZ7OmBHdPs1PWYJyKXs0tIXoipXJpINut9xjwmkrovbDuXJN42Hy9af0EhfFnzr49%2F1682611200000%2F1682571309302%2F1682571305361%2F0%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("publish_badge_show_info", "%221%2C0%2C0%2C1682571310671%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("VIDEO_FILTER_MEMO_SELECT", "%7B%22expireTime%22%3A1683176881558%2C%22type%22%3A0%7D", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("odin_tt", "e358ef25bd19cd6d41c17dbd83adb460c997604be5ae96f8d9418919b3efe1e83af6fed20905d49a9211a710c6efd508", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("device_web_cpu_core", "4", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("device_web_memory_size", "8", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("csrf_session_id", "7a425075d921605adceee1d9b60b552a", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("webcast_local_quality", "origin", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("xgplayer_user_id", "440566915584", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("passport_fe_beating_status", "true", "/", ".live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("home_can_add_dy_2_desktop", "%221%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__live_version__", "%221.1.0.9036%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("live_can_add_dy_2_desktop", "%220%22", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__ac_nonce", "0644a366c007701b9f30d", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("__ac_signature", "_02B4Z6wo00f01viYEhAAAIDDm5LSeD7fcpL4uBaAANp5vgPZ4kvID0tCFTvDoh0URodpZBvUi19il7Wj5zoLDlBmbD-9n1Q2yZGKNRdzekLhwDOnt3d.cG7fPKyp0I28uZB8dax2IjQ0rtMB2c", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("webcast_leading_last_show_time", "1682585207858", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("webcast_leading_total_show_times", "1", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("msToken", "OWTnLWZCnBBLvoTbzzKecFT0z9haO4QcjksmYnDHHKyOjYla1f7qusrcs_TFqhyj2mYY-gi-2G4p7F9yXwvk_OPWepfWtGIiEyY6sWECtaP21oKF2fwChQ==", "/", ".douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("msToken", "sgB7qgEYrtFfqHAyX8DJ_7UcONUDtU0-E08-mfARSg8NYR4bicql9H3ie2tB0FPrtXzNkG2iboXA_sU6-vXRPlLDZgu02VPQ5UiEZWgYskjUUIuM_pPuGw==", "/", "live.douyin.com")))
$session.Cookies.Add((New-Object System.Net.Cookie("tt_scid", "KPFKg6hWjr1pCaXUX1RdvBjhhRXnIYD3jrWyBBcUORY-OiuVVOaSDoYhgQlOYFHV82cf", "/", "live.douyin.com")))
$response = Invoke-WebRequest -UseBasicParsing -Uri "https://live.douyin.com/$roomId" `
-WebSession $session `
-Headers @{
"authority"="live.douyin.com"
  "method"="GET"
  "path"="/$roomId"
  "scheme"="https"
  "accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
  "accept-encoding"="text/plain;charset=UTF-8"
  "accept-language"="zh-CN,zh;q=0.9"
  "cache-control"="no-cache"
  "pragma"="no-cache"
  "referer"="https://live.douyin.com/$roomId"
  "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
  "sec-fetch-dest"="document"
  "sec-fetch-mode"="navigate"
  "sec-fetch-site"="same-origin"
  "sec-fetch-user"="?1"
  "upgrade-insecure-requests"="1"
}

$content = $response.Content
$content = [System.Web.HttpUtility]::UrlDecode($content)

$regex = """origin"":{""main"":{""flv"":""(https?://[^""]+)"",""hls"""
$matches = [regex]::Matches($content, $regex)

if ($matches.Count -ge 2) {
    $link = $matches[1].Groups[1].Value
    # Write-Host $link
}

$fileName = "{0}_{1}.flv" -f $roomId, (Get-Date -Format 'yyyy-MM-dd HH_mm')
$command = "aria2c --referer=https://www.douyin.com/ -o ""$fileName"" ""$link"""
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", $command

# cmd /c "pause"
