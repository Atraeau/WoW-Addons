# C_SpellBook

[← API index](../README.md) · group: [Spells, Auras & Talents](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**51** functions · **19** events · **2** types

## Functions

### C_SpellBook.AbortSpellIntro

```lua
C_SpellBook.AbortSpellIntro(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.AbortSpellIntro(2050)
```

### C_SpellBook.CastSpellBookItem

```lua
C_SpellBook.CastSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank, targetSelf)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |
| `targetSelf` | bool | no | If true, spell will target the current player; Otherwise, targets the player's current target (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.CastSpellBookItem(1, 2050, false)
```

### C_SpellBook.ContainsAnyDisenchantSpell

Returns true if player knows any Disenchant spells

```lua
contains = C_SpellBook.ContainsAnyDisenchantSpell()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contains` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contains = C_SpellBook.ContainsAnyDisenchantSpell()
```

### C_SpellBook.FindBaseSpellByID

```lua
baseSpellID = C_SpellBook.FindBaseSpellByID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseSpellID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local baseSpellID = C_SpellBook.FindBaseSpellByID(2050)
```

### C_SpellBook.FindFlyoutSlotBySpellID

```lua
flyoutSlot = C_SpellBook.FindFlyoutSlotBySpellID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutSlot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flyoutSlot = C_SpellBook.FindFlyoutSlotBySpellID(2050)
```

### C_SpellBook.FindSpellBookSlotForSpell

If found, returns the first slot position of a SpellBookItem matching the specified spell and criteria

```lua
spellBookItemSlotIndex, spellBookItemSpellBank = C_SpellBook.FindSpellBookSlotForSpell(spellIdentifier, includeHidden, includeFlyouts, includeFutureSpells, includeOffSpec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `includeHidden` | bool | no | If true, search includes SpellBookItems that are hidden from the SpellBook UI (ex: spells that have been replaced, are also in a Flyout, etc) (default: False) |
| `includeFlyouts` | bool | no | If true, search includes Flyout SpellBookItems containing the specified spell (default: True) |
| `includeFutureSpells` | bool | no | If true, search includes SpellBookItems for spells that have not yet been learned (default: False) |
| `includeOffSpec` | bool | no | If true, search includes SpellBookItems belonging to non-active specializations; If spell is in active and inactive spec, the active spec slot will always be returned (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellBookItemSlotIndex, spellBookItemSpellBank = C_SpellBook.FindSpellBookSlotForSpell(2050, false, false, 2050, false)
```

### C_SpellBook.FindSpellOverrideByID

```lua
overrideSpellID = C_SpellBook.FindSpellOverrideByID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideSpellID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local overrideSpellID = C_SpellBook.FindSpellOverrideByID(2050)
```

### C_SpellBook.GetClassSkillLineInfo

```lua
skillLineInfo = C_SpellBook.GetClassSkillLineInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineInfo` | SpellBookSkillLineInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineInfo = C_SpellBook.GetClassSkillLineInfo()
```

### C_SpellBook.GetCurrentLevelSpells

Returns general, class, and active spec spells that are learned at the specified level

```lua
spellIDs = C_SpellBook.GetCurrentLevelSpells(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellIDs = C_SpellBook.GetCurrentLevelSpells(0)
```

### C_SpellBook.GetNumSpellBookSkillLines

```lua
numSpellBookSkillLines = C_SpellBook.GetNumSpellBookSkillLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSpellBookSkillLines` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSpellBookSkillLines = C_SpellBook.GetNumSpellBookSkillLines()
```

### C_SpellBook.GetSkillLineIndexByID

```lua
skillIndex = C_SpellBook.GetSkillLineIndexByID(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillIndex` | luaIndex | yes | Will be nil if the specified SkillLine could not be found, or if it is not one of the player's tracked skill lines |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillIndex = C_SpellBook.GetSkillLineIndexByID(0)
```

### C_SpellBook.GetSpellBookItemAutoCast

Returns nothing if item doesn't exist or isn't a spell

```lua
autoCastAllowed, autoCastEnabled = C_SpellBook.GetSpellBookItemAutoCast(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCastAllowed` | bool | no | True if this spell is allowed to be auto-cast |
| `autoCastEnabled` | bool | no | True if auto-casting this spell is currently enabled (usually by the player) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local autoCastAllowed, autoCastEnabled = C_SpellBook.GetSpellBookItemAutoCast(1, 2050)
```

### C_SpellBook.GetSpellBookItemCastCount

Returns number of times a SpellBookItem can be cast, typically based on availability of things like required reagent items; Always returns 0 if item is not found or is not a spell

```lua
castCount = C_SpellBook.GetSpellBookItemCastCount(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `castCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local castCount = C_SpellBook.GetSpellBookItemCastCount(1, 2050)
```

### C_SpellBook.GetSpellBookItemChargeDuration

Returns a duration object describing the active recharge time for a spellbook item.

```lua
duration = C_SpellBook.GetSpellBookItemChargeDuration(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_SpellBook.GetSpellBookItemChargeDuration(1, 2050)
```

### C_SpellBook.GetSpellBookItemCharges

Returns a table of info about the charges of a charge-accumulating SpellBookItem; May return nil if item is not found or is not charge-based

```lua
chargeInfo = C_SpellBook.GetSpellBookItemCharges(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chargeInfo` | SpellChargeInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chargeInfo = C_SpellBook.GetSpellBookItemCharges(1, 2050)
```

### C_SpellBook.GetSpellBookItemCooldown

Returns nil if item doesn't exist or if this kind of item doesn't display cooldowns (ex: future or offspec spells)

```lua
spellCooldownInfo = C_SpellBook.GetSpellBookItemCooldown(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCooldownInfo` | SpellCooldownInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellCooldownInfo = C_SpellBook.GetSpellBookItemCooldown(1, 2050)
```

### C_SpellBook.GetSpellBookItemCooldownDuration

Returns a duration object describing the active cooldown duration for a spellbook item.

```lua
duration = C_SpellBook.GetSpellBookItemCooldownDuration(spellBookItemSlotIndex, spellBookItemSpellBank, ignoreGCD)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |
| `ignoreGCD` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_SpellBook.GetSpellBookItemCooldownDuration(1, 2050, false)
```

### C_SpellBook.GetSpellBookItemDescription

```lua
description = C_SpellBook.GetSpellBookItemDescription(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no | May be empty if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_SpellBook.GetSpellBookItemDescription(1, 2050)
```

### C_SpellBook.GetSpellBookItemInfo

```lua
spellBookItemInfo = C_SpellBook.GetSpellBookItemInfo(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemInfo` | SpellBookItemInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellBookItemInfo = C_SpellBook.GetSpellBookItemInfo(1, 2050)
```

### C_SpellBook.GetSpellBookItemLevelLearned

Returns the level the spell is learned at; May return a different value if the player is currently Level Linked with another player; Returns 0 if item is not a Spell

```lua
levelLearned = C_SpellBook.GetSpellBookItemLevelLearned(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelLearned` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local levelLearned = C_SpellBook.GetSpellBookItemLevelLearned(1, 2050)
```

### C_SpellBook.GetSpellBookItemLink

```lua
spellLink = C_SpellBook.GetSpellBookItemLink(spellBookItemSlotIndex, spellBookItemSpellBank, [glyphID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |
| `glyphID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellLink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellLink = C_SpellBook.GetSpellBookItemLink(1, 2050)
```

### C_SpellBook.GetSpellBookItemLossOfControlCooldownDuration

Returns a duration object describing the active loss of control cooldown duration for a spellbook item.

```lua
duration = C_SpellBook.GetSpellBookItemLossOfControlCooldownDuration(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_SpellBook.GetSpellBookItemLossOfControlCooldownDuration(1, 2050)
```

### C_SpellBook.GetSpellBookItemLossOfControlCooldownInfo

Returns nil if item doesn't exist or if this kind of item doesn't display cooldowns (ex: future or offspec spells)

```lua
lossOfControlInfo = C_SpellBook.GetSpellBookItemLossOfControlCooldownInfo(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lossOfControlInfo` | SpellLossOfControlInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lossOfControlInfo = C_SpellBook.GetSpellBookItemLossOfControlCooldownInfo(1, 2050)
```

### C_SpellBook.GetSpellBookItemName

```lua
name, subName = C_SpellBook.GetSpellBookItemName(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `subName` | string | no | May be empty if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, subName = C_SpellBook.GetSpellBookItemName(1, 2050)
```

### C_SpellBook.GetSpellBookItemPowerCost

Returns a table containing one or more SpellPowerCostInfos, one for each power type a SpellBookItem costs; May return nil if item is not found or has no resource costs

```lua
powerCosts = C_SpellBook.GetSpellBookItemPowerCost(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerCosts` | SpellPowerCostInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerCosts = C_SpellBook.GetSpellBookItemPowerCost(1, 2050)
```

### C_SpellBook.GetSpellBookItemSkillLineIndex

Get the index of the SkillLine this SpellBookItem is part of

```lua
skillLineIndex = C_SpellBook.GetSpellBookItemSkillLineIndex(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineIndex` | luaIndex | yes | Will be nil if the specified SpellBookItem doesn't exist or isn't part of a SkillLine |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineIndex = C_SpellBook.GetSpellBookItemSkillLineIndex(1, 2050)
```

### C_SpellBook.GetSpellBookItemTexture

```lua
iconID = C_SpellBook.GetSpellBookItemTexture(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconID` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local iconID = C_SpellBook.GetSpellBookItemTexture(1, 2050)
```

### C_SpellBook.GetSpellBookItemTradeSkillLink

Returns nil if SpellBookItem is not associated with a trade skill

```lua
spellLink = C_SpellBook.GetSpellBookItemTradeSkillLink(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellLink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellLink = C_SpellBook.GetSpellBookItemTradeSkillLink(1, 2050)
```

### C_SpellBook.GetSpellBookItemType

```lua
itemType, actionID, spellID = C_SpellBook.GetSpellBookItemType(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemType` | SpellBookItemType | no |  |
| `actionID` | number | no | Represents a base spellID for spells, flyoutID for flyouts, or petActionID for pet actions |
| `spellID` | number | yes | May be nil if item is not a spell; Will be the overriding spellID if spell is overriden, otherwise will match actionID |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemType, actionID, spellID = C_SpellBook.GetSpellBookItemType(1, 2050)
```

### C_SpellBook.GetSpellBookSkillLineInfo

```lua
skillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo(skillLineIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineInfo` | SpellBookSkillLineInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo(1)
```

### C_SpellBook.HasPetSpells

Returns nothing if player has no pet spells

```lua
numPetSpells, petNameToken = C_SpellBook.HasPetSpells()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPetSpells` | number | no |  |
| `petNameToken` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numPetSpells, petNameToken = C_SpellBook.HasPetSpells()
```

### C_SpellBook.IsAutoAttackSpellBookItem

Returns true if the SpellBookItem is the player's melee Auto Attack spell

```lua
isAutoAttack = C_SpellBook.IsAutoAttackSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoAttack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAutoAttack = C_SpellBook.IsAutoAttackSpellBookItem(1, 2050)
```

### C_SpellBook.IsClassTalentSpellBookItem

Returns true if the SpellBookItem comes from a Class Talent

```lua
isClassTalent = C_SpellBook.IsClassTalentSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isClassTalent` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isClassTalent = C_SpellBook.IsClassTalentSpellBookItem(1, 2050)
```

### C_SpellBook.IsPvPTalentSpellBookItem

Returns true if the SpellBookItem comes from a PvP Talent

```lua
isPvPTalent = C_SpellBook.IsPvPTalentSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPvPTalent` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPvPTalent = C_SpellBook.IsPvPTalentSpellBookItem(1, 2050)
```

### C_SpellBook.IsRangedAutoAttackSpellBookItem

Returns true if the SpellBookItem is the player's ranged Auto Attack spell (ex: Shoot, Auto Shot, etc)

```lua
isRangedAutoAttack = C_SpellBook.IsRangedAutoAttackSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRangedAutoAttack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRangedAutoAttack = C_SpellBook.IsRangedAutoAttackSpellBookItem(1, 2050)
```

### C_SpellBook.IsSpellBookItemHarmful

Returns true if the SpellBookIem can be cast on hostile targets

```lua
isHarmful = C_SpellBook.IsSpellBookItemHarmful(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHarmful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHarmful = C_SpellBook.IsSpellBookItemHarmful(1, 2050)
```

### C_SpellBook.IsSpellBookItemHelpful

Returns true if the SpellBookIem can be cast on the player or other friendly targets

```lua
isHelpful = C_SpellBook.IsSpellBookItemHelpful(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHelpful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHelpful = C_SpellBook.IsSpellBookItemHelpful(1, 2050)
```

### C_SpellBook.IsSpellBookItemInRange

Returns true if the current target is within range of the SpellBookIem; False if out of range; Nil if range check was invalid

```lua
inRange = C_SpellBook.IsSpellBookItemInRange(spellBookItemSlotIndex, spellBookItemSpellBank, [targetUnit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |
| `targetUnit` | UnitToken | yes | Optional specific target; If not supplied, player's current target (if any) will be used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inRange` | bool | yes | May be nil if the range check was invalid, ie due to unknown/invalid spell, missing/invalid target, etc |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inRange = C_SpellBook.IsSpellBookItemInRange(1, 2050)
```

### C_SpellBook.IsSpellBookItemLooseFlyoutMember

Returns true if the SpellBookItem is represented in a Flyout.

```lua
isFlyoutMember = C_SpellBook.IsSpellBookItemLooseFlyoutMember(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFlyoutMember` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFlyoutMember = C_SpellBook.IsSpellBookItemLooseFlyoutMember(1, 2050)
```

### C_SpellBook.IsSpellBookItemLowRank

Returns true if the SpellBookItem is a lower rank of a known higher rank spell.  Returns false if there is only a single rank or it is the highest rank known.

```lua
isLowRank = C_SpellBook.IsSpellBookItemLowRank(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLowRank` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLowRank = C_SpellBook.IsSpellBookItemLowRank(1, 2050)
```

### C_SpellBook.IsSpellBookItemOffSpec

Returns true if the SpellBookItem belongs to a non-active class specialization

```lua
isOffSpec = C_SpellBook.IsSpellBookItemOffSpec(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOffSpec` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isOffSpec = C_SpellBook.IsSpellBookItemOffSpec(1, 2050)
```

### C_SpellBook.IsSpellBookItemPassive

Returns true if the SpellBookItem is a passive spell; Will always return false if it is not a spell

```lua
isPassive = C_SpellBook.IsSpellBookItemPassive(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPassive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPassive = C_SpellBook.IsSpellBookItemPassive(1, 2050)
```

### C_SpellBook.IsSpellBookItemUsable

Returns whether the SpellBookIem is currently castable; Typically based on things like learned status, required resources, etc

```lua
isUsable, insufficientPower = C_SpellBook.IsSpellBookItemUsable(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsable` | bool | no |  |
| `insufficientPower` | bool | no | True if SpellBookIem is specifically unusable due to insufficient power (ie MANA, RAGE, etc) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsable, insufficientPower = C_SpellBook.IsSpellBookItemUsable(1, 2050)
```

### C_SpellBook.IsSpellInSpellBook

Returns true if a spell should be found in the spellbook. This function can also return true for spells that aren't known, such as override spells granted by an aura linked to class talents

```lua
isInSpellBook = C_SpellBook.IsSpellInSpellBook(spellID, spellBank, includeOverrides)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `spellBank` | SpellBookSpellBank | no | (default: Player) |
| `includeOverrides` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInSpellBook` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInSpellBook = C_SpellBook.IsSpellInSpellBook(2050, 2050, false)
```

### C_SpellBook.IsSpellKnown

Returns true if a player knows a spell. This function can also return true for spells that aren't in the spellbook, such as temporarily-granted abilities

```lua
isKnown = C_SpellBook.IsSpellKnown(spellID, spellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `spellBank` | SpellBookSpellBank | no | (default: Player) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKnown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isKnown = C_SpellBook.IsSpellKnown(2050, 2050)
```

### C_SpellBook.IsSpellKnownOrInSpellBook

Returns true if a spell is considered to be known or present in the spellbook

```lua
isKnownOrInSpellBook = C_SpellBook.IsSpellKnownOrInSpellBook(spellID, spellBank, includeOverrides)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `spellBank` | SpellBookSpellBank | no | (default: Player) |
| `includeOverrides` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKnownOrInSpellBook` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isKnownOrInSpellBook = C_SpellBook.IsSpellKnownOrInSpellBook(2050, 2050, false)
```

### C_SpellBook.PickupSpellBookItem

```lua
C_SpellBook.PickupSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.PickupSpellBookItem(1, 2050)
```

### C_SpellBook.SetBarSlotFromIntro

```lua
C_SpellBook.SetBarSlotFromIntro(spellID, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `slotIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.SetBarSlotFromIntro(2050, 1)
```

### C_SpellBook.SetSpellBookItemAutoCastEnabled

```lua
C_SpellBook.SetSpellBookItemAutoCastEnabled(spellBookItemSlotIndex, spellBookItemSpellBank, enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.SetSpellBookItemAutoCastEnabled(1, 2050, false)
```

### C_SpellBook.SpellBookItemHasRange

Returns true if the SpellBookIem has a min and/or max range greater than 0; Will always return false if it is not a spell

```lua
hasRange = C_SpellBook.SpellBookItemHasRange(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRange` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasRange = C_SpellBook.SpellBookItemHasRange(1, 2050)
```

### C_SpellBook.ToggleSpellBookItemAutoCast

```lua
C_SpellBook.ToggleSpellBookItemAutoCast(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpellBook.ToggleSpellBookItemAutoCast(1, 2050)
```

## Events

### CURRENT_SPELL_CAST_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cancelledCast` | bool | no |  |

### LEARNED_SPELL_IN_SKILL_LINE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `skillLineIndex` | luaIndex | no |  |
| `isGuildPerkSpell` | bool | no |  |

### MAX_SPELL_START_RECOVERY_OFFSET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clampedNewQueueWindowMs` | number | no |  |

### PLAYER_TOTEM_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totemSlot` | luaIndex | no |  |

### SPELL_FLYOUT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | yes |  |
| `spellID` | number | yes |  |
| `isLearned` | bool | yes |  |

### SPELL_PUSHED_TO_ACTIONBAR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `slot` | luaIndex | no |  |
| `page` | luaIndex | no |  |

### SPELL_PUSHED_TO_FLYOUT_ON_ACTIONBAR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `flyoutSlot` | luaIndex | no |  |
| `flyoutPage` | luaIndex | no |  |

### SPELLS_CHANGED

### SPELL_UPDATE_CHARGES

### SPELL_UPDATE_COOLDOWN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes | Can be a base spell or an override spell. A nil value indicates that all cooldowns should be updated, rather than just a specific one. |
| `baseSpellID` | number | yes | Will be set to the base spell if the spellID parameter is an override spell. |
| `category` | number | yes | If the spellID parameter is set, the cooldown category of the spell. A nil value indicates the spell does not have a cooldown category. |
| `startRecoveryCategory` | number | yes | If the spellID parameter is set, the cooldown start recovery category of the spell. A nil value indicates the spell does not have a cooldown start recovery category. |
| `itemID` | number | yes | If the itemID parameter is set, it's the itemID associated with the cast of the spell. |

### SPELL_UPDATE_ICON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes | Always refers to the base spell. A nil value indicates that all icons should be updated, rather than just a specific one. |

### SPELL_UPDATE_USABLE

### SPELL_UPDATE_USES

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no | Can be a base spell or override spell. |
| `baseSpellID` | number | yes | Will be set to the base spell if the spellID parameter is an override spell. |

### START_AUTOREPEAT_SPELL

### STOP_AUTOREPEAT_SPELL

### UPDATE_SHAPESHIFT_COOLDOWN

### UPDATE_SHAPESHIFT_FORM

### UPDATE_SHAPESHIFT_FORMS

### UPDATE_SHAPESHIFT_USABLE

## Types

### SpellBookItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | number | no | Represents a base spellID for spells, flyoutID for flyouts, or petActionID for pet actions |
| `spellID` | number | yes | May be nil if item is not a spell; Will be the overriding spellID if spell is overriden, otherwise will match actionID |
| `itemType` | SpellBookItemType | no |  |
| `name` | string | no |  |
| `subName` | string | no | May be empty if flyout, or if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |
| `iconID` | fileID | no |  |
| `isPassive` | bool | no | True if the item is a passive spell; Will always be false if it is not a spell |
| `isOffSpec` | bool | no | True if the item belongs to a non-active specialization |
| `skillLineIndex` | luaIndex | yes | Index of the SkillLine this SpellBookItem is part of; Nil this SpellBookItem isn't part of a SkillLine |

### SpellBookSkillLineInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `iconID` | fileID | no |  |
| `itemIndexOffset` | number | no | This value + 1 is the first Spell Book Item slotIndex within this skill line |
| `numSpellBookItems` | number | no |  |
| `isGuild` | bool | no |  |
| `shouldHide` | bool | no |  |
| `specID` | number | yes | Will be nil if this skill line is not associated with a specialization |
| `offSpecID` | number | yes | Will be nil if this skill line is not associated with a non-active specialization |

