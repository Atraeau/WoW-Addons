#requires -Version 7.0
<#
.SYNOPSIS
    Generate docs/console-commands.md: every console command and CVar the running client lists, from a WowApiExport dump, sorted by topic.

.DESCRIPTION
    Reads the SavedVariables file produced by the WowApiExport addon (run /apiexport then /reload in game, with
    addon version 0.2.0 or later), takes the client's own console list (ConsoleGetAllCommands, with each CVar's
    default value) and writes one Markdown page. The client's categories are too coarse to browse (graphics settings
    sit in "Default", "Game" holds 1,100 unrelated things), so settings are sorted into topics by name using the
    rules in scripts/console-groups.json (first matching group wins; edit that file to move a setting).
    Each table shows the command, what the game says it does, and its default, in that order, so the description is
    never pushed off the right edge. Use your browser's find (Ctrl+F) to search the page, as in the in-game console.

.PARAMETER Path
    Path to WowApiExport.lua. If omitted it is found under the game's WTF folder using wow-dev.config.json.

.PARAMETER ApiJson
    A prebuilt api.json (as docs/api.json) instead of the game dump.

.PARAMETER Out
    Output file. Default: <repo>/docs/console-commands.md

.PARAMETER Groups
    The topic rules. Default: scripts/console-groups.json

.EXAMPLE
    .\scripts\generate-console-docs.ps1
#>
[CmdletBinding()]
param(
    [string]$Path,
    [string]$ApiJson,
    [string]$Out,
    [string]$Groups
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding $false

if (-not $Out) { $Out = Join-Path $repoRoot 'docs/console-commands.md' }
if (-not $Groups) { $Groups = Join-Path $PSScriptRoot 'console-groups.json' }
if (-not (Test-Path $Groups)) { throw "Topic rules not found: $Groups" }
$rules = Get-Content -Raw -LiteralPath $Groups | ConvertFrom-Json

# --- Read the payload ------------------------------------------------------
$json = $null
if ($ApiJson) {
    if (-not (Test-Path $ApiJson)) { throw "api.json not found: $ApiJson" }
    $json = Get-Content -Raw -LiteralPath $ApiJson
} else {
    if (-not $Path) {
        $config = Get-Content (Join-Path $repoRoot 'wow-dev.config.json') -Raw | ConvertFrom-Json
        $wtf = Join-Path (Join-Path $config.gamePath $config.flavorDir) 'WTF'
        $candidates = Get-ChildItem -Path $wtf -Recurse -Filter 'WowApiExport.lua' -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTime -Descending
        if (-not $candidates) { throw "Could not find WowApiExport.lua under $wtf`nRun /apiexport then /reload in game first." }
        $Path = $candidates[0].FullName
        Write-Host "Using dump: $Path" -ForegroundColor Gray
    }
    $rawFile = Get-Content -Raw -LiteralPath $Path
    $b64Match = [regex]::Match($rawFile, 'WowApiExportB64\s*=\s*"([A-Za-z0-9+/=]*)"')
    if (-not ($b64Match.Success -and $b64Match.Groups[1].Value.Length -gt 0)) {
        throw "WowApiExportB64 not found (or empty) in $Path. Re-run /apiexport then /reload."
    }
    $json = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($b64Match.Groups[1].Value))
}
$data = $json | ConvertFrom-Json

$commands = @($data.consoleCommands)
if ($commands.Count -eq 0) {
    throw "This dump has no console commands. Update the WowApiExport addon (0.2.0 or later), run /apiexport, then /reload."
}

# --- Markdown helpers ------------------------------------------------------
# The game's help text is free text: left alone, a "<value>", an asterisk or a bracket is eaten by the renderer and the description seems to be missing.
function Esc([string]$text) {
    if ([string]::IsNullOrEmpty($text)) { return '' }
    $t = ($text -replace "\r?\n", ' ').Trim()
    $t = $t -replace '\\', '\\'
    foreach ($ch in '|', '<', '>', '*', '_', '[', ']', '`') { $t = $t.Replace($ch, '\' + $ch) }
    return $t.Replace('&', '&amp;')
}
# A Markdown code span; a value that contains a backtick (the console key) needs a longer fence.
function Code([string]$text) {
    $t = ($text -replace "\r?\n", ' ').Trim().Replace('|', '\|')
    if ($t.Contains([string][char]96)) { return '`` ' + $t + ' ``' }
    return '`' + $t + '`'
}
function Anchor([string]$title) { return (($title.ToLower() -replace '[^a-z0-9 -]', '') -replace ' ', '-') }

# --- Sort every entry into a topic -----------------------------------------
function GroupOf($c) {
    if ([string]$c.commandType -eq 'Command') { return $rules.commands.name }
    $name = [string]$c.command
    foreach ($g in $rules.groups) {
        foreach ($p in $g.match) { if ($name -match $p) { return $g.name } }
    }
    return $rules.fallback.name
}
$byGroup = @{}
foreach ($c in $commands) {
    $g = GroupOf $c
    if (-not $byGroup.ContainsKey($g)) { $byGroup[$g] = New-Object System.Collections.Generic.List[object] }
    $byGroup[$g].Add($c)
}
# Topics in the rules file's "display" order (the settings people change first, the developer ones last); any topic it doesn't list follows in
# the order of the rules, and what fits nowhere comes last.
$all = @($rules.commands) + @($rules.groups) + @($rules.fallback)
$shown = @()
foreach ($name in @($rules.display)) { $shown += @($all | Where-Object { $_.name -eq $name }) }
$rest = @($all | Where-Object { $n = $_.name; -not ($shown | Where-Object { $_.name -eq $n }) -and $_.name -ne $rules.fallback.name })
$tail = @($all | Where-Object { $_.name -eq $rules.fallback.name })
$topics = @(($shown + $rest + $tail) | Where-Object { $byGroup.ContainsKey($_.name) })

$meta = $data.meta
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('# Console commands and CVars')
[void]$sb.AppendLine('')
[void]$sb.AppendLine("Everything the running client lists in its console, from the client's own command list (``ConsoleGetAllCommands``): build $($meta.build), interface $($meta.interface), exported $($meta.exportedAt). $($commands.Count) entries, sorted into $($topics.Count) topics.")
[void]$sb.AppendLine('')
[void]$sb.AppendLine('Search with your browser''s find (Ctrl+F). In game, open the console with `/console enable`, then the ` or ~ key; change a CVar with `/console <name> <value>` (or `/run SetCVar("<name>", value)`), and read one with `/run print(GetCVar("<name>"))`. "Default" is the value a CVar resets to; a CVar with no default holds saved state (a counter, a last-seen flag) rather than a setting. Your own current values are not listed: they differ per install.')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('The game''s own categories are too coarse to browse (graphics options sit under "Default"), so these topics are chosen by name, using the rules in [`scripts/console-groups.json`](../scripts/console-groups.json). A setting in the wrong place is a one-line change there. Generated by `scripts/generate-console-docs.ps1` from a `WowApiExport` dump; do not edit this page by hand.')
[void]$sb.AppendLine('')
[void]$sb.AppendLine('## Topics')
[void]$sb.AppendLine('')
foreach ($t in $topics) {
    [void]$sb.AppendLine("- [$($t.name)](#$(Anchor $t.name)) ($($byGroup[$t.name].Count)): $($t.blurb)")
}
[void]$sb.AppendLine('')

foreach ($t in $topics) {
    $rows = $byGroup[$t.name] | Sort-Object { ([string]$_.command).ToLowerInvariant() }
    $isCommands = $t.name -eq $rules.commands.name
    [void]$sb.AppendLine("## $($t.name)")
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine("$($t.blurb)")
    [void]$sb.AppendLine('')
    if ($isCommands) {
        [void]$sb.AppendLine('| Command | What it does |')
        [void]$sb.AppendLine('|---|---|')
    } else {
        [void]$sb.AppendLine('| Setting | What it does | Default |')
        [void]$sb.AppendLine('|---|---|---|')
    }
    foreach ($c in $rows) {
        $help = Esc ([string]$c.help)
        if (-not $help) { $help = '*(the game gives no description)*' }
        if ($isCommands) {
            [void]$sb.AppendLine("| $(Code $c.command) | $help |")
        } else {
            $default = if ($null -ne $c.default -and "$($c.default)" -ne '') { Code "$($c.default)" } else { '' }
            [void]$sb.AppendLine("| $(Code $c.command) | $help | $default |")
        }
    }
    [void]$sb.AppendLine('')
}

$text = ($sb.ToString() -replace "`r`n", "`n").TrimEnd("`n") + "`n"
[System.IO.File]::WriteAllText($Out, $text, $utf8)
Write-Host "Wrote $Out ($($commands.Count) entries in $($topics.Count) topics)" -ForegroundColor Green
