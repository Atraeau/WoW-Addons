#requires -Version 5.1
<#
.SYNOPSIS
    Scaffold a new World of Warcraft addon under src/.

.DESCRIPTION
    Creates src/<Name>/ containing:
      - <Name>.toc          (base TOC, loads on any flavor)
      - <Name>_<suffix>.toc (flavor TOC, e.g. _Camelot for WoW: Forever)
      - Core.lua            (event-driven skeleton with a /slash command)
    Interface version and TOC suffix come from wow-dev.config.json.

.PARAMETER Name
    Addon name (PascalCase, no spaces). Also the folder and TOC base name.

.PARAMETER Title
    Human-readable title shown in the AddOns list. Defaults to Name.

.PARAMETER Notes
    One-line description for the TOC. Optional.

.EXAMPLE
    .\scripts\new-addon.ps1 -Name QuestHelper -Title "Quest Helper" -Notes "Tracks quest objectives"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Name,
    [string]$Title,
    [string]$Notes = ""
)

$ErrorActionPreference = 'Stop'
if ($Name -notmatch '^[A-Za-z][A-Za-z0-9_]*$') {
    throw "Addon name must be alphanumeric/underscore and start with a letter (got '$Name')."
}
if (-not $Title) { $Title = $Name }

$repoRoot = Split-Path -Parent $PSScriptRoot
$config   = Get-Content (Join-Path $repoRoot 'wow-dev.config.json') -Raw | ConvertFrom-Json
$iface    = $config.interface
$suffix   = $config.tocSuffix
$author   = $config.author

$addonDir = Join-Path (Join-Path $repoRoot 'src') $Name
if (Test-Path $addonDir) { throw "Addon already exists: $addonDir" }
New-Item -ItemType Directory -Path $addonDir -Force | Out-Null

# --- TOC contents (shared between base and flavor TOC) ---------------------
$tocBody = @"
## Interface: $iface
## Title: $Title
## Notes: $Notes
## Author: $author
## Version: 0.1.0
## SavedVariables: ${Name}DB

Core.lua
"@

$baseToc   = Join-Path $addonDir "$Name.toc"
$flavorToc = Join-Path $addonDir "${Name}_$suffix.toc"
Set-Content -Path $baseToc   -Value $tocBody -Encoding UTF8
Set-Content -Path $flavorToc -Value $tocBody -Encoding UTF8

# --- Core.lua skeleton -----------------------------------------------------
$slashUpper = $Name.ToUpper()
$core = @"
-- $Title
-- Addon private namespace: the loader passes (addonName, ns) as varargs.
local addonName, ns = ...

-- Saved variables table (declared in the .toc as SavedVariables)
${Name}DB = ${Name}DB or {}

-- Event dispatcher --------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		-- SavedVariables are available from here on.
	elseif event == "PLAYER_LOGIN" then
		local _, _, _, iface = GetBuildInfo()
		print("|cff33ff99$Title|r loaded (interface " .. tostring(iface) .. "). Type /$($Name.ToLower()) for options.")
	end
end)

-- Slash command -----------------------------------------------------------
SLASH_${slashUpper}1 = "/$($Name.ToLower())"
SlashCmdList["$slashUpper"] = function(msg)
	msg = (msg or ""):gsub("^%s+", ""):gsub("%s+$", "")
	print("|cff33ff99$Title|r: hello, " .. (UnitName("player") or "player") .. "!")
end
"@

Set-Content -Path (Join-Path $addonDir 'Core.lua') -Value $core -Encoding UTF8

Write-Host "Created addon '$Name' at $addonDir" -ForegroundColor Green
Write-Host "  - $Name.toc"
Write-Host "  - ${Name}_$suffix.toc  (interface $iface)"
Write-Host "  - Core.lua"
Write-Host ""
Write-Host "Next:  .\scripts\deploy.ps1 -Name $Name" -ForegroundColor Cyan
