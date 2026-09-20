# C_Spell

[← API index](../README.md) · group: [Spells, Auras & Talents](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**70** functions · **6** events · **3** types

## Functions

### C_Spell.CancelAutoRepeatSpell

Cancels the player's active auto repeat spell, if any

```lua
wasCancelled = C_Spell.CancelAutoRepeatSpell()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasCancelled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wasCancelled = C_Spell.CancelAutoRepeatSpell()
```

### C_Spell.CancelItemTempEnchantment

Cancel a temporary enchantment on an item

```lua
C_Spell.CancelItemTempEnchantment(weaponSlot, enchantmentType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weaponSlot` | WeaponSlot | no |  |
| `enchantmentType` | ItemEnchantType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.CancelItemTempEnchantment(1, enchantmentType)
```

### C_Spell.CancelSpellByID

```lua
C_Spell.CancelSpellByID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.CancelSpellByID(2050)
```

### C_Spell.DoesSpellExist

Returns true if the spell exists, regardless of whether the player has learned it

```lua
spellExists = C_Spell.DoesSpellExist(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no | Spell ID, name, name(subtext), or link; Using name will always check for an override on that spell |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellExists` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellExists = C_Spell.DoesSpellExist(2050)
```

### C_Spell.EnableSpellRangeCheck

Used in conjunction with SpellRangeCheckUpdate to inform the UI when a spell goes in or out of range with the current target.

```lua
C_Spell.EnableSpellRangeCheck(spellIdentifier, enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `enable` | bool | no | True if changes in range for the spell should dispatch SpellRangeCheckUpdate. False if the spell no longer needs the event. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.EnableSpellRangeCheck(2050, false)
```

### C_Spell.GetAuraStatChanges

```lua
healthChange, powerTypeChanges = C_Spell.GetAuraStatChanges(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healthChange` | number | no |  |
| `powerTypeChanges` | PowerTypeChange[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local healthChange, powerTypeChanges = C_Spell.GetAuraStatChanges(2050)
```

### C_Spell.GetBaseSpell

```lua
baseSpellID = C_Spell.GetBaseSpell(spellIdentifier, spec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `spec` | number | no | Which Class Specialization to consider, as overrides may vary by Spec; Defaults to player's current Spec (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseSpellID` | number | no | Returns the spellID passed in if there is no override |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local baseSpellID = C_Spell.GetBaseSpell(2050, 0)
```

### C_Spell.GetDeadlyDebuffInfo

```lua
deadlyDebuffInfo = C_Spell.GetDeadlyDebuffInfo(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deadlyDebuffInfo` | DeadlyDebuffInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deadlyDebuffInfo = C_Spell.GetDeadlyDebuffInfo(2050)
```

### C_Spell.GetItemModifiedAppearancesApplied

```lua
itemModifiedAppearanceIDs = C_Spell.GetItemModifiedAppearancesApplied(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemModifiedAppearanceIDs = C_Spell.GetItemModifiedAppearancesApplied(2050)
```

### C_Spell.GetLastCategoryCooldownSource

Searches for the most recent spellID and itemID that started a cooldown in this category

```lua
spellID, itemID = C_Spell.GetLastCategoryCooldownSource(spellCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCategory` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes | The most recent spell associated with the category |
| `itemID` | number | yes | The item used to trigger this spell |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID, itemID = C_Spell.GetLastCategoryCooldownSource(2050)
```

### C_Spell.GetMawPowerLinkBySpellID

```lua
link = C_Spell.GetMawPowerLinkBySpellID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local link = C_Spell.GetMawPowerLinkBySpellID(2050)
```

### C_Spell.GetMawPowerRarityInfoBySpellID

```lua
rarityID, rarityBorderAtlas = C_Spell.GetMawPowerRarityInfoBySpellID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rarityID` | number | no |  |
| `rarityBorderAtlas` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rarityID, rarityBorderAtlas = C_Spell.GetMawPowerRarityInfoBySpellID(2050)
```

### C_Spell.GetOverrideSpell

```lua
overrideSpellID = C_Spell.GetOverrideSpell(spellIdentifier, spec, onlyKnown, ignoreOverrideSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `spec` | number | no | Which Class Specialization to consider, as overrides may vary by Spec; Defaults to player's current Spec (default: 0) |
| `onlyKnown` | bool | no | (default: True) |
| `ignoreOverrideSpellID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideSpellID` | number | no | Returns the spellID passed in if there is no override |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local overrideSpellID = C_Spell.GetOverrideSpell(2050, 0, false, 2050)
```

### C_Spell.GetSchoolString

```lua
result = C_Spell.GetSchoolString(schoolMask)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `schoolMask` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Spell.GetSchoolString(0)
```

### C_Spell.GetSpellAutoCast

Returns nil if spell is not found

```lua
autoCastAllowed, autoCastEnabled = C_Spell.GetSpellAutoCast(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCastAllowed` | bool | no |  |
| `autoCastEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local autoCastAllowed, autoCastEnabled = C_Spell.GetSpellAutoCast(2050)
```

### C_Spell.GetSpellCastCount

Returns number of times a spell can be cast, typically based on availability of things like required reagent items; Returns 0 if spell is not found

```lua
castCount = C_Spell.GetSpellCastCount(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `castCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local castCount = C_Spell.GetSpellCastCount(2050)
```

### C_Spell.GetSpellChargeDuration

Returns a duration object describing the active recharge time for a spell.

```lua
duration = C_Spell.GetSpellChargeDuration(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_Spell.GetSpellChargeDuration(2050)
```

### C_Spell.GetSpellCharges

Returns a table of info about the charges of a charge-accumulating spell; May return nil if spell is not found or is not charge-based

```lua
chargeInfo = C_Spell.GetSpellCharges(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chargeInfo` | SpellChargeInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chargeInfo = C_Spell.GetSpellCharges(2050)
```

### C_Spell.GetSpellCooldown

Returns nil if spell is not found

```lua
spellCooldownInfo = C_Spell.GetSpellCooldown(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCooldownInfo` | SpellCooldownInfo | no |  |

**Example**

```lua
-- Returns a SpellCooldownInfo table
local cd = C_Spell.GetSpellCooldown(2050)
if cd and cd.duration > 0 then
    local remaining = (cd.startTime + cd.duration) - GetTime()
    print(("%.1fs remaining"):format(remaining))
end
```

### C_Spell.GetSpellCooldownDuration

Returns a duration object describing the active cooldown duration for a spell.

```lua
duration = C_Spell.GetSpellCooldownDuration(spellIdentifier, ignoreGCD)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `ignoreGCD` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_Spell.GetSpellCooldownDuration(2050, false)
```

### C_Spell.GetSpellDescription

Returns nil if spell is not found

```lua
description = C_Spell.GetSpellDescription(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no | May be empty if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_Spell.GetSpellDescription(2050)
```

### C_Spell.GetSpellDescriptionForItemLocation

Returns nil if spell is not found

```lua
description = C_Spell.GetSpellDescriptionForItemLocation(spellIdentifier, itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no | May be empty if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_Spell.GetSpellDescriptionForItemLocation(2050, 6948)
```

### C_Spell.GetSpellDisplayCount

Depending on the spell, return a string that is either the use count or number of charges. If value is beyond the display count parameter, returns the replacementString (defaults to '*').

```lua
displayCount = C_Spell.GetSpellDisplayCount(spellIdentifier, maxDisplayCount, replacementString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `maxDisplayCount` | number | no | (default: 9999) |
| `replacementString` | cstring | no | (default: *) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayCount` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local displayCount = C_Spell.GetSpellDisplayCount(2050, 0, "")
```

### C_Spell.GetSpellIDForSpellIdentifier

Meant primarily for getting a spell id from a spell name or link; Returns nothing if spell does not exist

```lua
spellID = C_Spell.GetSpellIDForSpellIdentifier(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no | Spell ID, name, name(subtext), or link; Using name will always check for an override on that spell; If passed a spell ID, will return same id as was passed |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_Spell.GetSpellIDForSpellIdentifier(2050)
```

### C_Spell.GetSpellInfo

Returns nil if spell is not found

```lua
spellInfo = C_Spell.GetSpellInfo(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no | Spell ID, name, name(subtext), or link; Using name will always check for an override on that spell |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellInfo` | SpellInfo | no |  |

**Example**

```lua
-- Modern replacement for the old multi-return GetSpellInfo; returns a table.
local info = C_Spell.GetSpellInfo(2050)  -- 2050 = Lesser Heal
if info then
    print(info.name, info.spellID, info.iconID, info.castTime)
end
```

### C_Spell.GetSpellLevelLearned

Returns the level the spell is learned at; May return a different value if the player is currently Level Linked with another player

```lua
levelLearned = C_Spell.GetSpellLevelLearned(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelLearned` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local levelLearned = C_Spell.GetSpellLevelLearned(2050)
```

### C_Spell.GetSpellLink

Returns nil if spell is not found

```lua
spellLink = C_Spell.GetSpellLink(spellIdentifier, [glyphID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `glyphID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellLink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellLink = C_Spell.GetSpellLink(2050)
```

### C_Spell.GetSpellLossOfControlCooldownDuration

Returns a duration object describing the active loss of control cooldown duration for a spell.

```lua
duration = C_Spell.GetSpellLossOfControlCooldownDuration(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_Spell.GetSpellLossOfControlCooldownDuration(2050)
```

### C_Spell.GetSpellLossOfControlCooldownInfo

Returns nil if spell is not found

```lua
lossOfControlInfo = C_Spell.GetSpellLossOfControlCooldownInfo(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lossOfControlInfo` | SpellLossOfControlInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lossOfControlInfo = C_Spell.GetSpellLossOfControlCooldownInfo(2050)
```

### C_Spell.GetSpellMaxCumulativeAuraApplications

```lua
cumulativeAura = C_Spell.GetSpellMaxCumulativeAuraApplications(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cumulativeAura` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cumulativeAura = C_Spell.GetSpellMaxCumulativeAuraApplications(2050)
```

### C_Spell.GetSpellName

Returns nil if spell is not found

```lua
name = C_Spell.GetSpellName(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_Spell.GetSpellName(2050)
```

### C_Spell.GetSpellPowerCost

Returns a table containing one or more SpellPowerCostInfos, one for each power type this spell costs; May return nil if spell is not found or has no resource costs

```lua
powerCosts = C_Spell.GetSpellPowerCost(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerCosts` | SpellPowerCostInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerCosts = C_Spell.GetSpellPowerCost(2050)
```

### C_Spell.GetSpellQueueWindow

```lua
result = C_Spell.GetSpellQueueWindow()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Spell.GetSpellQueueWindow()
```

### C_Spell.GetSpellSkillLineAbilityRank

Returns the rank of a spell that corresponds to an ability within a ranked SkillLine (ex: a crafting Recipe); Returns nil if spell is not found, or isn't part of a ranked SkillLine

```lua
rank = C_Spell.GetSpellSkillLineAbilityRank(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rank` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rank = C_Spell.GetSpellSkillLineAbilityRank(2050)
```

### C_Spell.GetSpellSubtext

Returns nil if spell is not found

```lua
subtext = C_Spell.GetSpellSubtext(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subtext` | string | no | May be empty if spell's data isn't loaded yet; Listen for SPELL_TEXT_UPDATE event, or use SpellMixin to load asynchronously |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local subtext = C_Spell.GetSpellSubtext(2050)
```

### C_Spell.GetSpellTexture

Returns nothing if spell is not found

```lua
iconID, originalIconID, conditionalIconID = C_Spell.GetSpellTexture(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconID` | fileID | no |  |
| `originalIconID` | fileID | no |  |
| `conditionalIconID` | fileID | yes |  |

**Example**

```lua
local icon = C_Spell.GetSpellTexture(2050)
print(icon)  -- fileID of the spell's icon
```

### C_Spell.GetSpellTradeSkillLink

Returns nil if spell is not associated with a trade skill

```lua
spellLink = C_Spell.GetSpellTradeSkillLink(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellLink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellLink = C_Spell.GetSpellTradeSkillLink(2050)
```

### C_Spell.GetTargetSpellID

```lua
spellID = C_Spell.GetTargetSpellID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_Spell.GetTargetSpellID()
```

### C_Spell.GetVisibilityInfo

```lua
hasCustom, alwaysShowMine, showForMySpec = C_Spell.GetVisibilityInfo(spellID, visibilityType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `visibilityType` | SpellAuraVisibilityType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCustom` | bool | no |  |
| `alwaysShowMine` | bool | no |  |
| `showForMySpec` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasCustom, alwaysShowMine, showForMySpec = C_Spell.GetVisibilityInfo(2050, visibilityType)
```

### C_Spell.IsActiveSpell

Returns true if the spell is a currently active toggled spell

```lua
isActiveSpell = C_Spell.IsActiveSpell(spellIdentifier, [targetUnit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `targetUnit` | UnitToken | yes | Optional specific target; If not supplied, the player will be used, or their pet if the spell is a pet spell |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActiveSpell` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActiveSpell = C_Spell.IsActiveSpell(2050)
```

### C_Spell.IsAutoAttackSpell

Returns true if the spell is the player's melee Auto Attack spell

```lua
isAutoAttack = C_Spell.IsAutoAttackSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoAttack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAutoAttack = C_Spell.IsAutoAttackSpell(2050)
```

### C_Spell.IsAutoRepeatSpell

Returns true if the spell is an auto repeat player spell

```lua
isAutoRepeat = C_Spell.IsAutoRepeatSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoRepeat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAutoRepeat = C_Spell.IsAutoRepeatSpell(2050)
```

### C_Spell.IsClassTalentSpell

Returns true if the spell comes from a Class Talent

```lua
isAutoRepeat = C_Spell.IsClassTalentSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoRepeat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAutoRepeat = C_Spell.IsClassTalentSpell(2050)
```

### C_Spell.IsConsumableSpell

```lua
consumable = C_Spell.IsConsumableSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `consumable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local consumable = C_Spell.IsConsumableSpell(2050)
```

### C_Spell.IsCurrentSpell

Returns true if the spell is currently being cast or is queued to be cast

```lua
isCurrentSpell = C_Spell.IsCurrentSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCurrentSpell` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCurrentSpell = C_Spell.IsCurrentSpell(2050)
```

### C_Spell.IsExternalDefensive

Returns true if an aura is considered an external defensive.

```lua
isExternalDefensive = C_Spell.IsExternalDefensive(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isExternalDefensive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isExternalDefensive = C_Spell.IsExternalDefensive(2050)
```

### C_Spell.IsPressHoldReleaseSpell

Returns true if the spell is an 'empower' type spell that is cast by pressing and holding, with the on-release cast typically being affected by time held

```lua
isPressHoldRelease = C_Spell.IsPressHoldReleaseSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPressHoldRelease` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPressHoldRelease = C_Spell.IsPressHoldReleaseSpell(2050)
```

### C_Spell.IsPriorityAura

Returns true if an aura is considered high priority and should be ordered ahead of other auras in the UI.

```lua
isHighPriority = C_Spell.IsPriorityAura(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHighPriority` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHighPriority = C_Spell.IsPriorityAura(2050)
```

### C_Spell.IsPvPTalentSpell

Returns true if the spell comes from a PvP Talent

```lua
isAutoRepeat = C_Spell.IsPvPTalentSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoRepeat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAutoRepeat = C_Spell.IsPvPTalentSpell(2050)
```

### C_Spell.IsRangedAutoAttackSpell

Returns true if the spell is the player's ranged Auto Attack spell (ex: Shoot, Auto Shot, etc)

```lua
isRangedAutoAttack = C_Spell.IsRangedAutoAttackSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRangedAutoAttack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRangedAutoAttack = C_Spell.IsRangedAutoAttackSpell(2050)
```

### C_Spell.IsSelfBuff

Returns true if an aura only applies effects to the player, and no other units.

```lua
hasSelfEffectsOnly = C_Spell.IsSelfBuff(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelfEffectsOnly` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelfEffectsOnly = C_Spell.IsSelfBuff(2050)
```

### C_Spell.IsSpellCrowdControl

Returns true if the spell causes a crowd control effect when cast on a valid target.

```lua
isCrowdControl = C_Spell.IsSpellCrowdControl(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCrowdControl` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCrowdControl = C_Spell.IsSpellCrowdControl(2050)
```

### C_Spell.IsSpellDataCached

Returns true if data for the spell has already been loaded and cached this session

```lua
isCached = C_Spell.IsSpellDataCached(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCached` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCached = C_Spell.IsSpellDataCached(2050)
```

### C_Spell.IsSpellDisabled

```lua
disabled = C_Spell.IsSpellDisabled(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local disabled = C_Spell.IsSpellDisabled(2050)
```

### C_Spell.IsSpellHarmful

Returns true if the spell can be cast on hostile targets

```lua
isHarmful = C_Spell.IsSpellHarmful(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHarmful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHarmful = C_Spell.IsSpellHarmful(2050)
```

### C_Spell.IsSpellHelpful

Returns true if the spell can be cast on the player or other friendly targets

```lua
isHelpful = C_Spell.IsSpellHelpful(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHelpful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHelpful = C_Spell.IsSpellHelpful(2050)
```

### C_Spell.IsSpellImportant

Returns true if the spell is considered important. For example a spell that's lethal if not interrupted would be considered important.

```lua
isImportant = C_Spell.IsSpellImportant(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isImportant` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isImportant = C_Spell.IsSpellImportant(2050)
```

### C_Spell.IsSpellInRange

Returns true if the current target is within range of the spell; False if out of range; Nil if range check was invalid

```lua
inRange = C_Spell.IsSpellInRange(spellIdentifier, [targetUnit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `targetUnit` | UnitToken | yes | Optional specific target; If not supplied, player's current target (if any) will be used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inRange` | bool | yes | May be nil if the range check was invalid, ie due to unknown/invalid spell, missing/invalid target, etc |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inRange = C_Spell.IsSpellInRange(2050)
```

### C_Spell.IsSpellPassive

```lua
isPassive = C_Spell.IsSpellPassive(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPassive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPassive = C_Spell.IsSpellPassive(2050)
```

### C_Spell.IsSpellUsable

Returns whether the spell is currently castable; Typically based on things like learned status, required resources, etc

```lua
isUsable, insufficientPower = C_Spell.IsSpellUsable(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsable` | bool | no |  |
| `insufficientPower` | bool | no | True if spell is specifically unusable due to insufficient power (ie MANA, RAGE, etc) |

**Example**

```lua
local usable, insufficientPower = C_Spell.IsSpellUsable(2050)
print(usable, insufficientPower)
```

### C_Spell.PickupSpell

```lua
C_Spell.PickupSpell(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.PickupSpell(2050)
```

### C_Spell.PlaceTargetingSpellAtCursor

```lua
C_Spell.PlaceTargetingSpellAtCursor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.PlaceTargetingSpellAtCursor()
```

### C_Spell.RequestLoadSpellData

Requests data for the spell be loaded; Listen for SPELL_DATA_LOAD_RESULT to be notified when load is finished

```lua
C_Spell.RequestLoadSpellData(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.RequestLoadSpellData(2050)
```

### C_Spell.SetSpellAutoCastEnabled

```lua
C_Spell.SetSpellAutoCastEnabled(spellIdentifier, enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.SetSpellAutoCastEnabled(2050, false)
```

### C_Spell.SpellHasRange

Returns true if the spell has a min and/or max range greater than 0

```lua
hasRange = C_Spell.SpellHasRange(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRange` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasRange = C_Spell.SpellHasRange(2050)
```

### C_Spell.TargetSpellChecksItemCondition

```lua
result = C_Spell.TargetSpellChecksItemCondition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Spell.TargetSpellChecksItemCondition()
```

### C_Spell.TargetSpellIsEnchanting

```lua
isEnchanting = C_Spell.TargetSpellIsEnchanting()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnchanting` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnchanting = C_Spell.TargetSpellIsEnchanting()
```

### C_Spell.TargetSpellJumpsUpgradeTrack

```lua
jumpsUpgradeTrack = C_Spell.TargetSpellJumpsUpgradeTrack()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `jumpsUpgradeTrack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local jumpsUpgradeTrack = C_Spell.TargetSpellJumpsUpgradeTrack()
```

### C_Spell.TargetSpellReplacesBonusTree

```lua
result = C_Spell.TargetSpellReplacesBonusTree()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Spell.TargetSpellReplacesBonusTree()
```

### C_Spell.ToggleSpellAutoCast

Toggles whether spell's autoCast is enabled

```lua
C_Spell.ToggleSpellAutoCast(spellIdentifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Spell.ToggleSpellAutoCast(2050)
```

## Events

### ENCHANT_SPELL_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `successful` | bool | no |  |
| `enchantedItem` | ItemLocation | yes |  |

### ENCHANT_SPELL_SELECTED

### SPELL_DATA_LOAD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `success` | bool | no |  |

### SPELL_RANGE_CHECK_UPDATE

Used in conjunction with EnableSpellRangeCheck to inform the UI when a spell goes in or out of range with the current target.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIdentifier` | SpellIdentifier | no |  |
| `isInRange` | bool | no | Whether or not the current target is in range of the spell. Should not be used if the 'checksRange' parameter is false. |
| `checksRange` | bool | no | Can be false if a range check was not made for any reason, for example there is not a current target. |

### SPELL_TEXT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

### UPDATE_SPELL_TARGET_ITEM_CONTEXT

## Types

### DeadlyDebuffInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criticalTimeRemainingMs` | number | yes |  |
| `criticalStacks` | number | yes |  |
| `priority` | number | no |  |
| `warningText` | string | no |  |
| `soundKitID` | number | yes |  |

### PowerTypeChange (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerType` | PowerType | no |  |
| `amount` | number | no |  |

### SpellInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `iconID` | fileID | no | Icon for this spell; If spell has been overriden, this may be the icon for the overriding spell; See originalIconID for spell's non-overriden icon |
| `originalIconID` | fileID | no |  |
| `castTime` | number | no |  |
| `minRange` | number | no |  |
| `maxRange` | number | no |  |
| `spellID` | number | no |  |

