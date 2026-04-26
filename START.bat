@echo off

powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/welles/lethal-company-mods-v4/refs/heads/main/START.ps1' -OutFile '%~dp0\START.ps1'"

powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0\START.ps1"

pause
