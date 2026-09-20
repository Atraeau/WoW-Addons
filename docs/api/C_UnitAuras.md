# C_UnitAuras

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**37** functions · **6** events · **0** types

## Functions

### C_UnitAuras.AddAuraSound

```lua
auraSoundID = C_UnitAuras.AddAuraSound(trigger, sound)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trigger` | UnitAuraSoundTrigger | no |  |
| `sound` | UnitAuraSoundInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraSoundID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local auraSoundID = C_UnitAuras.AddAuraSound(trigger, sound)
```

### C_UnitAuras.AddBlockedAura

```lua
C_UnitAuras.AddBlockedAura(unit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.AddBlockedAura("player", 0)
```

### C_UnitAuras.AddPrivateAuraAnchor

```lua
anchorID = C_UnitAuras.AddPrivateAuraAnchor(args)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `args` | AddPrivateAuraAnchorArgs | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchorID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local anchorID = C_UnitAuras.AddPrivateAuraAnchor(args)
```

### C_UnitAuras.AuraIsBigDefensive

```lua
isBigDefensive = C_UnitAuras.AuraIsBigDefensive(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBigDefensive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBigDefensive = C_UnitAuras.AuraIsBigDefensive(2050)
```

### C_UnitAuras.AuraIsPrivate

```lua
isPrivate = C_UnitAuras.AuraIsPrivate(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPrivate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPrivate = C_UnitAuras.AuraIsPrivate(2050)
```

### C_UnitAuras.CancelAuraByInstanceID

```lua
C_UnitAuras.CancelAuraByInstanceID(unit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.CancelAuraByInstanceID("player", 0)
```

### C_UnitAuras.ClearBlockedAuras

```lua
C_UnitAuras.ClearBlockedAuras(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.ClearBlockedAuras("player")
```

### C_UnitAuras.DoesAuraHaveExpirationTime

Returns true if an aura instance will expire after a certain amount of time.

```lua
hasExpirationTime = C_UnitAuras.DoesAuraHaveExpirationTime(auraInstanceUnit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasExpirationTime` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasExpirationTime = C_UnitAuras.DoesAuraHaveExpirationTime("player", 0)
```

### C_UnitAuras.GetAuraApplicationDisplayCount

Formats a string for displaying the number of applications an aura has present.

```lua
count = C_UnitAuras.GetAuraApplicationDisplayCount(auraInstanceUnit, auraInstanceID, minDisplayCount, [maxDisplayCount])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |
| `minDisplayCount` | number | no | Minimum number of applications required; if the application count is below this figure an empty string will be returned. (default: 2) |
| `maxDisplayCount` | number | yes | Maximum number of applications allowed; if the application count is above this figure then the string '*' will be returned. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_UnitAuras.GetAuraApplicationDisplayCount("player", 0, 0)
```

### C_UnitAuras.GetAuraBaseDuration

Returns the base duration of the given spell (or aura). Takes an optional spellID to use as the new duration if that cannot be derived from the aura, if that value isn't supplied the aura's spellID will be used

```lua
newDuration = C_UnitAuras.GetAuraBaseDuration(auraInstanceUnit, auraInstanceID, [spellID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |
| `spellID` | SpellIdentifier | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newDuration` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newDuration = C_UnitAuras.GetAuraBaseDuration("player", 0)
```

### C_UnitAuras.GetAuraCasterGUID

```lua
casterGUID = C_UnitAuras.GetAuraCasterGUID(auraInstanceUnit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `casterGUID` | WOWGUID | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local casterGUID = C_UnitAuras.GetAuraCasterGUID("player", 0)
```

### C_UnitAuras.GetAuraDataByAuraInstanceID

```lua
aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetAuraDataByAuraInstanceID("player", 0)
```

### C_UnitAuras.GetAuraDataByIndex

```lua
aura = C_UnitAuras.GetAuraDataByIndex(unit, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example**

```lua
-- Iterate a unit's buffs (filter "HELPFUL"/"HARMFUL") until nil
for i = 1, 40 do
    local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
    if not aura then break end
    print(aura.name, aura.spellId, aura.applications)
end
```

### C_UnitAuras.GetAuraDataBySlot

```lua
aura = C_UnitAuras.GetAuraDataBySlot(unit, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `slot` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetAuraDataBySlot("player", 1)
```

### C_UnitAuras.GetAuraDataBySpellName

```lua
aura = C_UnitAuras.GetAuraDataBySpellName(unit, spellName, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `spellName` | cstring | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetAuraDataBySpellName("player", 2050)
```

### C_UnitAuras.GetAuraDispelTypeColor

Queries the dispel type associated with an aura instance and remaps it to a color via a curve, with the dispel type ID used as the 'x' value.

```lua
dispelTypeColor = C_UnitAuras.GetAuraDispelTypeColor(auraInstanceUnit, auraInstanceID, curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |
| `curve` | LuaColorCurveObject | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dispelTypeColor` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dispelTypeColor = C_UnitAuras.GetAuraDispelTypeColor("player", 0, curve)
```

### C_UnitAuras.GetAuraDuration

```lua
duration = C_UnitAuras.GetAuraDuration(auraInstanceUnit, auraInstanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_UnitAuras.GetAuraDuration("player", 0)
```

### C_UnitAuras.GetAuraSlots

```lua
outContinuationToken, slots = C_UnitAuras.GetAuraSlots(unit, [filter], [maxSlots], [continuationToken])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `filter` | AuraFilters | yes |  |
| `maxSlots` | number | yes |  |
| `continuationToken` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outContinuationToken` | number | yes |  |
| `slots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local outContinuationToken, slots = C_UnitAuras.GetAuraSlots("player")
```

### C_UnitAuras.GetBuffDataByIndex

```lua
aura = C_UnitAuras.GetBuffDataByIndex(unit, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example**

```lua
local aura = C_UnitAuras.GetBuffDataByIndex("player", 1)
if aura then
    print(aura.name, aura.spellId, aura.expirationTime)
end
```

### C_UnitAuras.GetCooldownAuraBySpellID

```lua
cooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownSpellID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(2050)
```

### C_UnitAuras.GetDebuffDataByIndex

```lua
aura = C_UnitAuras.GetDebuffDataByIndex(unit, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetDebuffDataByIndex("player", 1)
```

### C_UnitAuras.GetGroupBuffVisualAlerts

```lua
visualAlerts = C_UnitAuras.GetGroupBuffVisualAlerts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualAlerts` | GroupBuffVisualAlertInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local visualAlerts = C_UnitAuras.GetGroupBuffVisualAlerts()
```

### C_UnitAuras.GetHiddenGroupBuffs

```lua
spellIDs = C_UnitAuras.GetHiddenGroupBuffs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellIDs = C_UnitAuras.GetHiddenGroupBuffs()
```

### C_UnitAuras.GetPlayerAuraBySpellID

```lua
aura = C_UnitAuras.GetPlayerAuraBySpellID(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetPlayerAuraBySpellID(2050)
```

### C_UnitAuras.GetRefreshExtendedDuration

Returns the client-predicted new duration of this aura if it were cast again right now. Takes an optional spellID to use as the new duration if that cannot be derived from the aura, if that value isn't supplied the aura's spellID will be used

```lua
newDuration = C_UnitAuras.GetRefreshExtendedDuration(auraInstanceUnit, auraInstanceID, [spellID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceUnit` | UnitToken | no |  |
| `auraInstanceID` | number | no |  |
| `spellID` | SpellIdentifier | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newDuration` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newDuration = C_UnitAuras.GetRefreshExtendedDuration("player", 0)
```

### C_UnitAuras.GetUnitAuraBySpellID

Returns the first instance of an aura on a unit matching a given spell ID. Returns nil if no such aura is found. Additionally can return nil if querying a unit that is not visible (eg. party members on other maps).

```lua
aura = C_UnitAuras.GetUnitAuraBySpellID(unit, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `spellID` | SpellIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aura` | AuraData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aura = C_UnitAuras.GetUnitAuraBySpellID("player", 2050)
```

### C_UnitAuras.GetUnitAuraInstanceIDs

```lua
auraInstanceIDs = C_UnitAuras.GetUnitAuraInstanceIDs(unit, filter, [maxCount], sortRule, sortDirection)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `filter` | AuraFilters | no |  |
| `maxCount` | number | yes |  |
| `sortRule` | UnitAuraSortRule | no | (default: Unsorted) |
| `sortDirection` | UnitAuraSortDirection | no | (default: Normal) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraInstanceIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local auraInstanceIDs = C_UnitAuras.GetUnitAuraInstanceIDs("player", "HELPFUL", sortRule, sortDirection)
```

### C_UnitAuras.GetUnitAuras

```lua
auras = C_UnitAuras.GetUnitAuras(unit, filter, [maxCount], sortRule, sortDirection)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `filter` | AuraFilters | no |  |
| `maxCount` | number | yes |  |
| `sortRule` | UnitAuraSortRule | no | (default: Unsorted) |
| `sortDirection` | UnitAuraSortDirection | no | (default: Normal) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auras` | AuraData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local auras = C_UnitAuras.GetUnitAuras("player", "HELPFUL", sortRule, sortDirection)
```

### C_UnitAuras.IsAuraFilteredOutByInstanceID

```lua
isFiltered = C_UnitAuras.IsAuraFilteredOutByInstanceID(unit, auraInstanceID, filter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |
| `filter` | AuraFilters | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFiltered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFiltered = C_UnitAuras.IsAuraFilteredOutByInstanceID("player", 0, "HELPFUL")
```

### C_UnitAuras.RemoveAuraSound

```lua
C_UnitAuras.RemoveAuraSound(auraSoundID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `auraSoundID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.RemoveAuraSound(0)
```

### C_UnitAuras.RemovePrivateAuraAnchor

```lua
C_UnitAuras.RemovePrivateAuraAnchor(anchorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anchorID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.RemovePrivateAuraAnchor(0)
```

### C_UnitAuras.ResetAuraDataProvider

```lua
C_UnitAuras.ResetAuraDataProvider()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.ResetAuraDataProvider()
```

### C_UnitAuras.SetGroupBuffVisualAlerts

```lua
C_UnitAuras.SetGroupBuffVisualAlerts(visualAlerts)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualAlerts` | GroupBuffVisualAlertInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.SetGroupBuffVisualAlerts(visualAlerts)
```

### C_UnitAuras.SetHiddenGroupBuffs

```lua
C_UnitAuras.SetHiddenGroupBuffs(spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.SetHiddenGroupBuffs(2050)
```

### C_UnitAuras.SetPrivateWarningTextAnchor

```lua
C_UnitAuras.SetPrivateWarningTextAnchor(parent, [anchor])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parent` | SimpleFrame | no |  |
| `anchor` | AnchorBinding | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.SetPrivateWarningTextAnchor(parent)
```

### C_UnitAuras.SwitchAuraDataProvider

```lua
C_UnitAuras.SwitchAuraDataProvider()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UnitAuras.SwitchAuraDataProvider()
```

### C_UnitAuras.WantsAlteredForm

```lua
wantsAlteredForm = C_UnitAuras.WantsAlteredForm(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wantsAlteredForm` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wantsAlteredForm = C_UnitAuras.WantsAlteredForm("player")
```

## Events

### AURA_DATA_PROVIDER_SWITCH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useRealDataProvider` | bool | no |  |

### GROUP_BUFF_VISUAL_ALERTS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visualAlerts` | GroupBuffVisualAlertInfo[] | no |  |

### HIDDEN_GROUP_BUFFS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

### UNIT_AURA

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `updateInfo` | UnitAuraUpdateInfo | no |  |

### UNIT_AURA_BLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `auraInstanceID` | number | no |  |

### UNIT_AURA_BLOCK_LIST_CLEARED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

