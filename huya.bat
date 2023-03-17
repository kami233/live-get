@echo off

rem 运行huya.py并将输出保存为huyatemp.txt
python huya.py > huyatemp.txt

rem 在huyatemp.txt中搜索.flv链接并录制视频
for /f "delims=" %%a in ('type huyatemp.txt ^| findstr /i ".flv"') do ffmpeg -i "%%a" -c copy "huya_%DATE:~0,4%-%DATE:~5,2%-%DATE:~8,2% %TIME:~0,2%_%TIME:~3,2%.flv"

rem 删除临时文件
del huyatemp.txt
pause