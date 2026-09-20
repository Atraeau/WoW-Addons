# FrameAPIUnitPositionFrame

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**12** functions · **0** events · **0** types

## Functions

### FrameAPIUnitPositionFrame.AddUnit

```lua
AddUnit(unitTokenString, asset, [width], [height], [r], [g], [b], [a], [sublayer], [showFacing])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTokenString` | cstring | no |  |
| `asset` | TextureAssetDisk | no |  |
| `width` | uiUnit | yes |  |
| `height` | uiUnit | yes |  |
| `r` | number | yes |  |
| `g` | number | yes |  |
| `b` | number | yes |  |
| `a` | number | yes |  |
| `sublayer` | number | yes |  |
| `showFacing` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddUnit("player", asset)
```

### FrameAPIUnitPositionFrame.ClearUnits

```lua
ClearUnits()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearUnits()
```

### FrameAPIUnitPositionFrame.FinalizeUnits

```lua
FinalizeUnits()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
FinalizeUnits()
```

### FrameAPIUnitPositionFrame.GetMouseOverUnits

```lua
units = GetMouseOverUnits()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `units` | UnitTokenType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local units = GetMouseOverUnits()
```

### FrameAPIUnitPositionFrame.GetPlayerPingScale

```lua
scale = GetPlayerPingScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scale = GetPlayerPingScale()
```

### FrameAPIUnitPositionFrame.GetUiMapID

```lua
mapID = GetUiMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapID = GetUiMapID()
```

### FrameAPIUnitPositionFrame.SetPlayerPingScale

```lua
SetPlayerPingScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPlayerPingScale(0)
```

### FrameAPIUnitPositionFrame.SetPlayerPingTexture

```lua
SetPlayerPingTexture(textureType, asset, width, height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureType` | PingTextureType | no |  |
| `asset` | FileAsset | no |  |
| `width` | uiUnit | no | (default: 0) |
| `height` | uiUnit | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPlayerPingTexture(textureType, asset, width, height)
```

### FrameAPIUnitPositionFrame.SetUiMapID

```lua
SetUiMapID(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUiMapID(0)
```

### FrameAPIUnitPositionFrame.SetUnitColor

```lua
SetUnitColor(unit, colorR, colorG, colorB, colorA)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenType | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUnitColor("player", 0, 0, 0, 0)
```

### FrameAPIUnitPositionFrame.StartPlayerPing

```lua
StartPlayerPing(duration, fadeDuration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | no | (default: 0) |
| `fadeDuration` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
StartPlayerPing(0, 0)
```

### FrameAPIUnitPositionFrame.StopPlayerPing

```lua
StopPlayerPing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopPlayerPing()
```

