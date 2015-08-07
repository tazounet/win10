@echo off
cls

echo Disable Lock Screen.
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f

pause
