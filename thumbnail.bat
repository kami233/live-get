@echo off
setlocal enabledelayedexpansion

REM ѭ����ȡ�Ϸŵ��ļ�·��
for %%G in (%*) do (
	set "input_file=%%~G"

	REM ��·���е�˫�����滻Ϊ�ո�
	set "input_file=!input_file:"= !"

	REM ��ȡ�ļ������ļ�����Ŀ¼
	for /f "delims=" %%a in ('echo "!input_file!"') do (
		set file_path=%%~dpa
		set file_name=%%~na
	)

	REM ��ȡ��Ƶ��֡��
	for /f "delims=" %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream^=nb_frames -of default^=nokey^=1:noprint_wrappers^=1 "!input_file!"') do set total_frames=%%a

	IF !total_frames! EQU 0 (
		echo Cannot generate thumbnail for !file_name!: Video has no frames.
	) ELSE (
		REM ������֡��
		set /a interval_frames=!total_frames!/16

		REM ��������ͼ�ļ���
		set thumbnail_name=!file_name!_%%04d.png

		REM ʹ��FFmpeg��������ͼ
		ffmpeg -i "!input_file!" -vf "select='not(mod(n\,!interval_frames!))',scale=w=320:h=-2,tile=4x4" -frames:v 1 "!file_path!!thumbnail_name!"
	)
)
pause
