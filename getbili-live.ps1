# ��װAria2c
# if (!Test-Path $aria2_path) {
    # Write-Host "Installing Aria2c..."
    # Invoke-WebRequest -Uri "https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip" -OutFile "$temp\aria2.zip"
    # Expand-Archive "$temp\aria2.zip" -DestinationPath $aria2_path
    # Remove-Item "$temp\aria2.zip"
# }

# �����������������
$room_id = Read-Host "Enter bilibili room id"

# ��ȡ��������API���ص�����
$url = "https://api.live.bilibili.com/room/v1/Room/playUrl?cid=$room_id&play_url=1&mask=1&qn=0&platform=web"
$response = Invoke-WebRequest -Uri $url -UseBasicParsing

# ���������еĲ���
$data = ConvertFrom-Json $response.Content
$stream_url = $data.data.durl[0].url
$fileName = "{0}_{1}.flv" -f $room_id, (Get-Date -Format 'yyyy-MM-dd HH_mm')
$command = "aria2c --referer=https://www.bilibili.com/ -o ""$fileName"" ""$stream_url"""
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", $command


# �����ý���ַ
# Write-Output "The stream url is: $stream_url"

cmd /c "pause"