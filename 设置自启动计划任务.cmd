@echo off
setlocal


cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && REG QUERY "HKU\S-1-5-19" 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && ""%~dp0�����������ƻ�����.cmd"" %Apply%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )



set /p a=����1����������������0ж��������:
	
if /i '%a%'=='1' call :settask
if /i '%a%'=='0' call :deltask

goto :eof

:settask
cd %~dp0
:: ����Ҫ���еĽű�·��
set "SCRIPT_PATH=%~dp0һ��������֤.cmd"

:: ���üƻ����������
set "TASK_NAME=autodrcomstart"

:: ��¼ʱ����ģ��
::schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c start /min "" ""%SCRIPT_PATH%""" /SC ONLOGON /RL HIGHEST /F
:: ϵͳ����ʱ����ģ��
::schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c start /min """%SCRIPT_PATH%"""" /SC ONSTART /RL HIGHEST /F
::schtasks /Create /TN "%TASK_NAME%" /TR """"%SCRIPT_PATH%"""" /SC ONLOGON /RL HIGHEST /F

::���üƻ�����
schtasks /Create /TN "%TASK_NAME%" /TR "cmd /c """start """""" /min """%SCRIPT_PATH%""""""" /SC ONSTART /RL HIGHEST /F

:: ��������Ƿ��Ѵ���
if %errorlevel%==0 (
    echo Task "%TASK_NAME%" created successfully.
) else (
    echo Failed to set task "%TASK_NAME%".
)

ECHO.&ECHO ��� &TIMEOUT /t 3 >NUL&EXIT
goto :eof

:deltask
:: ���üƻ����������
set "TASK_NAME=autodrcomstart"

:: ɾ��ָ���ļƻ�����
schtasks /Delete /TN "%TASK_NAME%" /F

:: ��������Ƿ���ɾ��
if %errorlevel%==0 (
    echo Task "%TASK_NAME%" deleted successfully.
) else (
    echo Failed to delete task "%TASK_NAME%".
)

ECHO.&ECHO ��� &TIMEOUT /t 3 >NUL&EXIT
goto :eof


endlocal
