param (
    [switch]
    $WhatIf,
    [switch]
    $ForceModListUpdate
)

$global:ProgressPreference = 'Continue'
$global:ErrorActionPreference = 'Stop'
$ProgressPreference = 'Continue'
$ErrorActionPreference = 'Stop'

$ExecutableName = "Lethal Company"
$ThunderstoreName = "lethal-company"
$GitRepositoryName = "lethal-company-mods-v3"
$SteamGameId = "1966720"

$BaseDir = "$PSScriptRoot\..\.."
$BepInExDir = "$BaseDir\BepInEx"
$PluginsDir = "$BepInExDir\plugins"
$ScriptsDir = "$BepInExDir\scripts"
$PatchersDir = "$BepInExDir\patchers"

$ModListPath = "$BepInExDir\mods.json"

if (!(Test-Path $ModListPath) -or $ForceModListUpdate.IsPresent -or (Get-Item $ModListPath).LastWriteTime -lt (Get-Date).AddDays(-1))
{
    Write-Host "Downloading mod master list... " -NoNewline

    Invoke-WebRequest "https://thunderstore.io/c/$ThunderstoreName/api/v1/package" -OutFile $ModListPath -ErrorAction Stop

    Write-Host "[OK]" -ForegroundColor Green
}
else
{
    $LastModListUpdate = (Get-Item $ModListPath).LastWriteTime.ToString("dd.MM.yyyy HH:mm:ss")

    Write-Host "Using existing mod master list... ($LastModListUpdate)"
}

$ModList = ConvertFrom-Json (Get-Content $ModListPath -Raw)

$ModFiles = Get-ChildItem "$PluginsDir\*\mod.json", "$PatchersDir\*\mod.json"

foreach ($ModFile in $ModFiles)
{
    $ModInfo = ConvertFrom-Json (Get-Content "$ModFile" -Raw)

    Write-Host "Checking mod " -NoNewline
    Write-Host $ModInfo.Name -NoNewline -ForegroundColor Cyan
    Write-Host " by " -NoNewline
    Write-Host $ModInfo.Author -NoNewline -ForegroundColor DarkBlue
    Write-Host "... " -NoNewline

    $ModMetrics = $ModList | Where-Object { $_.Name -eq $ModInfo.Name -and $_.Owner -eq $ModInfo.Author }

    if ($null -eq $ModMetrics.Versions -or $ModMetrics.Versions.Length -eq 0)
    {
        Write-Host "[NO VERSION FOUND IN THUNDERSTORE]" -ForegroundColor Red

        continue
    }

    $NewestVersion = $ModMetrics.Versions[0]

    if ($NewestVersion.Version_Number -ne $ModInfo.Version)
    {
        Write-Host "[Update available: $($NewestVersion.Version_Number)]" -ForegroundColor Yellow

        if (!$WhatIf.IsPresent)
        {
            & "$BepInExDir\scripts\Install-Mod.ps1" -Mod $ModInfo.Name -Author $ModInfo.Author

            Write-Host "Waiting until changes are committed... " -NoNewline

            $Null = Read-Host -MaskInput
        }
    }
    else
    {
        Write-Host "[No Update: $($ModInfo.Version)]" -ForegroundColor Green
    }
}
