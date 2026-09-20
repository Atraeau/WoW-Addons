#requires -Version 7.0
<#
.SYNOPSIS
    Generate a split-per-namespace Markdown API reference from a WowApiExport dump.

.DESCRIPTION
    Reads the SavedVariables file produced by the WowApiExport addon (run /apiexport
    then /reload in game), parses the JSON payload it stores, and writes one Markdown
    file per API namespace into docs/api/, plus an index.

    The documented API surface comes straight from the running client's own
    APIDocumentation system, so it reflects exactly what THIS client supports.

.PARAMETER Path
    Path to WowApiExport.lua. If omitted, it is auto-located under the game's WTF folder
    using wow-dev.config.json.

.PARAMETER OutDir
    Output directory for the generated docs. Default: <repo>/docs/api

.EXAMPLE
    .\scripts\generate-api-docs.ps1
#>
[CmdletBinding()]
param(
    [string]$Path,
    [string]$OutDir
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

# --- Locate the SavedVariables dump ---------------------------------------
if (-not $Path) {
    $config = Get-Content (Join-Path $repoRoot 'wow-dev.config.json') -Raw | ConvertFrom-Json
    $wtf = Join-Path (Join-Path $config.gamePath $config.flavorDir) 'WTF'
    $candidates = Get-ChildItem -Path $wtf -Recurse -Filter 'WowApiExport.lua' -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending
    if (-not $candidates) {
        throw "Could not find WowApiExport.lua under $wtf`nRun /apiexport then /reload in game first."
    }
    $Path = $candidates[0].FullName
    Write-Host "Using dump: $Path" -ForegroundColor Gray
}
if (-not (Test-Path $Path)) { throw "Dump not found: $Path" }
if (-not $OutDir) { $OutDir = Join-Path $repoRoot 'docs/api' }

# --- Read the payload ------------------------------------------------------
# Preferred: WowApiExportB64 = "<base64 of JSON>". Base64 has no quotes/backslashes,
# so it survives the SavedVariables serializer untouched -- no escaping to undo.
$rawFile = Get-Content -Raw -LiteralPath $Path
$json = $null

$b64Match = [regex]::Match($rawFile, 'WowApiExportB64\s*=\s*"([A-Za-z0-9+/=]*)"')
if ($b64Match.Success -and $b64Match.Groups[1].Value.Length -gt 0) {
    $bytes = [Convert]::FromBase64String($b64Match.Groups[1].Value)
    $json = [System.Text.Encoding]::UTF8.GetString($bytes)
} else {
    throw "WowApiExportB64 not found (or empty) in $Path. Re-run /apiexport then /reload with the current addon version."
}

$data = $json | ConvertFrom-Json

# --- Helpers ---------------------------------------------------------------
function Sanitize([string]$name) {
    if ([string]::IsNullOrWhiteSpace($name)) { return 'Global' }
    return ($name -replace '[^\w.\-]', '_')
}

# Escape text for use inside a Markdown table cell.
function Cell([string]$text) {
    if (-not $text) { return '' }
    return ($text -replace '\|', '\|' -replace '\r?\n', ' ').Trim()
}

function TypeStr($field) {
    if (-not $field) { return 'any' }
    $t = $field.type
    if (-not $t) { $t = 'any' }
    if ($field.innerType) { return "$($field.innerType)[]" }
    return $t
}

# A literal example value for an argument, using name/type heuristics.
function ExampleValue($arg) {
    $name = ("$($arg.name)").ToLower()
    $t = ("$($arg.type)").ToLower()
    if ($name -match 'unit') { return '"player"' }
    if ($name -match 'guid') { return '"Creature-0-0000-0-0-0-0"' }
    if ($name -match 'index|slot|rank') { return '1' }
    if ($name -match 'spell') { return '12345' }
    if ($name -match 'item') { return '6948' }
    if ($name -match 'filter') { return '"HELPFUL"' }
    switch ($t) {
        'string'  { return '""' }
        'cstring' { return '""' }
        'number'  { return '0' }
        'bool'    { return 'false' }
        'boolean' { return 'false' }
        default   { return $arg.name }   # complex type -> use the name as a placeholder
    }
}

function BuildSignature($fn, $namespace) {
    $prefix = if ($namespace) { "$namespace." } else { '' }
    # Returns
    $rets = @($fn.returns)
    $retStr = ''
    if ($rets.Count -gt 0) {
        $retStr = (($rets | ForEach-Object { $_.name }) -join ', ') + ' = '
    }
    # Arguments (nilable ones wrapped in [])
    $args = @($fn.arguments)
    $parts = @()
    foreach ($a in $args) {
        if ($a.nilable) { $parts += "[$($a.name)]" } else { $parts += $a.name }
    }
    return "$retStr$prefix$($fn.name)(" + ($parts -join ', ') + ')'
}

function BuildExample($fn, $namespace) {
    $prefix = if ($namespace) { "$namespace." } else { '' }
    $args = @($fn.arguments)
    $vals = @()
    foreach ($a in $args) {
        if ($a.nilable) { continue }   # minimal call: required args only
        $vals += (ExampleValue $a)
    }
    $rets = @($fn.returns)
    $lhs = ''
    if ($rets.Count -gt 0) {
        $lhs = 'local ' + (($rets | ForEach-Object { $_.name }) -join ', ') + ' = '
    }
    return "$lhs$prefix$($fn.name)(" + ($vals -join ', ') + ')'
}

function ArgTable($fields) {
    $rows = @($fields)
    if ($rows.Count -eq 0) { return $null }
    $lines = @('| Name | Type | Nilable | Description |', '|------|------|---------|-------------|')
    foreach ($f in $rows) {
        $nil = if ($f.nilable) { 'yes' } else { 'no' }
        $desc = Cell $f.documentation
        if ($f.default -ne $null -and "$($f.default)" -ne '') { $desc = ($desc + " (default: $($f.default))").Trim() }
        $lines += "| ``$($f.name)`` | $(TypeStr $f) | $nil | $desc |"
    }
    return $lines -join "`n"
}

# --- Prepare output --------------------------------------------------------
if (Test-Path $OutDir) { Remove-Item $OutDir -Recurse -Force }
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

$meta = $data.meta
$systemsRaw = @($data.systems)

# --- Fallback: no rich APIDocumentation, but we have the _G inventory --------
if ($systemsRaw.Count -eq 0) {
    Write-Host "APIDocumentation not present in dump -- generating a name-only inventory from the _G capture." -ForegroundColor Yellow
    $g = $data.globals
    $namespaces = @{}
    $globalFns = [System.Collections.Generic.List[string]]::new()
    foreach ($p in $g.PSObject.Properties) {
        if ($p.Value -is [string]) { $globalFns.Add($p.Name) }
        else { $namespaces[$p.Name] = @($p.Value) }
    }

    $note = @(
        "> Inventory from the WoW: Forever client (build $($meta.build), interface $($meta.interface)) on $($meta.exportedAt).",
        "> This lists the functions that exist on the client. Full signatures, arguments,",
        "> returns and examples require the rich APIDocumentation export (re-run /apiexport",
        "> then /reload with the updated addon, which force-loads Blizzard_APIDocumentation)."
    )

    $indexRows = @()
    foreach ($ns in ($namespaces.Keys | Sort-Object)) {
        $fns = @($namespaces[$ns] | Sort-Object)
        $md = @("# $ns", "") + $note + @("", "**$($fns.Count)** functions", "", '```lua')
        foreach ($fn in $fns) { $md += "$ns.$fn()" }
        $md += '```'
        ($md -join "`n") | Set-Content -Path (Join-Path $OutDir ((Sanitize $ns) + '.md')) -Encoding UTF8
        $indexRows += [pscustomobject]@{ Namespace = $ns; File = (Sanitize $ns) + '.md'; Functions = $fns.Count }
    }

    $gf = @($globalFns | Sort-Object)
    $md = @("# Global Functions", "") + $note + @("", "**$($gf.Count)** functions", "", '```lua')
    foreach ($fn in $gf) { $md += "$fn()" }
    $md += '```'
    ($md -join "`n") | Set-Content -Path (Join-Path $OutDir 'GlobalFunctions.md') -Encoding UTF8
    $indexRows += [pscustomobject]@{ Namespace = 'Global Functions'; File = 'GlobalFunctions.md'; Functions = $gf.Count }

    $idx = @('# WoW: Forever API Reference (inventory)', '')
    $idx += "Captured from the client's `_G` on $($meta.exportedAt) (build $($meta.build), interface $($meta.interface))."
    $idx += ''
    $idx += "> ⚠️ Names only. `APIDocumentation` was not loaded, so signatures/examples are pending."
    $idx += 'Re-run the export with the updated addon (which force-loads the docs) for full detail.'
    $idx += ''
    $idx += "- Namespaces: **$($namespaces.Count)** · Global functions: **$($gf.Count)**"
    $idx += ''
    $idx += '| Namespace | Functions |'
    $idx += '|-----------|-----------|'
    foreach ($row in ($indexRows | Sort-Object Namespace)) {
        $idx += "| [$($row.Namespace)]($($row.File)) | $($row.Functions) |"
    }
    ($idx -join "`n") | Set-Content -Path (Join-Path $OutDir 'README.md') -Encoding UTF8

    Write-Host "Generated $($indexRows.Count) inventory files into $OutDir" -ForegroundColor Green
    return
}

$systems = $systemsRaw | Sort-Object { if ($_.namespace) { $_.namespace } else { $_.name } }

$indexRows = @()

foreach ($sys in $systems) {
    $ns = if ($sys.namespace) { $sys.namespace } else { $sys.name }
    $fileName = (Sanitize $ns) + '.md'
    $funcs = @($sys.functions)
    $events = @($sys.events)
    $tables = @($sys.tables)

    $md = @()
    $md += "# $ns"
    $md += ''
    if ($sys.documentation) { $md += (Cell $sys.documentation); $md += '' }
    $md += "> Generated from the WoW: Forever client (build $($meta.build), interface $($meta.interface)) on $($meta.exportedAt)."
    $md += ''
    $md += "**$($funcs.Count)** functions · **$($events.Count)** events · **$($tables.Count)** types"
    $md += ''

    if ($funcs.Count -gt 0) {
        $md += '## Functions'
        $md += ''
        foreach ($fn in ($funcs | Sort-Object name)) {
            $md += "### $ns.$($fn.name)"
            $md += ''
            if ($fn.documentation) { $md += (Cell $fn.documentation); $md += '' }
            $md += '```lua'
            $md += (BuildSignature $fn $sys.namespace)
            $md += '```'
            $md += ''
            $argTbl = ArgTable $fn.arguments
            if ($argTbl) { $md += '**Arguments**'; $md += ''; $md += $argTbl; $md += '' }
            $retTbl = ArgTable $fn.returns
            if ($retTbl) { $md += '**Returns**'; $md += ''; $md += $retTbl; $md += '' }
            $md += '**Example**'
            $md += ''
            $md += '```lua'
            $md += (BuildExample $fn $sys.namespace)
            $md += '```'
            $md += ''
        }
    }

    if ($events.Count -gt 0) {
        $md += '## Events'
        $md += ''
        foreach ($ev in ($events | Sort-Object name)) {
            $md += "### $($ev.literalName ? $ev.literalName : $ev.name)"
            $md += ''
            if ($ev.documentation) { $md += (Cell $ev.documentation); $md += '' }
            $payTbl = ArgTable $ev.payload
            if ($payTbl) { $md += '**Payload**'; $md += ''; $md += $payTbl; $md += '' }
        }
    }

    if ($tables.Count -gt 0) {
        $md += '## Types'
        $md += ''
        foreach ($tb in ($tables | Sort-Object name)) {
            $md += ("### {0} ({1})" -f $tb.name, $tb.type)
            $md += ''
            if ($tb.documentation) { $md += (Cell $tb.documentation); $md += '' }
            $fldTbl = ArgTable $tb.fields
            if ($fldTbl) { $md += $fldTbl; $md += '' }
        }
    }

    ($md -join "`n") | Set-Content -Path (Join-Path $OutDir $fileName) -Encoding UTF8
    $indexRows += [pscustomobject]@{
        Namespace = $ns; File = $fileName
        Functions = $funcs.Count; Events = $events.Count; Types = $tables.Count
    }
}

# --- Index -----------------------------------------------------------------
$idx = @()
$idx += '# WoW: Forever API Reference'
$idx += ''
$idx += "Generated from the client's own `APIDocumentation` (build $($meta.build), interface $($meta.interface)) on $($meta.exportedAt)."
$idx += ''
$idx += "- Systems: **$($meta.systemCount)** · Functions: **$($meta.functionCount)** · Events: **$($meta.eventCount)** · Types: **$($meta.tableCount)**"
if (-not $meta.hasAPIDocumentation) {
    $idx += ''
    $idx += '> ⚠️ APIDocumentation was not present on the client; only the raw `_G` inventory was captured.'
}
$idx += ''
$idx += '## Namespaces'
$idx += ''
$idx += '| Namespace | Functions | Events | Types |'
$idx += '|-----------|-----------|--------|-------|'
foreach ($row in ($indexRows | Sort-Object Namespace)) {
    $idx += "| [$($row.Namespace)]($($row.File)) | $($row.Functions) | $($row.Events) | $($row.Types) |"
}
($idx -join "`n") | Set-Content -Path (Join-Path $OutDir 'README.md') -Encoding UTF8

Write-Host "Generated $($indexRows.Count) namespace files into $OutDir" -ForegroundColor Green
Write-Host "Index: $(Join-Path $OutDir 'README.md')" -ForegroundColor Gray
