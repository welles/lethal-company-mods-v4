function Invoke-Utility
{
    # StackOverflow: https://stackoverflow.com/a/48877892
    $exe, $argsForExe = $Args
    $ErrorActionPreference = 'Continue'
    try { return & $exe $argsForExe } catch { Throw }
    if ($LASTEXITCODE) { Throw "$exe ist fehlgeschlagen! (Exit Code $LASTEXITCODE; Kompletter Befehl: $Args) Nico Bescheid geben und Skript neu starten!" }
    $ErrorActionPreference = 'Stop'
}

$OriginalColor = $Host.UI.RawUI.ForegroundColor

$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"
$global:ProgressPreference = $ProgressPreference
$global:ErrorActionPreference = $ErrorActionPreference

$ExecutableName = "Lethal Company"
$ThunderstoreName = "lethal-company"
$GitRepository = "https://github.com/welles/lethal-company-mods-v4.git"
$SteamGameId = "1966720"

$BaseDirectory = $PSScriptRoot

Set-Location $BaseDirectory

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Checke ob START.bat sich im Spielverzeichnis befindet..."

if (!(Test-Path "$BaseDirectory\$ExecutableName.exe"))
{
    Write-Host "$ExecutableName nicht gefunden! Lege diese Skriptdatei in den Ordner neben `"$ExecutableName.exe`" und probiere es erneut!" -ForegroundColor Red

    exit
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Checke ob lokale Git-Installation vorhanden ist..."

$DoesGitExeExist = (Test-Path -Path "$BaseDirectory\git\bin\git.exe")

$GitVersion = ""
if ($DoesGitExeExist)
{
    $Host.UI.RawUI.ForegroundColor = "DarkGray"
    $GitVersion = (Invoke-Utility "$BaseDirectory\git\bin\git.exe" version)
    Write-Host $GitVersion
    $Host.UI.RawUI.ForegroundColor = $OriginalColor
}

if (!$DoesGitExeExist -or !($GitVersion -like "git version*"))
{
    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lokale Git-Installation ist nicht vorhanden!" -ForegroundColor Yellow

    if (Test-Path -Path "$BaseDirectory\git")
    {
        Write-Host "### " -ForegroundColor Cyan -NoNewline
        Write-Host "Entferne Reste alter Git-Installationen..."

        Remove-Item -Path "$BaseDirectory\git" -Recurse -Force
    }

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lade aktuelle Git-Installation herunter..."

    $LatestRelease = (Invoke-WebRequest https://api.github.com/repos/git-for-windows/git/releases -UseBasicParsing | ConvertFrom-Json) | Where-Object { $_.Prerelease -eq $False } | Select-Object -First 1
    $LatestReleaseAsset = $LatestRelease.Assets | Where-Object { $_.Name -match "PortableGit-[\d.]+-64-bit\.7z\.exe" }
    $LatestReleaseDownloadUrl = $LatestReleaseAsset.Browser_Download_Url

    Invoke-WebRequest -Uri "$LatestReleaseDownloadUrl" -OutFile "$BaseDirectory\git-install.exe"

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Extrahiere lokale Git-Installation..."

    Start-Process -FilePath "$BaseDirectory\git-install.exe" -ArgumentList "-o `"$BaseDirectory\git`" -y -gm2 -fm0" -Wait -NoNewWindow

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lokale Git-Installation wurde installiert!" -ForegroundColor Green
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Checke ob lokale 7-Zip-Installation vorhanden ist..."

$Does7zExeExist = (Test-Path -Path "$BaseDirectory\7z\7z.exe")

if (!$Does7zExeExist)
{
    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lokale 7-Zip-Installation ist nicht vorhanden!" -ForegroundColor Yellow

    if (Test-Path -Path "$BaseDirectory\7z")
    {
        Write-Host "### " -ForegroundColor Cyan -NoNewline
        Write-Host "Entferne Reste alter 7-Zip-Installationen..."

        Remove-Item -Path "$BaseDirectory\7z" -Recurse -Force
    }

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lade aktuelle 7-Zip-Installation herunter..."

    $Latest7zRelease = (Invoke-WebRequest https://api.github.com/repos/ip7z/7zip/releases -UseBasicParsing | ConvertFrom-Json) | Where-Object { $_.Prerelease -eq $False } | Select-Object -First 1
    $Latest7zAsset = $Latest7zRelease.Assets | Where-Object { $_.Name -match "7z[\d]+-x64\.exe" }
    $Latest7zDownloadUrl = $Latest7zAsset.Browser_Download_Url

    Invoke-WebRequest -Uri "$Latest7zDownloadUrl" -OutFile "$BaseDirectory\7z-install.exe"

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Extrahiere lokale 7-Zip-Installation..."

    Start-Process -FilePath "$BaseDirectory\7z-install.exe" -ArgumentList "/S /D=$BaseDirectory\7z" -Wait -NoNewWindow

    Remove-Item -Path "$BaseDirectory\7z-install.exe" -Force

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lokale 7-Zip-Installation wurde installiert!" -ForegroundColor Green
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Deaktiviere Sperrung von fremden Git-Repositories..."

Invoke-Utility "$BaseDirectory\git\bin\git.exe" config --global --unset-all safe.directory
Invoke-Utility "$BaseDirectory\git\bin\git.exe" config --global --add safe.directory '*'

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Checke ob es einen Fehler beim letzten Lauf von Git gab..."

if (Test-Path -Path "$BaseDirectory\.git\index.lock")
{
    Write-Host "Das Update der Mod-Dateien wurde beim letzten Lauf vorzeitig beendet oder ist gecrasht. Es wird versucht, den richtigen Zustand wiederherzustellen. Wenn es weiter nicht funktioniert, bitte den `".git`"-Ordner komplett entfernen und das Skript neu starten." -ForegroundColor Red

    Remove-Item -Path "$BaseDirectory\.git\index.lock" -Force
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Checke ob lokale Spieldateien mit Git-Repository verbunden sind..."

$Host.UI.RawUI.ForegroundColor = "DarkGray"
$IsRepository = (Invoke-Utility "$BaseDirectory\git\bin\git.exe" rev-parse --is-inside-work-tree)
$Host.UI.RawUI.ForegroundColor = $OriginalColor

$Host.UI.RawUI.ForegroundColor = "DarkGray"
$RemoteUrl = (Invoke-Utility "$BaseDirectory\git\bin\git.exe" config --get remote.origin.url)
$Host.UI.RawUI.ForegroundColor = $OriginalColor

if ($IsRepository -ne "true" -or $RemoteUrl -ne "$GitRepository")
{
    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Lokale Spieldateien sind nicht mit dem Repository verbunden!" -ForegroundColor Yellow

    if (Test-Path -Path "$BaseDirectory\.git")
    {
        Write-Host "### " -ForegroundColor Cyan -NoNewline
        Write-Host "Entferne Reste alter Git-Repositories..."

        Remove-Item -Path "$BaseDirectory\.git" -Recurse -Force
    }

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Initialisiere neues Git-Repository..."

    $Host.UI.RawUI.ForegroundColor = "DarkGray"
    Invoke-Utility "$BaseDirectory\git\bin\git.exe" init -b main
    $Host.UI.RawUI.ForegroundColor = $OriginalColor

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Stelle Verbindung zum Repository-Server her..."

    $Host.UI.RawUI.ForegroundColor = "DarkGray"
    Invoke-Utility "$BaseDirectory\git\bin\git.exe" remote add origin $GitRepository
    $Host.UI.RawUI.ForegroundColor = $OriginalColor

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Versteckt-Status des Repository-Ordners entfernen..."
    Set-ItemProperty -Path "$BaseDirectory\.git" -Name Attributes -Value Normal

    Write-Host "### " -ForegroundColor Cyan -NoNewline
    Write-Host "Repository wurde mit dem Server verbunden!" -ForegroundColor Green
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Lade Daten vom Repository-Server..."

$Host.UI.RawUI.ForegroundColor = "DarkGray"
Invoke-Utility "$BaseDirectory\git\bin\git.exe" fetch --depth 1 origin main --tags
$Host.UI.RawUI.ForegroundColor = $OriginalColor

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Aktualisiere lokale Dateien auf neuesten Stand im Repository... (Kann beim ersten mal dauern!)"

$Host.UI.RawUI.ForegroundColor = "DarkGray"
Invoke-Utility "$BaseDirectory\git\bin\git.exe" reset --hard origin/main
$Host.UI.RawUI.ForegroundColor = $OriginalColor

# $LatestTagHash = Invoke-Utility "$BaseDirectory\git\bin\git.exe" rev-list --tags --max-count=1
# $LatestTagName = Invoke-Utility "$BaseDirectory\git\bin\git.exe" describe --tags $LatestTagHash

# Write-Host "### " -ForegroundColor Cyan -NoNewline
# Write-Host "Die neueste Version des Modpacks ist: v$LatestTagName"

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Entferne Dateien, die nicht vom Spiel oder Repository sind..."

$Host.UI.RawUI.ForegroundColor = "DarkGray"
Invoke-Utility "$BaseDirectory\git\bin\git.exe" clean -df
$Host.UI.RawUI.ForegroundColor = $OriginalColor

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Extrahiere aufgeteilte Mod-Dateien..."

$Archives = Get-ChildItem -Path "$BaseDirectory\BepInEx" -Filter "*.7z.001" -Recurse -ErrorAction SilentlyContinue

foreach ($Archive in $Archives)
{
    $OriginalFilePath = $Archive.FullName -replace '\.7z\.001$', ''

    $NeedsExtraction = !(Test-Path -Path $OriginalFilePath) -or
                       ($Archive.LastWriteTime -gt (Get-Item $OriginalFilePath).LastWriteTime)

    if ($NeedsExtraction)
    {
        Write-Host "Extrahiere $($Archive.Name)... " -NoNewline

        Invoke-Utility "$BaseDirectory\7z\7z.exe" x "$($Archive.FullName)" "-o$($Archive.DirectoryName)" -y

        Write-Host "[OK]" -ForegroundColor Green
    }
}

Write-Host "### " -ForegroundColor Cyan -NoNewline
Write-Host "Fertig! Das Spiel kann gestartet werden!" -ForegroundColor Green
