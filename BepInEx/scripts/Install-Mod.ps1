Param(
    [Parameter(Mandatory = $true)]
    [String]$Author,
    [Parameter(Mandatory = $true)]
    [String]$Mod,
    [Parameter(Mandatory = $false)]
    [String]$Version,
    [switch]$ForceModListUpdate
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
$PatchersDir = "$BepInExDir\patchers"
$ScriptsDir = "$BepInExDir\scripts"
$ConfigDir = "$BepInExDir\config"
$CoreDir = "$BepInExDir\core"

Write-Host "Installing mod " -NoNewline
Write-Host $Mod -NoNewline -ForegroundColor Cyan
Write-Host " by " -NoNewline
Write-Host $Author -NoNewline -ForegroundColor DarkBlue
Write-Host "... "

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

Write-Host "Looking for mod in master list... " -NoNewline

$ModList = ConvertFrom-Json (Get-Content $ModListPath -Raw)

$ModMetrics = $ModList | Where-Object { $_.Name -eq $Mod -and $_.Owner -eq $Author }

if ($null -eq $ModMetrics)
{
    Write-Host "[Error]" -ForegroundColor Red

    Write-Host "The mod " -NoNewline -ForegroundColor Red
    Write-Host $Mod -NoNewline -ForegroundColor Cyan
    Write-Host " by " -NoNewline -ForegroundColor Red
    Write-Host $Author -NoNewline -ForegroundColor DarkBlue
    Write-Host " could not be found in Thunderstore!" -ForegroundColor Red

    exit
}

if ($Version)
{
    $NewestVersion = $ModMetrics.Versions | Where-Object { $_.Version_Number -eq $Version }
}
else
{
    $Version = "(Newest)"
    $NewestVersion = $ModMetrics.Versions | Select-Object -First 1
}

if ($null -eq $NewestVersion)
{
    Write-Host "[Error]" -ForegroundColor Red

    Write-Host "The version " -NoNewline -ForegroundColor Red
    Write-Host $Version -NoNewline -ForegroundColor DarkMagenta
    Write-Host " of the mod " -NoNewline -ForegroundColor Red
    Write-Host $Mod -NoNewline -ForegroundColor Cyan
    Write-Host " by " -NoNewline -ForegroundColor Red
    Write-Host $Author -NoNewline -ForegroundColor DarkBlue
    Write-Host " could not be found in Thunderstore!" -ForegroundColor Red

    exit
}

$DownloadUrl = $NewestVersion.Download_Url

$FileName = $ModMetrics.Full_Name

Write-Host "[OK: $($NewestVersion.Version_Number)]" -ForegroundColor Green

$IsUpdate = $false

$ConfigFiles = @()
$LfsFiles = @()

if (Test-Path "$PluginsDir\$FileName")
{
    Write-Host "Found existing installation in plugins, deleting... " -NoNewline -ForegroundColor Yellow

    $ModInfoExists = (Test-Path "$PluginsDir\$FileName\mod.json")

    if ($ModInfoExists)
    {
        $ModInfo = (Get-Content "$PluginsDir\$FileName\mod.json") | ConvertFrom-Json
    }

    Remove-Item "$PluginsDir\$FileName" -Recurse

    Write-Host "[OK]" -ForegroundColor Green

    if ($ModInfoExists -and $ModInfo.ConfigFiles)
    {
        $ConfigFiles = $ModInfo.ConfigFiles

        $ConfigFiles | ForEach-Object {
            Write-Host "Deleting config file $_ "  -NoNewline -ForegroundColor Yellow

            if (Test-Path "$BaseDir\$_")
            {
                Remove-Item "$BaseDir\$_"

                Write-Host "[OK]" -ForegroundColor Green
            }
            else
            {
                Write-Host "[Not Found]" -ForegroundColor Yellow
            }
        }
    }

    if ($ModInfoExists -and $ModInfo.LfsFiles) {
        $LfsFiles = $ModInfo.LfsFiles
    }

    $IsUpdate = $true
}

if (Test-Path "$CoreDir\$FileName")
{
    Write-Host "Found existing installation in core, deleting... " -NoNewline -ForegroundColor Yellow

    Remove-Item "$CoreDir\$FileName" -Recurse

    Write-Host "[OK]" -ForegroundColor Green
}

if (Test-Path "$PatchersDir\$FileName")
{
    Write-Host "Found existing installation in patchers, deleting... " -NoNewline -ForegroundColor Yellow

    Remove-Item "$PatchersDir\$FileName" -Recurse

    Write-Host "[OK]" -ForegroundColor Green
}

Write-Host "Downloading mod files... " -NoNewline

Invoke-WebRequest $DownloadUrl -OutFile "$PluginsDir\$FileName.zip"

Write-Host "[OK]" -ForegroundColor Green

Write-Host "Extracting mod files... " -NoNewline

Expand-Archive "$PluginsDir\$FileName.zip" -DestinationPath "$PluginsDir\$FileName"

Write-Host "[OK]" -ForegroundColor Green

Write-Host "Deleting downloaded archive... " -NoNewline

Remove-Item "$PluginsDir\$FileName.zip"

Write-Host "[OK]" -ForegroundColor Green

if (Test-Path "$PluginsDir\$FileName\BepInEx")
{
    Write-Host "Found BepInEx in files, moving up... " -NoNewline

    Move-Item "$PluginsDir\$FileName\BepInEx\*" "$PluginsDir\$FileName" -Force

    Remove-Item "$PluginsDir\$FileName\BepInEx"

    Write-Host "[OK]" -ForegroundColor Green
}

if (Test-Path "$PluginsDir\$FileName\patchers")
{
    Write-Host "Found patchers in files, moving up... " -NoNewline

    New-Item "$PatchersDir\$FileName" -ItemType Directory | Out-Null

    Move-Item "$PluginsDir\$FileName\patchers\*" "$PatchersDir\$FileName" -Force

    Remove-Item "$PluginsDir\$FileName\patchers"

    Write-Host "[OK]" -ForegroundColor Green
}

if (Test-Path "$PluginsDir\$FileName\core")
{
    Write-Host "Found core in files, moving up... " -NoNewline

    New-Item "$CoreDir\$FileName" -ItemType Directory | Out-Null

    Move-Item "$PluginsDir\$FileName\core\*" "$CoreDir\$FileName" -Force

    Remove-Item "$PluginsDir\$FileName\core"

    Write-Host "[OK]" -ForegroundColor Green
}

if (Test-Path "$PluginsDir\$FileName\config")
{
    Write-Host "Found config in files, moving up... " -NoNewline

    Copy-Item -Path "$PluginsDir\$FileName\config\*" -Destination "$ConfigDir" -Force -Recurse

    Remove-Item "$PluginsDir\$FileName\config" -Recurse

    Write-Host "[OK]" -ForegroundColor Green
}

if (Test-Path "$PluginsDir\$FileName\plugins")
{
    Write-Host "Found plugins in files, moving up... " -NoNewline

    Move-Item "$PluginsDir\$FileName\plugins\*" "$PluginsDir\$FileName" -Force

    Remove-Item "$PluginsDir\$FileName\plugins"

    Write-Host "[OK]" -ForegroundColor Green
}

Write-Host "Checking mod manifest... " -NoNewline

$ModManifest = ConvertFrom-Json (Get-Content "$PluginsDir\$FileName\manifest.json" -Raw)

$DependenciesWithoutBepInEx = [System.Collections.ArrayList]@()

foreach ($Dependency in $ModManifest.Dependencies)
{
    $DependencyAuthor = ($Dependency -split "-")[0]
    $DependencyName = ($Dependency -split "-")[1]
    $DependencyVersion = ($Dependency -split "-")[2]

    if ($DependencyAuthor -ne "BepInEx" -and $DependencyName -ne "BepInExPack")
    {
        $DependenyManifest =
        @{
            Author  = $DependencyAuthor
            Name    = $DependencyName
            Version = $DependencyVersion
        }

        $DependenciesWithoutBepInEx.Add($DependenyManifest) | Out-Null
    }
}

Write-Host "[OK]" -ForegroundColor Green

$MissingDependencies = $false

if ($DependenciesWithoutBepInEx.Length -gt 0)
{
    $ModFiles = Get-ChildItem "$PluginsDir\*\mod.json", "$PatchersDir\*\mod.json" | ForEach-Object { ConvertFrom-Json (Get-Content $_ -Raw) }

    Write-Host "This mod has dependencies:" -ForegroundColor Yellow

    foreach ($Dependency in $DependenciesWithoutBepInEx)
    {

        if (($ModFiles | Where-Object { $_.Author -eq $Dependency.Author -and $_.Name -eq $Dependency.Name } | Measure-Object).Count -eq 1)
        {
            Write-Host "$($Dependency.Author) - $($Dependency.Name) - $($Dependency.Version)" -ForegroundColor Green
        }
        else
        {
            Write-Host "MISSING DEPENDENCY: $($Dependency.Author) - $($Dependency.Name) - $($Dependency.Version)" -ForegroundColor Red

            $MissingDependencies = $true
        }
    }
}

if ($MissingDependencies)
{
    $ContinueWithoutDependencies = Read-Host "There are missing dependencies! Continue anyway? (y/n)"

    if ($ContinueWithoutDependencies -ne "y")
    {
        return
    }
}

Write-Host "Starting game... " -NoNewline

Start-Process steam://rungameid/$SteamGameId -Wait

Write-Host "[OK]" -ForegroundColor Green

Write-Host "Waiting until game process is found... " -NoNewline

do
{
    $GameProcess = Get-Process -Name "$ExecutableName" -ErrorAction SilentlyContinue

    Start-Sleep -Milliseconds 100
}
while ($null -eq $GameProcess)

Write-Host "[OK]" -ForegroundColor Green

Write-Host "Waiting until game exits... " -NoNewline

Wait-Process -InputObject $GameProcess

$Crashed = ($GameProcess.ExitCode -ne 0)

if ($Crashed)
{
    Write-Host "[Crash]" -ForegroundColor Red
}
else
{
    Write-Host "[OK]" -ForegroundColor Green
}

#region CONFIG FILES

Write-Host "Config Files:"
$ConfigFiles | ForEach-Object { Write-Host "- $_" }

while ($true)
{
    $InputPath = Read-Host "Enter path to config file (or 'q' to quit)"

    if ([string]::IsNullOrWhiteSpace($InputPath))
    {
        continue
    }
    elseif ($InputPath -eq 'q')
    {
        break
    }
    elseif (Test-Path "$BaseDir\$InputPath")
    {
        $ConfigFiles += $InputPath
    }
    else
    {
        Write-Host "Path does not exist: $InputPath" -ForegroundColor Red
    }
}

$ConfigFiles = $ConfigFiles | Select-Object -Unique

Write-Host "Config Files:"
$ConfigFiles | ForEach-Object { Write-Host "- $_" }

#endregion CONFIG FILES

#region LFS FILES

Write-Host "LFS Files:"
$LfsFiles | ForEach-Object { Write-Host "- $_" }

while ($true)
{
    $InputPath = Read-Host "Enter path to LFS file (or 'q' to quit)"

    if ([string]::IsNullOrWhiteSpace($InputPath))
    {
        continue
    }
    elseif ($InputPath -eq 'q')
    {
        break
    }
    elseif (Test-Path "$BaseDir\$InputPath")
    {
        $LfsFiles += $InputPath
    }
    else
    {
        Write-Host "Path does not exist: $InputPath" -ForegroundColor Red
    }
}

$LfsFiles = $LfsFiles | Select-Object -Unique

Write-Host "LFS Files:"
$LfsFiles | ForEach-Object { Write-Host "- $_" }

if ($LfsFiles.Length -gt 0) {
    Write-Host "Writing LFS git attributes to files... " -NoNewline

    foreach ($LfsFile in $LfsFiles) {
        $LfsFilePath = "$BaseDir\$LfsFile"

        $LfsDirectory = (Get-Item $LfsFilePath).Directory.FullName
        $LfsName = (Get-Item $LfsFilePath).Name

        $GitAttributesPath = "$LfsDirectory\.gitattributes"

        Add-Content -Path $GitAttributesPath -Value "$LfsName filter=lfs diff=lfs merge=lfs -text"
    }

    Write-Host "[OK]" -ForegroundColor Green
}

#endregion LFS FILES

Write-Host "Writing mod info to file... " -NoNewline

$ModInfo = [ordered] @{
    Author  = $ModMetrics.Owner
    Name    = $ModMetrics.Name
    Version = $NewestVersion.Version_Number
}

if ($ConfigFiles.Length -gt 0)
{
    $ModInfo.ConfigFiles = $ConfigFiles
}

if ($LfsFiles.Length -gt 0)
{
    $ModInfo.LfsFiles = $LfsFiles
}

Set-Content "$PluginsDir\$FileName\mod.json" -Value (ConvertTo-Json $ModInfo)

Write-Host "[OK]" -ForegroundColor Green

if ($IsUpdate)
{
    Write-Host "Update $($ModInfo.Name) by $($ModInfo.Author) to $($ModInfo.Version)" -ForegroundColor Magenta
}
else
{
    Write-Host "Install $($ModInfo.Name) by $($ModInfo.Author) $($ModInfo.Version)" -ForegroundColor Magenta
}

Write-Host "DONE!" -ForegroundColor Green
