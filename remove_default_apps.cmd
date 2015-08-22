@echo off
cls

echo Remove default apps.
echo.

set SDIR=%~dp0
Powershell.exe -executionpolicy bypass -file "%SDIR%\_remove_default_apps.ps1"

pause
