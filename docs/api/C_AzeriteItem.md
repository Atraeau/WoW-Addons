# C_AzeriteItem

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **3** events · **1** types

## Functions

### C_AzeriteItem.FindActiveAzeriteItem

```lua
activeAzeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeAzeriteItemLocation` | AzeriteItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activeAzeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
```

### C_AzeriteItem.GetAzeriteItemXPInfo

```lua
xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xp` | number | no |  |
| `totalLevelXP` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(6948)
```

### C_AzeriteItem.GetPowerLevel

```lua
powerLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerLevel = C_AzeriteItem.GetPowerLevel(6948)
```

### C_AzeriteItem.GetUnlimitedPowerLevel

```lua
powerLevel = C_AzeriteItem.GetUnlimitedPowerLevel(azeriteItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerLevel = C_AzeriteItem.GetUnlimitedPowerLevel(6948)
```

### C_AzeriteItem.HasActiveAzeriteItem

```lua
hasActiveAzeriteItem = C_AzeriteItem.HasActiveAzeriteItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasActiveAzeriteItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasActiveAzeriteItem = C_AzeriteItem.HasActiveAzeriteItem()
```

### C_AzeriteItem.IsAzeriteItem

```lua
isAzeriteItem = C_AzeriteItem.IsAzeriteItem(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAzeriteItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAzeriteItem = C_AzeriteItem.IsAzeriteItem(6948)
```

### C_AzeriteItem.IsAzeriteItemAtMaxLevel

```lua
isAtMax = C_AzeriteItem.IsAzeriteItemAtMaxLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtMax` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAtMax = C_AzeriteItem.IsAzeriteItemAtMaxLevel()
```

### C_AzeriteItem.IsAzeriteItemByID

```lua
isAzeriteItem = C_AzeriteItem.IsAzeriteItemByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAzeriteItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAzeriteItem = C_AzeriteItem.IsAzeriteItemByID(6948)
```

### C_AzeriteItem.IsAzeriteItemEnabled

```lua
isEnabled = C_AzeriteItem.IsAzeriteItemEnabled(azeriteItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_AzeriteItem.IsAzeriteItemEnabled(6948)
```

### C_AzeriteItem.IsUnlimitedLevelingUnlocked

```lua
isUnlimitedLevelingUnlocked = C_AzeriteItem.IsUnlimitedLevelingUnlocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnlimitedLevelingUnlocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnlimitedLevelingUnlocked = C_AzeriteItem.IsUnlimitedLevelingUnlocked()
```

## Events

### AZERITE_ITEM_ENABLED_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

### AZERITE_ITEM_EXPERIENCE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |
| `oldExperienceAmount` | number | no |  |
| `newExperienceAmount` | number | no |  |

### AZERITE_ITEM_POWER_LEVEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteItemLocation` | AzeriteItemLocation | no |  |
| `oldPowerLevel` | number | no |  |
| `newPowerLevel` | number | no |  |
| `unlockedEmpoweredItemsInfo` | UnlockedAzeriteEmpoweredItems[] | no |  |
| `azeriteItemID` | number | no |  |

## Types

### UnlockedAzeriteEmpoweredItems (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unlockedItem` | AzeriteEmpoweredItemLocation | no |  |
| `tierIndex` | luaIndex | no |  |

