Param(
    [Parameter(Mandatory = $false)]
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

$ExecutableName = "Lethal Company."
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

function Install-SingleMod {
    param(
        [String]$Author,
        [String]$Mod,
        [String]$Version
    )

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

    if ([string]::IsNullOrEmpty($Author))
    {
        $NameMatches = @($ModList | Where-Object { $_.Name -eq $Mod })

        if ($NameMatches.Count -eq 0)
        {
            Write-Host "No mod named " -NoNewline -ForegroundColor Red
            Write-Host $Mod -NoNewline -ForegroundColor Cyan
            Write-Host " found in Thunderstore!" -ForegroundColor Red

            exit
        }
        elseif ($NameMatches.Count -eq 1)
        {
            $Author    = $NameMatches[0].Owner
            $ModMetrics = $NameMatches[0]
        }
        else
        {
            Write-Host "Multiple mods named " -NoNewline
            Write-Host $Mod -NoNewline -ForegroundColor Cyan
            Write-Host " found. Choose one:" -ForegroundColor Yellow

            for ($i = 0; $i -lt $NameMatches.Count; $i++)
            {
                Write-Host "[$($i + 1)] $($NameMatches[$i].Owner)"
            }

            do
            {
                $Choice = Read-Host "Choice"
            }
            while (!($Choice -match '^\d+$') -or [int]$Choice -lt 1 -or [int]$Choice -gt $NameMatches.Count)

            $Author     = $NameMatches[[int]$Choice - 1].Owner
            $ModMetrics = $NameMatches[[int]$Choice - 1]
        }
    }
    else
    {
        $ModMetrics = $ModList | Where-Object { $_.Name -eq $Mod -and $_.Owner -eq $Author }

        if ($null -eq $ModMetrics)
        {
            Write-Host "The mod " -NoNewline -ForegroundColor Red
            Write-Host $Mod -NoNewline -ForegroundColor Cyan
            Write-Host " by " -NoNewline -ForegroundColor Red
            Write-Host $Author -NoNewline -ForegroundColor DarkBlue
            Write-Host " could not be found in Thunderstore!" -ForegroundColor Red

            exit
        }
    }

    # Free memory by clearing the massive master list
    $ModList = $null

    $Mod    = $ModMetrics.Name
    $Author = $ModMetrics.Owner

    Write-Host "Installing mod " -NoNewline
    Write-Host $Mod -NoNewline -ForegroundColor Cyan
    Write-Host " by " -NoNewline
    Write-Host $Author -NoNewline -ForegroundColor DarkBlue
    Write-Host "... " -NoNewline

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

    #region DEPENDENCY CHECK

    $DependenciesWithoutBepInEx = [System.Collections.ArrayList]@()

    foreach ($Dependency in $NewestVersion.dependencies)
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

    if ($DependenciesWithoutBepInEx.Length -gt 0)
    {
        $ModFiles = Get-ChildItem "$PluginsDir\*\mod.json", "$PatchersDir\*\mod.json" | ForEach-Object { ConvertFrom-Json (Get-Content $_ -Raw) }

        $MissingDepsList = @()
        Write-Host "This mod has dependencies:" -ForegroundColor Yellow

        foreach ($Dependency in $DependenciesWithoutBepInEx)
        {
            if (($ModFiles | Where-Object { $_.author -eq $Dependency.Author -and $_.name -eq $Dependency.Name } | Measure-Object).Count -eq 1)
            {
                Write-Host "$($Dependency.Author) - $($Dependency.Name) - $($Dependency.Version)" -ForegroundColor Green
            }
            else
            {
                Write-Host "MISSING DEPENDENCY: $($Dependency.Author) - $($Dependency.Name) - $($Dependency.Version)" -ForegroundColor Red
                $MissingDepsList += $Dependency
            }
        }

        $ModFiles = $null

        if ($MissingDepsList.Count -gt 0)
        {
            Write-Host "`nMissing dependencies found. Options:"
            Write-Host "[y] Continue anyway"
            Write-Host "[n] Exit"
            for ($i = 0; $i -lt $MissingDepsList.Count; $i++)
            {
                Write-Host "[$($i + 1)] Install $($MissingDepsList[$i].Author) - $($MissingDepsList[$i].Name)"
            }

            $Choice = Read-Host "Choice"

            if ($Choice -eq "y")
            {
                # Continue
            }
            elseif ($Choice -match '^\d+$' -and [int]$Choice -le $MissingDepsList.Count -and [int]$Choice -gt 0)
            {
                $SelectedDep = $MissingDepsList[[int]$Choice - 1]
                Install-SingleMod -Author $SelectedDep.Author -Mod $SelectedDep.Name -Version $null
                return
            }
            else
            {
                exit
            }
        }
    }

    #endregion DEPENDENCY CHECK

    $IsUpdate = $false

    $ConfigFiles = @()

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

        if ($ModInfoExists -and $ModInfo.config_files)
        {
            $ConfigFiles = @($ModInfo.config_files)

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

    $UntrackedConfigs = git ls-files --others --exclude-standard BepInEx/config

    if ($UntrackedConfigs)
    {
        Write-Host "`nDetected new/untracked config files:" -ForegroundColor Cyan
        foreach ($File in $UntrackedConfigs)
        {
            $Confirmation = Read-Host "Add '$File'? (y/n)"
            if ($Confirmation -eq 'y')
            {
                $ConfigFiles += $File
            }
        }
        Write-Host ""
    }

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

    Write-Host "Writing mod info to file... " -NoNewline

    $ModInfo = [ordered] @{
        author       = $ModMetrics.Owner
        name         = $ModMetrics.Name
        version      = $NewestVersion.Version_Number
        config_files = @($ConfigFiles)
    }

    Set-Content "$PluginsDir\$FileName\mod.json" -Value (ConvertTo-Json $ModInfo)

    Write-Host "[OK]" -ForegroundColor Green

    Write-Host "Checking for large files (>=100MB)... " -NoNewline

    $DirsToCheck = @("$PluginsDir\$FileName")
    if (Test-Path "$PatchersDir\$FileName") { $DirsToCheck += "$PatchersDir\$FileName" }
    if (Test-Path "$CoreDir\$FileName")    { $DirsToCheck += "$CoreDir\$FileName" }

    $LargeFiles = $DirsToCheck | ForEach-Object {
        Get-ChildItem -Path $_ -Recurse -File -ErrorAction SilentlyContinue
    } | Where-Object { $_.Length -ge 100MB }

    if ($LargeFiles.Count -eq 0)
    {
        Write-Host "[None found]" -ForegroundColor Green
    }
    else
    {
        Write-Host "[$($LargeFiles.Count) found]" -ForegroundColor Yellow

        foreach ($LargeFile in $LargeFiles)
        {
            $ArchiveBase = "$($LargeFile.FullName).7z"
            $FirstPart   = "$ArchiveBase.001"

            if (Test-Path -Path $FirstPart)
            {
                Write-Host "Skipping $($LargeFile.Name) (already split)" -ForegroundColor DarkGray
                continue
            }

            Write-Host "Splitting $($LargeFile.Name)... " -NoNewline

            & 7zz a -v100m "$ArchiveBase" "$($LargeFile.FullName)" | Out-Null

            if ($LASTEXITCODE -ne 0)
            {
                Write-Host "[Fehler beim Aufteilen!]" -ForegroundColor Red
            }
            else
            {
                Write-Host "[OK]" -ForegroundColor Green

                $GitIgnorePath = "$($LargeFile.DirectoryName)\.gitignore"
                $EntryToAdd    = $LargeFile.Name

                $ExistingEntries = @()
                if (Test-Path $GitIgnorePath)
                {
                    $ExistingEntries = Get-Content $GitIgnorePath
                }

                if ($ExistingEntries -notcontains $EntryToAdd)
                {
                    Add-Content -Path $GitIgnorePath -Value $EntryToAdd
                    Write-Host "Added '$EntryToAdd' to .gitignore" -ForegroundColor DarkGray
                }
            }
        }
    }

    if ($IsUpdate)
    {
        Write-Host "Update $($ModInfo.Name) by $($ModInfo.Author) to $($ModInfo.Version)" -ForegroundColor Magenta
    }
    else
    {
        Write-Host "Install $($ModInfo.Name) by $($ModInfo.Author) $($ModInfo.Version)" -ForegroundColor Magenta
    }

    Write-Host "DONE!" -ForegroundColor Green
}

Install-SingleMod -Author $Author -Mod $Mod -Version $Version
