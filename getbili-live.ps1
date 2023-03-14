# �����������������
$room_id = Read-Host "Enter bilibili room id"

# ��ȡ��������API���ص�����
$url = "https://api.live.bilibili.com/room/v1/Room/playUrl?cid=$room_id&quality=4&platform=web"
$response = Invoke-WebRequest -Uri $url -UseBasicParsing

# ���������еĲ���
$data = ConvertFrom-Json $response.Content
$stream_url = $data.data.durl[0].url

# �����ý���ַ
Write-Output "The stream url is: $stream_url"

cmd /c "pause"