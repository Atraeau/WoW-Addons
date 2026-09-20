# C_ModifiedInstance

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

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

