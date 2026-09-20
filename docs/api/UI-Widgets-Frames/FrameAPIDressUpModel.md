# FrameAPIDressUpModel

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**20** functions · **0** events · **0** types

## Functions

### FrameAPIDressUpModel.Dress

```lua
Dress()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Dress()
```

### FrameAPIDressUpModel.GetAutoDress

```lua
enabled = GetAutoDress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = GetAutoDress()
```

### FrameAPIDressUpModel.GetItemTransmogInfo

```lua
itemTransmogInfo = GetItemTransmogInfo(inventorySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemTransmogInfo` | ItemTransmogInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemTransmogInfo = GetItemTransmogInfo(1)
```

### FrameAPIDressUpModel.GetItemTransmogInfoList

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

### FrameAPIDressUpModel.GetObeyHideInTransmogFlag

```lua
enabled = GetObeyHideInTransmogFlag()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = GetObeyHideInTransmogFlag()
```

### FrameAPIDressUpModel.GetSheathed

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

### FrameAPIDressUpModel.GetUseTransmogChoices

```lua
enabled = GetUseTransmogChoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = GetUseTransmogChoices()
```

### FrameAPIDressUpModel.GetUseTransmogSkin

```lua
enabled = GetUseTransmogSkin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = GetUseTransmogSkin()
```

### FrameAPIDressUpModel.IsGeoReady

```lua
ready = IsGeoReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ready` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ready = IsGeoReady()
```

### FrameAPIDressUpModel.IsSlotAllowed

```lua
allowed = IsSlotAllowed(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowed = IsSlotAllowed(1)
```

### FrameAPIDressUpModel.IsSlotVisible

```lua
visible = IsSlotVisible(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local visible = IsSlotVisible(1)
```

### FrameAPIDressUpModel.SetAutoDress

```lua
SetAutoDress(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAutoDress(false)
```

### FrameAPIDressUpModel.SetItemTransmogInfo

```lua
result = SetItemTransmogInfo(itemTransmogInfo, [inventorySlot], ignoreChildItems)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemTransmogInfo` | ItemTransmogInfo | no |  |
| `inventorySlot` | luaIndex | yes |  |
| `ignoreChildItems` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ItemTryOnReason | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = SetItemTransmogInfo(6948, 6948)
```

### FrameAPIDressUpModel.SetObeyHideInTransmogFlag

```lua
SetObeyHideInTransmogFlag(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetObeyHideInTransmogFlag(false)
```

### FrameAPIDressUpModel.SetSheathed

```lua
SetSheathed(sheathed, hideWeapons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sheathed` | bool | no | (default: False) |
| `hideWeapons` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSheathed(false, false)
```

### FrameAPIDressUpModel.SetUseTransmogChoices

```lua
SetUseTransmogChoices(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseTransmogChoices(false)
```

### FrameAPIDressUpModel.SetUseTransmogSkin

```lua
SetUseTransmogSkin(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseTransmogSkin(false)
```

### FrameAPIDressUpModel.TryOn

```lua
result = TryOn(linkOrItemModifiedAppearanceID, [handSlotName], [spellEnchantID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `linkOrItemModifiedAppearanceID` | IDOrLink | no |  |
| `handSlotName` | cstring | yes |  |
| `spellEnchantID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ItemTryOnReason | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = TryOn(6948)
```

### FrameAPIDressUpModel.Undress

```lua
Undress()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Undress()
```

### FrameAPIDressUpModel.UndressSlot

```lua
UndressSlot(inventorySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UndressSlot(1)
```

