# C_CinematicList

[← API index](../README.md) · group: [UI Systems & Input](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**1** functions · **0** events · **1** types

## Functions

### C_CinematicList.GetUICinematicList

```lua
cinematics = C_CinematicList.GetUICinematicList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cinematics` | UICinematic[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cinematics = C_CinematicList.GetUICinematicList()
```

## Types

### UICinematic (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansion` | number | no |  |
| `movieIDs` | number[] | no |  |
| `buttonUpAtlas` | textureAtlas | no |  |
| `buttonDownAtlas` | textureAtlas | no |  |
| `title` | string | yes |  |
| `disableAutoPlay` | bool | no |  |
| `orderID` | number | no |  |

