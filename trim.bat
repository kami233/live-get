@echo off

REM 设置输入和输出路径
set input_path=%1
set output_path=%~dpn1_t.mp4

REM 使用ffprobe检测黑边大小
for /f "usebackq delims=: tokens=2" %%a in (`ffprobe -v error -select_streams v:0 -show_entries stream^=width -of csv^=s^=x:p^=0 "%input_path%"`) do set video_size=%%a
set /A width=%video_size:~0,-1%
set /A height=%video_size:~-1%

if %width% LSS %height% (
  set min_size=%width%
  set max_size=%height%
) else (
  set min_size=%height%
  set max_size=%width%
)

for /f "usebackq delims=: tokens=2" %%a in (`ffprobe -v error -select_streams v:0 -show_entries stream_tags^=side_data -of default^=noprint_wrappers^=1:nokey^=1 "%input_path%"`) do set side_data=%%a

if "%side_data%" == "" (
  echo No black borders detected.
  pause
  exit
)

set /A left_border=%min_size% - %side_data%
set /A right_border=%width% - %min_size% + %side_data%
set /A top_border=%max_size% - %side_data%
set /A bottom_border=%height% - %max_size% + %side_data%

echo Detected black borders:
echo Left: %left_border%
echo Right: %right_border%
echo Top: %top_border%
echo Bottom: %bottom_border%

REM 使用ffmpeg裁剪黑边并输出新视频
ffmpeg -i "%input_path%" -filter:v "crop=%width%:%height%:%left_border%:%top_border%" -c:a copy "%output_path%"

echo Successfully trimmed black borders from %input_path%.
pause
