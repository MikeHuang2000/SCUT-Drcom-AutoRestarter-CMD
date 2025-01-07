@echo off
SETLOCAL

taskkill /f /im DrMain.exe
taskkill /f /im DrClient.exe
taskkill /f /im DrUpdate.exe


start "" "%~dp0DrMain.exe"

exit

ENDLOCAL