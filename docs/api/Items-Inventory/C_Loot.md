# C_Loot

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **37** events · **0** types

## Functions

### C_Loot.GetLootRollDuration

```lua
duration = C_Loot.GetLootRollDuration(rollID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_Loot.GetLootRollDuration(0)
```

### C_Loot.IsLegacyLootModeEnabled

```lua
isLegacyLootModeEnabled = C_Loot.IsLegacyLootModeEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLegacyLootModeEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLegacyLootModeEnabled = C_Loot.IsLegacyLootModeEnabled()
```

## Events

### AZERITE_EMPOWERED_ITEM_LOOTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |

### BONUS_ROLL_ACTIVATE

### BONUS_ROLL_DEACTIVATE

### BONUS_ROLL_FAILED

### BONUS_ROLL_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIdentifier` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `personalLootToast` | bool | no |  |
| `currencyID` | number | yes |  |
| `isSecondaryResult` | bool | no |  |
| `corrupted` | bool | no |  |

### BONUS_ROLL_STARTED

### CANCEL_ALL_LOOT_ROLLS

### CANCEL_LOOT_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |

### CONFIRM_DISENCHANT_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |
| `rollType` | number | no |  |

### CONFIRM_LOOT_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |
| `rollType` | number | no |  |
| `confirmReason` | cstring | no |  |

### ENCOUNTER_LOOT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `itemID` | number | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `itemName` | cstring | no |  |
| `fileName` | cstring | no |  |

### GARRISON_MISSION_BONUS_ROLL_LOOT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quantity` | number | no |  |

### ITEM_PUSH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagSlot` | luaIndex | no |  |
| `iconFileID` | number | no |  |

### LEGACY_LOOT_RULES_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLegacyLootModeEnabled` | bool | no |  |

### LOOT_BIND_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lootSlot` | luaIndex | no |  |

### LOOT_CLOSED

### LOOT_ITEM_AVAILABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemTooltip` | cstring | no |  |
| `lootHandle` | number | no |  |

### LOOT_ITEM_ROLL_WON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |
| `rollQuantity` | number | no |  |
| `rollType` | number | no |  |
| `roll` | number | no |  |
| `upgraded` | bool | no |  |

### LOOT_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoLoot` | bool | no |  |
| `isFromItem` | bool | no |  |

### LOOT_READY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoloot` | bool | no |  |

### LOOT_ROLLS_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lootHandle` | number | no |  |

### LOOT_SLOT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lootSlot` | luaIndex | no |  |

### LOOT_SLOT_CLEARED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lootSlot` | luaIndex | no |  |

### MAIN_SPEC_NEED_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |
| `roll` | number | no |  |
| `isWinning` | bool | no |  |

### OPEN_MASTER_LOOT_LIST

### PET_BATTLE_LOOT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIdentifier` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |

### PLAYER_LOOT_SPEC_UPDATED

### QUEST_CURRENCY_LOOT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `currencyId` | number | no |  |
| `quantity` | number | no |  |

### QUEST_LOOT_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |

### SHOW_LOOT_TOAST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIdentifier` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `personalLootToast` | bool | no |  |
| `toastMethod` | number | no |  |
| `lessAwesome` | bool | no |  |
| `upgraded` | bool | no |  |
| `corrupted` | bool | no |  |

### SHOW_LOOT_TOAST_LEGENDARY_LOOTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |

### SHOW_LOOT_TOAST_UPGRADE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `baseQuality` | number | no |  |
| `personalLootToast` | bool | no |  |
| `lessAwesome` | bool | no |  |

### SHOW_PVP_FACTION_LOOT_TOAST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIdentifier` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `personalLootToast` | bool | no |  |
| `lessAwesome` | bool | no |  |

### SHOW_RATED_PVP_REWARD_TOAST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeIdentifier` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `personalLootToast` | bool | no |  |
| `lessAwesome` | bool | no |  |

### START_LOOT_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rollID` | number | no |  |
| `rollTime` | number | no |  |
| `lootHandle` | number | yes |  |

### TRIAL_CAP_REACHED_MONEY

### UPDATE_MASTER_LOOT_LIST

