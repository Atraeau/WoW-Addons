#requires -Version 5.1
<#
.SYNOPSIS
    Link (or copy) every addon under src/ into the WoW: Forever AddOns folder.

.DESCRIPTION
    By default this creates a directory JUNCTION for each addon folder, so the
    game reads your source live and you never have to re-copy after an edit.
    Junctions do NOT require administrator rights.

    Use -Copy to hard-copy instead (useful for packaging or if the game is on a
    different drive where junctions aren't possible).

.PARAMETER Name
    Deploy only the named addon(s). Omit to deploy all addons under src/.

.PARAMETER Copy
    Copy files instead of creating a junction.

.PARAMETER Clean
    Remove the deployed link/copy for the selected addon(s) instead of creating it.

.EXAMPLE
    .\scripts\deploy.ps1                # link all addons
    .\scripts\deploy.ps1 -Name MyAddon  # link just one
    .\scripts\deploy.ps1 -Copy          # copy instead of link
    .\scripts\deploy.ps1 -Clean         # remove all links
#>
[CmdletBinding()]
param(
    [string[]]$Name,
    [switch]$Copy,
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$srcDir   = Join-Path $repoRoot 'src'

# --- Load config -----------------------------------------------------------
$configPath = Join-Path $repoRoot 'wow-dev.config.json'
$localPath  = Join-Path $repoRoot 'wow-dev.config.local.json'
if (-not (Test-Path $configPath)) { throw "Missing config: $configPath" }
$config = Get-Content $configPath -Raw | ConvertFrom-Json
if (Test-Path $localPath) {
    $local = Get-Content $localPath -Raw | ConvertFrom-Json
    foreach ($p in $local.PSObject.Properties) { $config | Add-Member -NotePropertyName $p.Name -NotePropertyValue $p.Value -Force }
}

$addonsDir = Join-Path (Join-Path $config.gamePath $config.flavorDir) 'Interface\AddOns'
if (-not (Test-Path $addonsDir)) {
    throw "AddOns folder not found: $addonsDir`nCheck 'gamePath' / 'flavorDir' in wow-dev.config.json."
}

# --- Select addons ---------------------------------------------------------
if (-not (Test-Path $srcDir)) { throw "No src/ folder at $srcDir" }
$all = Get-ChildItem $srcDir -Directory
if ($Name) { $all = $all | Where-Object { $Name -contains $_.Name } }
if (-not $all) { Write-Warning "No matching addons found under src/."; return }

foreach ($addon in $all) {
    $link = Join-Path $addonsDir $addon.Name

    # Always remove any existing deployment first (link or copied folder).
    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.LinkType) {
            # It's a junction/symlink: remove the link only, never the target.
            [System.IO.Directory]::Delete($link, $false)
        } else {
            Remove-Item $link -Recurse -Force
        }
    }

    if ($Clean) {
        Write-Host "[clean]  $($addon.Name)" -ForegroundColor Yellow
        continue
    }

    if ($Copy) {
        Copy-Item $addon.FullName $link -Recurse -Force
        Write-Host "[copy]   $($addon.Name) -> $link" -ForegroundColor Cyan
    } else {
        New-Item -ItemType Junction -Path $link -Target $addon.FullName | Out-Null
        Write-Host "[link]   $($addon.Name) -> $link" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done. AddOns folder: $addonsDir" -ForegroundColor Gray
if (-not $Clean) {
    Write-Host "Tip: enable 'Load out of date AddOns' on the character select screen if anything is greyed out." -ForegroundColor Gray
}
