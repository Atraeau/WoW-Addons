# C_PerksProgram

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**24** functions · **15** events · **6** types

## Functions

### C_PerksProgram.ClearFrozenPerksVendorItem

```lua
C_PerksProgram.ClearFrozenPerksVendorItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.ClearFrozenPerksVendorItem()
```

### C_PerksProgram.CloseInteraction

```lua
C_PerksProgram.CloseInteraction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.CloseInteraction()
```

### C_PerksProgram.GetAvailableCategoryIDs

```lua
categoryIDs = C_PerksProgram.GetAvailableCategoryIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categoryIDs = C_PerksProgram.GetAvailableCategoryIDs()
```

### C_PerksProgram.GetAvailableVendorItemIDs

```lua
vendorItemIDs = C_PerksProgram.GetAvailableVendorItemIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vendorItemIDs = C_PerksProgram.GetAvailableVendorItemIDs()
```

### C_PerksProgram.GetCategoryInfo

```lua
categoryInfo = C_PerksProgram.GetCategoryInfo(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryInfo` | PerksVendorCategoryInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categoryInfo = C_PerksProgram.GetCategoryInfo(0)
```

### C_PerksProgram.GetCurrencyAmount

```lua
currencyAmount = C_PerksProgram.GetCurrencyAmount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyAmount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencyAmount = C_PerksProgram.GetCurrencyAmount()
```

### C_PerksProgram.GetDraggedPerksVendorItem

```lua
perksVendorItemID = C_PerksProgram.GetDraggedPerksVendorItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local perksVendorItemID = C_PerksProgram.GetDraggedPerksVendorItem()
```

### C_PerksProgram.GetFrozenPerksVendorItemInfo

```lua
vendorItemInfo = C_PerksProgram.GetFrozenPerksVendorItemInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemInfo` | PerksVendorItemInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vendorItemInfo = C_PerksProgram.GetFrozenPerksVendorItemInfo()
```

### C_PerksProgram.GetPendingChestRewards

```lua
pendingRewards = C_PerksProgram.GetPendingChestRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pendingRewards` | PerksProgramPendingChestRewards[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pendingRewards = C_PerksProgram.GetPendingChestRewards()
```

### C_PerksProgram.GetPerksProgramItemDisplayInfo

```lua
item = C_PerksProgram.GetPerksProgramItemDisplayInfo(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | PerksProgramItemDisplayInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local item = C_PerksProgram.GetPerksProgramItemDisplayInfo(0)
```

### C_PerksProgram.GetTimeRemaining

```lua
timeRemaining = C_PerksProgram.GetTimeRemaining(vendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeRemaining` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeRemaining = C_PerksProgram.GetTimeRemaining(6948)
```

### C_PerksProgram.GetVendorItemInfo

```lua
vendorItemInfo = C_PerksProgram.GetVendorItemInfo(vendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemInfo` | PerksVendorItemInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vendorItemInfo = C_PerksProgram.GetVendorItemInfo(6948)
```

### C_PerksProgram.GetVendorItemInfoRefundTimeLeft

```lua
refundTimeRemaining = C_PerksProgram.GetVendorItemInfoRefundTimeLeft(vendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundTimeRemaining` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local refundTimeRemaining = C_PerksProgram.GetVendorItemInfoRefundTimeLeft(6948)
```

### C_PerksProgram.IsAttackAnimToggleEnabled

```lua
isAttackAnimToggleEnabled = C_PerksProgram.IsAttackAnimToggleEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAttackAnimToggleEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAttackAnimToggleEnabled = C_PerksProgram.IsAttackAnimToggleEnabled()
```

### C_PerksProgram.IsFrozenPerksVendorItem

```lua
isFrozen = C_PerksProgram.IsFrozenPerksVendorItem(perksVendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFrozen` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFrozen = C_PerksProgram.IsFrozenPerksVendorItem(6948)
```

### C_PerksProgram.IsMountSpecialAnimToggleEnabled

```lua
isMountSpecialAnimToggleEnabled = C_PerksProgram.IsMountSpecialAnimToggleEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMountSpecialAnimToggleEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMountSpecialAnimToggleEnabled = C_PerksProgram.IsMountSpecialAnimToggleEnabled()
```

### C_PerksProgram.ItemSelectedTelemetry

```lua
C_PerksProgram.ItemSelectedTelemetry(perksVendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.ItemSelectedTelemetry(6948)
```

### C_PerksProgram.PickupPerksVendorItem

```lua
C_PerksProgram.PickupPerksVendorItem(perksVendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.PickupPerksVendorItem(6948)
```

### C_PerksProgram.RequestCartCheckout

```lua
C_PerksProgram.RequestCartCheckout(perksVendorItemIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.RequestCartCheckout(6948)
```

### C_PerksProgram.RequestPendingChestRewards

```lua
C_PerksProgram.RequestPendingChestRewards()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.RequestPendingChestRewards()
```

### C_PerksProgram.RequestPurchase

```lua
C_PerksProgram.RequestPurchase(perksVendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.RequestPurchase(6948)
```

### C_PerksProgram.RequestRefund

```lua
C_PerksProgram.RequestRefund(perksVendorItemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksVendorItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.RequestRefund(6948)
```

### C_PerksProgram.ResetHeldItemDragAndDrop

```lua
C_PerksProgram.ResetHeldItemDragAndDrop()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.ResetHeldItemDragAndDrop()
```

### C_PerksProgram.SetFrozenPerksVendorItem

```lua
C_PerksProgram.SetFrozenPerksVendorItem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PerksProgram.SetFrozenPerksVendorItem()
```

## Events

### CHEST_REWARDS_UPDATED_FROM_SERVER

### PERKS_PROGRAM_ADD_PENDING_SHOP_ITEM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

### PERKS_PROGRAM_CLOSE

### PERKS_PROGRAM_CURRENCY_AWARDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

### PERKS_PROGRAM_CURRENCY_REFRESH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldValue` | number | no |  |
| `newValue` | number | no |  |

### PERKS_PROGRAM_DATA_REFRESH

### PERKS_PROGRAM_DATA_SPECIFIC_ITEM_REFRESH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

### PERKS_PROGRAM_DISABLED

### PERKS_PROGRAM_OPEN

### PERKS_PROGRAM_PURCHASE_CART_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemIDs` | number[] | no |  |

### PERKS_PROGRAM_PURCHASE_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

### PERKS_PROGRAM_REFUND_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

### PERKS_PROGRAM_REMOVE_PENDING_SHOP_ITEM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

### PERKS_PROGRAM_RESULT_ERROR

### PERKS_PROGRAM_SET_FROZEN_ITEM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorItemID` | number | no |  |

## Types

### PerksProgramItemDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideModelSceneID` | number | yes |  |
| `creatureDisplayInfoID` | number | yes |  |
| `mainHandItemModifiedAppearanceID` | number | yes |  |
| `offHandItemModifiedAppearanceID` | number | yes |  |

### PerksProgramPendingChestRewards (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardTypeID` | number | no |  |
| `perksVendorItemID` | number | yes |  |
| `rewardAmount` | number | no |  |
| `monthRewarded` | string | yes |  |
| `activityMonthID` | number | no |  |
| `thresholdOrderIndex` | number | no |  |

### PerksVendorCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `displayName` | cstring | no |  |
| `defaultUIModelSceneID` | number | no |  |

### PerksVendorItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `perksVendorCategoryID` | number | no |  |
| `description` | string | no |  |
| `timeRemaining` | time_t | no |  |
| `purchased` | bool | no |  |
| `refundable` | bool | no |  |
| `subItemsLoaded` | bool | no |  |
| `isPurchasePending` | bool | no |  |
| `doesNotExpire` | bool | no |  |
| `price` | number | no |  |
| `originalPrice` | number | yes |  |
| `showSaleBanner` | bool | no |  |
| `perksVendorItemID` | number | no |  |
| `itemID` | number | no |  |
| `iconTexture` | string | no |  |
| `mountID` | number | no |  |
| `mountTypeName` | string | no |  |
| `speciesID` | number | no |  |
| `transmogSetID` | number | no |  |
| `itemModifiedAppearanceID` | number | no |  |
| `subItems` | PerksVendorSubItemInfo[] | no |  |
| `uiGroupInfo` | PerksVendorItemUIGroupInfo | yes |  |
| `invType` | string | no |  |
| `quality` | ItemQuality | no |  |

### PerksVendorItemUIGroupInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `name` | cstring | no |  |
| `priority` | number | no |  |

### PerksVendorSubItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `itemID` | number | no |  |
| `itemModifiedAppearanceID` | number | no |  |
| `invType` | string | no |  |
| `quality` | ItemQuality | no |  |

