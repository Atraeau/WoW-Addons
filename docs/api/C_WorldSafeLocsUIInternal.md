# C_WorldSafeLocsUIInternal

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **0** events · **1** types

## Functions

### C_WorldSafeLocsUIInternal.GetWorldSafeLocs

```lua
worldSafeLocs = C_WorldSafeLocsUIInternal.GetWorldSafeLocs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `worldSafeLocs` | WorldSafeLocInfo[] | no |  |

**Example**

```lua
local worldSafeLocs = C_WorldSafeLocsUIInternal.GetWorldSafeLocs()
```

## Types

### WorldSafeLocInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `continent` | number | no |  |
| `loc` | vector3 | no |  |
| `facing` | number | no |  |

