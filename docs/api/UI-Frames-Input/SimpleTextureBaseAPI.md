# SimpleTextureBaseAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**52** functions · **0** events · **0** types

## Functions

### SimpleTextureBaseAPI.ClearRadialProgressBar

Disable radial progress bar rendering and restore standard texture display.

```lua
ClearRadialProgressBar()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearRadialProgressBar()
```

### SimpleTextureBaseAPI.ClearSVG

```lua
ClearSVG()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearSVG()
```

### SimpleTextureBaseAPI.ClearTextureSlice

Disable shader based nineslice texture rendering. Since SetAtlas will automatically load slice data for the atlas from the DB, can be useful if you want to disable nineslice after setting an atlas.

```lua
ClearTextureSlice()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearTextureSlice()
```

### SimpleTextureBaseAPI.ClearVertexOffsets

```lua
ClearVertexOffsets()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearVertexOffsets()
```

### SimpleTextureBaseAPI.GetAtlas

```lua
atlas = GetAtlas()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlas = GetAtlas()
```

### SimpleTextureBaseAPI.GetBlendMode

```lua
blendMode = GetBlendMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blendMode` | BlendMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local blendMode = GetBlendMode()
```

### SimpleTextureBaseAPI.GetDesaturation

```lua
desaturation = GetDesaturation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturation` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local desaturation = GetDesaturation()
```

### SimpleTextureBaseAPI.GetHorizTile

```lua
tiling = GetHorizTile()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tiling` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tiling = GetHorizTile()
```

### SimpleTextureBaseAPI.GetRadialProgressBarEndOffset

Returns the end angle offset of the radial progress bar as a normalized value (0 to 1).

```lua
offset = GetRadialProgressBarEndOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offset = GetRadialProgressBarEndOffset()
```

### SimpleTextureBaseAPI.GetRadialProgressBarFeather

Returns the feather/blur amount applied to the radial progress bar edge.

```lua
feather = GetRadialProgressBarFeather()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `feather` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local feather = GetRadialProgressBarFeather()
```

### SimpleTextureBaseAPI.GetRadialProgressBarPercent

Returns the fill percentage of the radial progress bar (0 to 1).

```lua
percent = GetRadialProgressBarPercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `percent` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local percent = GetRadialProgressBarPercent()
```

### SimpleTextureBaseAPI.GetRadialProgressBarReverse

Returns whether the radial progress bar fills in reverse (counterclockwise) direction.

```lua
reverse = GetRadialProgressBarReverse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reverse = GetRadialProgressBarReverse()
```

### SimpleTextureBaseAPI.GetRadialProgressBarStartOffset

Returns the start angle offset of the radial progress bar as a normalized value (0 to 1).

```lua
offset = GetRadialProgressBarStartOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offset = GetRadialProgressBarStartOffset()
```

### SimpleTextureBaseAPI.GetRotation

```lua
radians, normalizedRotationPoint = GetRotation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |
| `normalizedRotationPoint` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local radians, normalizedRotationPoint = GetRotation()
```

### SimpleTextureBaseAPI.GetTexCoord

```lua
ulX, ulY, llX, llY, urX, urY, lrX, lrY = GetTexCoord()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ulX` | number | no |  |
| `ulY` | number | no |  |
| `llX` | number | no |  |
| `llY` | number | no |  |
| `urX` | number | no |  |
| `urY` | number | no |  |
| `lrX` | number | no |  |
| `lrY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ulX, ulY, llX, llY, urX, urY, lrX, lrY = GetTexCoord()
```

### SimpleTextureBaseAPI.GetTexelSnappingBias

```lua
bias = GetTexelSnappingBias()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bias` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bias = GetTexelSnappingBias()
```

### SimpleTextureBaseAPI.GetTexture

```lua
textureFile = GetTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureFile` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureFile = GetTexture()
```

### SimpleTextureBaseAPI.GetTextureFileID

```lua
textureFile = GetTextureFileID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureFile` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureFile = GetTextureFileID()
```

### SimpleTextureBaseAPI.GetTextureFilePath

```lua
textureFile = GetTextureFilePath()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureFile` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureFile = GetTextureFilePath()
```

### SimpleTextureBaseAPI.GetTextureSliceMargins

```lua
left, top, right, bottom = GetTextureSliceMargins()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no |  |
| `top` | number | no |  |
| `right` | number | no |  |
| `bottom` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, top, right, bottom = GetTextureSliceMargins()
```

### SimpleTextureBaseAPI.GetTextureSliceMode

```lua
sliceMode = GetTextureSliceMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sliceMode` | UITextureSliceMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sliceMode = GetTextureSliceMode()
```

### SimpleTextureBaseAPI.GetVertexOffset

```lua
offsetX, offsetY = GetVertexOffset(vertexIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vertexIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offsetX, offsetY = GetVertexOffset(1)
```

### SimpleTextureBaseAPI.GetVertTile

```lua
tiling = GetVertTile()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tiling` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tiling = GetVertTile()
```

### SimpleTextureBaseAPI.IsBlockingLoadRequested

```lua
blocking = IsBlockingLoadRequested()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blocking` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local blocking = IsBlockingLoadRequested()
```

### SimpleTextureBaseAPI.IsDesaturated

```lua
desaturated = IsDesaturated()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local desaturated = IsDesaturated()
```

### SimpleTextureBaseAPI.IsSnappingToPixelGrid

```lua
snap = IsSnappingToPixelGrid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `snap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local snap = IsSnappingToPixelGrid()
```

### SimpleTextureBaseAPI.ResetTexCoord

```lua
ResetTexCoord()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetTexCoord()
```

### SimpleTextureBaseAPI.SetAtlas

```lua
SetAtlas(atlas, useAtlasSize, [filterMode], [resetTexCoords], [wrapModeHorizontal], [wrapModeVertical])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |
| `useAtlasSize` | bool | no | (default: False) |
| `filterMode` | FilterMode | yes |  |
| `resetTexCoords` | bool | yes |  |
| `wrapModeHorizontal` | cstring | yes |  |
| `wrapModeVertical` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAtlas(atlas, false)
```

### SimpleTextureBaseAPI.SetBlendMode

```lua
SetBlendMode(blendMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blendMode` | BlendMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBlendMode(blendMode)
```

### SimpleTextureBaseAPI.SetBlockingLoadsRequested

```lua
SetBlockingLoadsRequested(blocking)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blocking` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBlockingLoadsRequested(false)
```

### SimpleTextureBaseAPI.SetColorTexture

```lua
SetColorTexture(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetColorTexture(0, 0, 0)
```

### SimpleTextureBaseAPI.SetDesaturated

```lua
SetDesaturated(desaturated)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturated` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDesaturated(false)
```

### SimpleTextureBaseAPI.SetDesaturation

```lua
SetDesaturation(desaturation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturation` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDesaturation(desaturation)
```

### SimpleTextureBaseAPI.SetGradient

```lua
SetGradient(orientation, minColor, maxColor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orientation` | Orientation | no |  |
| `minColor` | colorRGBA | no |  |
| `maxColor` | colorRGBA | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetGradient(orientation, minColor, maxColor)
```

### SimpleTextureBaseAPI.SetHorizTile

```lua
SetHorizTile(tiling)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tiling` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHorizTile(false)
```

### SimpleTextureBaseAPI.SetMask

```lua
SetMask(file)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `file` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMask("")
```

### SimpleTextureBaseAPI.SetRadialProgressBarEndOffset

Sets the end angle offset of the radial progress bar as a normalized value (0 to 1).

```lua
SetRadialProgressBarEndOffset(offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRadialProgressBarEndOffset(1)
```

### SimpleTextureBaseAPI.SetRadialProgressBarFeather

Sets the feather/blur amount applied to the radial progress bar edge (higher = more gradual falloff).

```lua
SetRadialProgressBarFeather(feather)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `feather` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRadialProgressBarFeather(feather)
```

### SimpleTextureBaseAPI.SetRadialProgressBarPercent

Sets the fill percentage of the radial progress bar (0 to 1).

```lua
SetRadialProgressBarPercent(percent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `percent` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRadialProgressBarPercent(percent)
```

### SimpleTextureBaseAPI.SetRadialProgressBarReverse

Sets whether the radial progress bar fills in reverse (counterclockwise) direction.

```lua
SetRadialProgressBarReverse(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRadialProgressBarReverse(false)
```

### SimpleTextureBaseAPI.SetRadialProgressBarStartOffset

Sets the start angle offset of the radial progress bar as a normalized value (0 to 1), where 0 is at the bottom.

```lua
SetRadialProgressBarStartOffset(offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRadialProgressBarStartOffset(1)
```

### SimpleTextureBaseAPI.SetRotation

```lua
SetRotation(radians, [normalizedRotationPoint])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |
| `normalizedRotationPoint` | vector2 | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRotation(0)
```

### SimpleTextureBaseAPI.SetSnapToPixelGrid

```lua
SetSnapToPixelGrid(snap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `snap` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSnapToPixelGrid(false)
```

### SimpleTextureBaseAPI.SetSpriteSheetCell

```lua
SetSpriteSheetCell(cell, numRows, numColumns, [cellWidth], [cellHeight])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cell` | luaIndex | no |  |
| `numRows` | number | no |  |
| `numColumns` | number | no |  |
| `cellWidth` | number | yes |  |
| `cellHeight` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSpriteSheetCell(1, 0, 0)
```

### SimpleTextureBaseAPI.SetSVG

```lua
success = SetSVG(svgAsset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `svgAsset` | FileAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetSVG(svgAsset)
```

### SimpleTextureBaseAPI.SetTexCoord

```lua
SetTexCoord(left, right, bottom, top)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no |  |
| `right` | number | no |  |
| `bottom` | number | no |  |
| `top` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTexCoord(0, 0, 0, 0)
```

### SimpleTextureBaseAPI.SetTexelSnappingBias

```lua
SetTexelSnappingBias(bias)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bias` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTexelSnappingBias(bias)
```

### SimpleTextureBaseAPI.SetTexture

```lua
success = SetTexture([textureAsset], [wrapModeHorizontal], [wrapModeVertical], [filterMode])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureAsset` | cstring | yes |  |
| `wrapModeHorizontal` | cstring | yes |  |
| `wrapModeVertical` | cstring | yes |  |
| `filterMode` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetTexture()
```

### SimpleTextureBaseAPI.SetTextureSliceMargins

Enables nineslice texture rendering using the specified pixel margins. Preferred over legacy nineslice approach that uses 9 separate textures.

```lua
SetTextureSliceMargins(left, top, right, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no |  |
| `top` | number | no |  |
| `right` | number | no |  |
| `bottom` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTextureSliceMargins(0, 0, 0, 0)
```

### SimpleTextureBaseAPI.SetTextureSliceMode

Controls whether the center and sides are Stretched or Tiled when using nineslice texture rendering. Defaults to Stretched.

```lua
SetTextureSliceMode(sliceMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sliceMode` | UITextureSliceMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTextureSliceMode(sliceMode)
```

### SimpleTextureBaseAPI.SetVertexOffset

```lua
SetVertexOffset(vertexIndex, offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vertexIndex` | luaIndex | no |  |
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetVertexOffset(1, 1, 1)
```

### SimpleTextureBaseAPI.SetVertTile

```lua
SetVertTile(tiling)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tiling` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetVertTile(false)
```

