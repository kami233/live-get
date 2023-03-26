@echo off
setlocal enableDelayedExpansion

for %%I in (%*) do (
    set name=%%~nI
    set ext=%%~xI
    set resolution_info=%%~dpnI_resolution.txt
    
    if not exist "!resolution_info!" (
        ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "%%~I" > "!resolution_info!"
    )
    
    set /p height=<"!resolution_info!"
    
    if !height! gtr 1000 (
        ffplay -i "%%~I" -vf scale=-1:1000
    ) else if !height! gtr 720 (
        ffplay -i "%%~I" -vf scale=-1:720
    ) else (
        ffplay -i "%%~I"
    )
    
    del "!resolution_info!"
)

endlocal
