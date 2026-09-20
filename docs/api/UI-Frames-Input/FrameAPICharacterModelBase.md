# FrameAPICharacterModelBase

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**24** functions · **0** events · **0** types

## Functions

### FrameAPICharacterModelBase.ApplySpellVisualKit

```lua
ApplySpellVisualKit(spellVisualKitID, oneShot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellVisualKitID` | number | no |  |
| `oneShot` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ApplySpellVisualKit(2050, false)
```

### FrameAPICharacterModelBase.CanSetUnit

```lua
CanSetUnit(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
CanSetUnit("player")
```

### FrameAPICharacterModelBase.FreezeAnimation

```lua
FreezeAnimation(anim, variation, frame)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anim` | AnimationDataEnum | no |  |
| `variation` | number | no |  |
| `frame` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
FreezeAnimation(anim, 0, 0)
```

### FrameAPICharacterModelBase.GetDisplayInfo

```lua
displayID = GetDisplayInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local displayID = GetDisplayInfo()
```

### FrameAPICharacterModelBase.GetDoBlend

```lua
doBlend = GetDoBlend()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doBlend` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doBlend = GetDoBlend()
```

### FrameAPICharacterModelBase.GetKeepModelOnHide

```lua
keepModelOnHide = GetKeepModelOnHide()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keepModelOnHide` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local keepModelOnHide = GetKeepModelOnHide()
```

### FrameAPICharacterModelBase.HasAnimation

```lua
hasAnimation = HasAnimation(anim)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anim` | AnimationDataEnum | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnimation` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnimation = HasAnimation(anim)
```

### FrameAPICharacterModelBase.PlayAnimKit

```lua
PlayAnimKit(animKit, loop)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animKit` | number | no |  |
| `loop` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
PlayAnimKit(0, false)
```

### FrameAPICharacterModelBase.RefreshCamera

```lua
RefreshCamera()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RefreshCamera()
```

### FrameAPICharacterModelBase.RefreshUnit

```lua
RefreshUnit()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RefreshUnit()
```

### FrameAPICharacterModelBase.SetAnimation

```lua
SetAnimation(anim, [variation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anim` | AnimationDataEnum | no |  |
| `variation` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAnimation(anim)
```

### FrameAPICharacterModelBase.SetBarberShopAlternateForm

```lua
SetBarberShopAlternateForm()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBarberShopAlternateForm()
```

### FrameAPICharacterModelBase.SetCamDistanceScale

```lua
SetCamDistanceScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCamDistanceScale(0)
```

### FrameAPICharacterModelBase.SetCreature

```lua
SetCreature(creatureID, displayID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |
| `displayID` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCreature(0, 0)
```

### FrameAPICharacterModelBase.SetDisplayInfo

```lua
SetDisplayInfo(displayID, [mountDisplayID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayID` | number | no |  |
| `mountDisplayID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDisplayInfo(0)
```

### FrameAPICharacterModelBase.SetDoBlend

```lua
SetDoBlend(doBlend)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doBlend` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDoBlend(false)
```

### FrameAPICharacterModelBase.SetItem

```lua
SetItem(itemID, [appearanceModID], [itemVisualID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `appearanceModID` | number | yes |  |
| `itemVisualID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetItem(6948)
```

### FrameAPICharacterModelBase.SetItemAppearance

```lua
SetItemAppearance(itemAppearanceID, [itemVisualID], [itemSubclass])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |
| `itemVisualID` | number | yes |  |
| `itemSubclass` | ItemWeaponSubclass | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetItemAppearance(6948)
```

### FrameAPICharacterModelBase.SetKeepModelOnHide

```lua
SetKeepModelOnHide(keepModelOnHide)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keepModelOnHide` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetKeepModelOnHide(false)
```

### FrameAPICharacterModelBase.SetPortraitZoom

```lua
SetPortraitZoom(zoom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoom` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPortraitZoom(0)
```

### FrameAPICharacterModelBase.SetRotation

```lua
SetRotation(radians, animate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |
| `animate` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRotation(0, false)
```

### FrameAPICharacterModelBase.SetUnit

```lua
success = SetUnit(unit, blend, [useNativeForm])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `blend` | bool | no | (default: True) |
| `useNativeForm` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetUnit("player", false)
```

### FrameAPICharacterModelBase.StopAnimKit

```lua
StopAnimKit()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopAnimKit()
```

### FrameAPICharacterModelBase.ZeroCachedCenterXY

```lua
ZeroCachedCenterXY()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ZeroCachedCenterXY()
```

