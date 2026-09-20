# C_Container

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**47** functions · **17** events · **5** types

## Functions

### C_Container.CalculateTotalNumberOfFreeBagSlots

```lua
totalFreeSlots = C_Container.CalculateTotalNumberOfFreeBagSlots()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalFreeSlots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalFreeSlots = C_Container.CalculateTotalNumberOfFreeBagSlots()
```

### C_Container.ContainerIDToInventoryID

```lua
inventoryID = C_Container.ContainerIDToInventoryID(containerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerID` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryID` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inventoryID = C_Container.ContainerIDToInventoryID(Enum.BagIndex.Accountbanktab)
```

### C_Container.ContainerRefundItemPurchase

```lua
C_Container.ContainerRefundItemPurchase(containerIndex, slotIndex, isEquipped)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `isEquipped` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.ContainerRefundItemPurchase(1, 1, false)
```

### C_Container.GetBackpackAutosortDisabled

```lua
isDisabled = C_Container.GetBackpackAutosortDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDisabled = C_Container.GetBackpackAutosortDisabled()
```

### C_Container.GetBackpackSellJunkDisabled

```lua
isDisabled = C_Container.GetBackpackSellJunkDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDisabled = C_Container.GetBackpackSellJunkDisabled()
```

### C_Container.GetBagName

```lua
name = C_Container.GetBagName(bagIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_Container.GetBagName(1)
```

### C_Container.GetBagSlotFlag

```lua
isSet = C_Container.GetBagSlotFlag(bagIndex, flag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |
| `flag` | BagSlotFlags | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSet = C_Container.GetBagSlotFlag(1, flag)
```

### C_Container.GetBankAutosortDisabled

```lua
isDisabled = C_Container.GetBankAutosortDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDisabled = C_Container.GetBankAutosortDisabled()
```

### C_Container.GetContainerFreeSlots

```lua
freeSlots = C_Container.GetContainerFreeSlots(containerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `freeSlots` | luaIndex[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local freeSlots = C_Container.GetContainerFreeSlots(1)
```

### C_Container.GetContainerItemCooldown

```lua
startTime, duration, enable = C_Container.GetContainerItemCooldown(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local startTime, duration, enable = C_Container.GetContainerItemCooldown(1, 1)
```

### C_Container.GetContainerItemDurability

```lua
durability, maxDurability = C_Container.GetContainerItemDurability(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durability` | number | no |  |
| `maxDurability` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durability, maxDurability = C_Container.GetContainerItemDurability(1, 1)
```

### C_Container.GetContainerItemEquipmentSetInfo

```lua
inSet, setList = C_Container.GetContainerItemEquipmentSetInfo(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inSet` | bool | no |  |
| `setList` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inSet, setList = C_Container.GetContainerItemEquipmentSetInfo(1, 1)
```

### C_Container.GetContainerItemID

```lua
containerID = C_Container.GetContainerItemID(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local containerID = C_Container.GetContainerItemID(1, 1)
```

### C_Container.GetContainerItemInfo

```lua
containerInfo = C_Container.GetContainerItemInfo(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerInfo` | ContainerItemInfo | no |  |

**Example**

```lua
-- Returns a ContainerItemInfo table, or nil for an empty slot
local info = C_Container.GetContainerItemInfo(0, 1)
if info then
    print(info.itemID, info.stackCount, info.hyperlink)
end
```

### C_Container.GetContainerItemLink

```lua
itemLink = C_Container.GetContainerItemLink(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemLink = C_Container.GetContainerItemLink(1, 1)
```

### C_Container.GetContainerItemPurchaseCurrency

```lua
currencyInfo = C_Container.GetContainerItemPurchaseCurrency(containerIndex, slotIndex, itemIndex, isEquipped)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `itemIndex` | luaIndex | no |  |
| `isEquipped` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyInfo` | ItemPurchaseCurrency | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencyInfo = C_Container.GetContainerItemPurchaseCurrency(1, 1, 1, false)
```

### C_Container.GetContainerItemPurchaseInfo

```lua
info = C_Container.GetContainerItemPurchaseInfo(containerIndex, slotIndex, isEquipped)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `isEquipped` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemPurchaseInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Container.GetContainerItemPurchaseInfo(1, 1, false)
```

### C_Container.GetContainerItemPurchaseItem

```lua
itemInfo = C_Container.GetContainerItemPurchaseItem(containerIndex, slotIndex, itemIndex, isEquipped)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `itemIndex` | luaIndex | no |  |
| `isEquipped` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemPurchaseItem | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemInfo = C_Container.GetContainerItemPurchaseItem(1, 1, 1, false)
```

### C_Container.GetContainerItemQuestInfo

```lua
questInfo = C_Container.GetContainerItemQuestInfo(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questInfo` | ItemQuestInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questInfo = C_Container.GetContainerItemQuestInfo(1, 1)
```

### C_Container.GetContainerNumFreeSlots

```lua
numFreeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(bagIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFreeSlots` | number | no |  |
| `bagFamily` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numFreeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(1)
```

### C_Container.GetContainerNumSlots

```lua
numSlots = C_Container.GetContainerNumSlots(containerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSlots` | number | no |  |

**Example**

```lua
local slots = C_Container.GetContainerNumSlots(0)  -- bagID 0 = backpack
print(slots)
```

### C_Container.GetInsertItemsLeftToRight

```lua
isEnabled = C_Container.GetInsertItemsLeftToRight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_Container.GetInsertItemsLeftToRight()
```

### C_Container.GetItemCooldown

```lua
startTime, duration, enable = C_Container.GetItemCooldown(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local startTime, duration, enable = C_Container.GetItemCooldown(6948)
```

### C_Container.GetMaxArenaCurrency

```lua
maxCurrency = C_Container.GetMaxArenaCurrency()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxCurrency` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxCurrency = C_Container.GetMaxArenaCurrency()
```

### C_Container.GetSortBagsRightToLeft

```lua
isEnabled = C_Container.GetSortBagsRightToLeft()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_Container.GetSortBagsRightToLeft()
```

### C_Container.HasContainerItem

```lua
hasItem = C_Container.HasContainerItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasItem = C_Container.HasContainerItem(1, 1)
```

### C_Container.IsBattlePayItem

```lua
isBattlePayItem = C_Container.IsBattlePayItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBattlePayItem` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBattlePayItem = C_Container.IsBattlePayItem(1, 1)
```

### C_Container.IsContainerFiltered

```lua
isFiltered = C_Container.IsContainerFiltered(containerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFiltered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFiltered = C_Container.IsContainerFiltered(1)
```

### C_Container.PickupContainerItem

```lua
C_Container.PickupContainerItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.PickupContainerItem(1, 1)
```

### C_Container.PlayerHasHearthstone

```lua
itemID = C_Container.PlayerHasHearthstone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID = C_Container.PlayerHasHearthstone()
```

### C_Container.SetBackpackAutosortDisabled

```lua
C_Container.SetBackpackAutosortDisabled(disable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetBackpackAutosortDisabled(false)
```

### C_Container.SetBackpackSellJunkDisabled

```lua
C_Container.SetBackpackSellJunkDisabled(disable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetBackpackSellJunkDisabled(false)
```

### C_Container.SetBagPortraitTexture

```lua
C_Container.SetBagPortraitTexture(texture, bagIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `bagIndex` | BagIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetBagPortraitTexture(texture, 1)
```

### C_Container.SetBagSlotFlag

```lua
C_Container.SetBagSlotFlag(bagIndex, flag, isSet)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |
| `flag` | BagSlotFlags | no |  |
| `isSet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetBagSlotFlag(1, flag, false)
```

### C_Container.SetBankAutosortDisabled

```lua
C_Container.SetBankAutosortDisabled(disable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetBankAutosortDisabled(false)
```

### C_Container.SetInsertItemsLeftToRight

```lua
C_Container.SetInsertItemsLeftToRight(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetInsertItemsLeftToRight(false)
```

### C_Container.SetItemSearch

```lua
C_Container.SetItemSearch(searchString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchString` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetItemSearch("")
```

### C_Container.SetSortBagsRightToLeft

```lua
C_Container.SetSortBagsRightToLeft(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SetSortBagsRightToLeft(false)
```

### C_Container.ShowContainerSellCursor

```lua
C_Container.ShowContainerSellCursor(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.ShowContainerSellCursor(1, 1)
```

### C_Container.SocketContainerItem

```lua
success = C_Container.SocketContainerItem(containerIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_Container.SocketContainerItem(1, 1)
```

### C_Container.SortAccountBankBags

```lua
C_Container.SortAccountBankBags()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SortAccountBankBags()
```

### C_Container.SortBags

```lua
C_Container.SortBags()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SortBags()
```

### C_Container.SortBank

```lua
C_Container.SortBank(bankType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankType` | BankType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SortBank(bankType)
```

### C_Container.SortBankBags

```lua
C_Container.SortBankBags()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SortBankBags()
```

### C_Container.SplitContainerItem

```lua
C_Container.SplitContainerItem(containerIndex, slotIndex, amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `amount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.SplitContainerItem(1, 1, 0)
```

### C_Container.UseContainerItem

```lua
C_Container.UseContainerItem(containerIndex, slotIndex, [unitToken], [bankType], reagentBankOpen)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containerIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `unitToken` | UnitToken | yes |  |
| `bankType` | BankType | yes |  |
| `reagentBankOpen` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Container.UseContainerItem(1, 1, false)
```

### C_Container.UseHearthstone

```lua
used = C_Container.UseHearthstone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `used` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local used = C_Container.UseHearthstone()
```

## Events

### BAG_CLOSED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagID` | BagIndex | no |  |

### BAG_CONTAINER_UPDATE

### BAG_NEW_ITEMS_UPDATED

### BAG_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagID` | number | no |  |

### BAG_OVERFLOW_WITH_FULL_INVENTORY

### BAG_SLOT_FLAGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |

### BAG_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagID` | BagIndex | no |  |

### BAG_UPDATE_COOLDOWN

### BAG_UPDATE_DELAYED

### EQUIP_BIND_REFUNDABLE_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |
| `itemLocation` | ItemLocation | no |  |

### EQUIP_BIND_TRADEABLE_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |
| `itemLocation` | ItemLocation | no |  |

### EXPAND_BAG_BAR_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expandBagBar` | bool | no |  |

### INVENTORY_SEARCH_UPDATE

### ITEM_LOCK_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagOrSlotIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | yes |  |

### ITEM_LOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagOrSlotIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | yes |  |

### ITEM_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagOrSlotIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | yes |  |

### USE_COMBINED_BAGS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useCombinedBags` | bool | no |  |

## Types

### ContainerItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFileID` | fileID | no |  |
| `stackCount` | number | no |  |
| `isLocked` | bool | no |  |
| `quality` | ItemQuality | yes |  |
| `isReadable` | bool | no |  |
| `hasLoot` | bool | no |  |
| `hyperlink` | string | no |  |
| `isFiltered` | bool | no |  |
| `hasNoValue` | bool | no |  |
| `itemID` | number | no |  |
| `isBound` | bool | no |  |
| `itemName` | string | no |  |

### ItemPurchaseCurrency (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFileID` | number | yes |  |
| `currencyCount` | number | no |  |
| `name` | cstring | no |  |

### ItemPurchaseInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `money` | WOWMONEY | no |  |
| `itemCount` | number | no |  |
| `refundSeconds` | time_t | no |  |
| `currencyCount` | number | no |  |
| `hasEnchants` | bool | no |  |

### ItemPurchaseItem (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFileID` | number | yes |  |
| `itemCount` | number | no |  |
| `hyperlink` | string | no |  |

### ItemQuestInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isQuestItem` | bool | no |  |
| `questID` | number | yes |  |
| `isActive` | bool | no |  |

