# SimpleStatusBarAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**28** functions · **0** events · **0** types

## Functions

### SimpleStatusBarAPI.GetFillStyle

```lua
fillStyle = GetFillStyle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fillStyle` | StatusBarFillStyle | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fillStyle = GetFillStyle()
```

### SimpleStatusBarAPI.GetInterpolatedValue

Returns the current interpolated value displayed by the bar.

```lua
value = GetInterpolatedValue()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = GetInterpolatedValue()
```

### SimpleStatusBarAPI.GetMinMaxValues

```lua
minValue, maxValue = GetMinMaxValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minValue` | number | no |  |
| `maxValue` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minValue, maxValue = GetMinMaxValues()
```

### SimpleStatusBarAPI.GetOrientation

```lua
orientation = GetOrientation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orientation` | Orientation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local orientation = GetOrientation()
```

### SimpleStatusBarAPI.GetRenderMode

```lua
renderMode = GetRenderMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renderMode` | StatusBarRenderMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local renderMode = GetRenderMode()
```

### SimpleStatusBarAPI.GetReverseFill

```lua
isReverseFill = GetReverseFill()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReverseFill` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isReverseFill = GetReverseFill()
```

### SimpleStatusBarAPI.GetRotatesTexture

```lua
rotatesTexture = GetRotatesTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotatesTexture` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rotatesTexture = GetRotatesTexture()
```

### SimpleStatusBarAPI.GetStatusBarColor

```lua
colorR, colorG, colorB, colorA = GetStatusBarColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetStatusBarColor()
```

### SimpleStatusBarAPI.GetStatusBarDesaturation

```lua
desaturation = GetStatusBarDesaturation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturation` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local desaturation = GetStatusBarDesaturation()
```

### SimpleStatusBarAPI.GetStatusBarTexture

```lua
texture = GetStatusBarTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = GetStatusBarTexture()
```

### SimpleStatusBarAPI.GetTimerDuration

```lua
duration = GetTimerDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = GetTimerDuration()
```

### SimpleStatusBarAPI.GetValue

```lua
value = GetValue()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = GetValue()
```

### SimpleStatusBarAPI.IsInterpolating

Returns true if the status bar is currently interpolating toward a target value.

```lua
isInterpolating = IsInterpolating()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInterpolating` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInterpolating = IsInterpolating()
```

### SimpleStatusBarAPI.IsStatusBarDesaturated

```lua
desaturated = IsStatusBarDesaturated()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local desaturated = IsStatusBarDesaturated()
```

### SimpleStatusBarAPI.SetColorFill

```lua
SetColorFill(colorR, colorG, colorB, [a])
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
SetColorFill(0, 0, 0)
```

### SimpleStatusBarAPI.SetFillStyle

```lua
SetFillStyle(fillStyle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fillStyle` | StatusBarFillStyle | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFillStyle(fillStyle)
```

### SimpleStatusBarAPI.SetMinMaxValues

```lua
SetMinMaxValues(minValue, maxValue, interpolation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minValue` | number | no |  |
| `maxValue` | number | no |  |
| `interpolation` | StatusBarInterpolation | no | (default: Immediate) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMinMaxValues(0, 0, interpolation)
```

### SimpleStatusBarAPI.SetOrientation

```lua
SetOrientation(orientation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orientation` | Orientation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetOrientation(orientation)
```

### SimpleStatusBarAPI.SetRenderMode

```lua
SetRenderMode(renderMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renderMode` | StatusBarRenderMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRenderMode(renderMode)
```

### SimpleStatusBarAPI.SetReverseFill

```lua
SetReverseFill(isReverseFill)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReverseFill` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetReverseFill(false)
```

### SimpleStatusBarAPI.SetRotatesTexture

```lua
SetRotatesTexture(rotatesTexture)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotatesTexture` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRotatesTexture(false)
```

### SimpleStatusBarAPI.SetStatusBarColor

```lua
SetStatusBarColor(colorR, colorG, colorB, [a])
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
SetStatusBarColor(0, 0, 0)
```

### SimpleStatusBarAPI.SetStatusBarDesaturated

```lua
SetStatusBarDesaturated(desaturated)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturated` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStatusBarDesaturated(false)
```

### SimpleStatusBarAPI.SetStatusBarDesaturation

```lua
SetStatusBarDesaturation(desaturation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturation` | normalizedValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStatusBarDesaturation(desaturation)
```

### SimpleStatusBarAPI.SetStatusBarTexture

```lua
success = SetStatusBarTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetStatusBarTexture(asset)
```

### SimpleStatusBarAPI.SetTimerDuration

```lua
SetTimerDuration(duration, interpolation, direction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |
| `interpolation` | StatusBarInterpolation | no | (default: Immediate) |
| `direction` | StatusBarTimerDirection | no | (default: ElapsedTime) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTimerDuration(duration, interpolation, direction)
```

### SimpleStatusBarAPI.SetToTargetValue

Immediately finishes any interpolation of the bar and snaps it to the target value.

```lua
SetToTargetValue()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToTargetValue()
```

### SimpleStatusBarAPI.SetValue

```lua
SetValue(value, interpolation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |
| `interpolation` | StatusBarInterpolation | no | (default: Immediate) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetValue(0, interpolation)
```

