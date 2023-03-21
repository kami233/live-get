# 创建 temp 文件夹
New-Item -Path ".\temp" -ItemType Directory -Force

# 获取视频地址链接并下载到 temp 文件夹中
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
$json = Invoke-WebRequest -UseBasicParsing -Uri "https://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=52fb50a78f334207baf6a30ba17fc5ad&client=flash&im=0&tsp=1679284556&vn=2049&vc=2B3C05D5712E965567ECF14F1F947130&uid=8E131D27B470F9CD737B936398E59547&wlan=" `
    -WebSession $session `
    -Headers @{
        "Accept"="*/*"
        "Accept-Encoding"="gzip, deflate, br"
        "Accept-Language"="zh-CN,zh;q=0.9"
        "Origin"="https://tv.cctv.com"
        "Referer"="https://tv.cctv.com/"
        "Sec-Fetch-Dest"="empty"
        "Sec-Fetch-Mode"="cors"
        "Sec-Fetch-Site"="cross-site"
        "sec-ch-ua"="`"Chromium`";v=`"106`", `"Google Chrome`";v=`"106`", `"Not;A=Brand`";v=`"99`""
        "sec-ch-ua-mobile"="?0"
        "sec-ch-ua-platform"="`"Windows`""
    } | Select -ExpandProperty Content
$urls = (ConvertFrom-Json $json).video.chapters4.url
$processes = @()
foreach ($url in $urls) {
    # 下载视频文件到 temp 文件夹中
    $process = Start-Process "C:\KuGou\aria2\aria2c.exe" "-x 16 -s 16 -d .\temp $url" -PassThru
    $processes += $process
}
$processes | Wait-Process

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# 遍历文件夹中所有的视频文件，将它们添加到列表中并重命名
Get-ChildItem -Path "$scriptPath\temp" -Recurse -Include *.mp4 | ForEach-Object {
    $temp = $_.FullName -replace '"', ''
    Write-Output "file '$temp'"
    $xz = $_.Name -replace "-1.m", "-01.m" `
                   -replace "-2", "-02" `
                   -replace "-3", "-03" `
                   -replace "-4", "-04" `
                   -replace "-5", "-05" `
                   -replace "-6", "-06" `
                   -replace "-7", "-07" `
                   -replace "-8", "-08" `
                   -replace "-9", "-09"
    Rename-Item $temp -NewName $xz
}

# 等待5秒后再次遍历文件夹中所有的视频文件，并将它们添加到列表中
Start-Sleep -Seconds 5
$list_file = Join-Path -Path $scriptPath -ChildPath "list.txt"  # 列表文件的完整路径
(Get-ChildItem -Path "$scriptPath\temp" -Recurse -Include *.mp4).FullName | ForEach-Object {
    Write-Output "file '$_'"
} | Set-Content -Path $list_file -Encoding UTF8

# 删除生成的文件的 BOM（Byte Order Mark）
$content = Get-Content -Path $list_file -Raw -Encoding UTF8
[Byte[]] $noBomContent = [System.Text.Encoding]::UTF8.GetBytes($content)
[System.IO.File]::WriteAllBytes($list_file, $noBomContent)

# 使用 FFmpeg 合并视频文件
$outputPath = Join-Path $PSScriptRoot "$(Get-Date -Format 'yyyyMMdd_HHmmss')_merged.mp4"
ffmpeg -f concat -safe 0 -i list.txt -c copy $outputPath

# 清理临时文件
Remove-Item -Recurse -Force temp
Remove-Item -Force list.txt

echo "合并完成！"

# Write-Host "提取到的地址为："
# $urls
cmd /c "pause"