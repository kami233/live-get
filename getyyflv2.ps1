Invoke-WebRequest -Uri "https://stream-manager.yy.com/v3/channel/streams?uid=0&cid=54880976&sid=54880976&appid=0&sequence=1632705735370&encode=json" `
-Method "POST" `
-Headers @{
"method"="POST"
  "authority"="stream-manager.yy.com"
  "scheme"="https"
  "path"="/v3/channel/streams?uid=0&cid=54880976&sid=54880976&appid=0&sequence=1632705735370&encode=json"
  "sec-ch-ua"="`" Not A;Brand`";v=`"99`", `"Chromium`";v=`"90`", `"Google Chrome`";v=`"90`""
  "sec-ch-ua-mobile"="?0"
  "user-agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"
  "accept"="*/*"
  "origin"="https://www.yy.com"
  "sec-fetch-site"="same-site"
  "sec-fetch-mode"="cors"
  "sec-fetch-dest"="empty"
  "referer"="https://www.yy.com/"
  "accept-encoding"="gzip, deflate, br"
  "accept-language"="zh-CN,zh;q=0.9,en;q=0.8"
} `
-ContentType "text/plain;charset=UTF-8" `
-Body "{`"head`":{`"seq`":1632705735370,`"appidstr`":`"0`",`"bidstr`":`"120`",`"cidstr`":`"54880976`",`"sidstr`":`"54880976`",`"uid64`":0,`"client_type`":108,`"client_ver`":`"3.4.0`",`"stream_sys_ver`":1,`"app`":`"www.yy.com`",`"playersdk_ver`":`"3.4.0`",`"thundersdk_ver`":`"0`",`"streamsdk_ver`":`"1.11.2`"},`"client_attribute`":{`"client`":`"web`",`"model`":`"`",`"cpu`":`"`",`"graphics_card`":`"`",`"os`":`"chrome`",`"osversion`":`"90.0.4430.212`",`"vsdk_version`":`"`",`"app_identify`":`"`",`"app_version`":`"`",`"business`":`"`",`"width`":`"1920`",`"height`":`"1080`",`"scale`":`"`",`"client_type`":8,`"h265`":0},`"avp_parameter`":{`"version`":1,`"client_type`":8,`"service_type`":0,`"imsi`":0,`"send_time`":1632705735,`"line_seq`":-1,`"gear`":2,`"ssl`":1,`"stream_format`":0}}" | ft -wrap


cmd /c "pause"