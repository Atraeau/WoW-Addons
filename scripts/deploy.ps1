#requires -Version 5.1
<#
.SYNOPSIS
    Build every addon under src/ into AddOns/, then link (or copy) the built folders into the WoW: Forever AddOns folder.

.DESCRIPTION
    src/<Addon>/ holds everything about an addon (game code, tests, simulator, docs). scripts/build-addons.lua turns
    it into AddOns/<Addon>/: exactly the files the client loads (see that script for the rules). This script runs that
    build, then deploys AddOns/<Addon> into the game.

    By default each addon is a directory JUNCTION to its built folder, so the game reads the build and a rebuild is
    all it takes after an edit (then /reload in game). Junctions do NOT require administrator rights. Use -Watch to
    rebuild automatically whenever a source file changes.

    Use -Copy to hard-copy instead (useful if the game is on a different drive where junctions aren't possible).

    Needs Lua on the PATH (the same Lua 5.4 the tests use).

.PARAMETER Name
    Deploy only the named addon(s). Omit to deploy all addons under src/.

.PARAMETER Copy
    Copy files instead of creating a junction.

.PARAMETER Watch
    After deploying, keep running and rebuild an addon whenever one of its source files changes. Ctrl+C to stop.

.PARAMETER Clean
    Remove the deployed link/copy for the selected addon(s) instead of creating it.

.EXAMPLE
    .\scripts\deploy.ps1                # build and link all addons
    .\scripts\deploy.ps1 -Name MyAddon  # just one
    .\scripts\deploy.ps1 -Watch         # link, then rebuild on every save
    .\scripts\deploy.ps1 -Copy          # copy instead of link
    .\scripts\deploy.ps1 -Clean         # remove all links
#>
[CmdletBinding()]
param(
    [string[]]$Name,
    [switch]$Copy,
    [switch]$Watch,
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$srcDir   = Join-Path $repoRoot 'src'
$buildDir = Join-Path $repoRoot 'AddOns'

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

# --- Build -----------------------------------------------------------------
if (-not (Test-Path $srcDir)) { throw "No src/ folder at $srcDir" }
function Invoke-Build([string[]]$Only) {
    if (-not (Get-Command lua -ErrorAction SilentlyContinue)) {
        throw "Lua is needed to build the addons (scripts/build-addons.lua). Install Lua 5.4 and put it on the PATH: the test suite uses the same one."
    }
    $buildArgs = @('scripts/build-addons.lua', '--check')
    if ($Only) { $buildArgs += @('--name', ($Only -join ',')) }
    Push-Location $repoRoot
    try {
        & lua @buildArgs
        if ($LASTEXITCODE -ne 0) { throw "The build failed; nothing was deployed from it." }
    } finally { Pop-Location }
}

$sourceNames = @(Get-ChildItem $srcDir -Directory | ForEach-Object { $_.Name })
if ($Name) { $sourceNames = @($sourceNames | Where-Object { $Name -contains $_ }) }
if (-not $sourceNames) { Write-Warning "No matching addons found under src/."; return }

if (-not $Clean) { Invoke-Build $sourceNames }

# --- Deploy ----------------------------------------------------------------
foreach ($addonName in $sourceNames) {
    $link = Join-Path $addonsDir $addonName

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
        Write-Host "[clean]  $addonName" -ForegroundColor Yellow
        continue
    }

    $built = Join-Path $buildDir $addonName
    if ($Copy) {
        Copy-Item $built $link -Recurse -Force
        Write-Host "[copy]   $addonName -> $link" -ForegroundColor Cyan
    } else {
        New-Item -ItemType Junction -Path $link -Target $built | Out-Null
        Write-Host "[link]   $addonName -> $link" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done. AddOns folder: $addonsDir" -ForegroundColor Gray
if (-not $Clean) {
    Write-Host "Tip: enable 'Load out of date AddOns' on the character select screen if anything is greyed out." -ForegroundColor Gray
}

# --- Watch -----------------------------------------------------------------
if ($Watch -and -not $Clean) {
    function Get-Stamp([string]$addonName) {
        $newest = Get-ChildItem (Join-Path $srcDir $addonName) -Recurse -File -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
        if ($newest) { $newest.LastWriteTimeUtc.Ticks } else { 0 }
    }
    $stamps = @{}
    foreach ($addonName in $sourceNames) { $stamps[$addonName] = Get-Stamp $addonName }
    Write-Host "Watching src/ for changes (Ctrl+C to stop). Rebuilds the addon that changed; /reload in game to see it." -ForegroundColor Gray
    while ($true) {
        Start-Sleep -Seconds 1
        foreach ($addonName in $sourceNames) {
            $now = Get-Stamp $addonName
            if ($now -ne $stamps[$addonName]) {
                $stamps[$addonName] = $now
                Write-Host ("[{0}] {1} changed: rebuilding" -f (Get-Date -Format 'HH:mm:ss'), $addonName) -ForegroundColor Cyan
                try { Invoke-Build @($addonName) } catch { Write-Host $_.Exception.Message -ForegroundColor Red }
            }
        }
    }
}
