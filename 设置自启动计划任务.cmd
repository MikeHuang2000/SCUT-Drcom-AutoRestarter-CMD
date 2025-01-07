@echo off
setlocal


cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && REG QUERY "HKU\S-1-5-19" 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && ""%~dp0设置自启动计划任务.cmd"" %Apply%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )



set /p a=输入1设置自启动，输入0卸载自启动:
	
if /i '%a%'=='1' call :settask
if /i '%a%'=='0' call :deltask

goto :eof

:settask
cd %~dp0
:: 设置要运行的脚本路径
set "SCRIPT_PATH=%~dp0一键重启认证.cmd"

:: 设置计划任务的名称
set "TASK_NAME=autodrcomstart"

:: 登录时运行模板
::schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c start /min "" ""%SCRIPT_PATH%""" /SC ONLOGON /RL HIGHEST /F
:: 系统启动时运行模板
::schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c start /min """%SCRIPT_PATH%"""" /SC ONSTART /RL HIGHEST /F
::schtasks /Create /TN "%TASK_NAME%" /TR """"%SCRIPT_PATH%"""" /SC ONLOGON /RL HIGHEST /F

::设置计划任务
schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c """start """""" /min """%SCRIPT_PATH%""""""" /SC ONSTART /RL HIGHEST /F

:: 检查任务是否已创建
if %errorlevel%==0 (
    echo Task "%TASK_NAME%" created successfully.
) else (
    echo Failed to set task "%TASK_NAME%".
)

ECHO.&ECHO 完成 &TIMEOUT /t 3 >NUL&EXIT
goto :eof

:deltask
:: 设置计划任务的名称
set "TASK_NAME=autodrcomstart"

:: 删除指定的计划任务
schtasks /Delete /TN "%TASK_NAME%" /F

:: 检查任务是否已删除
if %errorlevel%==0 (
    echo Task "%TASK_NAME%" deleted successfully.
) else (
    echo Failed to delete task "%TASK_NAME%".
)

ECHO.&ECHO 完成 &TIMEOUT /t 3 >NUL&EXIT
goto :eof


endlocal
