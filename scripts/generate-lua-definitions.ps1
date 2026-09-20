#requires -Version 7.0
<#
.SYNOPSIS
    Generate a Lua Language Server (sumneko) definitions file from a WowApiExport dump.

.DESCRIPTION
    Emits types/WowForeverAPI.lua with LuaCATS annotations for every documented
    function (typed @param/@return), enum (Enum.X tables + type aliases), and
    structure (@class ... @field). Point Lua.workspace.library at the types/ folder
    (see .vscode/settings.json) so completion/hover matches THIS client exactly.

.PARAMETER Path
    Path to WowApiExport.lua. Auto-located under the game's WTF folder if omitted.

.PARAMETER OutFile
    Output .lua file. Default: <repo>/types/WowForeverAPI.lua
#>
[CmdletBinding()]
param(
    [string]$Path,
    [string]$OutFile
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $Path) {
    $config = Get-Content (Join-Path $repoRoot 'wow-dev.config.json') -Raw | ConvertFrom-Json
    $wtf = Join-Path (Join-Path $config.gamePath $config.flavorDir) 'WTF'
    $Path = (Get-ChildItem -Path $wtf -Recurse -Filter 'WowApiExport.lua' -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
    if (-not $Path) { throw "No WowApiExport.lua found under $wtf. Run /apiexport then /reload." }
}
if (-not $OutFile) { $OutFile = Join-Path $repoRoot 'types/WowForeverAPI.lua' }
Write-Host "Dump: $Path" -ForegroundColor Gray

# --- Read base64 payload ---------------------------------------------------
$raw = Get-Content -Raw -LiteralPath $Path
$m = [regex]::Match($raw, 'WowApiExportB64\s*=\s*"([A-Za-z0-9+/=]*)"')
if (-not $m.Success) { throw "WowApiExportB64 not found in $Path" }
$json = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($m.Groups[1].Value))
$data = $json | ConvertFrom-Json
if (-not $data.meta.hasAPIDocumentation) {
    throw "This dump has no APIDocumentation (names only). Re-run /apiexport (force-loads the docs) then /reload."
}

# --- Helpers ---------------------------------------------------------------
$LuaKeywords = @{}
foreach ($k in 'and','break','do','else','elseif','end','false','for','function','if','in','local','nil','not','or','repeat','return','then','true','until','while') { $LuaKeywords[$k] = $true }

function SafeName([string]$n) {
    if (-not $n) { return 'arg' }
    if ($LuaKeywords.ContainsKey($n)) { return $n + '_' }
    if ($n -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') { return ($n -replace '[^A-Za-z0-9_]', '_') }
    return $n
}

function MapType($t, $inner) {
    if ($inner) { return (MapType $inner $null) + '[]' }
    switch ("$t".ToLower()) {
        ''         { return 'any' }
        'string'   { return 'string' }
        'cstring'  { return 'string' }
        'wowguid'  { return 'string' }
        'number'   { return 'number' }
        'luaindex' { return 'number' }
        'fileid'   { return 'number' }
        'time_t'   { return 'number' }
        'wowmoney' { return 'number' }
        'bool'     { return 'boolean' }
        'boolean'  { return 'boolean' }
        'table'    { return 'table' }
        default    { return "$t" }   # enum / structure name (defined elsewhere)
    }
}

function Comment([string]$text) {
    if (-not $text) { return $null }
    return '--- ' + ($text -replace '\r?\n', ' ').Trim()
}

$out = [System.Text.StringBuilder]::new()
function W([string]$s = '') { [void]$out.AppendLine($s) }

$meta = $data.meta
W '---@meta'
W "-- WoW: Forever API definitions -- generated from the client's own APIDocumentation."
W "-- build $($meta.build), interface $($meta.interface), exported $($meta.exportedAt)."
W "-- Do not edit by hand; regenerate with scripts/generate-lua-definitions.ps1."
W ''
W 'Enum = Enum or {}'
W ''

# --- Enums & structures (from every system's tables) -----------------------
$enumCount = 0; $classCount = 0
foreach ($sys in $data.systems) {
    foreach ($tb in @($sys.tables)) {
        $fields = @($tb.fields)
        if ($tb.type -eq 'Enumeration') {
            W "---@alias $($tb.name) number"
            $pairs = foreach ($f in $fields) { "`t$(SafeName $f.name) = $($f.enumValue)," }
            W "Enum.$($tb.name) = {"
            foreach ($p in $pairs) { W $p }
            W '}'
            W ''
            $enumCount++
        } else {
            # Structure / Constants -> a @class with typed fields
            if ($tb.documentation) { W (Comment $tb.documentation) }
            W "---@class $($tb.name)"
            foreach ($f in $fields) {
                $fname = SafeName $f.name
                if ($f.nilable) { $fname = $fname + '?' }
                W "---@field $fname $(MapType $f.type $f.innerType)"
            }
            W ''
            $classCount++
        }
    }
}

# --- Declare namespace tables ----------------------------------------------
$namespaces = [System.Collections.Generic.SortedSet[string]]::new()
foreach ($sys in $data.systems) { if ($sys.namespace) { [void]$namespaces.Add($sys.namespace) } }
foreach ($ns in $namespaces) {
    # declare each dotted prefix once (nearly all are single-level C_*)
    $parts = $ns -split '\.'
    $acc = ''
    foreach ($p in $parts) {
        $acc = if ($acc) { "$acc.$p" } else { $p }
        W "$acc = $acc or {}"
    }
}
W ''

# --- Functions -------------------------------------------------------------
$fnCount = 0
foreach ($sys in $data.systems) {
    $prefix = if ($sys.namespace) { "$($sys.namespace)." } else { '' }
    foreach ($fn in @($sys.functions)) {
        if ($fn.documentation) { W (Comment $fn.documentation) }
        $argNames = @()
        foreach ($a in @($fn.arguments)) {
            $an = SafeName $a.name
            $argNames += $an
            $pn = if ($a.nilable) { "$an?" } else { $an }
            W "---@param $pn $(MapType $a.type $a.innerType)"
        }
        foreach ($r in @($fn.returns)) {
            $rt = MapType $r.type $r.innerType
            if ($r.nilable) { $rt = "$rt?" }
            W "---@return $rt $(SafeName $r.name)"
        }
        W "function $prefix$($fn.name)($($argNames -join ', ')) end"
        W ''
        $fnCount++
    }
}

# --- Write -----------------------------------------------------------------
$outDir = Split-Path -Parent $OutFile
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
$out.ToString() | Set-Content -Path $OutFile -Encoding UTF8

Write-Host "Wrote $OutFile" -ForegroundColor Green
Write-Host "  $fnCount functions, $enumCount enums, $classCount classes" -ForegroundColor Gray
