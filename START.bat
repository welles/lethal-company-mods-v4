@echo off

set git-repository-name=lethal-company-mods-v3

powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Invoke-WebRequest -Uri 'http://gitea.welles.app/nico/%git-repository-name%/raw/branch/main/START.ps1' -OutFile '%~dp0\START.ps1'"

powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0\START.ps1"

pause