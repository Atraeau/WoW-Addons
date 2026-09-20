# FrameAPIModelSceneFrameActor

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**31** functions · **0** events · **0** types

## Functions

### FrameAPIModelSceneFrameActor.AttachToMount

```lua
success = AttachToMount(rider, animation, [spellKitVisualID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rider` | ModelSceneFrameActor | no |  |
| `animation` | AnimationDataEnum | no |  |
| `spellKitVisualID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = AttachToMount(rider, animation)
```

### FrameAPIModelSceneFrameActor.CalculateMountScale

```lua
scale = CalculateMountScale(rider)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rider` | ModelSceneFrameActor | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scale = CalculateMountScale(rider)
```

### FrameAPIModelSceneFrameActor.DetachFromMount

```lua
success = DetachFromMount(rider)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rider` | ModelSceneFrameActor | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = DetachFromMount(rider)
```

### FrameAPIModelSceneFrameActor.Dress

```lua
Dress()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Dress()
```

### FrameAPIModelSceneFrameActor.DressPlayerSlot

```lua
DressPlayerSlot(invSlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
DressPlayerSlot(1)
```

### FrameAPIModelSceneFrameActor.GetAutoDress

```lua
autoDress = GetAutoDress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoDress` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local autoDress = GetAutoDress()
```

### FrameAPIModelSceneFrameActor.GetItemTransmogInfo

```lua
itemTransmogInfo = GetItemTransmogInfo(inventorySlots)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlots` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemTransmogInfo` | ItemTransmogInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemTransmogInfo = GetItemTransmogInfo(1)
```

### FrameAPIModelSceneFrameActor.GetItemTransmogInfoList

```lua
infoList = GetItemTransmogInfoList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infoList` | ItemTransmogInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infoList = GetItemTransmogInfoList()
```

### FrameAPIModelSceneFrameActor.GetObeyHideInTransmogFlag

```lua
obey = GetObeyHideInTransmogFlag()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `obey` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local obey = GetObeyHideInTransmogFlag()
```

### FrameAPIModelSceneFrameActor.GetPaused

```lua
paused, globalPaused = GetPaused()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `paused` | bool | no |  |
| `globalPaused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local paused, globalPaused = GetPaused()
```

### FrameAPIModelSceneFrameActor.GetSheathed

```lua
sheathed = GetSheathed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sheathed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sheathed = GetSheathed()
```

### FrameAPIModelSceneFrameActor.GetUseTransmogChoices

```lua
use = GetUseTransmogChoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `use` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local use = GetUseTransmogChoices()
```

### FrameAPIModelSceneFrameActor.GetUseTransmogSkin

```lua
use = GetUseTransmogSkin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `use` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local use = GetUseTransmogSkin()
```

### FrameAPIModelSceneFrameActor.IsGeoReady

```lua
isReady = IsGeoReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isReady = IsGeoReady()
```

### FrameAPIModelSceneFrameActor.IsSlotAllowed

```lua
allowed = IsSlotAllowed(inventorySlots)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlots` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowed = IsSlotAllowed(1)
```

### FrameAPIModelSceneFrameActor.IsSlotVisible

```lua
visible = IsSlotVisible(inventorySlots)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlots` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local visible = IsSlotVisible(1)
```

### FrameAPIModelSceneFrameActor.ReleaseFrontEndCharacterDisplays

```lua
success = ReleaseFrontEndCharacterDisplays()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = ReleaseFrontEndCharacterDisplays()
```

### FrameAPIModelSceneFrameActor.ResetNextHandSlot

```lua
ResetNextHandSlot()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetNextHandSlot()
```

### FrameAPIModelSceneFrameActor.SetAutoDress

```lua
SetAutoDress(autoDress)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoDress` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAutoDress(false)
```

### FrameAPIModelSceneFrameActor.SetFrontEndLobbyModelFromDefaultCharacterDisplay

```lua
success = SetFrontEndLobbyModelFromDefaultCharacterDisplay(characterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetFrontEndLobbyModelFromDefaultCharacterDisplay(1)
```

### FrameAPIModelSceneFrameActor.SetItemTransmogInfo

```lua
result = SetItemTransmogInfo(transmogInfo, [inventorySlots], ignoreChildItems)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogInfo` | ItemTransmogInfo | no |  |
| `inventorySlots` | number | yes |  |
| `ignoreChildItems` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ItemTryOnReason | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = SetItemTransmogInfo(transmogInfo, 6948)
```

### FrameAPIModelSceneFrameActor.SetModelByHyperlink

```lua
success = SetModelByHyperlink(link)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetModelByHyperlink("")
```

### FrameAPIModelSceneFrameActor.SetObeyHideInTransmogFlag

```lua
SetObeyHideInTransmogFlag(obey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `obey` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetObeyHideInTransmogFlag(false)
```

### FrameAPIModelSceneFrameActor.SetPaused

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

### FrameAPIModelSceneFrameActor.SetSheathed

```lua
SetSheathed(sheathed, hidden)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sheathed` | bool | no |  |
| `hidden` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSheathed(false, false)
```

### FrameAPIModelSceneFrameActor.SetSheathedCategory

```lua
SetSheathedCategory(inventorySlots, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlots` | number | no |  |
| `category` | TransmogOutfitSlotOptionSheatheCategory | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSheathedCategory(1, category)
```

### FrameAPIModelSceneFrameActor.SetUseTransmogChoices

```lua
SetUseTransmogChoices(use)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `use` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseTransmogChoices(false)
```

### FrameAPIModelSceneFrameActor.SetUseTransmogSkin

```lua
SetUseTransmogSkin(use)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `use` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseTransmogSkin(false)
```

### FrameAPIModelSceneFrameActor.Undress

```lua
Undress(includeWeapons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `includeWeapons` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
Undress(false)
```

### FrameAPIModelSceneFrameActor.UndressSlot

```lua
UndressSlot(inventorySlots)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UndressSlot(1)
```

### FrameAPIModelSceneFrameActor.UseUnitSheatheCategory

```lua
UseUnitSheatheCategory(useCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useCategory` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UseUnitSheatheCategory(false)
```

