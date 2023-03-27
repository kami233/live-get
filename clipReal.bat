@echo off
set /p mytime=�����뿪ʼ�ͽ���ʱ�䣨��ʽ��814.61 949.14��:
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
REM FFmpeg��Ƶ�����ű�

REM �����ļ��Ϸ�������ʱ����ʾ�û����뿪ʼ�ͽ���ʱ�䣬��ʽΪ "814.61 949.14" �����һᰴ������ĺ�׺����������ļ��ĺ�׺������flv��ʽ���ļ���Ĭ�����Ϊmp4��ʽ��������ʽ���ļ��򱣳ֲ��䡣

REM ���ϣ����ȡ��Ƶ������ʹ�� aac ����������룺"814.61 949.14 aac"��

REM �������� "mcp" ���ὫԴ�ļ���װΪ MP4 ��ʽ���������� "fcp" ���ὫԴ�ļ���װΪ FLV ��ʽ���������� "vncp" ������ȡԴ�ļ��е���Ƶ��������Ϊ AAC ��ʽ���������� "ancp" ������ȡԴ�ļ��е���Ƶ��������Ϊ MP4 ��ʽ��
REM �������� "m4a192" ���Ὣ��Ƶ��ת��Ϊ 192k �� M4A ��ʽ���������� "m4a224" ���Ὣ��Ƶ��ת��Ϊ 224k �� M4A ��ʽ��

REM ʾ�����£�

REM 1.����"814.61 949.14"��ִ�� ` ffmpeg -ss 814.61 -i "%~1" -vcodec copy -acodec copy -to 949.14 "%~dpn1_clip.mp4" ` 
REM 2.����"814.61 949.14 flv"��ִ�� ` ffmpeg -ss 814.61 -i "%~1" -vcodec copy -acodec copy -to 949.14 "%~dpn1_clip.flv" ` 
REM 3.����"814.61 949.14 aac"��ִ�� ` ffmpeg -ss 814.61 -i "%~1" -vn -acodec copy -to 949.14 "%~dpn1_clip.aac" ` 
REM 4.����"mcp"��ִ�� ` ffmpeg -i "%~1" -c copy "%~dpn1_v.mp4" ` 
REM 5.����"fcp"��ִ�� ` ffmpeg -i "%~1" -c copy "%~dpn1_v.flv" ` 
REM 6.����"vncp"��ִ�� ` ffmpeg -i "%~1" -vn -c:a copy "%~dpn1_v.aac" ` 
REM 7.����"ancp"��ִ�� ` ffmpeg -i "%~1" -c:v copy -an "%~dpn1_ancp.mp4" ` 
REM 8.����"m4a192"��ִ�� ` ffmpeg -y -i "%~1" -vn -c:a aac -b:a 192k -map_metadata -1 -map_chapters -1 "%~dpn1_192k.m4a" `  
REM 9.����"m4a224"��ִ�� ` ffmpeg -y -i "%~1" -vn -codec:a aac -b:a 224000 -ar:a 48000 -ac:a 2 -map_metadata -1 -map_chapters -1 "%~dpn1_224k.m4a" `  
