$sourceStr="https://aliyun-flv-ipv6.yy.com/live/15013_xv_54880976_54880976_0_0_0-15013_xa_54880976_54880976_0_0_0-0-0-0-0-0-1678769105154761.flv?codec=orig\u0026appid=15013\u0026secret=ffbc1c8491910347990902185497c35e\u0026t=1678855638\u0026mtk=1\u0026line_seq=2\u0026cp_id=2\u0026stream_key=15013_xv_54880976_54880976_0_0_0\u0026r=enter"
$matchEvaluator={
param($v)
[char][int]($v.Value.replace('\u','0x'))
}
[regex]::Replace($sourceStr,'\\u[0-9-a-f]{4}',$matchEvaluator)

cmd /c "pause"