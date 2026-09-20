# FrameAPIModelSceneFrameActorBase

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**50** functions · **0** events · **0** types

## Functions

### FrameAPIModelSceneFrameActorBase.ClearModel

```lua
ClearModel()
```

**Example**

```lua
ClearModel()
```

### FrameAPIModelSceneFrameActorBase.GetActiveBoundingBox

```lua
boxBottom, boxTop = GetActiveBoundingBox()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `boxBottom` | vector3 | no |  |
| `boxTop` | vector3 | no |  |

**Example**

```lua
local boxBottom, boxTop = GetActiveBoundingBox()
```

### FrameAPIModelSceneFrameActorBase.GetAlpha

```lua
alpha = GetAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
local alpha = GetAlpha()
```

### FrameAPIModelSceneFrameActorBase.GetAnimation

```lua
animation = GetAnimation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animation` | AnimationDataEnum | no |  |

**Example**

```lua
local animation = GetAnimation()
```

### FrameAPIModelSceneFrameActorBase.GetAnimationBlendOperation

```lua
blendOp = GetAnimationBlendOperation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blendOp` | ModelBlendOperation | no |  |

**Example**

```lua
local blendOp = GetAnimationBlendOperation()
```

### FrameAPIModelSceneFrameActorBase.GetAnimationVariation

```lua
variation = GetAnimationVariation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `variation` | number | no |  |

**Example**

```lua
local variation = GetAnimationVariation()
```

### FrameAPIModelSceneFrameActorBase.GetDesaturation

```lua
strength = GetDesaturation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example**

```lua
local strength = GetDesaturation()
```

### FrameAPIModelSceneFrameActorBase.GetMaxBoundingBox

```lua
boxBottom, boxTop = GetMaxBoundingBox()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `boxBottom` | vector3 | no |  |
| `boxTop` | vector3 | no |  |

**Example**

```lua
local boxBottom, boxTop = GetMaxBoundingBox()
```

### FrameAPIModelSceneFrameActorBase.GetModelFileID

```lua
file = GetModelFileID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `file` | fileID | no |  |

**Example**

```lua
local file = GetModelFileID()
```

### FrameAPIModelSceneFrameActorBase.GetModelPath

```lua
path = GetModelPath()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `path` | string | no |  |

**Example**

```lua
local path = GetModelPath()
```

### FrameAPIModelSceneFrameActorBase.GetModelUnitGUID

```lua
guid = GetModelUnitGUID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Example**

```lua
local guid = GetModelUnitGUID()
```

### FrameAPIModelSceneFrameActorBase.GetParticleOverrideScale

```lua
scale = GetParticleOverrideScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | yes |  |

**Example**

```lua
local scale = GetParticleOverrideScale()
```

### FrameAPIModelSceneFrameActorBase.GetPitch

```lua
pitch = GetPitch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pitch` | number | no |  |

**Example**

```lua
local pitch = GetPitch()
```

### FrameAPIModelSceneFrameActorBase.GetPosition

```lua
positionX, positionY, positionZ = GetPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example**

```lua
local positionX, positionY, positionZ = GetPosition()
```

### FrameAPIModelSceneFrameActorBase.GetRoll

```lua
roll = GetRoll()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roll` | number | no |  |

**Example**

```lua
local roll = GetRoll()
```

### FrameAPIModelSceneFrameActorBase.GetScale

```lua
scale = GetScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example**

```lua
local scale = GetScale()
```

### FrameAPIModelSceneFrameActorBase.GetSpellVisualKit

```lua
spellVisualKitID = GetSpellVisualKit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellVisualKitID` | number | no |  |

**Example**

```lua
local spellVisualKitID = GetSpellVisualKit()
```

### FrameAPIModelSceneFrameActorBase.GetYaw

```lua
yaw = GetYaw()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `yaw` | number | no |  |

**Example**

```lua
local yaw = GetYaw()
```

### FrameAPIModelSceneFrameActorBase.Hide

```lua
Hide()
```

**Example**

```lua
Hide()
```

### FrameAPIModelSceneFrameActorBase.IsLoaded

```lua
isLoaded = IsLoaded()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoaded` | bool | no |  |

**Example**

```lua
local isLoaded = IsLoaded()
```

### FrameAPIModelSceneFrameActorBase.IsPreferringModelCollisionBounds

```lua
preferringCollisionBounds = IsPreferringModelCollisionBounds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `preferringCollisionBounds` | bool | no |  |

**Example**

```lua
local preferringCollisionBounds = IsPreferringModelCollisionBounds()
```

### FrameAPIModelSceneFrameActorBase.IsShown

```lua
isShown = IsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isShown` | bool | no |  |

**Example**

```lua
local isShown = IsShown()
```

### FrameAPIModelSceneFrameActorBase.IsUsingCenterForOrigin

```lua
x, y, z = IsUsingCenterForOrigin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | bool | no |  |
| `y` | bool | no |  |
| `z` | bool | no |  |

**Example**

```lua
local x, y, z = IsUsingCenterForOrigin()
```

### FrameAPIModelSceneFrameActorBase.IsVisible

```lua
isVisible = IsVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example**

```lua
local isVisible = IsVisible()
```

### FrameAPIModelSceneFrameActorBase.PlayAnimationKit

```lua
PlayAnimationKit(animationKit, isLooping)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animationKit` | number | no |  |
| `isLooping` | bool | no | (default: False) |

**Example**

```lua
PlayAnimationKit(0, false)
```

### FrameAPIModelSceneFrameActorBase.SetAlpha

```lua
SetAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | number | no |  |

**Example**

```lua
SetAlpha(0)
```

### FrameAPIModelSceneFrameActorBase.SetAnimation

```lua
SetAnimation(animation, [variation], animSpeed, animOffsetSeconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animation` | AnimationDataEnum | no |  |
| `variation` | number | yes |  |
| `animSpeed` | number | no | (default: 1) |
| `animOffsetSeconds` | number | no | (default: 0) |

**Example**

```lua
SetAnimation(animation, 0, 0)
```

### FrameAPIModelSceneFrameActorBase.SetAnimationBlendOperation

```lua
SetAnimationBlendOperation(blendOp)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blendOp` | ModelBlendOperation | no |  |

**Example**

```lua
SetAnimationBlendOperation(blendOp)
```

### FrameAPIModelSceneFrameActorBase.SetDesaturation

```lua
SetDesaturation(strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strength` | number | no |  |

**Example**

```lua
SetDesaturation(0)
```

### FrameAPIModelSceneFrameActorBase.SetGradientMask

```lua
SetGradientMask(gradientIndex0, gradientIndex1, gradientIndex2, gradientIndex3)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gradientIndex0` | number | no |  |
| `gradientIndex1` | number | no |  |
| `gradientIndex2` | number | no |  |
| `gradientIndex3` | number | no |  |

**Example**

```lua
SetGradientMask(1, 1, 1, 1)
```

### FrameAPIModelSceneFrameActorBase.SetGradientMaskWithDyes

```lua
SetGradientMaskWithDyes([grad0DyeColorID], [grad1DyeColorID], [grad2DyeColorID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `grad0DyeColorID` | number | yes |  |
| `grad1DyeColorID` | number | yes |  |
| `grad2DyeColorID` | number | yes |  |

**Example**

```lua
SetGradientMaskWithDyes()
```

### FrameAPIModelSceneFrameActorBase.SetModelByCreatureDisplayID

```lua
success = SetModelByCreatureDisplayID(creatureDisplayID, useActivePlayerCustomizations)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayID` | number | no |  |
| `useActivePlayerCustomizations` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetModelByCreatureDisplayID(0, false)
```

### FrameAPIModelSceneFrameActorBase.SetModelByFileID

```lua
success = SetModelByFileID(asset, useMips)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |
| `useMips` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetModelByFileID(asset, false)
```

### FrameAPIModelSceneFrameActorBase.SetModelByPath

```lua
success = SetModelByPath(asset, useMips)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | FileAsset | no |  |
| `useMips` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetModelByPath(asset, false)
```

### FrameAPIModelSceneFrameActorBase.SetModelByUnit

```lua
success = SetModelByUnit(unit, sheatheWeapons, autoDress, hideWeapons, usePlayerNativeForm, holdBowString, [customRaceID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `sheatheWeapons` | bool | no | (default: False) |
| `autoDress` | bool | no | (default: True) |
| `hideWeapons` | bool | no | (default: False) |
| `usePlayerNativeForm` | bool | no | (default: True) |
| `holdBowString` | bool | no | (default: False) |
| `customRaceID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetModelByUnit("player", false, false, false, false, false)
```

### FrameAPIModelSceneFrameActorBase.SetModelByUnitCreatureDisplayID

```lua
success = SetModelByUnitCreatureDisplayID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetModelByUnitCreatureDisplayID("player")
```

### FrameAPIModelSceneFrameActorBase.SetParticleOverrideScale

```lua
SetParticleOverrideScale([scale])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | yes |  |

**Example**

```lua
SetParticleOverrideScale()
```

### FrameAPIModelSceneFrameActorBase.SetPitch

```lua
SetPitch(pitch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pitch` | number | no |  |

**Example**

```lua
SetPitch(0)
```

### FrameAPIModelSceneFrameActorBase.SetPlayerModelFromGlues

```lua
success = SetPlayerModelFromGlues([characterIndex], sheatheWeapons, autoDress, hideWeapons, usePlayerNativeForm, [customRaceID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterIndex` | number | yes |  |
| `sheatheWeapons` | bool | no | (default: False) |
| `autoDress` | bool | no | (default: True) |
| `hideWeapons` | bool | no | (default: False) |
| `usePlayerNativeForm` | bool | no | (default: True) |
| `customRaceID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetPlayerModelFromGlues(false, false, false, false)
```

### FrameAPIModelSceneFrameActorBase.SetPosition

```lua
SetPosition(positionX, positionY, positionZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |

**Example**

```lua
SetPosition(0, 0, 0)
```

### FrameAPIModelSceneFrameActorBase.SetPreferModelCollisionBounds

If true, will try to use the collision bounds of models for sizing and centering. Will fall back to default model bounds if set to False, or if collision bounds are unavailable.

```lua
SetPreferModelCollisionBounds(preferCollisionBounds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `preferCollisionBounds` | bool | no |  |

**Example**

```lua
SetPreferModelCollisionBounds(false)
```

### FrameAPIModelSceneFrameActorBase.SetRoll

```lua
SetRoll(roll)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roll` | number | no |  |

**Example**

```lua
SetRoll(0)
```

### FrameAPIModelSceneFrameActorBase.SetScale

```lua
SetScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example**

```lua
SetScale(0)
```

### FrameAPIModelSceneFrameActorBase.SetShown

```lua
SetShown(show)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `show` | bool | no | (default: False) |

**Example**

```lua
SetShown(false)
```

### FrameAPIModelSceneFrameActorBase.SetSpellVisualKit

```lua
SetSpellVisualKit(spellVisualKitID, oneShot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellVisualKitID` | number | no | (default: 0) |
| `oneShot` | bool | no | (default: False) |

**Example**

```lua
SetSpellVisualKit(12345, false)
```

### FrameAPIModelSceneFrameActorBase.SetUseCenterForOrigin

```lua
SetUseCenterForOrigin(x, y, z)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | bool | no | (default: False) |
| `y` | bool | no | (default: False) |
| `z` | bool | no | (default: False) |

**Example**

```lua
SetUseCenterForOrigin(false, false, false)
```

### FrameAPIModelSceneFrameActorBase.SetYaw

```lua
SetYaw(yaw)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `yaw` | number | no |  |

**Example**

```lua
SetYaw(0)
```

### FrameAPIModelSceneFrameActorBase.Show

```lua
Show()
```

**Example**

```lua
Show()
```

### FrameAPIModelSceneFrameActorBase.StopAnimationKit

```lua
StopAnimationKit()
```

**Example**

```lua
StopAnimationKit()
```

### FrameAPIModelSceneFrameActorBase.TryOn

```lua
reason = TryOn(itemLinkOrItemModifiedAppearanceID, [handSlotName], spellEnchantmentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLinkOrItemModifiedAppearanceID` | cstring | no |  |
| `handSlotName` | cstring | yes |  |
| `spellEnchantmentID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | ItemTryOnReason | yes |  |

**Example**

```lua
local reason = TryOn(6948, 12345)
```

