# FrameAPIModelSceneFrame

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**47** functions · **0** events · **0** types

## Functions

### FrameAPIModelSceneFrame.ClearFog

```lua
ClearFog()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearFog()
```

### FrameAPIModelSceneFrame.CreateActor

```lua
CreateActor(name, template)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `template` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
CreateActor("", "")
```

### FrameAPIModelSceneFrame.GetActorAtIndex

```lua
GetActorAtIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
GetActorAtIndex(1)
```

### FrameAPIModelSceneFrame.GetAllowOverlappedModels

```lua
allowOverlappedModels = GetAllowOverlappedModels()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowOverlappedModels` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowOverlappedModels = GetAllowOverlappedModels()
```

### FrameAPIModelSceneFrame.GetCameraFarClip

```lua
farClip = GetCameraFarClip()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `farClip` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local farClip = GetCameraFarClip()
```

### FrameAPIModelSceneFrame.GetCameraFieldOfView

Field of view in radians

```lua
fov = GetCameraFieldOfView()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fov` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fov = GetCameraFieldOfView()
```

### FrameAPIModelSceneFrame.GetCameraForward

```lua
forwardX, forwardY, forwardZ = GetCameraForward()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forwardX` | number | no |  |
| `forwardY` | number | no |  |
| `forwardZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local forwardX, forwardY, forwardZ = GetCameraForward()
```

### FrameAPIModelSceneFrame.GetCameraNearClip

```lua
nearClip = GetCameraNearClip()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nearClip` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nearClip = GetCameraNearClip()
```

### FrameAPIModelSceneFrame.GetCameraPosition

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

### FrameAPIModelSceneFrame.GetCameraRight

```lua
rightX, rightY, rightZ = GetCameraRight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rightX` | number | no |  |
| `rightY` | number | no |  |
| `rightZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rightX, rightY, rightZ = GetCameraRight()
```

### FrameAPIModelSceneFrame.GetCameraUp

```lua
upX, upY, upZ = GetCameraUp()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `upX` | number | no |  |
| `upY` | number | no |  |
| `upZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local upX, upY, upZ = GetCameraUp()
```

### FrameAPIModelSceneFrame.GetDrawLayer

```lua
layer, sublevel = GetDrawLayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `sublevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layer, sublevel = GetDrawLayer()
```

### FrameAPIModelSceneFrame.GetFogColor

```lua
colorR, colorG, colorB = GetFogColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB = GetFogColor()
```

### FrameAPIModelSceneFrame.GetFogFar

```lua
far = GetFogFar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `far` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local far = GetFogFar()
```

### FrameAPIModelSceneFrame.GetFogNear

```lua
near = GetFogNear()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `near` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local near = GetFogNear()
```

### FrameAPIModelSceneFrame.GetLightAmbientColor

```lua
colorR, colorG, colorB = GetLightAmbientColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB = GetLightAmbientColor()
```

### FrameAPIModelSceneFrame.GetLightDiffuseColor

```lua
colorR, colorG, colorB = GetLightDiffuseColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB = GetLightDiffuseColor()
```

### FrameAPIModelSceneFrame.GetLightDirection

```lua
directionX, directionY, directionZ = GetLightDirection()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `directionX` | number | no |  |
| `directionY` | number | no |  |
| `directionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local directionX, directionY, directionZ = GetLightDirection()
```

### FrameAPIModelSceneFrame.GetLightPosition

```lua
positionX, positionY, positionZ = GetLightPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local positionX, positionY, positionZ = GetLightPosition()
```

### FrameAPIModelSceneFrame.GetLightType

```lua
lightType = GetLightType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lightType` | ModelLightType | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lightType = GetLightType()
```

### FrameAPIModelSceneFrame.GetNumActors

```lua
numActors = GetNumActors()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numActors` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numActors = GetNumActors()
```

### FrameAPIModelSceneFrame.GetViewInsets

```lua
insets = GetViewInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `insets` | uiRect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local insets = GetViewInsets()
```

### FrameAPIModelSceneFrame.GetViewTranslation

```lua
translationX, translationY = GetViewTranslation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `translationX` | number | no |  |
| `translationY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local translationX, translationY = GetViewTranslation()
```

### FrameAPIModelSceneFrame.IsLightVisible

```lua
isVisible = IsLightVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isVisible = IsLightVisible()
```

### FrameAPIModelSceneFrame.Project3DPointTo2D

```lua
point2DX, point2DY, depth = Project3DPointTo2D(pointX, pointY, pointZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointX` | number | no |  |
| `pointY` | number | no |  |
| `pointZ` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point2DX` | number | no |  |
| `point2DY` | number | no |  |
| `depth` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local point2DX, point2DY, depth = Project3DPointTo2D(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetAllowOverlappedModels

```lua
SetAllowOverlappedModels(allowOverlappedModels)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowOverlappedModels` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAllowOverlappedModels(false)
```

### FrameAPIModelSceneFrame.SetCameraFarClip

```lua
SetCameraFarClip(farClip)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `farClip` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraFarClip(0)
```

### FrameAPIModelSceneFrame.SetCameraFieldOfView

Field of view in radians

```lua
SetCameraFieldOfView(fov)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fov` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraFieldOfView(0)
```

### FrameAPIModelSceneFrame.SetCameraNearClip

```lua
SetCameraNearClip(nearClip)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nearClip` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraNearClip(0)
```

### FrameAPIModelSceneFrame.SetCameraOrientationByAxisVectors

```lua
SetCameraOrientationByAxisVectors(forwardX, forwardY, forwardZ, rightX, rightY, rightZ, upX, upY, upZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forwardX` | number | no |  |
| `forwardY` | number | no |  |
| `forwardZ` | number | no |  |
| `rightX` | number | no |  |
| `rightY` | number | no |  |
| `rightZ` | number | no |  |
| `upX` | number | no |  |
| `upY` | number | no |  |
| `upZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraOrientationByAxisVectors(0, 0, 0, 0, 0, 0, 0, 0, 0)
```

### FrameAPIModelSceneFrame.SetCameraOrientationByYawPitchRoll

```lua
SetCameraOrientationByYawPitchRoll(yaw, pitch, roll)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `yaw` | number | no |  |
| `pitch` | number | no |  |
| `roll` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCameraOrientationByYawPitchRoll(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetCameraPosition

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

### FrameAPIModelSceneFrame.SetDesaturation

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

### FrameAPIModelSceneFrame.SetDrawLayer

```lua
SetDrawLayer(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawLayer(layer)
```

### FrameAPIModelSceneFrame.SetFogColor

```lua
SetFogColor(colorR, colorG, colorB)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFogColor(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetFogFar

```lua
SetFogFar(far)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `far` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFogFar(0)
```

### FrameAPIModelSceneFrame.SetFogNear

```lua
SetFogNear(near)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `near` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFogNear(0)
```

### FrameAPIModelSceneFrame.SetLightAmbientColor

```lua
SetLightAmbientColor(colorR, colorG, colorB)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightAmbientColor(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetLightDiffuseColor

```lua
SetLightDiffuseColor(colorR, colorG, colorB)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightDiffuseColor(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetLightDirection

```lua
SetLightDirection(directionX, directionY, directionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `directionX` | number | no |  |
| `directionY` | number | no |  |
| `directionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightDirection(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetLightPosition

```lua
SetLightPosition(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightPosition(0, 0, 0)
```

### FrameAPIModelSceneFrame.SetLightType

```lua
SetLightType(lightType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lightType` | ModelLightType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightType(lightType)
```

### FrameAPIModelSceneFrame.SetLightVisible

```lua
SetLightVisible(visible)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visible` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetLightVisible(false)
```

### FrameAPIModelSceneFrame.SetPaused

```lua
SetPaused(paused, affectsGlobalPause)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `paused` | bool | no |  |
| `affectsGlobalPause` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPaused(false, false)
```

### FrameAPIModelSceneFrame.SetViewInsets

```lua
SetViewInsets(insets)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `insets` | uiRect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetViewInsets(insets)
```

### FrameAPIModelSceneFrame.SetViewTranslation

```lua
SetViewTranslation(translationX, translationY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `translationX` | number | no |  |
| `translationY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetViewTranslation(0, 0)
```

### FrameAPIModelSceneFrame.TakeActor

```lua
TakeActor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
TakeActor()
```

