# MinimapFrameAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**31** functions · **0** events · **0** types

## Functions

### MinimapFrameAPI.GetPingPosition

```lua
positionX, positionY = GetPingPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |

**Example**

```lua
local positionX, positionY = GetPingPosition()
```

### MinimapFrameAPI.GetZoom

```lua
zoomFactor = GetZoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomFactor` | number | no |  |

**Example**

```lua
local zoomFactor = GetZoom()
```

### MinimapFrameAPI.GetZoomLevels

```lua
zoomLevels = GetZoomLevels()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomLevels` | number | no |  |

**Example**

```lua
local zoomLevels = GetZoomLevels()
```

### MinimapFrameAPI.PingLocation

```lua
PingLocation(locationX, locationY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationX` | number | no |  |
| `locationY` | number | no |  |

**Example**

```lua
PingLocation(0, 0)
```

### MinimapFrameAPI.SetArchBlobInsideAlpha

```lua
SetArchBlobInsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetArchBlobInsideAlpha(0)
```

### MinimapFrameAPI.SetArchBlobInsideTexture

```lua
SetArchBlobInsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetArchBlobInsideTexture(asset)
```

### MinimapFrameAPI.SetArchBlobOutsideAlpha

```lua
SetArchBlobOutsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetArchBlobOutsideAlpha(0)
```

### MinimapFrameAPI.SetArchBlobOutsideTexture

```lua
SetArchBlobOutsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetArchBlobOutsideTexture(asset)
```

### MinimapFrameAPI.SetArchBlobRingAlpha

```lua
SetArchBlobRingAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetArchBlobRingAlpha(0)
```

### MinimapFrameAPI.SetArchBlobRingScalar

```lua
SetArchBlobRingScalar(scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
SetArchBlobRingScalar(0)
```

### MinimapFrameAPI.SetArchBlobRingTexture

```lua
SetArchBlobRingTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetArchBlobRingTexture(asset)
```

### MinimapFrameAPI.SetIconScale

```lua
SetIconScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example**

```lua
SetIconScale(0)
```

### MinimapFrameAPI.SetMaskTexture

```lua
SetMaskTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetMaskTexture(asset)
```

### MinimapFrameAPI.SetQuestBlobInsideAlpha

```lua
SetQuestBlobInsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetQuestBlobInsideAlpha(0)
```

### MinimapFrameAPI.SetQuestBlobInsideTexture

```lua
SetQuestBlobInsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetQuestBlobInsideTexture(asset)
```

### MinimapFrameAPI.SetQuestBlobOutsideAlpha

```lua
SetQuestBlobOutsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetQuestBlobOutsideAlpha(0)
```

### MinimapFrameAPI.SetQuestBlobOutsideTexture

```lua
SetQuestBlobOutsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetQuestBlobOutsideTexture(asset)
```

### MinimapFrameAPI.SetQuestBlobRingAlpha

```lua
SetQuestBlobRingAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetQuestBlobRingAlpha(0)
```

### MinimapFrameAPI.SetQuestBlobRingScalar

```lua
SetQuestBlobRingScalar(scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
SetQuestBlobRingScalar(0)
```

### MinimapFrameAPI.SetQuestBlobRingTexture

```lua
SetQuestBlobRingTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetQuestBlobRingTexture(asset)
```

### MinimapFrameAPI.SetTaskBlobInsideAlpha

```lua
SetTaskBlobInsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetTaskBlobInsideAlpha(0)
```

### MinimapFrameAPI.SetTaskBlobInsideTexture

```lua
SetTaskBlobInsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetTaskBlobInsideTexture(asset)
```

### MinimapFrameAPI.SetTaskBlobOutsideAlpha

```lua
SetTaskBlobOutsideAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetTaskBlobOutsideAlpha(0)
```

### MinimapFrameAPI.SetTaskBlobOutsideTexture

```lua
SetTaskBlobOutsideTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetTaskBlobOutsideTexture(asset)
```

### MinimapFrameAPI.SetTaskBlobRingAlpha

```lua
SetTaskBlobRingAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetTaskBlobRingAlpha(0)
```

### MinimapFrameAPI.SetTaskBlobRingScalar

```lua
SetTaskBlobRingScalar(scalar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalar` | number | no |  |

**Example**

```lua
SetTaskBlobRingScalar(0)
```

### MinimapFrameAPI.SetTaskBlobRingTexture

```lua
SetTaskBlobRingTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetTaskBlobRingTexture(asset)
```

### MinimapFrameAPI.SetUsingSoftCursor

```lua
SetUsingSoftCursor(usingSoftCursor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usingSoftCursor` | bool | no |  |

**Example**

```lua
SetUsingSoftCursor(false)
```

### MinimapFrameAPI.SetZoom

```lua
SetZoom(zoomFactor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomFactor` | number | no |  |

**Example**

```lua
SetZoom(0)
```

### MinimapFrameAPI.UpdateBlips

```lua
UpdateBlips()
```

**Example**

```lua
UpdateBlips()
```

### MinimapFrameAPI.UpdateMouseoverAtPoint

```lua
UpdateMouseoverAtPoint(pointX, pointY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointX` | number | no |  |
| `pointY` | number | no |  |

**Example**

```lua
UpdateMouseoverAtPoint(0, 0)
```

