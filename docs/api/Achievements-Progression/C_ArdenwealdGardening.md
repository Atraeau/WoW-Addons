# C_ArdenwealdGardening

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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
