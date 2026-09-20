# C_LegendaryCrafting

[← API index](../README.md) · group: [Professions & Crafting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**20** functions · **4** events · **0** types

## Functions

### C_LegendaryCrafting.CloseRuneforgeInteraction

```lua
C_LegendaryCrafting.CloseRuneforgeInteraction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LegendaryCrafting.CloseRuneforgeInteraction()
```

### C_LegendaryCrafting.CraftRuneforgeLegendary

```lua
C_LegendaryCrafting.CraftRuneforgeLegendary(description)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | RuneforgeLegendaryCraftDescription | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LegendaryCrafting.CraftRuneforgeLegendary(description)
```

### C_LegendaryCrafting.GetRuneforgeItemPreviewInfo

```lua
info = C_LegendaryCrafting.GetRuneforgeItemPreviewInfo(baseItem, [runeforgePowerID], [modifiers])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |
| `runeforgePowerID` | number | yes |  |
| `modifiers` | number[] | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RuneforgeItemPreviewInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_LegendaryCrafting.GetRuneforgeItemPreviewInfo(6948)
```

### C_LegendaryCrafting.GetRuneforgeLegendaryComponentInfo

```lua
componentInfo = C_LegendaryCrafting.GetRuneforgeLegendaryComponentInfo(runeforgeLegendary)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgeLegendary` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `componentInfo` | RuneforgeLegendaryComponentInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local componentInfo = C_LegendaryCrafting.GetRuneforgeLegendaryComponentInfo(runeforgeLegendary)
```

### C_LegendaryCrafting.GetRuneforgeLegendaryCost

```lua
cost = C_LegendaryCrafting.GetRuneforgeLegendaryCost(baseItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | CurrencyCost[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cost = C_LegendaryCrafting.GetRuneforgeLegendaryCost(6948)
```

### C_LegendaryCrafting.GetRuneforgeLegendaryCraftSpellID

```lua
spellID = C_LegendaryCrafting.GetRuneforgeLegendaryCraftSpellID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_LegendaryCrafting.GetRuneforgeLegendaryCraftSpellID()
```

### C_LegendaryCrafting.GetRuneforgeLegendaryCurrencies

```lua
currencies = C_LegendaryCrafting.GetRuneforgeLegendaryCurrencies()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencies` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencies = C_LegendaryCrafting.GetRuneforgeLegendaryCurrencies()
```

### C_LegendaryCrafting.GetRuneforgeLegendaryUpgradeCost

```lua
cost = C_LegendaryCrafting.GetRuneforgeLegendaryUpgradeCost(runeforgeLegendary, upgradeItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgeLegendary` | ItemLocation | no |  |
| `upgradeItem` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | CurrencyCost[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cost = C_LegendaryCrafting.GetRuneforgeLegendaryUpgradeCost(runeforgeLegendary, 6948)
```

### C_LegendaryCrafting.GetRuneforgeModifierInfo

```lua
name, description = C_LegendaryCrafting.GetRuneforgeModifierInfo(baseItem, [powerID], addedModifierIndex, modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |
| `powerID` | number | yes |  |
| `addedModifierIndex` | luaIndex | no |  |
| `modifiers` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, description = C_LegendaryCrafting.GetRuneforgeModifierInfo(6948, 1, modifiers)
```

### C_LegendaryCrafting.GetRuneforgeModifiers

```lua
modifiedReagentItemIDs = C_LegendaryCrafting.GetRuneforgeModifiers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifiedReagentItemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modifiedReagentItemIDs = C_LegendaryCrafting.GetRuneforgeModifiers()
```

### C_LegendaryCrafting.GetRuneforgePowerInfo

```lua
power = C_LegendaryCrafting.GetRuneforgePowerInfo(runeforgePowerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgePowerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `power` | RuneforgePower | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local power = C_LegendaryCrafting.GetRuneforgePowerInfo(0)
```

### C_LegendaryCrafting.GetRuneforgePowers

```lua
primaryRuneforgePowerIDs, otherRuneforgePowerIDs = C_LegendaryCrafting.GetRuneforgePowers([baseItem], [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | yes |  |
| `filter` | RuneforgePowerFilter | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `primaryRuneforgePowerIDs` | number[] | no |  |
| `otherRuneforgePowerIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local primaryRuneforgePowerIDs, otherRuneforgePowerIDs = C_LegendaryCrafting.GetRuneforgePowers()
```

### C_LegendaryCrafting.GetRuneforgePowersByClassSpecAndCovenant

```lua
runeforgePowerIDs = C_LegendaryCrafting.GetRuneforgePowersByClassSpecAndCovenant([classID], [specID], [covenantID], [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | yes |  |
| `specID` | number | yes |  |
| `covenantID` | number | yes |  |
| `filter` | RuneforgePowerFilter | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgePowerIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local runeforgePowerIDs = C_LegendaryCrafting.GetRuneforgePowersByClassSpecAndCovenant()
```

### C_LegendaryCrafting.GetRuneforgePowerSlots

```lua
slotNames = C_LegendaryCrafting.GetRuneforgePowerSlots(runeforgePowerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgePowerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotNames` | cstring[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotNames = C_LegendaryCrafting.GetRuneforgePowerSlots(0)
```

### C_LegendaryCrafting.IsRuneforgeLegendary

```lua
isRuneforgeLegendary = C_LegendaryCrafting.IsRuneforgeLegendary(item)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRuneforgeLegendary` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRuneforgeLegendary = C_LegendaryCrafting.IsRuneforgeLegendary(6948)
```

### C_LegendaryCrafting.IsRuneforgeLegendaryMaxLevel

```lua
isMaxLevel = C_LegendaryCrafting.IsRuneforgeLegendaryMaxLevel(runeforgeLegendary)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgeLegendary` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMaxLevel` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMaxLevel = C_LegendaryCrafting.IsRuneforgeLegendaryMaxLevel(runeforgeLegendary)
```

### C_LegendaryCrafting.IsUpgradeItemValidForRuneforgeLegendary

```lua
isValid = C_LegendaryCrafting.IsUpgradeItemValidForRuneforgeLegendary(runeforgeLegendary, upgradeItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgeLegendary` | ItemLocation | no |  |
| `upgradeItem` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_LegendaryCrafting.IsUpgradeItemValidForRuneforgeLegendary(runeforgeLegendary, 6948)
```

### C_LegendaryCrafting.IsValidRuneforgeBaseItem

```lua
isValid = C_LegendaryCrafting.IsValidRuneforgeBaseItem(baseItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_LegendaryCrafting.IsValidRuneforgeBaseItem(6948)
```

### C_LegendaryCrafting.MakeRuneforgeCraftDescription

```lua
description = C_LegendaryCrafting.MakeRuneforgeCraftDescription(baseItem, runeforgePowerID, modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |
| `runeforgePowerID` | number | no |  |
| `modifiers` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | RuneforgeLegendaryCraftDescription | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_LegendaryCrafting.MakeRuneforgeCraftDescription(6948, 0, modifiers)
```

### C_LegendaryCrafting.UpgradeRuneforgeLegendary

```lua
C_LegendaryCrafting.UpgradeRuneforgeLegendary(runeforgeLegendary, upgradeItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeforgeLegendary` | ItemLocation | no |  |
| `upgradeItem` | ItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LegendaryCrafting.UpgradeRuneforgeLegendary(runeforgeLegendary, 6948)
```

## Events

### NEW_RUNEFORGE_POWER_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

### RUNEFORGE_LEGENDARY_CRAFTING_CLOSED

### RUNEFORGE_LEGENDARY_CRAFTING_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUpgrade` | bool | no |  |

### RUNEFORGE_POWER_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

