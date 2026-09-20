# C_TooltipInfo

[← API index](../README.md) · group: [UI Systems & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**82** functions · **3** events · **0** types

## Functions

### C_TooltipInfo.GetAchievementByID

```lua
data = C_TooltipInfo.GetAchievementByID(achievementID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetAchievementByID(0)
```

### C_TooltipInfo.GetAction

```lua
data = C_TooltipInfo.GetAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetAction(1)
```

### C_TooltipInfo.GetArtifactItem

```lua
data = C_TooltipInfo.GetArtifactItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetArtifactItem()
```

### C_TooltipInfo.GetArtifactPowerByID

```lua
data = C_TooltipInfo.GetArtifactPowerByID(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetArtifactPowerByID(0)
```

### C_TooltipInfo.GetAzeriteEssence

```lua
data = C_TooltipInfo.GetAzeriteEssence(essenceID, [rank])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `essenceID` | number | no |  |
| `rank` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetAzeriteEssence(0)
```

### C_TooltipInfo.GetAzeriteEssenceSlot

```lua
data = C_TooltipInfo.GetAzeriteEssenceSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | AzeriteEssenceSlot | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetAzeriteEssenceSlot(1)
```

### C_TooltipInfo.GetAzeritePower

```lua
data = C_TooltipInfo.GetAzeritePower(itemID, itemLevel, powerID, [owningItemLink])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemLevel` | number | no |  |
| `powerID` | number | no |  |
| `owningItemLink` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetAzeritePower(6948, 6948, 0)
```

### C_TooltipInfo.GetBackpackToken

```lua
data = C_TooltipInfo.GetBackpackToken(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetBackpackToken(1)
```

### C_TooltipInfo.GetBagItem

```lua
data = C_TooltipInfo.GetBagItem(bagIndex, slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetBagItem(1, 1)
```

### C_TooltipInfo.GetBagItemChild

```lua
data = C_TooltipInfo.GetBagItemChild(bagIndex, slotIndex, equipSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bagIndex` | BagIndex | no |  |
| `slotIndex` | luaIndex | no |  |
| `equipSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetBagItemChild(1, 1, 1)
```

### C_TooltipInfo.GetBuybackItem

```lua
data = C_TooltipInfo.GetBuybackItem(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetBuybackItem(1)
```

### C_TooltipInfo.GetCompanionPet

```lua
data = C_TooltipInfo.GetCompanionPet(petGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetCompanionPet(UnitGUID("player"))
```

### C_TooltipInfo.GetConduit

```lua
data = C_TooltipInfo.GetConduit(conduitID, conduitRank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `conduitRank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetConduit(0, 1)
```

### C_TooltipInfo.GetCurrencyByID

```lua
data = C_TooltipInfo.GetCurrencyByID(currencyID, [amount])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `amount` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetCurrencyByID(0)
```

### C_TooltipInfo.GetCurrencyToken

```lua
data = C_TooltipInfo.GetCurrencyToken(tokenIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tokenIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetCurrencyToken(1)
```

### C_TooltipInfo.GetEnhancedConduit

```lua
data = C_TooltipInfo.GetEnhancedConduit(conduitID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `conduitID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetEnhancedConduit(0, 1)
```

### C_TooltipInfo.GetEquipmentSet

```lua
data = C_TooltipInfo.GetEquipmentSet(setID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetEquipmentSet(0)
```

### C_TooltipInfo.GetExistingSocketGem

```lua
data = C_TooltipInfo.GetExistingSocketGem(index, [toDestroy])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `toDestroy` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetExistingSocketGem(1)
```

### C_TooltipInfo.GetGuildBankItem

```lua
data = C_TooltipInfo.GetGuildBankItem(tab, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tab` | luaIndex | no |  |
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetGuildBankItem(1, 1)
```

### C_TooltipInfo.GetHeirloomByItemID

```lua
data = C_TooltipInfo.GetHeirloomByItemID(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetHeirloomByItemID(6948)
```

### C_TooltipInfo.GetHyperlink

```lua
data = C_TooltipInfo.GetHyperlink(hyperlink, [optionalArg1], [optionalArg2], [hideVendorPrice])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | cstring | no |  |
| `optionalArg1` | number | yes |  |
| `optionalArg2` | number | yes |  |
| `hideVendorPrice` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetHyperlink("")
```

### C_TooltipInfo.GetInboxItem

```lua
data = C_TooltipInfo.GetInboxItem(messageIndex, [attachmentIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageIndex` | luaIndex | no |  |
| `attachmentIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetInboxItem(1)
```

### C_TooltipInfo.GetInstanceLockEncountersComplete

```lua
data = C_TooltipInfo.GetInstanceLockEncountersComplete(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetInstanceLockEncountersComplete(1)
```

### C_TooltipInfo.GetInventoryItem

```lua
data = C_TooltipInfo.GetInventoryItem(unit, slot, [hideUselessStats])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `slot` | luaIndex | no |  |
| `hideUselessStats` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetInventoryItem("player", 1)
```

### C_TooltipInfo.GetInventoryItemByID

```lua
data = C_TooltipInfo.GetInventoryItemByID(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetInventoryItemByID(6948)
```

### C_TooltipInfo.GetItemByGUID

```lua
data = C_TooltipInfo.GetItemByGUID(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetItemByGUID(UnitGUID("player"))
```

### C_TooltipInfo.GetItemByID

```lua
data = C_TooltipInfo.GetItemByID(itemID, [quality], [itemContext], [treasureContextLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `quality` | number | yes |  |
| `itemContext` | number | yes |  |
| `treasureContextLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetItemByID(6948)
```

### C_TooltipInfo.GetItemByItemModifiedAppearanceID

```lua
data = C_TooltipInfo.GetItemByItemModifiedAppearanceID(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetItemByItemModifiedAppearanceID(6948)
```

### C_TooltipInfo.GetItemInteractionItem

```lua
data = C_TooltipInfo.GetItemInteractionItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetItemInteractionItem()
```

### C_TooltipInfo.GetItemKey

```lua
data = C_TooltipInfo.GetItemKey(itemID, itemLevel, itemSuffix, [requiredLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemLevel` | number | no |  |
| `itemSuffix` | number | no |  |
| `requiredLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetItemKey(6948, 6948, 6948)
```

### C_TooltipInfo.GetLFGDungeonReward

```lua
data = C_TooltipInfo.GetLFGDungeonReward(dungeonID, lootIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number | no |  |
| `lootIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetLFGDungeonReward(0, 1)
```

### C_TooltipInfo.GetLFGDungeonShortageReward

```lua
data = C_TooltipInfo.GetLFGDungeonShortageReward(dungeonID, shortageSeverity, lootIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number | no |  |
| `shortageSeverity` | luaIndex | no |  |
| `lootIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetLFGDungeonShortageReward(0, 1, 1)
```

### C_TooltipInfo.GetLootCurrency

```lua
data = C_TooltipInfo.GetLootCurrency(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetLootCurrency(1)
```

### C_TooltipInfo.GetLootItem

```lua
data = C_TooltipInfo.GetLootItem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetLootItem(1)
```

### C_TooltipInfo.GetLootRollItem

```lua
data = C_TooltipInfo.GetLootRollItem(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetLootRollItem(0)
```

### C_TooltipInfo.GetMerchantCostItem

```lua
data = C_TooltipInfo.GetMerchantCostItem(slot, costIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |
| `costIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetMerchantCostItem(1, 1)
```

### C_TooltipInfo.GetMerchantItem

```lua
data = C_TooltipInfo.GetMerchantItem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetMerchantItem(1)
```

### C_TooltipInfo.GetMinimapMouseover

```lua
data = C_TooltipInfo.GetMinimapMouseover()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetMinimapMouseover()
```

### C_TooltipInfo.GetMountBySpellID

```lua
data = C_TooltipInfo.GetMountBySpellID(spellID, [checkIndoors])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |
| `checkIndoors` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetMountBySpellID(2050)
```

### C_TooltipInfo.GetOutfit

```lua
data = C_TooltipInfo.GetOutfit(outfitID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outfitID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetOutfit(0)
```

### C_TooltipInfo.GetOwnedItemByID

```lua
data = C_TooltipInfo.GetOwnedItemByID(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetOwnedItemByID(6948)
```

### C_TooltipInfo.GetPetAction

```lua
data = C_TooltipInfo.GetPetAction(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetPetAction(1)
```

### C_TooltipInfo.GetPossession

```lua
data = C_TooltipInfo.GetPossession(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetPossession(1)
```

### C_TooltipInfo.GetPvpBrawl

```lua
data = C_TooltipInfo.GetPvpBrawl([isSpecial])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpecial` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetPvpBrawl()
```

### C_TooltipInfo.GetPvpTalent

```lua
data = C_TooltipInfo.GetPvpTalent(talentID, [isInspect], [groupIndex], [talentIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `isInspect` | bool | yes |  |
| `groupIndex` | luaIndex | yes |  |
| `talentIndex` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetPvpTalent(0)
```

### C_TooltipInfo.GetQuestCurrency

```lua
data = C_TooltipInfo.GetQuestCurrency(type, currencyIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |
| `currencyIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestCurrency("", 1)
```

### C_TooltipInfo.GetQuestItem

```lua
data = C_TooltipInfo.GetQuestItem(type, itemIndex, [allowCollectionText])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |
| `itemIndex` | luaIndex | no |  |
| `allowCollectionText` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestItem("", 1)
```

### C_TooltipInfo.GetQuestLogCurrency

```lua
data = C_TooltipInfo.GetQuestLogCurrency(type, currencyIndex, [questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |
| `currencyIndex` | luaIndex | no |  |
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestLogCurrency("", 1)
```

### C_TooltipInfo.GetQuestLogItem

```lua
data = C_TooltipInfo.GetQuestLogItem(type, itemIndex, [questID], [allowCollectionText])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |
| `itemIndex` | luaIndex | no |  |
| `questID` | number | yes |  |
| `allowCollectionText` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestLogItem("", 1)
```

### C_TooltipInfo.GetQuestLogSpecialItem

```lua
data = C_TooltipInfo.GetQuestLogSpecialItem(questIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestLogSpecialItem(1)
```

### C_TooltipInfo.GetQuestPartyProgress

```lua
data = C_TooltipInfo.GetQuestPartyProgress(questID, [omitTitle], [ignoreActivePlayer])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `omitTitle` | bool | yes |  |
| `ignoreActivePlayer` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetQuestPartyProgress(0)
```

### C_TooltipInfo.GetRecipeRankInfo

```lua
data = C_TooltipInfo.GetRecipeRankInfo(recipeID, rank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `rank` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetRecipeRankInfo(0, 1)
```

### C_TooltipInfo.GetRecipeReagentItem

```lua
data = C_TooltipInfo.GetRecipeReagentItem(recipeSpellID, dataSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `dataSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetRecipeReagentItem(2050, 1)
```

### C_TooltipInfo.GetRecipeResultItem

```lua
data = C_TooltipInfo.GetRecipeResultItem(recipeID, [reagentInfos], [recraftItemGUID], [recipeLevel], [overrideQualityID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `reagentInfos` | CraftingReagentInfo[] | yes |  |
| `recraftItemGUID` | WOWGUID | yes |  |
| `recipeLevel` | luaIndex | yes |  |
| `overrideQualityID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetRecipeResultItem(0)
```

### C_TooltipInfo.GetRecipeResultItemForOrder

```lua
data = C_TooltipInfo.GetRecipeResultItemForOrder(recipeID, [reagentInfos], [orderID], [recipeLevel], [overrideQualityID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `reagentInfos` | CraftingReagentInfo[] | yes |  |
| `orderID` | BigUInteger | yes |  |
| `recipeLevel` | luaIndex | yes |  |
| `overrideQualityID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetRecipeResultItemForOrder(0)
```

### C_TooltipInfo.GetRuneforgeResultItem

```lua
data = C_TooltipInfo.GetRuneforgeResultItem(itemGUID, itemLevel, [powerID], [modifiers])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |
| `itemLevel` | number | no |  |
| `powerID` | number | yes |  |
| `modifiers` | number[] | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetRuneforgeResultItem(UnitGUID("player"), 6948)
```

### C_TooltipInfo.GetSendMailItem

```lua
data = C_TooltipInfo.GetSendMailItem([attachmentIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attachmentIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSendMailItem()
```

### C_TooltipInfo.GetShapeshift

```lua
data = C_TooltipInfo.GetShapeshift(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetShapeshift(1)
```

### C_TooltipInfo.GetSlottedKeystone

```lua
data = C_TooltipInfo.GetSlottedKeystone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSlottedKeystone()
```

### C_TooltipInfo.GetSocketedItem

```lua
data = C_TooltipInfo.GetSocketedItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSocketedItem()
```

### C_TooltipInfo.GetSocketedRelic

```lua
data = C_TooltipInfo.GetSocketedRelic(slotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSocketedRelic(1)
```

### C_TooltipInfo.GetSocketGem

```lua
data = C_TooltipInfo.GetSocketGem(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSocketGem(1)
```

### C_TooltipInfo.GetSpellBookItem

```lua
data = C_TooltipInfo.GetSpellBookItem(spellBookItemSlotIndex, spellBookItemSpellBank)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellBookItemSlotIndex` | luaIndex | no |  |
| `spellBookItemSpellBank` | SpellBookSpellBank | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSpellBookItem(1, 2050)
```

### C_TooltipInfo.GetSpellByID

```lua
data = C_TooltipInfo.GetSpellByID(spellID, [isPet], [showSubtext], [dontOverride], [difficultyID], [isLink])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |
| `isPet` | bool | yes |  |
| `showSubtext` | bool | yes |  |
| `dontOverride` | bool | yes |  |
| `difficultyID` | number | yes |  |
| `isLink` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetSpellByID(2050)
```

### C_TooltipInfo.GetTalent

```lua
data = C_TooltipInfo.GetTalent(talentID, [isInspect], [groupIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `isInspect` | bool | yes |  |
| `groupIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTalent(0)
```

### C_TooltipInfo.GetTotem

```lua
data = C_TooltipInfo.GetTotem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTotem(1)
```

### C_TooltipInfo.GetToyByItemID

```lua
data = C_TooltipInfo.GetToyByItemID(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetToyByItemID(6948)
```

### C_TooltipInfo.GetTradePlayerItem

```lua
data = C_TooltipInfo.GetTradePlayerItem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTradePlayerItem(1)
```

### C_TooltipInfo.GetTradeTargetItem

```lua
data = C_TooltipInfo.GetTradeTargetItem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTradeTargetItem(1)
```

### C_TooltipInfo.GetTrainerService

```lua
data = C_TooltipInfo.GetTrainerService(serviceIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serviceIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTrainerService(1)
```

### C_TooltipInfo.GetTraitEntry

```lua
data = C_TooltipInfo.GetTraitEntry(entryID, [rank])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |
| `rank` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetTraitEntry(0)
```

### C_TooltipInfo.GetUnit

```lua
data = C_TooltipInfo.GetUnit(unit, [hideStatus])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `hideStatus` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnit("player")
```

### C_TooltipInfo.GetUnitAura

```lua
data = C_TooltipInfo.GetUnitAura(unitToken, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitAura("player", 1)
```

### C_TooltipInfo.GetUnitAuraByAuraInstanceID

Obtains aura info like other functions with the caveat that the filters will always at least include the typically mutually exclusive HELPFUL\|HARMFUL regardless of what the argument value is set to

```lua
data = C_TooltipInfo.GetUnitAuraByAuraInstanceID(unitToken, auraInstanceID, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitAuraByAuraInstanceID("player", 0)
```

### C_TooltipInfo.GetUnitBuff

```lua
data = C_TooltipInfo.GetUnitBuff(unitToken, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitBuff("player", 1)
```

### C_TooltipInfo.GetUnitBuffByAuraInstanceID

```lua
data = C_TooltipInfo.GetUnitBuffByAuraInstanceID(unitToken, auraInstanceID, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitBuffByAuraInstanceID("player", 0)
```

### C_TooltipInfo.GetUnitDebuff

```lua
data = C_TooltipInfo.GetUnitDebuff(unitToken, index, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `index` | luaIndex | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitDebuff("player", 1)
```

### C_TooltipInfo.GetUnitDebuffByAuraInstanceID

```lua
data = C_TooltipInfo.GetUnitDebuffByAuraInstanceID(unitToken, auraInstanceID, [filter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenRestrictedForAddOns | no |  |
| `auraInstanceID` | number | no |  |
| `filter` | AuraFilters | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUnitDebuffByAuraInstanceID("player", 0)
```

### C_TooltipInfo.GetUpgradeItem

```lua
data = C_TooltipInfo.GetUpgradeItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetUpgradeItem()
```

### C_TooltipInfo.GetWeeklyReward

```lua
data = C_TooltipInfo.GetWeeklyReward(itemDBID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemDBID` | WeeklyRewardItemDBID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetWeeklyReward(6948)
```

### C_TooltipInfo.GetWorldCursor

```lua
data = C_TooltipInfo.GetWorldCursor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetWorldCursor()
```

### C_TooltipInfo.GetWorldLootObject

```lua
data = C_TooltipInfo.GetWorldLootObject(unitTokenString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTokenString` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | TooltipData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_TooltipInfo.GetWorldLootObject("player")
```

## Events

### HIDE_HYPERLINK_TOOLTIP

### SHOW_HYPERLINK_TOOLTIP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | string | no |  |

### TOOLTIP_DATA_UPDATE

Sends an update to the UI that a sparse or cache lookup has resolved

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dataInstanceID` | number | yes |  |

