@echo off

rem ����huya.py�����������Ϊhuyatemp.txt
python huya.py > huyatemp.txt

rem ��huyatemp.txt������.flv���Ӳ�¼����Ƶ
for /f "delims=" %%a in ('type huyatemp.txt ^| findstr /i ".flv"') do ffmpeg -i "%%a" -c copy "huya_%DATE:~0,4%-%DATE:~5,2%-%DATE:~8,2% %TIME:~0,2%_%TIME:~3,2%.flv"

rem ɾ����ʱ�ļ�
del huyatemp.txt
pause