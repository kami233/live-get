# 输入哔哩哔哩房间号
$room_id = Read-Host "Enter bilibili room id"

# 获取哔哩哔哩API返回的数据
$url = "https://api.live.bilibili.com/room/v1/Room/playUrl?cid=$room_id&quality=4&platform=web"
$response = Invoke-WebRequest -Uri $url -UseBasicParsing

# 解析数据中的参数
$data = ConvertFrom-Json $response.Content
$stream_url = $data.data.durl[0].url

# 输出流媒体地址
Write-Output "The stream url is: $stream_url"

cmd /c "pause"