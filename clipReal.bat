@echo off
set /p mytime=请输入开始和结束时间（格式：814.61 949.14）:
set "input=%~1"
for /f "tokens=1,2,3 delims= " %%a in ("%mytime%") do (
    set "ext=%%c"
)
if "%ext%"=="" (
    set "output=%~dpn1_clip.mp4"
) else (
	if /I "%ext%"=="flv" (
        set "output=%~dpn1_clip.flv"
    ) else if /I "%ext%"=="aac" (
    set "output=%~dpn1_clip.aac"
	) else (
    set "output=%~dpn1_clip.mp4"
	)
)
if /I "%mytime%"=="mcp" (
    ffmpeg -i "%input%" -c copy "%~dpn1_v.mp4"
) else if /I "%mytime%"=="fcp" (
    ffmpeg -i "%input%" -c copy "%~dpn1_v.flv"
) else if /I "%mytime%"=="vncp" (
    ffmpeg -i "%input%" -vn -c:a copy "%~dpn1_v.aac"
) else if /I "%mytime%"=="ancp" (
    ffmpeg -i "%input%" -c:v copy -an "%~dpn1_ancp.mp4"
) else if /I "%mytime%"=="m4a192" (
    ffmpeg -y -i "%input%" -vn -c:a aac -b:a 192k -map_metadata -1 -map_chapters -1 "%~dpn1_192k.m4a"
) else if /I "%mytime%"=="m4a224" (
    ffmpeg -y -i "%input%" -vn -codec:a aac -b:a 224000 -ar:a 48000 -ac:a 2 -map_metadata -1 -map_chapters -1 "%~dpn1_224k.m4a"
) else (
    for /f "tokens=1-2 delims= " %%a in ("%mytime%") do (
        ffmpeg -i "%input%" -ss %%a -to %%b -c:v copy -c:a copy "%output%"
    )
)
REM FFmpeg视频剪辑脚本

REM 当把文件拖放在上面时，提示用户输入开始和结束时间，格式为 "814.61 949.14" ，并且会按照输入的后缀来设置输出文件的后缀。对于flv格式的文件，默认输出为mp4格式，其他格式的文件则保持不变。

REM 如果希望截取音频，可以使用 aac 命令，例如输入："814.61 949.14 aac"。

REM 输入命令 "mcp" 将会将源文件封装为 MP4 格式，输入命令 "fcp" 将会将源文件封装为 FLV 格式，输入命令 "vncp" 将会提取源文件中的音频流并保存为 AAC 格式，输入命令 "ancp" 将会提取源文件中的视频流并保存为 MP4 格式。
REM 输入命令 "m4a192" 将会将音频流转换为 192k 的 M4A 格式，输入命令 "m4a224" 将会将音频流转换为 224k 的 M4A 格式。

REM 示例如下：

REM 1.输入"814.61 949.14"，执行 ` ffmpeg -ss 814.61 -i "%~1" -vcodec copy -acodec copy -to 949.14 "%~dpn1_clip.mp4" ` 
REM 2.输入"814.61 949.14 flv"，执行 ` ffmpeg -ss 814.61 -i "%~1" -vcodec copy -acodec copy -to 949.14 "%~dpn1_clip.flv" ` 
REM 3.输入"814.61 949.14 aac"，执行 ` ffmpeg -ss 814.61 -i "%~1" -vn -acodec copy -to 949.14 "%~dpn1_clip.aac" ` 
REM 4.输入"mcp"，执行 ` ffmpeg -i "%~1" -c copy "%~dpn1_v.mp4" ` 
REM 5.输入"fcp"，执行 ` ffmpeg -i "%~1" -c copy "%~dpn1_v.flv" ` 
REM 6.输入"vncp"，执行 ` ffmpeg -i "%~1" -vn -c:a copy "%~dpn1_v.aac" ` 
REM 7.输入"ancp"，执行 ` ffmpeg -i "%~1" -c:v copy -an "%~dpn1_ancp.mp4" ` 
REM 8.输入"m4a192"，执行 ` ffmpeg -y -i "%~1" -vn -c:a aac -b:a 192k -map_metadata -1 -map_chapters -1 "%~dpn1_192k.m4a" `  
REM 9.输入"m4a224"，执行 ` ffmpeg -y -i "%~1" -vn -codec:a aac -b:a 224000 -ar:a 48000 -ac:a 2 -map_metadata -1 -map_chapters -1 "%~dpn1_224k.m4a" `  
