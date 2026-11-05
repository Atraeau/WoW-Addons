# C_WorldSafeLocsUIInternal

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 70790, interface 16001) on 2026-11-05 13:35:56.

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

**Example** _(auto-generated from the signature — illustrative)_

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
