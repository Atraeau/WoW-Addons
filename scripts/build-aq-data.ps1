#requires -Version 7.0
<#
.SYNOPSIS
    Generate src/KingsGambit/AQ40.lua (training data) from simulator/data/aq40-raw.json.

.DESCRIPTION
    aq40-raw.json holds the Temple of Ahn'Qiraj's epic drops per boss as collected from Wowhead Classic (item id,
    name, slot, item class/subclass, required-class mask, observed drop rate) and the token turn-ins verified so far.
    This script adds a role tag to every item that is not class-restricted, describes each token (what it makes,
    and the turn-ins we know), works out drops per kill from the observed rates, and writes a Lua module.

    The role tags are PROVISIONAL: judged from item names and slots, to be replaced by tags derived from real
    item stats once those are collected. A token's `makes` is general knowledge of the raid, not yet checked
    against the quest pages; only the turn-ins listed in the raw data are verified.
#>
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$raw = Get-Content (Join-Path $repo 'simulator/data/aq40-raw.json') -Raw | ConvertFrom-Json

# Who wants each item that is not class-restricted (provisional, see above). Roles: tank, melee, hunter,
# caster, healer. A token usable by several roles lists them joined with "|".
$roles = @{
    # The Prophet Skeram
    'Amulet of Foul Warding' = 'tank'; 'Barrage Shoulders' = 'hunter'; 'Beetle Scaled Wristguards' = 'tank'
    'Boots of the Unwavering Will' = 'tank'; 'Breastplate of Annihilation' = 'melee'; 'Cloak of Concentrated Hatred' = 'melee'
    'Leggings of Immersion' = 'healer'; 'Pendant of the Qiraji Guardian' = 'tank'; 'Ring of Swarming Thought' = 'caster'
    'Boots of the Redeemed Prophecy' = 'healer'; "Hammer of Ji'zhi" = 'healer'; 'Staff of the Qiraji Prophets' = 'caster'
    'Boots of the Fallen Prophet' = 'caster'
    # The Bug Trio
    'Mantle of Phrenic Power' = 'caster'; 'Bile-Covered Gauntlets' = 'melee'; "Ukko's Ring of Darkness" = 'tank'
    'Robes of the Triumvirate' = 'healer'; "Angelista's Touch" = 'tank'; 'Cape of the Trinity' = 'caster'
    'Guise of the Devourer' = 'tank'; 'Ternary Mantle' = 'healer'; 'Triad Girdle' = 'melee'
    'Mantle of the Desert Crusade' = 'healer'; "Mantle of the Desert's Fury" = 'caster'
    # Battleguard Sartura
    'Gauntlets of Steadfast Determination' = 'tank'; 'Gloves of Enforcement' = 'melee'; 'Leggings of the Festering Swarm' = 'caster'
    'Necklace of Purity' = 'healer'; 'Recomposed Boots' = 'caster'; 'Robes of the Battleguard' = 'caster'
    'Thick Qirajihide Belt' = 'tank'; 'Badge of the Swarmguard' = 'melee'; 'Creeping Vine Helm' = 'healer'
    'Legplates of Blazing Light' = 'healer'; "Sartura's Might" = 'healer'; 'Silithid Claw' = 'melee'
    'Scaled Leggings of Qiraji Fury' = 'caster'
    # Fankriss the Unyielding
    'Barbed Choker' = 'melee'; 'Cloak of Untold Secrets' = 'tank'; 'Fetish of the Sand Reaver' = 'melee'
    'Mantle of Wicked Revenge' = 'melee'; 'Pauldrons of the Unrelenting' = 'tank'; 'Robes of the Guardian Saint' = 'healer'
    'Scaled Sand Reaver Leggings' = 'hunter'; 'Silithid Carapace Chestguard' = 'tank'; "Hive Tunneler's Boots" = 'melee'
    'Ancient Qiraji Ripper' = 'melee'; 'Barb of the Sand Reaver' = 'hunter'; 'Libram of Grace' = 'healer'; 'Totem of Life' = 'healer'
    # Viscidus
    'Idol of Health' = 'healer'; 'Ring of the Qiraji Fury' = 'melee'; 'Scarab Brooch' = 'healer'
    'Slime-coated Leggings' = 'hunter'; 'Sharpened Silithid Femur' = 'caster'; 'Gauntlets of Kalimdor' = 'caster'
    'Gauntlets of the Righteous Champion' = 'melee'
    # Princess Huhuran
    'Gloves of the Messiah' = 'healer'; 'Hive Defiler Wristguards' = 'melee'; 'Ring of the Martyr' = 'healer'
    'Wasphide Gauntlets' = 'healer'; 'Cloak of the Golden Hive' = 'tank'; "Huhuran's Stinger" = 'hunter'
    # The Twin Emperors
    'Royal Qiraji Belt' = 'tank'; 'Boots of Epiphany' = 'caster'; 'Qiraji Execution Bracers' = 'melee'
    "Ring of Emperor Vek'lor" = 'tank'; "Vek'lor's Gloves of Devastation" = 'hunter'; "Royal Scepter of Vek'lor" = 'caster'
    "Amulet of Vek'nilash" = 'caster'; 'Bracelets of Royal Redemption' = 'healer'; 'Gloves of the Hidden Temple' = 'tank'
    "Regenerating Belt of Vek'nilash" = 'tank'; 'Belt of the Fallen Emperor' = 'melee'; "Kalimdor's Revenge" = 'melee'
    'Grasp of the Fallen Emperor' = 'hunter'
    # Ouro
    'Burrower Bracers' = 'caster'; 'Jom Gabbar' = 'melee'; 'Larvae of the Great Worm' = 'hunter'
    "The Burrower's Shell" = 'tank'; 'Wormscale Blocker' = 'healer'; "Don Rigoberto's Lost Hat" = 'healer'
    # C'Thun
    'Cloak of Clarity' = 'healer'; 'Gauntlets of Annihilation' = 'melee'; "Mark of C'Thun" = 'tank'
    'Belt of Never-ending Agony' = 'melee'; 'Cloak of the Devoured' = 'caster'; 'Dark Storm Gauntlets' = 'caster'
    'Eyestalk Waist Cord' = 'caster'; 'Grasp of the Old God' = 'healer'; 'Ring of the Godslayer' = 'hunter'
    "Vanquished Tentacle of C'Thun" = 'melee'; "Death's Sting" = 'melee'; 'Dark Edge of Insanity' = 'melee'
    'Scepter of the False Prophet' = 'healer'
    # Tokens open to every class: by who uses what they make
    'Imperial Qiraji Armaments' = 'tank|melee|hunter'; 'Imperial Qiraji Regalia' = 'caster|healer'
    "Eye of C'Thun" = 'tank|melee|hunter|caster|healer'
}

# What each token makes (general knowledge, not yet checked against the quest pages).
$makes = @{
    20928 = 'Shoulders or feet'; 20932 = 'Shoulders or feet'
    20930 = 'Head'; 20926 = 'Head'
    20931 = 'Legs'; 20927 = 'Legs'
    20933 = 'Chest'; 20929 = 'Chest'
    21232 = 'A weapon'; 21237 = 'A weapon'
    21221 = 'A neck, back or finger item'
}
# Factions by name (the game's faction ids).
$factions = @{ 'Brood of Nozdormu' = 910 }

$classBits = [ordered]@{ WARRIOR = 1; PALADIN = 2; HUNTER = 4; ROGUE = 8; PRIEST = 16; SHAMAN = 64; MAGE = 128; WARLOCK = 256; DRUID = 1024 }
$armor = @{ 1 = 'cloth'; 2 = 'leather'; 3 = 'mail'; 4 = 'plate' }

function Q([string]$s) { '"' + ($s -replace '\\', '\\' -replace '"', '\"') + '"' }
function V($v) { if ($v -is [string]) { Q $v } else { [string][int]$v } }

# Verified turn-ins, grouped by token and class.
$turnIns = @{}
foreach ($t in $raw.tokenTurnIns.verified) {
    $tok = [int]$t.token
    if (-not $turnIns.ContainsKey($tok)) { $turnIns[$tok] = [ordered]@{} }
    if (-not $turnIns[$tok].Contains($t.class)) { $turnIns[$tok][$t.class] = @() }
    $turnIns[$tok][$t.class] += $t
}

$sb = [System.Text.StringBuilder]::new()
function W([string]$s = '') { [void]$sb.Append($s); [void]$sb.Append("`n") }

W '-- King''s Gambit: Temple of Ahn''Qiraj (AQ40) training data (Phase 4.5). GENERATED by scripts/build-aq-data.ps1'
W '-- from simulator/data/aq40-raw.json (Wowhead Classic drop tables, epic+ items, collected 2026-10-29). Do not edit by hand.'
W '-- Role tags are provisional (judged from names; to be replaced from real item stats). A token''s `makes` is not yet'
W '-- checked against the quest pages; its `turnIns` are only the verified ones, so readiness is unknown for the rest.'
W 'local _, SK = ...'
W 'local M = SK:NewModule("AQ40")'
W ''
W 'M.name = "Temple of Ahn''Qiraj"'
W ('M.CLASS_BITS = { ' + (($classBits.GetEnumerator() | ForEach-Object { "$($_.Key) = $($_.Value)" }) -join ', ') + ' }')
W ''
W '-- items[id] = { id, name, slot, armor, classes (bitmask, 0 = any), role, token? }'
W '-- token = { makes, turnIns = { [CLASS] = { { reward, quest, needs = { { item, count } }, reputation } } } }'
W 'M.items = {'
$seen = @{}
$untagged = @()
foreach ($b in $raw.bosses) {
    foreach ($i in $b[2]) {
        $id = [int]$i[0]
        if ($seen.ContainsKey($id)) { continue }
        $seen[$id] = $true
        $name = [string]$i[1]
        $cls = [int]$i[4]; $sub = [int]$i[5]; $mask = [int]$i[6]
        $arm = if ($cls -eq 4 -and $armor.ContainsKey($sub)) { "`"$($armor[$sub])`"" } else { 'nil' }
        $role = if ($mask -ne 0) { 'nil' } elseif ($roles.ContainsKey($name)) { Q $roles[$name] } else { $untagged += $name; 'nil' }
        $line = "    [$id] = { id = $id, name = $(Q $name), slot = $([int]$i[3]), armor = $arm, classes = $mask, role = $role"
        if ($cls -eq 12) {
            $parts = @()
            if ($turnIns.ContainsKey($id)) {
                foreach ($c in $turnIns[$id].Keys) {
                    $opts = foreach ($t in $turnIns[$id][$c]) {
                        $needs = ($t.items | ForEach-Object { "{ $(V $_[0]), $([int]$_[1]) }" }) -join ', '
                        $rep = if ($t.reputation) { "{ faction = $(Q $t.reputation[0]), factionId = $($factions[$t.reputation[0]]), standing = $(Q $t.reputation[1]) }" } else { 'nil' }
                        "{ reward = $(Q $t.reward), quest = $([int]$t.quest), needs = { $needs }, reputation = $rep }"
                    }
                    $parts += "$c = { $($opts -join ', ') }"
                }
            }
            $line += ", token = { makes = $(Q $makes[$id]), turnIns = { $($parts -join ', ') } }"
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
W 'function M.Item(id) return M.items[id] end'
$out = Join-Path $repo 'src/KingsGambit/AQ40.lua'
[System.IO.File]::WriteAllText($out, $sb.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Host "Wrote $out ($($seen.Count) items, $($raw.bosses.Count) bosses)"
if ($untagged.Count) { Write-Warning ("No role tag for: " + ($untagged -join ', ')) }
