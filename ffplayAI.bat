@echo off
setlocal enableDelayedExpansion

for %%I in (%*) do (
    set name=%%~nI
    set ext=%%~xI
    
    for /f "usebackq delims=" %%A in (`ffprobe -v error -select_streams v:0 -show_entries stream^=height -of csv^=p^=0 "%%~I"`) do set height=%%A
    
    if !height! gtr 1000 (
        ffplay -i "%%~I" -vf scale=-1:1000
    ) else if !height! gtr 720 (
        ffplay -i "%%~I" -vf scale=-1:720
    ) else (
        ffplay -i "%%~I"
    )
)

endlocal
