Param(
    [Parameter(Mandatory = $true)]
    [String]$Author,
    [Parameter(Mandatory = $true)]
    [String]$Mod
)

$global:ProgressPreference = 'Continue'
$global:ErrorActionPreference = 'Stop'
$ProgressPreference = 'Continue'
$ErrorActionPreference = 'Stop'

$BaseDir = "$PSScriptRoot\..\.."
$BepInExDir = "$BaseDir\BepInEx"
$PluginsDir = "$BepInExDir\plugins"
$PatchersDir = "$BepInExDir\patchers"
$ConfigDir = "$BepInExDir\config"
$CoreDir = "$BepInExDir\core"

function Remove-SingleMod {
    param(
        [String]$Author,
        [String]$Mod,
        [switch]$IsDependency
    )

    Write-Host "Removing mod " -NoNewline
    Write-Host $Mod -NoNewline -ForegroundColor Cyan
    Write-Host " by " -NoNewline
    Write-Host $Author -NoNewline -ForegroundColor DarkBlue
    Write-Host "..."

    $FileName = "$Author-$Mod"

    if (!(Test-Path "$PluginsDir\$FileName\mod.json"))
    {
        Write-Host "Mod " -NoNewline -ForegroundColor Red
        Write-Host $FileName -NoNewline -ForegroundColor Cyan
        Write-Host " is not installed!" -ForegroundColor Red

        exit
    }

    $ModInfo = ConvertFrom-Json (Get-Content "$PluginsDir\$FileName\mod.json" -Raw)

    # Warn if other mods still depend on this one, unless we were called from a
    # dependency removal — in that case the caller already knows about this relationship
    if (!$IsDependency)
    {
        $Dependents = Get-ChildItem "$PluginsDir\*\manifest.json" -ErrorAction SilentlyContinue |
            Where-Object { $_.Directory.Name -ne $FileName } |
            ForEach-Object { ConvertFrom-Json (Get-Content $_.FullName -Raw) } |
            Where-Object { $_.dependencies -like "$Author-$Mod-*" } |
            ForEach-Object { $_.name }

        if ($Dependents)
        {
            Write-Host "Warning: the following installed mods depend on $Mod`:" -ForegroundColor Yellow

            foreach ($Dependent in $Dependents)
            {
                Write-Host "  - $Dependent" -ForegroundColor Yellow
            }

            $Confirmation = Read-Host "Remove anyway? (y/n)"

            if ($Confirmation -ne "y")
            {
                exit
            }
        }
    }

    # Read dependencies from manifest.json left behind by Thunderstore zip
    $Dependencies = @()

    $ManifestPath = "$PluginsDir\$FileName\manifest.json"

    if (Test-Path $ManifestPath)
    {
        $Manifest = ConvertFrom-Json (Get-Content $ManifestPath -Raw)

        if ($Manifest.dependencies)
        {
            $Dependencies = @($Manifest.dependencies)
        }
    }

    # Classify each non-BepInEx dependency as removable or blocked by another mod
    $RemovableDeps = [System.Collections.ArrayList]@()
    $BlockedDeps   = [System.Collections.ArrayList]@()

    foreach ($Dependency in $Dependencies)
    {
        $Parts     = $Dependency -split "-"
        $DepAuthor = $Parts[0]
        $DepName   = $Parts[1]

        if ($DepAuthor -eq "BepInEx" -and $DepName -eq "BepInExPack") { continue }

        $DepFileName = "$DepAuthor-$DepName"

        # Skip deps that are not currently installed
        if (!(Test-Path "$PluginsDir\$DepFileName") -and
            !(Test-Path "$PatchersDir\$DepFileName") -and
            !(Test-Path "$CoreDir\$DepFileName"))
        {
            continue
        }

        # Find other installed mods whose manifest lists this dep
        $DependentMods = Get-ChildItem "$PluginsDir\*\manifest.json" -ErrorAction SilentlyContinue |
            Where-Object { $_.Directory.Name -ne $FileName } |
            ForEach-Object { ConvertFrom-Json (Get-Content $_.FullName -Raw) } |
            Where-Object { $_.dependencies -like "$DepAuthor-$DepName-*" } |
            ForEach-Object { $_.name }

        if ($DependentMods)
        {
            $BlockedDeps.Add([PSCustomObject]@{
                Author = $DepAuthor
                Name   = $DepName
                UsedBy = @($DependentMods)
            }) | Out-Null
        }
        else
        {
            $RemovableDeps.Add([PSCustomObject]@{
                Author = $DepAuthor
                Name   = $DepName
            }) | Out-Null
        }
    }

    if ($BlockedDeps.Count -gt 0 -or $RemovableDeps.Count -gt 0)
    {
        Write-Host "This mod has dependencies:" -ForegroundColor Yellow

        foreach ($Dep in $BlockedDeps)
        {
            Write-Host "$($Dep.Author) - $($Dep.Name) " -NoNewline -ForegroundColor DarkGray
            Write-Host "[In use by: $($Dep.UsedBy -join ', ')]" -ForegroundColor Yellow
        }

        for ($i = 0; $i -lt $RemovableDeps.Count; $i++)
        {
            Write-Host "[$($i + 1)] $($RemovableDeps[$i].Author) - $($RemovableDeps[$i].Name)" -ForegroundColor Green
        }
    }

    if ($RemovableDeps.Count -gt 0)
    {
        Write-Host "`nRemovable dependencies found. Options:"
        Write-Host "[y] Remove $Mod only"
        Write-Host "[n] Exit"

        for ($i = 0; $i -lt $RemovableDeps.Count; $i++)
        {
            Write-Host "[$($i + 1)] Remove $($RemovableDeps[$i].Author) - $($RemovableDeps[$i].Name) first"
        }

        $Choice = Read-Host "Choice"

        if ($Choice -eq "y")
        {
            # Continue to remove main mod
        }
        elseif ($Choice -match '^\d+$' -and [int]$Choice -le $RemovableDeps.Count -and [int]$Choice -gt 0)
        {
            $SelectedDep = $RemovableDeps[[int]$Choice - 1]
            Remove-SingleMod -Author $SelectedDep.Author -Mod $SelectedDep.Name -IsDependency
            return
        }
        else
        {
            exit
        }
    }

    # Remove config files tracked in mod.json
    foreach ($ConfigFile in $ModInfo.config_files)
    {
        Write-Host "Removing config file $ConfigFile... " -NoNewline -ForegroundColor Yellow

        if (Test-Path "$BaseDir\$ConfigFile")
        {
            Remove-Item "$BaseDir\$ConfigFile"

            Write-Host "[OK]" -ForegroundColor Green
        }
        else
        {
            Write-Host "[Not Found]" -ForegroundColor Yellow
        }
    }

    # Remove mod from all install locations
    if (Test-Path "$PluginsDir\$FileName")
    {
        Write-Host "Removing from plugins... " -NoNewline

        Remove-Item "$PluginsDir\$FileName" -Recurse

        Write-Host "[OK]" -ForegroundColor Green
    }

    if (Test-Path "$PatchersDir\$FileName")
    {
        Write-Host "Removing from patchers... " -NoNewline

        Remove-Item "$PatchersDir\$FileName" -Recurse

        Write-Host "[OK]" -ForegroundColor Green
    }

    if (Test-Path "$CoreDir\$FileName")
    {
        Write-Host "Removing from core... " -NoNewline

        Remove-Item "$CoreDir\$FileName" -Recurse

        Write-Host "[OK]" -ForegroundColor Green
    }

    Write-Host "Removed $Mod by $Author" -ForegroundColor Magenta
    Write-Host "DONE!" -ForegroundColor Green
}

Remove-SingleMod -Author $Author -Mod $Mod
