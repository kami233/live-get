@echo off
setlocal enabledelayedexpansion

REM 获取视频文件的分辨率
for /f "usebackq tokens=1,2 delims=x," %%a in (`ffprobe -v error -show_entries stream^=width^,height -of csv^=s^=x:p^=0 "%~1"`) do (
    set "img_width=%%a"
    set "img_height=%%b"
)

echo 视频尺寸为：%img_width%x%img_height%

:loop
REM 根据提示输入deloge信息xywh
set /p input="请输入deloge信息xywh（格式：x y w h）："

if /i "%input%"=="exit" exit

REM 检查输入信息是否有效
set "need_ffmpeg="
for /f "tokens=1-4 delims= " %%a in ("%input%") do (
    set "img_x=%%a"
    set "img_y=%%b"
    set "img_w=%%c"
    set "img_h=%%d"
    if !img_x! GTR !img_width! (
        echo 请重新输入，x不能超过%img_width%。
        goto loop
    )
    if !img_y! LSS 0 (
        echo 请重新输入，y不能小于0。
        goto loop
    )
    if !img_y! GTR !img_height! (
        echo 请重新输入，y不能超过%img_height%。
        goto loop
    )
    if !img_w! GTR !img_width! (
        echo 请重新输入，w不能超过%img_width%。
        goto loop
    )
    if !img_h! GTR !img_height! (
        echo 请重新输入，h不能超过%img_height%。
        goto loop
    )
    set "show=1"
    if /i "!input:~-1!"=="0" set "show=0"
    if /i "!input:~-1!"=="y" set "need_ffmpeg=1"
)

REM 根据需要调用ffplay或ffmpeg进行deloge处理
if defined need_ffmpeg (
    ffmpeg -i "%~1" -vf delogo=x=!img_x!:y=!img_y!:w=!img_w!:h=!img_h!:show=0 -c:a copy -b:v 1200k -y "%~dpn1_delogo.mp4"
    pause
    goto loop
) else (
    ffplay -i "%~1" -vf delogo=x=!img_x!:y=!img_y!:w=!img_w!:h=!img_h!:show=!show!
    goto loop
)
