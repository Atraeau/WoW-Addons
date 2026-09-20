# C_ModifiedInstance

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **0** events · **1** types

## Functions

### C_ModifiedInstance.GetModifiedInstanceInfoFromMapID

```lua
info = C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ModifiedInstanceInfo | no |  |

**Example**

```lua
local info = C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(0)
```

## Types

### ModifiedInstanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfrItemLevel` | number | yes |  |
| `normalItemLevel` | number | yes |  |
| `heroicItemLevel` | number | yes |  |
| `mythicItemLevel` | number | yes |  |
| `uiTextureKit` | textureKit | no |  |
| `description` | string | no |  |

