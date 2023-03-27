
@echo off
IF "%~1"=="" GOTO :eof
SET /P userInput="请输入指令："

REM 分割用户输入字符串
FOR /f "tokens=1,2,3 delims= " %%a IN ("%userInput%") DO (
    SET "startPoint=%%a"
    SET "endPoint=%%b"
    SET "outputExt=%%c"
	SET /a realEnd=endPoint-startPoint
)

REM 判断输出文件格式
IF "%outputExt%"=="" (
    SET outputExt=mp4
) ELSE (
    IF /I "%outputExt%"=="flv" (
        SET outputExt=flv
    ) ELSE IF /I "%outputExt%"=="aac" (
        SET outputExt=aac
    ) ELSE (
        SET outputExt=mp4
    )
)

REM 根据用户输入调用 FFmpeg 剪辑视频
IF /I "%userInput%"=="mcp" (
    ffmpeg -i "%~1" -c copy "%~dpn1_v.mp4"
) ELSE IF /I "%userInput%"=="fcp" (
    ffmpeg -i "%~1" -c copy "%~dpn1_v.flv"
) ELSE IF /I "%userInput%"=="vncp" (
    ffmpeg -i "%~1" -vn -c:a copy "%~dpn1_v.aac"
) ELSE IF /I "%userInput%"=="ancp" (
    ffmpeg -i "%~1" -c:v copy -an "%~dpn1_ancp.mp4"
) ELSE IF /I "%userInput%"=="m4a192" (
    ffmpeg -y -i "%~1" -vn -c:a aac -b:a 192k -map_metadata -1 -map_chapters -1 "%~dpn1_192k.m4a"
) ELSE IF /I "%userInput%"=="m4a224" (
    ffmpeg -y -i "%~1" -vn -codec:a aac -b:a 224000 -ar:a 48000 -ac:a 2 -map_metadata -1 -map_chapters -1 "%~dpn1_224k.m4a"
) ELSE (
    ffmpeg -ss %startPoint% -i "%~1" -vcodec copy -acodec copy -to %realEnd% "%~dpn1_clip.%outputExt%"
)

