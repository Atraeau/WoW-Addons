# SimpleModelAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**65** functions · **0** events · **0** types

## Functions

### SimpleModelAPI.AdvanceTime

```lua
AdvanceTime()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
AdvanceTime()
```

### SimpleModelAPI.ClearFog

```lua
ClearFog()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearFog()
```

### SimpleModelAPI.ClearModel

```lua
ClearModel()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearModel()
```

### SimpleModelAPI.ClearTransform

```lua
ClearTransform()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearTransform()
```

### SimpleModelAPI.GetCameraDistance

```lua
distance = GetCameraDistance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local distance = GetCameraDistance()
```

### SimpleModelAPI.GetCameraFacing

```lua
radians = GetCameraFacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local radians = GetCameraFacing()
```

### SimpleModelAPI.GetCameraPosition

```lua
positionX, positionY, positionZ = GetCameraPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local positionX, positionY, positionZ = GetCameraPosition()
```

### SimpleModelAPI.GetCameraRoll

```lua
radians = GetCameraRoll()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local radians = GetCameraRoll()
```

### SimpleModelAPI.GetCameraTarget

```lua
targetX, targetY, targetZ = GetCameraTarget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetX` | number | no |  |
| `targetY` | number | no |  |
| `targetZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local targetX, targetY, targetZ = GetCameraTarget()
```

### SimpleModelAPI.GetDesaturation

```lua
strength = GetDesaturation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local strength = GetDesaturation()
```

### SimpleModelAPI.GetFacing

```lua
facing = GetFacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `facing` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local facing = GetFacing()
```

### SimpleModelAPI.GetFogColor

```lua
colorR, colorG, colorB, colorA = GetFogColor()
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
local colorR, colorG, colorB, colorA = GetFogColor()
```

### SimpleModelAPI.GetFogFar

```lua
fogFar = GetFogFar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogFar` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fogFar = GetFogFar()
```

### SimpleModelAPI.GetFogNear

```lua
fogNear = GetFogNear()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogNear` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fogNear = GetFogNear()
```

### SimpleModelAPI.GetLight

```lua
enabled, light = GetLight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |
| `light` | ModelLight | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled, light = GetLight()
```

### SimpleModelAPI.GetModelAlpha

```lua
alpha = GetModelAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local alpha = GetModelAlpha()
```

### SimpleModelAPI.GetModelDrawLayer

```lua
layer, sublayer = GetModelDrawLayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `sublayer` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layer, sublayer = GetModelDrawLayer()
```

### SimpleModelAPI.GetModelFileID

```lua
modelFileID = GetModelFileID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelFileID` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modelFileID = GetModelFileID()
```

### SimpleModelAPI.GetModelScale

```lua
scale = GetModelScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scale = GetModelScale()
```

### SimpleModelAPI.GetPaused

```lua
paused = GetPaused()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `paused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local paused = GetPaused()
```

### SimpleModelAPI.GetPitch

```lua
pitch = GetPitch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pitch` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pitch = GetPitch()
```

### SimpleModelAPI.GetPosition

```lua
positionX, positionY, positionZ = GetPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local positionX, positionY, positionZ = GetPosition()
```

### SimpleModelAPI.GetRoll

```lua
roll = GetRoll()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roll` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roll = GetRoll()
```

### SimpleModelAPI.GetShadowEffect

```lua
strength = GetShadowEffect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local strength = GetShadowEffect()
```

### SimpleModelAPI.GetViewInsets

```lua
left, right, top, bottom = GetViewInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = GetViewInsets()
```

### SimpleModelAPI.GetViewTranslation

```lua
x, y = GetViewTranslation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local x, y = GetViewTranslation()
```

### SimpleModelAPI.GetWorldScale

```lua
worldScale = GetWorldScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `worldScale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local worldScale = GetWorldScale()
```

### SimpleModelAPI.HasAttachmentPoints

```lua
hasAttachmentPoints = HasAttachmentPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAttachmentPoints` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAttachmentPoints = HasAttachmentPoints()
```

### SimpleModelAPI.HasCustomCamera

```lua
hasCustomCamera = HasCustomCamera()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCustomCamera` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasCustomCamera = HasCustomCamera()
```

### SimpleModelAPI.IsUsingModelCenterToTransform

```lua
useCenter = IsUsingModelCenterToTransform()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useCenter` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local useCenter = IsUsingModelCenterToTransform()
```

### SimpleModelAPI.MakeCurrentCameraCustom

```lua
MakeCurrentCameraCustom()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
MakeCurrentCameraCustom()
```

### SimpleModelAPI.ReplaceIconTexture

```lua
ReplaceIconTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ReplaceIconTexture(asset)
```

### SimpleModelAPI.SetCamera

```lua
SetCamera(cameraIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cameraIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCamera(1)
```

### SimpleModelAPI.SetCameraDistance

```lua
SetCameraDistance(distance)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraDistance(0)
```

### SimpleModelAPI.SetCameraFacing

```lua
SetCameraFacing(radians)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraFacing(0)
```

### SimpleModelAPI.SetCameraPosition

```lua
SetCameraPosition(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraPosition(0, 0, 0)
```

### SimpleModelAPI.SetCameraRoll

```lua
SetCameraRoll(radians)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraRoll(0)
```

### SimpleModelAPI.SetCameraTarget

```lua
SetCameraTarget(targetX, targetY, targetZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetX` | number | no |  |
| `targetY` | number | no |  |
| `targetZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraTarget(0, 0, 0)
```

### SimpleModelAPI.SetCustomCamera

```lua
SetCustomCamera(cameraIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cameraIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCustomCamera(1)
```

### SimpleModelAPI.SetDesaturation

```lua
SetDesaturation(strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDesaturation(0)
```

### SimpleModelAPI.SetFacing

```lua
SetFacing(facing)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `facing` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFacing(0)
```

### SimpleModelAPI.SetFogColor

```lua
SetFogColor(colorR, colorG, colorB, [a])
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
SetFogColor(0, 0, 0)
```

### SimpleModelAPI.SetFogFar

```lua
SetFogFar(fogFar)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogFar` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFogFar(0)
```

### SimpleModelAPI.SetFogNear

```lua
SetFogNear(fogNear)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fogNear` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFogNear(0)
```

### SimpleModelAPI.SetGlow

```lua
SetGlow(glow)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `glow` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetGlow(0)
```

### SimpleModelAPI.SetGradientMask

```lua
SetGradientMask(grad0, grad1, grad2, grad3)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `grad0` | number | no |  |
| `grad1` | number | no |  |
| `grad2` | number | no |  |
| `grad3` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetGradientMask(0, 0, 0, 0)
```

### SimpleModelAPI.SetLight

```lua
SetLight(enabled, light)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |
| `light` | ModelLight | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLight(false, light)
```

### SimpleModelAPI.SetModel

```lua
SetModel(asset, noMip)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | ModelAsset | no |  |
| `noMip` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetModel(asset, false)
```

### SimpleModelAPI.SetModelAlpha

```lua
SetModelAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetModelAlpha(0)
```

### SimpleModelAPI.SetModelDrawLayer

```lua
SetModelDrawLayer(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetModelDrawLayer(layer)
```

### SimpleModelAPI.SetModelScale

```lua
SetModelScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetModelScale(0)
```

### SimpleModelAPI.SetParticlesEnabled

```lua
SetParticlesEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetParticlesEnabled(false)
```

### SimpleModelAPI.SetPaused

```lua
SetPaused(paused)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `paused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPaused(false)
```

### SimpleModelAPI.SetPitch

```lua
SetPitch(pitch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pitch` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPitch(0)
```

### SimpleModelAPI.SetPosition

```lua
SetPosition(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPosition(0, 0, 0)
```

### SimpleModelAPI.SetRoll

```lua
SetRoll(roll)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roll` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRoll(0)
```

### SimpleModelAPI.SetSequence

```lua
SetSequence(sequence)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sequence` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSequence(0)
```

### SimpleModelAPI.SetSequenceTime

```lua
SetSequenceTime(sequence, timeOffset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sequence` | number | no |  |
| `timeOffset` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSequenceTime(0, 1)
```

### SimpleModelAPI.SetShadowEffect

```lua
SetShadowEffect(strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShadowEffect(0)
```

### SimpleModelAPI.SetTransform

```lua
SetTransform([translation], [rotation], [scale])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `translation` | vector3 | yes |  |
| `rotation` | vector3 | yes |  |
| `scale` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTransform()
```

### SimpleModelAPI.SetUseGBuffer

```lua
SetUseGBuffer(useGBuffer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useGBuffer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseGBuffer(false)
```

### SimpleModelAPI.SetViewInsets

```lua
SetViewInsets(left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetViewInsets(left, right, top, bottom)
```

### SimpleModelAPI.SetViewTranslation

```lua
SetViewTranslation(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetViewTranslation(x, y)
```

### SimpleModelAPI.TransformCameraSpaceToModelSpace

```lua
modelPosition = TransformCameraSpaceToModelSpace(cameraPosition)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cameraPosition` | vector3 | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelPosition` | vector3 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modelPosition = TransformCameraSpaceToModelSpace(cameraPosition)
```

### SimpleModelAPI.UseModelCenterToTransform

```lua
UseModelCenterToTransform(useCenter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useCenter` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UseModelCenterToTransform(false)
```

