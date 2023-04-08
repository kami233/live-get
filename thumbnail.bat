@echo off
setlocal enabledelayedexpansion

REM 循环获取拖放的文件路径
for %%G in (%*) do (
    set "input_file=%%~G"

    REM 将路径中的双引号替换为空格
    set "input_file=!input_file:"= !"

    REM 获取文件名和文件所在目录
    for /f "delims=" %%a in ('echo "!input_file!"') do (
        set file_path=%%~dpa
        set file_name=%%~na
    )

    REM 获取视频总帧数
    for /f "delims=" %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream^=nb_frames -of default^=nokey^=1:noprint_wrappers^=1 "!input_file!"') do set total_frames=%%a

    IF !total_frames! EQU 0 (
        echo Cannot generate thumbnail for !file_name!: Video has no frames.
    ) ELSE (
        REM 计算间隔帧数
        set /a interval_frames=!total_frames!/17

        REM 排除除以0的异常情况
        if !interval_frames! EQU 0 (
            set interval_frames=8700
        )

        REM 生成缩略图文件名
        set thumbnail_name=!file_name!_%%04d.png

        REM 使用FFmpeg生成缩略图
        ffmpeg -i "!input_file!" -vf "select='not(mod(n\,!interval_frames!))',scale=w=320:h=-2,tile=4x4" -frames:v 1 "!file_path!!thumbnail_name!"
    )
)
pause
