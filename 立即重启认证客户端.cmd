@echo off
setlocal

:: ���üƻ����������
set "TASK_NAME=autodrcomstart"

schtasks /Run /TN "%TASK_NAME%"

endlocal