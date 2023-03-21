# ���� temp �ļ���
New-Item -Path ".\temp" -ItemType Directory -Force

# ��ȡ��Ƶ��ַ���Ӳ����ص� temp �ļ�����
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
    # ������Ƶ�ļ��� temp �ļ�����
    $process = Start-Process "C:\KuGou\aria2\aria2c.exe" "-x 16 -s 16 -d .\temp $url" -PassThru
    $processes += $process
}
$processes | Wait-Process

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# �����ļ��������е���Ƶ�ļ�����������ӵ��б��в�������
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

# �ȴ�5����ٴα����ļ��������е���Ƶ�ļ�������������ӵ��б���
Start-Sleep -Seconds 5
$list_file = Join-Path -Path $scriptPath -ChildPath "list.txt"  # �б��ļ�������·��
(Get-ChildItem -Path "$scriptPath\temp" -Recurse -Include *.mp4).FullName | ForEach-Object {
    Write-Output "file '$_'"
} | Set-Content -Path $list_file -Encoding UTF8

# ɾ�����ɵ��ļ��� BOM��Byte Order Mark��
$content = Get-Content -Path $list_file -Raw -Encoding UTF8
[Byte[]] $noBomContent = [System.Text.Encoding]::UTF8.GetBytes($content)
[System.IO.File]::WriteAllBytes($list_file, $noBomContent)

# ʹ�� FFmpeg �ϲ���Ƶ�ļ�
$outputPath = Join-Path $PSScriptRoot "$(Get-Date -Format 'yyyyMMdd_HHmmss')_merged.mp4"
ffmpeg -f concat -safe 0 -i list.txt -c copy $outputPath

# ������ʱ�ļ�
Remove-Item -Recurse -Force temp
Remove-Item -Force list.txt

echo "�ϲ���ɣ�"

# Write-Host "��ȡ���ĵ�ַΪ��"
# $urls
cmd /c "pause"