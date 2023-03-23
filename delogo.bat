@echo off
setlocal enabledelayedexpansion

REM ��ȡ��Ƶ�ļ��ķֱ���
for /f "usebackq tokens=1,2 delims=x," %%a in (`ffprobe -v error -show_entries stream^=width^,height -of csv^=s^=x:p^=0 "%~1"`) do (
    set "img_width=%%a"
    set "img_height=%%b"
)

echo ��Ƶ�ߴ�Ϊ��%img_width%x%img_height%

:loop
REM ������ʾ����deloge��Ϣxywh
set /p input="������deloge��Ϣxywh����ʽ��x y w h����"

if /i "%input%"=="exit" exit

REM ���������Ϣ�Ƿ���Ч
set "need_ffmpeg="
for /f "tokens=1-4 delims= " %%a in ("%input%") do (
    set "img_x=%%a"
    set "img_y=%%b"
    set "img_w=%%c"
    set "img_h=%%d"
    if !img_x! GTR !img_width! (
        echo ���������룬x���ܳ���%img_width%��
        goto loop
    )
    if !img_y! LSS 0 (
        echo ���������룬y����С��0��
        goto loop
    )
    if !img_y! GTR !img_height! (
        echo ���������룬y���ܳ���%img_height%��
        goto loop
    )
    if !img_w! GTR !img_width! (
        echo ���������룬w���ܳ���%img_width%��
        goto loop
    )
    if !img_h! GTR !img_height! (
        echo ���������룬h���ܳ���%img_height%��
        goto loop
    )
    if /i "!input:~-1!"=="y" set "need_ffmpeg=1"
)

REM ������Ҫ����ffplay��ffmpeg����deloge����
if defined need_ffmpeg (
    ffmpeg -i "%~1" -vf delogo=x=!img_x!:y=!img_y!:w=!img_w!:h=!img_h!:show=0 -c:a copy -b:v 1200k -y "%~dpn1_delogo.mp4"
    pause
    goto loop
) else (
    ffplay -i "%~1" -vf delogo=x=!img_x!:y=!img_y!:w=!img_w!:h=!img_h!:show=1
    goto loop
)
