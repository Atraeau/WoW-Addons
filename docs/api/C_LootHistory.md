# C_LootHistory

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **5** events · **5** types

## Functions

### C_LootHistory.GetAllEncounterInfos

```lua
infos = C_LootHistory.GetAllEncounterInfos()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infos` | EncounterLootInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infos = C_LootHistory.GetAllEncounterInfos()
```

### C_LootHistory.GetInfoForEncounter

```lua
info = C_LootHistory.GetInfoForEncounter(encounterID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | EncounterLootInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_LootHistory.GetInfoForEncounter(0)
```

### C_LootHistory.GetLootHistoryTime

```lua
time = C_LootHistory.GetLootHistoryTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = C_LootHistory.GetLootHistoryTime()
```

### C_LootHistory.GetSortedDropsForEncounter

```lua
drops = C_LootHistory.GetSortedDropsForEncounter(encounterID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drops` | EncounterLootDropInfo[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local drops = C_LootHistory.GetSortedDropsForEncounter(0)
```

### C_LootHistory.GetSortedInfoForDrop

```lua
info = C_LootHistory.GetSortedInfoForDrop(encounterID, lootListKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `lootListKey` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | EncounterLootDropInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_LootHistory.GetSortedInfoForDrop(0, 0)
```

## Events

### LOOT_HISTORY_CLEAR_HISTORY

### LOOT_HISTORY_GO_TO_ENCOUNTER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |

### LOOT_HISTORY_ONE_HUNDRED_ROLL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `lootListKey` | number | no |  |

### LOOT_HISTORY_UPDATE_DROP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `lootListKey` | number | no |  |

### LOOT_HISTORY_UPDATE_ENCOUNTER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |

## Types

### EncounterLootDropInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lootListKey` | number | no |  |
| `itemHyperlink` | string | no |  |
| `playerRollState` | EncounterLootDropRollState | no |  |
| `currentLeader` | EncounterLootDropRollInfo | yes |  |
| `isTied` | bool | no | (default: False) |
| `winner` | EncounterLootDropRollInfo | yes |  |
| `allPassed` | bool | no | (default: False) |
| `rollInfos` | EncounterLootDropRollInfo[] | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |

### EncounterLootDropRollInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string | no |  |
| `playerGUID` | WOWGUID | no |  |
| `playerClass` | string | no |  |
| `isSelf` | bool | no |  |
| `state` | EncounterLootDropRollState | no |  |
| `isWinner` | bool | no | (default: False) |
| `roll` | number | yes |  |

### EncounterLootDropRollState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `NeedMainSpec` | EncounterLootDropRollState | no |  |
| `NeedOffSpec` | EncounterLootDropRollState | no |  |
| `Transmog` | EncounterLootDropRollState | no |  |
| `Greed` | EncounterLootDropRollState | no |  |
| `NoRoll` | EncounterLootDropRollState | no |  |
| `Pass` | EncounterLootDropRollState | no |  |

### EncounterLootDrops (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `drops` | EncounterLootDropInfo[] | no |  |

### EncounterLootInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterName` | string | no |  |
| `encounterID` | number | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |

