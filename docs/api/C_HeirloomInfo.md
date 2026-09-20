# C_HeirloomInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **2** events · **0** types

## Functions

### C_HeirloomInfo.AreAllCollectionFiltersChecked

```lua
areAllCollectionFiltersChecked = C_HeirloomInfo.AreAllCollectionFiltersChecked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAllCollectionFiltersChecked` | bool | no |  |

**Example**

```lua
local areAllCollectionFiltersChecked = C_HeirloomInfo.AreAllCollectionFiltersChecked()
```

### C_HeirloomInfo.AreAllSourceFiltersChecked

```lua
areAllSourceFiltersChecked = C_HeirloomInfo.AreAllSourceFiltersChecked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAllSourceFiltersChecked` | bool | no |  |

**Example**

```lua
local areAllSourceFiltersChecked = C_HeirloomInfo.AreAllSourceFiltersChecked()
```

### C_HeirloomInfo.HeirloomsAvailable

```lua
areHeirloomsAvailable = C_HeirloomInfo.HeirloomsAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areHeirloomsAvailable` | bool | no |  |

**Example**

```lua
local areHeirloomsAvailable = C_HeirloomInfo.HeirloomsAvailable()
```

### C_HeirloomInfo.IsHeirloomSourceValid

```lua
isHeirloomSourceValid = C_HeirloomInfo.IsHeirloomSourceValid(source)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `source` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHeirloomSourceValid` | bool | no |  |

**Example**

```lua
local isHeirloomSourceValid = C_HeirloomInfo.IsHeirloomSourceValid(source)
```

### C_HeirloomInfo.IsUsingDefaultFilters

```lua
isUsingDefaultFilters = C_HeirloomInfo.IsUsingDefaultFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultFilters` | bool | no |  |

**Example**

```lua
local isUsingDefaultFilters = C_HeirloomInfo.IsUsingDefaultFilters()
```

### C_HeirloomInfo.SetAllCollectionFilters

```lua
C_HeirloomInfo.SetAllCollectionFilters(checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example**

```lua
C_HeirloomInfo.SetAllCollectionFilters(false)
```

### C_HeirloomInfo.SetAllSourceFilters

```lua
C_HeirloomInfo.SetAllSourceFilters(checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checked` | bool | no |  |

**Example**

```lua
C_HeirloomInfo.SetAllSourceFilters(false)
```

### C_HeirloomInfo.SetDefaultFilters

```lua
C_HeirloomInfo.SetDefaultFilters()
```

**Example**

```lua
C_HeirloomInfo.SetDefaultFilters()
```

## Events

### HEIRLOOMS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |
| `updateReason` | cstring | yes |  |
| `hideUntilLearned` | bool | yes |  |

### HEIRLOOM_UPGRADE_TARGETING_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pendingHeirloomUpgradeSpellcast` | bool | no |  |

