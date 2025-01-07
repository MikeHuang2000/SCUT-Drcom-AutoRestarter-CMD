@echo off
setlocal

:: 设置计划任务的名称
set "TASK_NAME=autodrcomstart"

schtasks /Run /TN "%TASK_NAME%"

endlocal