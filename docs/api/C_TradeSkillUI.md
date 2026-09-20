# C_TradeSkillUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**89** functions · **20** events · **0** types

## Functions

### C_TradeSkillUI.CancelProfessionRespec

```lua
C_TradeSkillUI.CancelProfessionRespec()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.CancelProfessionRespec()
```

### C_TradeSkillUI.CanStoreEnchantInItem

```lua
canStore = C_TradeSkillUI.CanStoreEnchantInItem(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canStore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canStore = C_TradeSkillUI.CanStoreEnchantInItem(UnitGUID("player"))
```

### C_TradeSkillUI.CanTradeSkillShowCraftingUI

```lua
canShow = C_TradeSkillUI.CanTradeSkillShowCraftingUI(tradeSkillSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tradeSkillSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canShow = C_TradeSkillUI.CanTradeSkillShowCraftingUI(2050)
```

### C_TradeSkillUI.CheckRespecNPC

```lua
canInteract = C_TradeSkillUI.CheckRespecNPC()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canInteract` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canInteract = C_TradeSkillUI.CheckRespecNPC()
```

### C_TradeSkillUI.CloseTradeSkill

```lua
C_TradeSkillUI.CloseTradeSkill()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.CloseTradeSkill()
```

### C_TradeSkillUI.ConfirmProfessionRespec

```lua
C_TradeSkillUI.ConfirmProfessionRespec()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.ConfirmProfessionRespec()
```

### C_TradeSkillUI.CraftEnchant

```lua
C_TradeSkillUI.CraftEnchant(recipeSpellID, numCasts, [craftingReagents], [itemTarget], [applyConcentration])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `numCasts` | number | no | (default: 1) |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |
| `itemTarget` | ItemLocation | yes |  |
| `applyConcentration` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.CraftEnchant(2050, 0)
```

### C_TradeSkillUI.CraftRecipe

```lua
C_TradeSkillUI.CraftRecipe(recipeSpellID, numCasts, [craftingReagents], [recipeLevel], [orderID], [applyConcentration])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `numCasts` | number | no | (default: 1) |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |
| `recipeLevel` | luaIndex | yes |  |
| `orderID` | BigUInteger | yes |  |
| `applyConcentration` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.CraftRecipe(2050, 0)
```

### C_TradeSkillUI.CraftSalvage

```lua
C_TradeSkillUI.CraftSalvage(recipeSpellID, numCasts, itemTarget, [craftingReagents], [applyConcentration])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `numCasts` | number | no | (default: 1) |
| `itemTarget` | ItemLocation | no |  |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |
| `applyConcentration` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.CraftSalvage(2050, 0, 6948)
```

### C_TradeSkillUI.DoesRecraftingRecipeAcceptItem

```lua
result = C_TradeSkillUI.DoesRecraftingRecipeAcceptItem(itemLocation, recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.DoesRecraftingRecipeAcceptItem(6948, 0)
```

### C_TradeSkillUI.GetAllProfessionTradeSkillLines

```lua
skillLineID = C_TradeSkillUI.GetAllProfessionTradeSkillLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineID = C_TradeSkillUI.GetAllProfessionTradeSkillLines()
```

### C_TradeSkillUI.GetBaseProfessionInfo

```lua
info = C_TradeSkillUI.GetBaseProfessionInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ProfessionInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetBaseProfessionInfo()
```

### C_TradeSkillUI.GetChildProfessionInfo

```lua
info = C_TradeSkillUI.GetChildProfessionInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ProfessionInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetChildProfessionInfo()
```

### C_TradeSkillUI.GetChildProfessionInfos

```lua
infos = C_TradeSkillUI.GetChildProfessionInfos()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infos` | ProfessionInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infos = C_TradeSkillUI.GetChildProfessionInfos()
```

### C_TradeSkillUI.GetConcentrationCurrencyID

```lua
currencyType = C_TradeSkillUI.GetConcentrationCurrencyID(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencyType = C_TradeSkillUI.GetConcentrationCurrencyID(0)
```

### C_TradeSkillUI.GetCraftableCount

```lua
numAvailable = C_TradeSkillUI.GetCraftableCount(recipeSpellID, [recipeLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `recipeLevel` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numAvailable` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numAvailable = C_TradeSkillUI.GetCraftableCount(2050)
```

### C_TradeSkillUI.GetCraftingOperationInfo

```lua
info = C_TradeSkillUI.GetCraftingOperationInfo(recipeID, craftingReagents, [allocationItemGUID], applyConcentration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `craftingReagents` | CraftingReagentInfo[] | no |  |
| `allocationItemGUID` | WOWGUID | yes |  |
| `applyConcentration` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingOperationInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetCraftingOperationInfo(0, craftingReagents, false)
```

### C_TradeSkillUI.GetCraftingOperationInfoForOrder

```lua
info = C_TradeSkillUI.GetCraftingOperationInfoForOrder(recipeID, craftingReagents, orderID, applyConcentration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `craftingReagents` | CraftingReagentInfo[] | no |  |
| `orderID` | BigUInteger | no |  |
| `applyConcentration` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingOperationInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetCraftingOperationInfoForOrder(0, craftingReagents, orderID, false)
```

### C_TradeSkillUI.GetCraftingReagentBonusText

```lua
bonusText = C_TradeSkillUI.GetCraftingReagentBonusText(recipeSpellID, craftingReagentIndex, craftingReagents, [allocationItemGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `craftingReagentIndex` | luaIndex | no |  |
| `craftingReagents` | CraftingReagentInfo[] | no |  |
| `allocationItemGUID` | WOWGUID | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusText` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bonusText = C_TradeSkillUI.GetCraftingReagentBonusText(2050, 1, craftingReagents)
```

### C_TradeSkillUI.GetCraftingTargetItems

```lua
items = C_TradeSkillUI.GetCraftingTargetItems(itemIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `items` | CraftingTargetItem[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local items = C_TradeSkillUI.GetCraftingTargetItems(6948)
```

### C_TradeSkillUI.GetDependentReagents

```lua
reagents = C_TradeSkillUI.GetDependentReagents(reagent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reagent` | CraftingReagent | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reagents` | CraftingReagent[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reagents = C_TradeSkillUI.GetDependentReagents(reagent)
```

### C_TradeSkillUI.GetEnchantItems

```lua
items = C_TradeSkillUI.GetEnchantItems(recipeID, [craftingReagents])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `items` | WOWGUID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local items = C_TradeSkillUI.GetEnchantItems(0)
```

### C_TradeSkillUI.GetFactionSpecificOutputItem

```lua
itemID = C_TradeSkillUI.GetFactionSpecificOutputItem(recipeSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID = C_TradeSkillUI.GetFactionSpecificOutputItem(2050)
```

### C_TradeSkillUI.GetGatheringOperationInfo

```lua
info = C_TradeSkillUI.GetGatheringOperationInfo(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GatheringOperationInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetGatheringOperationInfo(0)
```

### C_TradeSkillUI.GetHideUnownedFlags

```lua
cannotModifyHideUnowned, alwaysShowUnowned = C_TradeSkillUI.GetHideUnownedFlags(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cannotModifyHideUnowned` | bool | no |  |
| `alwaysShowUnowned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cannotModifyHideUnowned, alwaysShowUnowned = C_TradeSkillUI.GetHideUnownedFlags(0)
```

### C_TradeSkillUI.GetItemCraftedQualityByItemInfo

```lua
quality = C_TradeSkillUI.GetItemCraftedQualityByItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local quality = C_TradeSkillUI.GetItemCraftedQualityByItemInfo(6948)
```

### C_TradeSkillUI.GetItemCraftedQualityInfo

```lua
info = C_TradeSkillUI.GetItemCraftedQualityInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingQualityInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetItemCraftedQualityInfo(6948)
```

### C_TradeSkillUI.GetItemReagentQualityByItemInfo

```lua
quality = C_TradeSkillUI.GetItemReagentQualityByItemInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local quality = C_TradeSkillUI.GetItemReagentQualityByItemInfo(6948)
```

### C_TradeSkillUI.GetItemReagentQualityInfo

```lua
info = C_TradeSkillUI.GetItemReagentQualityInfo(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingQualityInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetItemReagentQualityInfo(6948)
```

### C_TradeSkillUI.GetItemSlotModifications

```lua
slotMods = C_TradeSkillUI.GetItemSlotModifications(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotMods` | CraftingItemSlotModification[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotMods = C_TradeSkillUI.GetItemSlotModifications(UnitGUID("player"))
```

### C_TradeSkillUI.GetItemSlotModificationsForOrder

```lua
slotMods = C_TradeSkillUI.GetItemSlotModificationsForOrder(orderID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotMods` | CraftingItemSlotModification[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotMods = C_TradeSkillUI.GetItemSlotModificationsForOrder(orderID)
```

### C_TradeSkillUI.GetOriginalCraftRecipeID

```lua
recipeID, skillLineAbilityID = C_TradeSkillUI.GetOriginalCraftRecipeID(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | yes |  |
| `skillLineAbilityID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recipeID, skillLineAbilityID = C_TradeSkillUI.GetOriginalCraftRecipeID(UnitGUID("player"))
```

### C_TradeSkillUI.GetProfessionByInventorySlot

```lua
profession = C_TradeSkillUI.GetProfessionByInventorySlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local profession = C_TradeSkillUI.GetProfessionByInventorySlot(1)
```

### C_TradeSkillUI.GetProfessionChildSkillLineID

```lua
skillLineID = C_TradeSkillUI.GetProfessionChildSkillLineID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineID = C_TradeSkillUI.GetProfessionChildSkillLineID()
```

### C_TradeSkillUI.GetProfessionForCursorItem

```lua
profession = C_TradeSkillUI.GetProfessionForCursorItem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local profession = C_TradeSkillUI.GetProfessionForCursorItem()
```

### C_TradeSkillUI.GetProfessionInfoByRecipeID

```lua
info = C_TradeSkillUI.GetProfessionInfoByRecipeID(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ProfessionInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetProfessionInfoByRecipeID(0)
```

### C_TradeSkillUI.GetProfessionInfoBySkillLineID

```lua
info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ProfessionInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetProfessionInfoBySkillLineID(0)
```

### C_TradeSkillUI.GetProfessionInventorySlots

```lua
invSlots = C_TradeSkillUI.GetProfessionInventorySlots()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlots` | InventorySlots[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invSlots = C_TradeSkillUI.GetProfessionInventorySlots()
```

### C_TradeSkillUI.GetProfessionNameForSkillLineAbility

```lua
professionNmae = C_TradeSkillUI.GetProfessionNameForSkillLineAbility(skillLineAbilityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAbilityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `professionNmae` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local professionNmae = C_TradeSkillUI.GetProfessionNameForSkillLineAbility(0)
```

### C_TradeSkillUI.GetProfessionSkillLineID

```lua
skillLineID = C_TradeSkillUI.GetProfessionSkillLineID(profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineID = C_TradeSkillUI.GetProfessionSkillLineID(profession)
```

### C_TradeSkillUI.GetProfessionSlots

```lua
slots = C_TradeSkillUI.GetProfessionSlots(profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slots = C_TradeSkillUI.GetProfessionSlots(profession)
```

### C_TradeSkillUI.GetProfessionSpells

```lua
knownSpells = C_TradeSkillUI.GetProfessionSpells(professionID, [skillLineID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `professionID` | number | no |  |
| `skillLineID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `knownSpells` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local knownSpells = C_TradeSkillUI.GetProfessionSpells(0)
```

### C_TradeSkillUI.GetQualitiesForRecipe

```lua
qualityIDs = C_TradeSkillUI.GetQualitiesForRecipe(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `qualityIDs` | number[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local qualityIDs = C_TradeSkillUI.GetQualitiesForRecipe(0)
```

### C_TradeSkillUI.GetReagentDifficultyText

```lua
bonusText = C_TradeSkillUI.GetReagentDifficultyText(craftingReagentIndex, craftingReagents)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `craftingReagentIndex` | luaIndex | no |  |
| `craftingReagents` | CraftingReagentInfo[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusText` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bonusText = C_TradeSkillUI.GetReagentDifficultyText(1, craftingReagents)
```

### C_TradeSkillUI.GetReagentSlotStatus

```lua
locked, lockedReason = C_TradeSkillUI.GetReagentSlotStatus(mcrSlotID, recipeSpellID, skillLineAbilityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mcrSlotID` | number | no |  |
| `recipeSpellID` | number | no |  |
| `skillLineAbilityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locked` | bool | no |  |
| `lockedReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local locked, lockedReason = C_TradeSkillUI.GetReagentSlotStatus(1, 2050, 0)
```

### C_TradeSkillUI.GetRecipeDescription

```lua
description = C_TradeSkillUI.GetRecipeDescription(recipeID, craftingReagents, [allocationItemGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `craftingReagents` | CraftingReagentInfo[] | no |  |
| `allocationItemGUID` | WOWGUID | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_TradeSkillUI.GetRecipeDescription(0, craftingReagents)
```

### C_TradeSkillUI.GetRecipeInfo

```lua
recipeInfo = C_TradeSkillUI.GetRecipeInfo(recipeSpellID, [recipeLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `recipeLevel` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeInfo` | TradeSkillRecipeInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recipeInfo = C_TradeSkillUI.GetRecipeInfo(2050)
```

### C_TradeSkillUI.GetRecipeInfoForSkillLineAbility

```lua
recipeInfo = C_TradeSkillUI.GetRecipeInfoForSkillLineAbility(skillLineAbilityID, [recipeLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAbilityID` | number | no |  |
| `recipeLevel` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeInfo` | TradeSkillRecipeInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recipeInfo = C_TradeSkillUI.GetRecipeInfoForSkillLineAbility(0)
```

### C_TradeSkillUI.GetRecipeItemQualityInfo

```lua
info = C_TradeSkillUI.GetRecipeItemQualityInfo(recipeID, quality)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `quality` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingQualityInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_TradeSkillUI.GetRecipeItemQualityInfo(0, 0)
```

### C_TradeSkillUI.GetRecipeOutputItemData

```lua
outputInfo = C_TradeSkillUI.GetRecipeOutputItemData(recipeSpellID, [reagents], [allocationItemGUID], [overrideQualityID], [recraftOrderID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `reagents` | CraftingReagentInfo[] | yes |  |
| `allocationItemGUID` | WOWGUID | yes |  |
| `overrideQualityID` | number | yes |  |
| `recraftOrderID` | BigUInteger | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outputInfo` | CraftingRecipeOutputInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local outputInfo = C_TradeSkillUI.GetRecipeOutputItemData(2050)
```

### C_TradeSkillUI.GetRecipeQualityItemIDs

```lua
qualityItemIDs = C_TradeSkillUI.GetRecipeQualityItemIDs(recipeSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `qualityItemIDs` | number[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local qualityItemIDs = C_TradeSkillUI.GetRecipeQualityItemIDs(2050)
```

### C_TradeSkillUI.GetRecipeQualityReagentLink

```lua
link = C_TradeSkillUI.GetRecipeQualityReagentLink(recipeID, dataSlotIndex, qualityIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `dataSlotIndex` | luaIndex | no |  |
| `qualityIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local link = C_TradeSkillUI.GetRecipeQualityReagentLink(0, 1, 1)
```

### C_TradeSkillUI.GetRecipeRequirements

```lua
requirements = C_TradeSkillUI.GetRecipeRequirements(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requirements` | CraftingRecipeRequirement[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requirements = C_TradeSkillUI.GetRecipeRequirements(0)
```

### C_TradeSkillUI.GetRecipeSchematic

```lua
schematic = C_TradeSkillUI.GetRecipeSchematic(recipeSpellID, isRecraft, [recipeLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |
| `isRecraft` | bool | no |  |
| `recipeLevel` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `schematic` | CraftingRecipeSchematic | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local schematic = C_TradeSkillUI.GetRecipeSchematic(2050, false)
```

### C_TradeSkillUI.GetRecipesTracked

```lua
recipeIDs = C_TradeSkillUI.GetRecipesTracked(isRecraft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecraft` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recipeIDs = C_TradeSkillUI.GetRecipesTracked(false)
```

### C_TradeSkillUI.GetRecraftItems

```lua
items = C_TradeSkillUI.GetRecraftItems([recipeID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `items` | WOWGUID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local items = C_TradeSkillUI.GetRecraftItems()
```

### C_TradeSkillUI.GetRecraftRemovalWarnings

```lua
warnings = C_TradeSkillUI.GetRecraftRemovalWarnings(itemGUID, replacedReagents)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |
| `replacedReagents` | CraftingReagent[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warnings` | cstring[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warnings = C_TradeSkillUI.GetRecraftRemovalWarnings(UnitGUID("player"), replacedReagents)
```

### C_TradeSkillUI.GetRemainingRecasts

```lua
remaining = C_TradeSkillUI.GetRemainingRecasts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `remaining` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local remaining = C_TradeSkillUI.GetRemainingRecasts()
```

### C_TradeSkillUI.GetSalvagableItemIDs

```lua
itemIDs = C_TradeSkillUI.GetSalvagableItemIDs(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemIDs = C_TradeSkillUI.GetSalvagableItemIDs(0)
```

### C_TradeSkillUI.GetShowLearned

```lua
flag = C_TradeSkillUI.GetShowLearned()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flag = C_TradeSkillUI.GetShowLearned()
```

### C_TradeSkillUI.GetShowUnlearned

```lua
flag = C_TradeSkillUI.GetShowUnlearned()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flag = C_TradeSkillUI.GetShowUnlearned()
```

### C_TradeSkillUI.GetSkillLineForGear

```lua
skillLineID = C_TradeSkillUI.GetSkillLineForGear(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineID = C_TradeSkillUI.GetSkillLineForGear(6948)
```

### C_TradeSkillUI.GetSourceTypeFilter

```lua
sourceTypeFilter = C_TradeSkillUI.GetSourceTypeFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceTypeFilter` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sourceTypeFilter = C_TradeSkillUI.GetSourceTypeFilter()
```

### C_TradeSkillUI.GetTradeSkillDisplayName

```lua
professionDisplayName = C_TradeSkillUI.GetTradeSkillDisplayName(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `professionDisplayName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local professionDisplayName = C_TradeSkillUI.GetTradeSkillDisplayName(0)
```

### C_TradeSkillUI.HasFavoriteOrderRecipes

```lua
hasFavorites = C_TradeSkillUI.HasFavoriteOrderRecipes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFavorites` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasFavorites = C_TradeSkillUI.HasFavoriteOrderRecipes()
```

### C_TradeSkillUI.IsEnchantTargetValid

```lua
valid = C_TradeSkillUI.IsEnchantTargetValid(recipeID, itemGUID, [craftingReagents])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `itemGUID` | WOWGUID | no |  |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_TradeSkillUI.IsEnchantTargetValid(0, UnitGUID("player"))
```

### C_TradeSkillUI.IsGuildTradeSkillsEnabled

```lua
enabled = C_TradeSkillUI.IsGuildTradeSkillsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_TradeSkillUI.IsGuildTradeSkillsEnabled()
```

### C_TradeSkillUI.IsNearProfessionSpellFocus

```lua
nearFocus = C_TradeSkillUI.IsNearProfessionSpellFocus(profession)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profession` | Profession | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nearFocus` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nearFocus = C_TradeSkillUI.IsNearProfessionSpellFocus(profession)
```

### C_TradeSkillUI.IsNPCCrafting

```lua
result = C_TradeSkillUI.IsNPCCrafting()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.IsNPCCrafting()
```

### C_TradeSkillUI.IsOriginalCraftRecipeLearned

```lua
learned = C_TradeSkillUI.IsOriginalCraftRecipeLearned(itemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `learned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local learned = C_TradeSkillUI.IsOriginalCraftRecipeLearned(UnitGUID("player"))
```

### C_TradeSkillUI.IsRecipeFirstCraft

```lua
result = C_TradeSkillUI.IsRecipeFirstCraft(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.IsRecipeFirstCraft(0)
```

### C_TradeSkillUI.IsRecipeInBaseSkillLine

```lua
result = C_TradeSkillUI.IsRecipeInBaseSkillLine(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.IsRecipeInBaseSkillLine(0)
```

### C_TradeSkillUI.IsRecipeInSkillLine

```lua
result = C_TradeSkillUI.IsRecipeInSkillLine(recipeID, skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.IsRecipeInSkillLine(0, 0)
```

### C_TradeSkillUI.IsRecipeProfessionLearned

```lua
recipeProfessionLearned = C_TradeSkillUI.IsRecipeProfessionLearned(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeProfessionLearned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recipeProfessionLearned = C_TradeSkillUI.IsRecipeProfessionLearned(0)
```

### C_TradeSkillUI.IsRecipeTracked

```lua
tracked = C_TradeSkillUI.IsRecipeTracked(recipeID, isRecraft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `isRecraft` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tracked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tracked = C_TradeSkillUI.IsRecipeTracked(0, false)
```

### C_TradeSkillUI.IsRecraftItemEquipped

```lua
isEquipped = C_TradeSkillUI.IsRecraftItemEquipped(recraftItemGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recraftItemGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEquipped` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEquipped = C_TradeSkillUI.IsRecraftItemEquipped(UnitGUID("player"))
```

### C_TradeSkillUI.IsRecraftReagentValid

```lua
valid = C_TradeSkillUI.IsRecraftReagentValid(itemGUID, reagent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |
| `reagent` | CraftingReagent | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local valid = C_TradeSkillUI.IsRecraftReagentValid(UnitGUID("player"), reagent)
```

### C_TradeSkillUI.IsRuneforging

```lua
result = C_TradeSkillUI.IsRuneforging()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.IsRuneforging()
```

### C_TradeSkillUI.OpenRecipe

```lua
C_TradeSkillUI.OpenRecipe(recipeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.OpenRecipe(0)
```

### C_TradeSkillUI.OpenTradeSkill

```lua
opened = C_TradeSkillUI.OpenTradeSkill(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `opened` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local opened = C_TradeSkillUI.OpenTradeSkill(0)
```

### C_TradeSkillUI.RecraftLimitCategoryValid

```lua
recraftValid = C_TradeSkillUI.RecraftLimitCategoryValid(reagent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reagent` | CraftingReagent | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recraftValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recraftValid = C_TradeSkillUI.RecraftLimitCategoryValid(reagent)
```

### C_TradeSkillUI.RecraftRecipe

```lua
result = C_TradeSkillUI.RecraftRecipe(itemGUID, [craftingReagents], [removedModifications], [applyConcentration])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |
| `removedModifications` | CraftingItemSlotModification[] | yes |  |
| `applyConcentration` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.RecraftRecipe(UnitGUID("player"))
```

### C_TradeSkillUI.RecraftRecipeForOrder

```lua
result = C_TradeSkillUI.RecraftRecipeForOrder(orderID, itemGUID, [craftingReagents], [removedModifications], [applyConcentration])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderID` | BigUInteger | no |  |
| `itemGUID` | WOWGUID | no |  |
| `craftingReagents` | CraftingReagentInfo[] | yes |  |
| `removedModifications` | CraftingItemSlotModification[] | yes |  |
| `applyConcentration` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_TradeSkillUI.RecraftRecipeForOrder(orderID, UnitGUID("player"))
```

### C_TradeSkillUI.SetOnlyShowAvailableForOrders

```lua
C_TradeSkillUI.SetOnlyShowAvailableForOrders(flag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetOnlyShowAvailableForOrders(false)
```

### C_TradeSkillUI.SetProfessionChildSkillLineID

```lua
C_TradeSkillUI.SetProfessionChildSkillLineID(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetProfessionChildSkillLineID(0)
```

### C_TradeSkillUI.SetRecipeTracked

```lua
C_TradeSkillUI.SetRecipeTracked(recipeID, tracked, isRecraft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `tracked` | bool | no |  |
| `isRecraft` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetRecipeTracked(0, false, false)
```

### C_TradeSkillUI.SetShowLearned

```lua
C_TradeSkillUI.SetShowLearned(flag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetShowLearned(false)
```

### C_TradeSkillUI.SetShowUnlearned

```lua
C_TradeSkillUI.SetShowUnlearned(flag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetShowUnlearned(false)
```

### C_TradeSkillUI.SetSourceTypeFilter

```lua
C_TradeSkillUI.SetSourceTypeFilter(sourceTypeFilter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceTypeFilter` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeSkillUI.SetSourceTypeFilter("HELPFUL")
```

## Events

### CRAFTING_DETAILS_UPDATE

### NEW_RECIPE_LEARNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `recipeLevel` | luaIndex | yes |  |
| `baseRecipeID` | number | yes |  |

### OBLITERUM_FORGE_PENDING_ITEM_CHANGED

### OPEN_RECIPE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `skillLineID` | number | no |  |
| `expansionSkillLineID` | number | no |  |

### PROFESSION_RESPEC_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillName` | cstring | no |  |

### TRACKED_RECIPE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeID` | number | no |  |
| `tracked` | bool | no |  |

### TRADE_SKILL_CLOSE

### TRADE_SKILL_CRAFT_BEGIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recipeSpellID` | number | no |  |

### TRADE_SKILL_CRAFTING_REAGENT_BONUS_TEXT_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### TRADE_SKILL_CURRENCY_REWARD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | CraftingCurrencyResultData | no |  |

### TRADE_SKILL_DATA_SOURCE_CHANGED

### TRADE_SKILL_DATA_SOURCE_CHANGING

### TRADE_SKILL_DETAILS_UPDATE

### TRADE_SKILL_FAVORITES_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |
| `recipeSpellID` | number | no |  |

### TRADE_SKILL_ITEM_CRAFTED_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | CraftingItemResultData | no |  |

### TRADE_SKILL_ITEM_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemGUID` | WOWGUID | no |  |

### TRADE_SKILL_LIST_UPDATE

### TRADE_SKILL_NAME_UPDATE

### TRADE_SKILL_SHOW

### UPDATE_TRADESKILL_CAST_STOPPED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isScrapping` | bool | no |  |

