#requires -Version 7.0
<#
.SYNOPSIS
    Generate src/KingsGambit/AQ40.lua (training data) from simulator/data/aq40-raw.json.

.DESCRIPTION
    aq40-raw.json holds the Temple of Ahn'Qiraj's epic drops per boss as collected from Wowhead Classic (item id,
    name, slot, item class/subclass, required-class mask, observed drop rate). The token turn-ins (which quest, for
    which class, what it rewards, what materials it asks for) come from cmangos.json, extracted from the CMaNGOS
    world database by scripts/extract-cmangos.lua; their reputation requirement comes from aq-reputation.json (the
    wiki). The quest lists collected from Wowhead (aq40-raw.json tokenTurnIns.quests) are checked against them.
    This script adds each item as the fit heuristic sees it (stats, and what a token becomes, from cmangos.json),
    describes each token, adds the simulated officers' calls for items the heuristic can't judge
    (officer-calls.json), works out drops per kill from the observed rates, and writes a Lua module.
#>
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$raw = Get-Content (Join-Path $repo 'simulator/data/aq40-raw.json') -Raw | ConvertFrom-Json


$db = Get-Content (Join-Path $repo 'simulator/data/cmangos.json') -Raw | ConvertFrom-Json
$rep = Get-Content (Join-Path $repo 'simulator/data/aq-reputation.json') -Raw | ConvertFrom-Json
$dbItems = @{}
foreach ($i in $db.items) { $dbItems[[int]$i.id] = $i }
# The item as ItemFit sees it (slot, item class and subclass, stats), from the CMaNGOS extract, as Lua; nil if absent.
$cm = Get-Content (Join-Path $repo 'simulator/data/cmangos.json') -Raw | ConvertFrom-Json
$cmItems = @{}
foreach ($i in $cm.items) { $cmItems[[int]$i.id] = $i }
function FitLua([int]$id, [bool]$inner = $false) {
    $it = $cmItems[$id]
    if (-not $it -or -not $it.fit) { return 'nil' }
    $f = $it.fit
    $stats = if ($f.stats -is [array]) { "" } else { ($f.stats.PSObject.Properties | Sort-Object Name | ForEach-Object { "$($_.Name) = $([double]$_.Value)" }) -join ', ' }
    $slot = if ($f.slot) { "`"$($f.slot)`"" } else { 'nil' }
    $into = ''
    if ($f.into -and -not $inner) {
        $parts = @($f.into | ForEach-Object { FitLua ([int]$_) $true } | Where-Object { $_ -ne 'nil' })
        if ($parts.Count) { $into = ", into = { " + ($parts -join ', ') + " }" }
    }
    "{ slot = $slot, class = $([int]$f.class), subclass = $([int]$f.subclass), stats = { $stats }$into }"
}

# What a token makes, in words, from the inventory types of its rewards.
$slotWords = @{
    1 = 'head'; 2 = 'neck'; 3 = 'shoulders'; 5 = 'chest'; 20 = 'chest'; 7 = 'legs'; 8 = 'feet'; 16 = 'back'; 11 = 'finger'
    13 = 'weapon'; 14 = 'shield'; 15 = 'weapon'; 17 = 'weapon'; 21 = 'weapon'; 22 = 'weapon'; 26 = 'weapon'
}
function MakesOf($rewardIds) {
    $found = @($rewardIds | ForEach-Object { $slotWords[[int]$dbItems[[int]$_].inventoryType] })
    $words = @('head', 'neck', 'shoulders', 'back', 'chest', 'legs', 'feet', 'finger', 'weapon', 'shield' | Where-Object { $found -contains $_ })
    $text = if ($words.Count -eq 1) { $words[0] } else { ($words[0..($words.Count - 2)] -join ', ') + ' or ' + $words[-1] }
    if ($words.Count -eq 1 -and $words[0] -eq 'weapon') { $text = 'a weapon' }
    $text.Substring(0, 1).ToUpper() + $text.Substring(1)
}

$classBits = [ordered]@{ WARRIOR = 1; PALADIN = 2; HUNTER = 4; ROGUE = 8; PRIEST = 16; SHAMAN = 64; MAGE = 128; WARLOCK = 256; DRUID = 1024 }
$armor = @{ 1 = 'cloth'; 2 = 'leather'; 3 = 'mail'; 4 = 'plate' }

function Q([string]$s) { '"' + ($s -replace '\\', '\\' -replace '"', '\"') + '"' }
function V($v) { if ($v -is [string]) { Q $v } else { [string][int]$v } }

# Turn-ins, grouped by token and class: every quest that asks for the token (its first required item) and
# rewards something (C'Thun's Legacy only hands the Eye on to The Savior of Kalimdor). A quest open to every
# class (mask 0) is listed under each class.
$turnIns = @{}; $rewardsOf = @{}; $questsOf = @{}
foreach ($q in $db.quests) {
    if ($q.rewards.Count -eq 0) { continue }
    $tok = [int]$q.needs[0][0]
    if (-not $turnIns.ContainsKey($tok)) { $turnIns[$tok] = [ordered]@{}; $questsOf[$tok] = @(); $rewardsOf[$tok] = @() }
    $questsOf[$tok] += [int]$q.id
    $rewardsOf[$tok] += $q.rewards
    foreach ($c in $classBits.Keys) {
        if ($q.classes -ne 0 -and -not ($q.classes -band $classBits[$c])) { continue }
        if (-not $turnIns[$tok].Contains($c)) { $turnIns[$tok][$c] = @() }
        $turnIns[$tok][$c] += $q
    }
}
# The quest lists collected from Wowhead must match.
foreach ($p in $raw.tokenTurnIns.quests.PSObject.Properties) {
    if ($p.Name -notmatch '^\d+$') { continue }
    $want = @($p.Value | ForEach-Object { [int]$_[0] } | Sort-Object) -join ','
    $got = @($questsOf[[int]$p.Name] | Sort-Object) -join ','
    if ($want -ne $got) { throw "Token $($p.Name): Wowhead lists quests $want but CMaNGOS has $got" }
}

$sb = [System.Text.StringBuilder]::new()
function W([string]$s = '') { [void]$sb.Append($s); [void]$sb.Append("`n") }

W '-- King''s Gambit: Temple of Ahn''Qiraj (AQ40) training data (Phase 4.5). GENERATED by scripts/build-aq-data.ps1'
W '-- from simulator/data/aq40-raw.json (Wowhead Classic drop tables, epic+ items, collected 2026-10-29). Do not edit by hand.'
W '-- Token turn-ins from the CMaNGOS world database (simulator/data/cmangos.json), reputation from the wiki'
W '-- (simulator/data/aq-reputation.json). Item stats from the CMaNGOS world database, judged by the fit heuristic.'
W 'local _, SK = ...'
W 'local M = SK:NewModule("AQ40")'
W ''
W 'M.name = "Temple of Ahn''Qiraj"'
W ('M.CLASS_BITS = { ' + (($classBits.GetEnumerator() | ForEach-Object { "$($_.Key) = $($_.Value)" }) -join ', ') + ' }')
W ''
W '-- items[id] = { id, name, slot, armor, classes (bitmask, 0 = any), fit, token? }'
W '-- fit: the item as ItemFit sees it (slot, item class, subclass, stats), from the CMaNGOS world database.'
W '-- token = { makes, turnIns = { [CLASS] = { { reward, quest, needs = { { item, count } }, reputation } } } }'
W 'M.items = {'
$seen = @{}
foreach ($b in $raw.bosses) {
    foreach ($i in $b[2]) {
        $id = [int]$i[0]
        if ($seen.ContainsKey($id)) { continue }
        $seen[$id] = $true
        $name = [string]$i[1]
        $cls = [int]$i[4]; $sub = [int]$i[5]; $mask = [int]$i[6]
        $arm = if ($cls -eq 4 -and $armor.ContainsKey($sub)) { "`"$($armor[$sub])`"" } else { 'nil' }
        $line = "    [$id] = { id = $id, name = $(Q $name), slot = $([int]$i[3]), armor = $arm, classes = $mask, fit = $(FitLua $id)"
        if ($cls -eq 12) {
            if (-not $turnIns.ContainsKey($id)) { throw "No turn-in quest found for token $id ($name)" }
            if (-not $rep.byToken.PSObject.Properties[[string]$id]) { throw "No reputation entry for token $id ($name)" }
            $r = $rep.byToken.([string]$id)
            $repLua = if ($r) { "{ faction = $(Q $r[0]), factionId = $($rep.factions.($r[0])), standing = $(Q $r[1]) }" } else { 'nil' }
            $parts = @()
            foreach ($c in $turnIns[$id].Keys) {
                $opts = foreach ($t in $turnIns[$id][$c]) {
                    $needs = ($t.needs | ForEach-Object { "{ $([int]$_[0]), $([int]$_[1]) }" }) -join ', '
                    $reward = ($t.rewards | ForEach-Object { $dbItems[[int]$_].name }) -join ' / '
                    "{ reward = $(Q $reward), quest = $([int]$t.id), needs = { $needs }, reputation = $repLua }"
                }
                $parts += "$c = { $($opts -join ', ') }"
            }
            $line += ", token = { makes = $(Q (MakesOf $rewardsOf[$id])), turnIns = { $($parts -join ', ') } }"
        }
        W ($line + ' },')
    }
}
W '}'
W ''
W '-- Bosses in the usual kill order. drops = epics per kill (from observed rates); loot = { { id, weight } }.'
W 'M.bosses = {'
foreach ($b in $raw.bosses) {
    $loot = $b[2]
    $sum = ($loot | ForEach-Object { [double]$_[7] } | Measure-Object -Sum).Sum
    $drops = [Math]::Max(1, [Math]::Round($sum))
    W ("    { name = $(Q $b[0]), id = $($b[1]), drops = $drops, loot = {")
    foreach ($i in $loot) { W ("        { $([int]$i[0]), $([double]$i[7]) },  -- $($i[1])") }
    W '    } },'
}
W '}'
W ''
# The simulated guild's officers' overrides of the fit heuristic, for items in this raid (officer-calls.json).
$calls = (Get-Content (Join-Path $repo 'simulator/data/officer-calls.json') -Raw | ConvertFrom-Json).calls
W '-- The simulated guild''s officers'' overrides of the fit heuristic (simulator/data/officer-calls.json), for items'
W '-- whose effect is not a stat. The simulator records them in its ledger (ItemSuits) before a raid night.'
W 'M.officerCalls = {'
foreach ($p in $calls.PSObject.Properties | Sort-Object { [int]$_.Name }) {
    if (-not $seen.ContainsKey([int]$p.Name)) { continue }
    $rolesLua = ($p.Value[0] | ForEach-Object { Q $_ }) -join ', '
    W ("    [$($p.Name)] = { roles = { $rolesLua }, reason = $(Q $p.Value[1]) },")
}
W '}'
W ''
W 'function M.Item(id) return M.items[id] end'
$out = Join-Path $repo 'src/KingsGambit/AQ40.lua'
[System.IO.File]::WriteAllText($out, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Host "Wrote $out ($($seen.Count) items, $($raw.bosses.Count) bosses)"
