# C_ArdenwealdGardening

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **1** types

## Functions

### C_ArdenwealdGardening.GetGardenData

```lua
data = C_ArdenwealdGardening.GetGardenData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | ArdenwealdGardenData | no |  |

**Example**

```lua
local data = C_ArdenwealdGardening.GetGardenData()
```

### C_ArdenwealdGardening.IsGardenAccessible

```lua
accessible = C_ArdenwealdGardening.IsGardenAccessible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accessible` | bool | no |  |

**Example**

```lua
local accessible = C_ArdenwealdGardening.IsGardenAccessible()
```

## Types

### ArdenwealdGardenData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | number | no |  |
| `ready` | number | no |  |
| `remainingSeconds` | time_t | no |  |

