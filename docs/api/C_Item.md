# C_Item

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**121** functions · **19** events · **3** types

## Functions

### C_Item.ActionBindsItem

```lua
C_Item.ActionBindsItem()
```

**Example**

```lua
C_Item.ActionBindsItem()
```

### C_Item.BindEnchant

```lua
C_Item.BindEnchant()
```

**Example**

```lua
C_Item.BindEnchant()
```

### C_Item.CanBeRefunded

```lua
canBeRefunded = C_Item.CanBeRefunded(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canBeRefunded` | bool | no |  |

**Example**

```lua
local canBeRefunded = C_Item.CanBeRefunded(6948)
```

### C_Item.CanItemTransmogAppearance

```lua
canTransmog, errorCode = C_Item.CanItemTransmogAppearance(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canTransmog` | bool | no |  |
| `errorCode` | TransmogOutfitSlotError | no |  |

**Example**

```lua
local canTransmog, errorCode = C_Item.CanItemTransmogAppearance(6948)
```

### C_Item.CanScrapItem

```lua
canBeScrapped = C_Item.CanScrapItem(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canBeScrapped` | bool | no |  |

**Example**

```lua
local canBeScrapped = C_Item.CanScrapItem(6948)
```

### C_Item.CanViewItemPowers

```lua
isItemViewable = C_Item.CanViewItemPowers(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemViewable` | bool | no |  |

**Example**

```lua
local isItemViewable = C_Item.CanViewItemPowers(6948)
```

### C_Item.ConfirmBindOnUse

```lua
C_Item.ConfirmBindOnUse()
```

**Example**

```lua
C_Item.ConfirmBindOnUse()
```

### C_Item.ConfirmDeleteItem

```lua
C_Item.ConfirmDeleteItem(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Example**

```lua
C_Item.ConfirmDeleteItem("Creature-0-0000-0-0-0-0")
```

### C_Item.ConfirmNoRefundOnUse

```lua
C_Item.ConfirmNoRefundOnUse()
```

**Example**

```lua
C_Item.ConfirmNoRefundOnUse()
```

### C_Item.ConfirmOnUse

```lua
C_Item.ConfirmOnUse()
```

**Example**

```lua
C_Item.ConfirmOnUse()
```

### C_Item.DeleteItem

```lua
C_Item.DeleteItem(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Example**

```lua
C_Item.DeleteItem("Creature-0-0000-0-0-0-0")
```

### C_Item.DoesItemContainSpec

```lua
result = C_Item.DoesItemContainSpec(itemInfo, classID, specID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `classID` | number | no |  |
| `specID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.DoesItemContainSpec(6948, 0, 0)
```

### C_Item.DoesItemExist

```lua
itemExists = C_Item.DoesItemExist(emptiableItemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `emptiableItemLocation` | EmptiableItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemExists` | bool | no |  |

**Example**

```lua
local itemExists = C_Item.DoesItemExist(6948)
```

### C_Item.DoesItemExistByID

```lua
itemExists = C_Item.DoesItemExistByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemExists` | bool | no |  |

**Example**

```lua
local itemExists = C_Item.DoesItemExistByID(6948)
```

### C_Item.DoesItemMatchBonusTreeReplacement

```lua
matchesBonusTree = C_Item.DoesItemMatchBonusTreeReplacement(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchesBonusTree` | bool | no |  |

**Example**

```lua
local matchesBonusTree = C_Item.DoesItemMatchBonusTreeReplacement(6948)
```

### C_Item.DoesItemMatchSpellItemCondition

```lua
matches = C_Item.DoesItemMatchSpellItemCondition(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matches` | bool | no |  |

**Example**

```lua
local matches = C_Item.DoesItemMatchSpellItemCondition(6948)
```

### C_Item.DoesItemMatchTargetEnchantingSpell

```lua
matchesTargetEnchantingSpell = C_Item.DoesItemMatchTargetEnchantingSpell(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchesTargetEnchantingSpell` | bool | no |  |

**Example**

```lua
local matchesTargetEnchantingSpell = C_Item.DoesItemMatchTargetEnchantingSpell(6948)
```

### C_Item.DoesItemMatchTrackJump

```lua
matchesTrackJump = C_Item.DoesItemMatchTrackJump(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matchesTrackJump` | bool | no |  |

**Example**

```lua
local matchesTrackJump = C_Item.DoesItemMatchTrackJump(6948)
```

### C_Item.DropItemOnUnit

```lua
C_Item.DropItemOnUnit(unitGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | UnitToken | no |  |

**Example**

```lua
C_Item.DropItemOnUnit("player")
```

### C_Item.EndBoundTradeable

```lua
C_Item.EndBoundTradeable(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |

**Example**

```lua
C_Item.EndBoundTradeable("")
```

### C_Item.EndRefund

```lua
C_Item.EndRefund(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |

**Example**

```lua
C_Item.EndRefund(0)
```

### C_Item.EquipItemByName

```lua
C_Item.EquipItemByName(itemInfo, [dstSlot])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `dstSlot` | luaIndex | yes |  |

**Example**

```lua
C_Item.EquipItemByName(6948)
```

### C_Item.GetAppliedItemTransmogInfo

```lua
info = C_Item.GetAppliedItemTransmogInfo(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemTransmogInfo | yes |  |

**Example**

```lua
local info = C_Item.GetAppliedItemTransmogInfo(6948)
```

### C_Item.GetBaseItemTransmogInfo

```lua
info = C_Item.GetBaseItemTransmogInfo(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemTransmogInfo | yes |  |

**Example**

```lua
local info = C_Item.GetBaseItemTransmogInfo(6948)
```

### C_Item.GetCurrentItemLevel

```lua
currentItemLevel = C_Item.GetCurrentItemLevel(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentItemLevel` | number | yes |  |

**Example**

```lua
local currentItemLevel = C_Item.GetCurrentItemLevel(6948)
```

### C_Item.GetCurrentItemTransmogInfo

```lua
info = C_Item.GetCurrentItemTransmogInfo(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemTransmogInfo | yes |  |

**Example**

```lua
local info = C_Item.GetCurrentItemTransmogInfo(6948)
```

### C_Item.GetDelvePreviewItemLink

```lua
itemLink = C_Item.GetDelvePreviewItemLink(itemID, context)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `context` | ItemCreationContext | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | string | yes |  |

**Example**

```lua
local itemLink = C_Item.GetDelvePreviewItemLink(6948, context)
```

### C_Item.GetDelvePreviewItemQuality

```lua
itemQuality = C_Item.GetDelvePreviewItemQuality(itemID, context)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `context` | ItemCreationContext | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemQuality` | ItemQuality | no |  |

**Example**

```lua
local itemQuality = C_Item.GetDelvePreviewItemQuality(6948, context)
```

### C_Item.GetDetailedItemLevelInfo

```lua
actualItemLevel, previewLevel, sparseItemLevel = C_Item.GetDetailedItemLevelInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actualItemLevel` | number | no |  |
| `previewLevel` | bool | no |  |
| `sparseItemLevel` | number | no |  |

**Example**

```lua
local actualItemLevel, previewLevel, sparseItemLevel = C_Item.GetDetailedItemLevelInfo(6948)
```

### C_Item.GetFirstTriggeredSpellForItem

```lua
spellID = C_Item.GetFirstTriggeredSpellForItem(itemID, itemQuality)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemQuality` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |

**Example**

```lua
local spellID = C_Item.GetFirstTriggeredSpellForItem(6948, 6948)
```

### C_Item.GetItemChildInfo

```lua
result = C_Item.GetItemChildInfo(itemInfo, [slotID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `slotID` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number[] | no |  |

**Example**

```lua
local result = C_Item.GetItemChildInfo(6948)
```

### C_Item.GetItemClassInfo

```lua
result = C_Item.GetItemClassInfo(itemClassID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemClassID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_Item.GetItemClassInfo(6948)
```

### C_Item.GetItemConversionOutputIcon

```lua
icon = C_Item.GetItemConversionOutputIcon(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | yes |  |

**Example**

```lua
local icon = C_Item.GetItemConversionOutputIcon(6948)
```

### C_Item.GetItemCooldown

```lua
startTimeSeconds, durationSeconds, enableCooldownTimer = C_Item.GetItemCooldown(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTimeSeconds` | number | no |  |
| `durationSeconds` | number | no |  |
| `enableCooldownTimer` | bool | no |  |

**Example**

```lua
local startTimeSeconds, durationSeconds, enableCooldownTimer = C_Item.GetItemCooldown(6948)
```

### C_Item.GetItemCount

```lua
count = C_Item.GetItemCount(itemInfo, includeBank, includeUses, includeReagentBank, includeAccountBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `includeBank` | bool | no | (default: False) |
| `includeUses` | bool | no | (default: False) |
| `includeReagentBank` | bool | no | (default: False) |
| `includeAccountBank` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example**

```lua
local count = C_Item.GetItemCount(6948, false, false, false, false)
```

### C_Item.GetItemCreationContext

```lua
itemID, creationContext = C_Item.GetItemCreationContext(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `creationContext` | cstring | no |  |

**Example**

```lua
local itemID, creationContext = C_Item.GetItemCreationContext(6948)
```

### C_Item.GetItemFamily

```lua
result = C_Item.GetItemFamily(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = C_Item.GetItemFamily(6948)
```

### C_Item.GetItemGem

```lua
gemName, gemLink = C_Item.GetItemGem(hyperlink, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | cstring | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gemName` | string | no |  |
| `gemLink` | cstring | no |  |

**Example**

```lua
local gemName, gemLink = C_Item.GetItemGem("", 1)
```

### C_Item.GetItemGemID

```lua
gemID = C_Item.GetItemGemID(itemInfo, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gemID` | number | no |  |

**Example**

```lua
local gemID = C_Item.GetItemGemID(6948, 1)
```

### C_Item.GetItemGUID

```lua
itemGUID = C_Item.GetItemGUID(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Example**

```lua
local itemGUID = C_Item.GetItemGUID(6948)
```

### C_Item.GetItemIcon

```lua
icon = C_Item.GetItemIcon(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | yes |  |

**Example**

```lua
local icon = C_Item.GetItemIcon(6948)
```

### C_Item.GetItemIconByID

```lua
icon = C_Item.GetItemIconByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | yes |  |

**Example**

```lua
local icon = C_Item.GetItemIconByID(6948)
```

### C_Item.GetItemID

```lua
itemID = C_Item.GetItemID(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example**

```lua
local itemID = C_Item.GetItemID(6948)
```

### C_Item.GetItemIDByGUID

```lua
itemID = C_Item.GetItemIDByGUID(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

**Example**

```lua
local itemID = C_Item.GetItemIDByGUID("Creature-0-0000-0-0-0-0")
```

### C_Item.GetItemIDForItemInfo

```lua
itemID = C_Item.GetItemIDForItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example**

```lua
local itemID = C_Item.GetItemIDForItemInfo(6948)
```

### C_Item.GetItemInfo

```lua
itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent, itemDescription = C_Item.GetItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `itemQuality` | ItemQuality | no |  |
| `itemLevel` | number | no |  |
| `itemMinLevel` | number | no |  |
| `itemType` | cstring | no |  |
| `itemSubType` | cstring | no |  |
| `itemStackCount` | number | no |  |
| `itemEquipLoc` | cstring | no |  |
| `itemTexture` | fileID | no |  |
| `sellPrice` | number | no |  |
| `classID` | number | no |  |
| `subclassID` | number | no |  |
| `bindType` | number | no |  |
| `expansionID` | number | no |  |
| `setID` | number | yes |  |
| `isCraftingReagent` | bool | no |  |
| `itemDescription` | cstring | no |  |

**Example**

```lua
local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent, itemDescription = C_Item.GetItemInfo(6948)
```

### C_Item.GetItemInfoInstant

```lua
itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = C_Item.GetItemInfoInstant(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemType` | cstring | no |  |
| `itemSubType` | cstring | no |  |
| `itemEquipLoc` | cstring | no |  |
| `icon` | fileID | no |  |
| `classID` | number | no |  |
| `subClassID` | number | no |  |

**Example**

```lua
local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = C_Item.GetItemInfoInstant(6948)
```

### C_Item.GetItemInventorySlotInfo

```lua
result = C_Item.GetItemInventorySlotInfo(inventorySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlot` | InventoryType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_Item.GetItemInventorySlotInfo(1)
```

### C_Item.GetItemInventorySlotKey

```lua
result = C_Item.GetItemInventorySlotKey(inventorySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventorySlot` | InventoryType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_Item.GetItemInventorySlotKey(1)
```

### C_Item.GetItemInventoryType

```lua
inventoryType = C_Item.GetItemInventoryType(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryType` | InventoryType | yes |  |

**Example**

```lua
local inventoryType = C_Item.GetItemInventoryType(6948)
```

### C_Item.GetItemInventoryTypeByID

```lua
inventoryType = C_Item.GetItemInventoryTypeByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryType` | InventoryType | yes |  |

**Example**

```lua
local inventoryType = C_Item.GetItemInventoryTypeByID(6948)
```

### C_Item.GetItemLearnTransmogSet

```lua
setID = C_Item.GetItemLearnTransmogSet(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | yes |  |

**Example**

```lua
local setID = C_Item.GetItemLearnTransmogSet(6948)
```

### C_Item.GetItemLink

```lua
itemLink = C_Item.GetItemLink(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | string | yes |  |

**Example**

```lua
local itemLink = C_Item.GetItemLink(6948)
```

### C_Item.GetItemLinkByGUID

```lua
itemLink = C_Item.GetItemLinkByGUID(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | string | yes |  |

**Example**

```lua
local itemLink = C_Item.GetItemLinkByGUID("Creature-0-0000-0-0-0-0")
```

### C_Item.GetItemLocation

```lua
itemLocation = C_Item.GetItemLocation(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | yes |  |

**Example**

```lua
local itemLocation = C_Item.GetItemLocation("Creature-0-0000-0-0-0-0")
```

### C_Item.GetItemMaxStackSize

```lua
stackSize = C_Item.GetItemMaxStackSize(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stackSize` | number | yes |  |

**Example**

```lua
local stackSize = C_Item.GetItemMaxStackSize(6948)
```

### C_Item.GetItemMaxStackSizeByID

```lua
stackSize = C_Item.GetItemMaxStackSizeByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stackSize` | number | yes |  |

**Example**

```lua
local stackSize = C_Item.GetItemMaxStackSizeByID(6948)
```

### C_Item.GetItemName

```lua
itemName = C_Item.GetItemName(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | string | yes |  |

**Example**

```lua
local itemName = C_Item.GetItemName(6948)
```

### C_Item.GetItemNameByID

```lua
itemName = C_Item.GetItemNameByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | string | yes |  |

**Example**

```lua
local itemName = C_Item.GetItemNameByID(6948)
```

### C_Item.GetItemNumAddedSockets

```lua
socketCount = C_Item.GetItemNumAddedSockets(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `socketCount` | number | no |  |

**Example**

```lua
local socketCount = C_Item.GetItemNumAddedSockets(6948)
```

### C_Item.GetItemNumSockets

```lua
socketCount = C_Item.GetItemNumSockets(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `socketCount` | number | no |  |

**Example**

```lua
local socketCount = C_Item.GetItemNumSockets(6948)
```

### C_Item.GetItemQuality

```lua
itemQuality = C_Item.GetItemQuality(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemQuality` | ItemQuality | yes |  |

**Example**

```lua
local itemQuality = C_Item.GetItemQuality(6948)
```

### C_Item.GetItemQualityByID

```lua
itemQuality = C_Item.GetItemQualityByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemQuality` | ItemQuality | yes |  |

**Example**

```lua
local itemQuality = C_Item.GetItemQualityByID(6948)
```

### C_Item.GetItemQualityColor

```lua
colorRGBR, colorRGBG, colorRGBB, qualityString = C_Item.GetItemQualityColor(quality)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | ItemQuality | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorRGBR` | number | no |  |
| `colorRGBG` | number | no |  |
| `colorRGBB` | number | no |  |
| `qualityString` | cstring | no |  |

**Example**

```lua
local colorRGBR, colorRGBG, colorRGBB, qualityString = C_Item.GetItemQualityColor(quality)
```

### C_Item.GetItemSetInfo

```lua
result = C_Item.GetItemSetInfo(setID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_Item.GetItemSetInfo(0)
```

### C_Item.GetItemSpecInfo

```lua
specTable = C_Item.GetItemSpecInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specTable` | number[] | no |  |

**Example**

```lua
local specTable = C_Item.GetItemSpecInfo(6948)
```

### C_Item.GetItemSpell

```lua
spellName, spellID = C_Item.GetItemSpell(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellName` | cstring | no |  |
| `spellID` | number | no |  |

**Example**

```lua
local spellName, spellID = C_Item.GetItemSpell(6948)
```

### C_Item.GetItemStatDelta

```lua
statTable = C_Item.GetItemStatDelta(itemLink1, itemLink2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink1` | cstring | no |  |
| `itemLink2` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `statTable` | LuaValueVariant | no |  |

**Example**

```lua
local statTable = C_Item.GetItemStatDelta(6948, 6948)
```

### C_Item.GetItemStats

```lua
statTable = C_Item.GetItemStats(itemLink)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `statTable` | LuaValueVariant | no |  |

**Example**

```lua
local statTable = C_Item.GetItemStats(6948)
```

### C_Item.GetItemSubClassInfo

```lua
subClassName, subClassUsesInvType = C_Item.GetItemSubClassInfo(itemClassID, itemSubClassID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemClassID` | number | no |  |
| `itemSubClassID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subClassName` | cstring | no |  |
| `subClassUsesInvType` | bool | no |  |

**Example**

```lua
local subClassName, subClassUsesInvType = C_Item.GetItemSubClassInfo(6948, 6948)
```

### C_Item.GetItemUniqueness

```lua
limitCategory, limitMax = C_Item.GetItemUniqueness(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `limitCategory` | number | no |  |
| `limitMax` | number | no |  |

**Example**

```lua
local limitCategory, limitMax = C_Item.GetItemUniqueness(6948)
```

### C_Item.GetItemUniquenessByID

```lua
isUnique, limitCategoryName, limitCategoryCount, limitCategoryID = C_Item.GetItemUniquenessByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnique` | bool | no |  |
| `limitCategoryName` | cstring | yes |  |
| `limitCategoryCount` | number | yes |  |
| `limitCategoryID` | number | yes |  |

**Example**

```lua
local isUnique, limitCategoryName, limitCategoryCount, limitCategoryID = C_Item.GetItemUniquenessByID(6948)
```

### C_Item.GetItemUpgradeInfo

```lua
itemUpgradeInfo = C_Item.GetItemUpgradeInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemUpgradeInfo` | ItemUpgradeInfo | yes |  |

**Example**

```lua
local itemUpgradeInfo = C_Item.GetItemUpgradeInfo(6948)
```

### C_Item.GetLimitedCurrencyItemInfo

```lua
name, icon, quantity, maxQuantity, totalEarned = C_Item.GetLimitedCurrencyItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | no |  |
| `quantity` | number | no |  |
| `maxQuantity` | number | no |  |
| `totalEarned` | number | no |  |

**Example**

```lua
local name, icon, quantity, maxQuantity, totalEarned = C_Item.GetLimitedCurrencyItemInfo(6948)
```

### C_Item.GetSetBonusesForSpecializationByItemID

```lua
itemSetSpellIDs = C_Item.GetSetBonusesForSpecializationByItemID(specID, itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemSetSpellIDs` | number[] | no |  |

**Example**

```lua
local itemSetSpellIDs = C_Item.GetSetBonusesForSpecializationByItemID(0, 6948)
```

### C_Item.GetStackCount

```lua
stackCount = C_Item.GetStackCount(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stackCount` | number | no |  |

**Example**

```lua
local stackCount = C_Item.GetStackCount(6948)
```

### C_Item.GetWeaponEnchantInfo

```lua
enchants = C_Item.GetWeaponEnchantInfo(weaponSlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weaponSlot` | WeaponSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enchants` | WeaponEnchantInfo[] | no |  |

**Example**

```lua
local enchants = C_Item.GetWeaponEnchantInfo(1)
```

### C_Item.IsAnimaItemByID

```lua
isAnimaItem = C_Item.IsAnimaItemByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAnimaItem` | bool | no |  |

**Example**

```lua
local isAnimaItem = C_Item.IsAnimaItemByID(6948)
```

### C_Item.IsArtifactPowerItem

```lua
result = C_Item.IsArtifactPowerItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsArtifactPowerItem(6948)
```

### C_Item.IsBound

```lua
isBound = C_Item.IsBound(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBound` | bool | no |  |

**Example**

```lua
local isBound = C_Item.IsBound(6948)
```

### C_Item.IsBoundToAccountUntilEquip

You can use IsItemBindToAccountUntilEquip instead if the item is not in your inventory

```lua
isBoundToAccountUntilEquip = C_Item.IsBoundToAccountUntilEquip(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBoundToAccountUntilEquip` | bool | no |  |

**Example**

```lua
local isBoundToAccountUntilEquip = C_Item.IsBoundToAccountUntilEquip(6948)
```

### C_Item.IsConsumableItem

```lua
result = C_Item.IsConsumableItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsConsumableItem(6948)
```

### C_Item.IsCorruptedItem

```lua
result = C_Item.IsCorruptedItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = C_Item.IsCorruptedItem(6948)
```

### C_Item.IsCosmeticItem

```lua
result = C_Item.IsCosmeticItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = C_Item.IsCosmeticItem(6948)
```

### C_Item.IsCurioItem

Returns whether the item is a consumable curio that can be applied to a delves companion.

```lua
result = C_Item.IsCurioItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = C_Item.IsCurioItem(6948)
```

### C_Item.IsCurrentItem

```lua
result = C_Item.IsCurrentItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsCurrentItem(6948)
```

### C_Item.IsDecorItem

Returns whether the item is a consumable decor item.

```lua
isDecor = C_Item.IsDecorItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDecor` | bool | yes |  |

**Example**

```lua
local isDecor = C_Item.IsDecorItem(6948)
```

### C_Item.IsDressableItemByID

```lua
isDressableItem = C_Item.IsDressableItemByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDressableItem` | bool | no |  |

**Example**

```lua
local isDressableItem = C_Item.IsDressableItemByID(6948)
```

### C_Item.IsEquippableItem

```lua
result = C_Item.IsEquippableItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsEquippableItem(6948)
```

### C_Item.IsEquippedItem

```lua
result = C_Item.IsEquippedItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsEquippedItem(6948)
```

### C_Item.IsEquippedItemType

```lua
result = C_Item.IsEquippedItemType(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsEquippedItemType("")
```

### C_Item.IsHarmfulItem

```lua
result = C_Item.IsHarmfulItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsHarmfulItem(6948)
```

### C_Item.IsHelpfulItem

```lua
result = C_Item.IsHelpfulItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.IsHelpfulItem(6948)
```

### C_Item.IsItemBindToAccount

```lua
isItemBindToAccount = C_Item.IsItemBindToAccount(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemBindToAccount` | bool | no |  |

**Example**

```lua
local isItemBindToAccount = C_Item.IsItemBindToAccount(6948)
```

### C_Item.IsItemBindToAccountUntilEquip

You can use IsBoundToAccountUntilEquip instead if the item exists in your inventory

```lua
isItemBindToAccountUntilEquip = C_Item.IsItemBindToAccountUntilEquip(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemBindToAccountUntilEquip` | bool | no |  |

**Example**

```lua
local isItemBindToAccountUntilEquip = C_Item.IsItemBindToAccountUntilEquip(6948)
```

### C_Item.IsItemConduit

```lua
isConduit = C_Item.IsItemConduit(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConduit` | bool | no |  |

**Example**

```lua
local isConduit = C_Item.IsItemConduit(6948)
```

### C_Item.IsItemConvertibleAndValidForPlayer

```lua
isItemConvertibleAndValidForPlayer = C_Item.IsItemConvertibleAndValidForPlayer(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemConvertibleAndValidForPlayer` | bool | no |  |

**Example**

```lua
local isItemConvertibleAndValidForPlayer = C_Item.IsItemConvertibleAndValidForPlayer(6948)
```

### C_Item.IsItemCorrupted

```lua
isCorrupted = C_Item.IsItemCorrupted(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCorrupted` | bool | no |  |

**Example**

```lua
local isCorrupted = C_Item.IsItemCorrupted(6948)
```

### C_Item.IsItemCorruptionRelated

```lua
isCorruptionRelated = C_Item.IsItemCorruptionRelated(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCorruptionRelated` | bool | no |  |

**Example**

```lua
local isCorruptionRelated = C_Item.IsItemCorruptionRelated(6948)
```

### C_Item.IsItemCorruptionResistant

```lua
isCorruptionResistant = C_Item.IsItemCorruptionResistant(itemLoc)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLoc` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCorruptionResistant` | bool | no |  |

**Example**

```lua
local isCorruptionResistant = C_Item.IsItemCorruptionResistant(6948)
```

### C_Item.IsItemDataCached

```lua
isCached = C_Item.IsItemDataCached(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCached` | bool | no |  |

**Example**

```lua
local isCached = C_Item.IsItemDataCached(6948)
```

### C_Item.IsItemDataCachedByID

```lua
isCached = C_Item.IsItemDataCachedByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCached` | bool | no |  |

**Example**

```lua
local isCached = C_Item.IsItemDataCachedByID(6948)
```

### C_Item.IsItemGUIDInInventory

```lua
valid = C_Item.IsItemGUIDInInventory(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example**

```lua
local valid = C_Item.IsItemGUIDInInventory("Creature-0-0000-0-0-0-0")
```

### C_Item.IsItemInRange

```lua
result = C_Item.IsItemInRange(itemInfo, targetToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `targetToken` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = C_Item.IsItemInRange(6948, "")
```

### C_Item.IsItemKeystoneByID

```lua
isKeystone = C_Item.IsItemKeystoneByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKeystone` | bool | no |  |

**Example**

```lua
local isKeystone = C_Item.IsItemKeystoneByID(6948)
```

### C_Item.IsItemSpecificToPlayerClass

```lua
isItemSpecificToPlayerClass = C_Item.IsItemSpecificToPlayerClass(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemSpecificToPlayerClass` | bool | no |  |

**Example**

```lua
local isItemSpecificToPlayerClass = C_Item.IsItemSpecificToPlayerClass(6948)
```

### C_Item.IsLocked

```lua
isLocked = C_Item.IsLocked(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocked` | bool | no |  |

**Example**

```lua
local isLocked = C_Item.IsLocked(6948)
```

### C_Item.IsRelicItem

Returns whether the item is a consumable relic  that can be applied to an artifact weapon.

```lua
result = C_Item.IsRelicItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = C_Item.IsRelicItem(6948)
```

### C_Item.IsUsableItem

```lua
usable, noMana = C_Item.IsUsableItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usable` | bool | no |  |
| `noMana` | bool | no |  |

**Example**

```lua
local usable, noMana = C_Item.IsUsableItem(6948)
```

### C_Item.ItemHasRange

```lua
result = C_Item.ItemHasRange(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_Item.ItemHasRange(6948)
```

### C_Item.LockItem

```lua
C_Item.LockItem(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Example**

```lua
C_Item.LockItem(6948)
```

### C_Item.LockItemByGUID

```lua
C_Item.LockItemByGUID(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Example**

```lua
C_Item.LockItemByGUID("Creature-0-0000-0-0-0-0")
```

### C_Item.PickupItem

```lua
C_Item.PickupItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Example**

```lua
C_Item.PickupItem(6948)
```

### C_Item.ReplaceEnchant

```lua
C_Item.ReplaceEnchant()
```

**Example**

```lua
C_Item.ReplaceEnchant()
```

### C_Item.ReplaceTradeEnchant

```lua
C_Item.ReplaceTradeEnchant()
```

**Example**

```lua
C_Item.ReplaceTradeEnchant()
```

### C_Item.ReplaceTradeskillEnchant

```lua
C_Item.ReplaceTradeskillEnchant()
```

**Example**

```lua
C_Item.ReplaceTradeskillEnchant()
```

### C_Item.RequestLoadItemData

```lua
C_Item.RequestLoadItemData(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Example**

```lua
C_Item.RequestLoadItemData(6948)
```

### C_Item.RequestLoadItemDataByID

```lua
C_Item.RequestLoadItemDataByID(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Example**

```lua
C_Item.RequestLoadItemDataByID(6948)
```

### C_Item.UnlockItem

```lua
C_Item.UnlockItem(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Example**

```lua
C_Item.UnlockItem(6948)
```

### C_Item.UnlockItemByGUID

```lua
C_Item.UnlockItemByGUID(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Example**

```lua
C_Item.UnlockItemByGUID("Creature-0-0000-0-0-0-0")
```

### C_Item.UseItemByName

```lua
C_Item.UseItemByName(itemInfo, [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |
| `target` | cstring | yes |  |

**Example**

```lua
C_Item.UseItemByName(6948)
```

## Events

### ACTION_WILL_BIND_ITEM

### BIND_ENCHANT

### CHARACTER_ITEM_FIXUP_NOTIFICATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixupVersion` | number | no |  |

### CONFIRM_BEFORE_USE

### CONVERT_TO_BIND_TO_ACCOUNT_CONFIRM

### DELETE_ITEM_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | cstring | no |  |
| `qualityID` | number | no |  |
| `bonding` | number | no |  |
| `questWarn` | number | no |  |
| `itemGUID` | WOWGUID | yes |  |

### END_BOUND_TRADEABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | cstring | no |  |

### GET_ITEM_INFO_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `success` | bool | no |  |

### ITEM_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previousHyperlink` | string | no |  |
| `newHyperlink` | string | no |  |

### ITEM_CONVERSION_DATA_READY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

### ITEM_COUNT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### ITEM_DATA_LOAD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `success` | bool | no |  |

### MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |

### REPLACE_ENCHANT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `existingStr` | cstring | no |  |
| `replacementStr` | cstring | no |  |

### REPLACE_TRADESKILL_ENCHANT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `existing` | cstring | no |  |
| `replacement` | cstring | no |  |

### TRADE_REPLACE_ENCHANT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `existing` | cstring | no |  |
| `replacement` | cstring | no |  |

### USE_BIND_CONFIRM

### USE_NO_REFUND_CONFIRM

### WEAPON_ENCHANT_CHANGED

## Types

### ItemInfoResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemName` | cstring | no |  |
| `itemLink` | cstring | no |  |
| `itemQuality` | ItemQuality | no |  |
| `itemLevel` | number | no |  |
| `itemMinLevel` | number | no |  |
| `itemType` | cstring | no |  |
| `itemSubType` | cstring | no |  |
| `itemStackCount` | number | no |  |
| `itemEquipLoc` | cstring | no |  |
| `itemTexture` | fileID | no |  |
| `sellPrice` | number | no |  |
| `classID` | number | no |  |
| `subclassID` | number | no |  |
| `bindType` | number | no |  |
| `expansionID` | number | no |  |
| `setID` | number | yes |  |
| `isCraftingReagent` | bool | no |  |
| `itemDescription` | cstring | no |  |

### ItemUpgradeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `maxItemLevel` | number | no |  |
| `trackString` | cstring | yes |  |
| `trackStringID` | number | yes |  |

### WeaponEnchantInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasEnchant` | bool | no |  |
| `enchantType` | ItemEnchantType | no |  |
| `timeLeft` | number | no |  |
| `charges` | number | no |  |
| `enchantID` | number | no |  |
| `enchantIconID` | number | no |  |

