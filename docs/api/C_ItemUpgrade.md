# C_ItemUpgrade

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**16** functions · **3** events · **7** types

## Functions

### C_ItemUpgrade.CanUpgradeItem

```lua
isValid = C_ItemUpgrade.CanUpgradeItem(baseItem)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseItem` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = C_ItemUpgrade.CanUpgradeItem(6948)
```

### C_ItemUpgrade.ClearItemUpgrade

```lua
C_ItemUpgrade.ClearItemUpgrade()
```

**Example**

```lua
C_ItemUpgrade.ClearItemUpgrade()
```

### C_ItemUpgrade.CloseItemUpgrade

```lua
C_ItemUpgrade.CloseItemUpgrade()
```

**Example**

```lua
C_ItemUpgrade.CloseItemUpgrade()
```

### C_ItemUpgrade.GetHighWatermarkForItem

```lua
characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no | Item ID, Link, or Name |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterHighWatermark` | number | no |  |
| `accountHighWatermark` | number | no |  |

**Example**

```lua
local characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForItem(6948)
```

### C_ItemUpgrade.GetHighWatermarkForSlot

```lua
characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForSlot(itemRedundancySlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemRedundancySlot` | number | no | Must be an Enum.ItemRedundancySlot value |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterHighWatermark` | number | no |  |
| `accountHighWatermark` | number | no |  |

**Example**

```lua
local characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForSlot(1)
```

### C_ItemUpgrade.GetHighWatermarkSlotForItem

```lua
itemRedundancySlot = C_ItemUpgrade.GetHighWatermarkSlotForItem(itemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemInfo | no | Item ID, Link, or Name |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemRedundancySlot` | number | no | Enum.ItemRedundancySlot value |

**Example**

```lua
local itemRedundancySlot = C_ItemUpgrade.GetHighWatermarkSlotForItem(6948)
```

### C_ItemUpgrade.GetItemHyperlink

```lua
link = C_ItemUpgrade.GetItemHyperlink()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_ItemUpgrade.GetItemHyperlink()
```

### C_ItemUpgrade.GetItemUpgradeCurrentLevel

```lua
itemLevel, isPvpItemLevel = C_ItemUpgrade.GetItemUpgradeCurrentLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLevel` | number | no |  |
| `isPvpItemLevel` | bool | no |  |

**Example**

```lua
local itemLevel, isPvpItemLevel = C_ItemUpgrade.GetItemUpgradeCurrentLevel()
```

### C_ItemUpgrade.GetItemUpgradeEffect

```lua
outBaseEffect, outUpgradedEffect = C_ItemUpgrade.GetItemUpgradeEffect(effectIndex, [numUpgradeLevels])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectIndex` | number | no |  |
| `numUpgradeLevels` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outBaseEffect` | string | no |  |
| `outUpgradedEffect` | string | no |  |

**Example**

```lua
local outBaseEffect, outUpgradedEffect = C_ItemUpgrade.GetItemUpgradeEffect(1)
```

### C_ItemUpgrade.GetItemUpgradeItemInfo

```lua
itemInfo = C_ItemUpgrade.GetItemUpgradeItemInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemInfo` | ItemUpgradeItemInfo | no |  |

**Example**

```lua
local itemInfo = C_ItemUpgrade.GetItemUpgradeItemInfo()
```

### C_ItemUpgrade.GetItemUpgradePvpItemLevelDeltaValues

```lua
currentPvPItemLevel, upgradedPvPItemLevel = C_ItemUpgrade.GetItemUpgradePvpItemLevelDeltaValues(numUpgradeLevels)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numUpgradeLevels` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentPvPItemLevel` | number | no |  |
| `upgradedPvPItemLevel` | number | no |  |

**Example**

```lua
local currentPvPItemLevel, upgradedPvPItemLevel = C_ItemUpgrade.GetItemUpgradePvpItemLevelDeltaValues(0)
```

### C_ItemUpgrade.GetNumItemUpgradeEffects

```lua
numItemUpgradeEffects = C_ItemUpgrade.GetNumItemUpgradeEffects()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numItemUpgradeEffects` | number | no |  |

**Example**

```lua
local numItemUpgradeEffects = C_ItemUpgrade.GetNumItemUpgradeEffects()
```

### C_ItemUpgrade.IsItemBound

```lua
isBound = C_ItemUpgrade.IsItemBound()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBound` | bool | no |  |

**Example**

```lua
local isBound = C_ItemUpgrade.IsItemBound()
```

### C_ItemUpgrade.SetItemUpgradeFromCursorItem

```lua
C_ItemUpgrade.SetItemUpgradeFromCursorItem()
```

**Example**

```lua
C_ItemUpgrade.SetItemUpgradeFromCursorItem()
```

### C_ItemUpgrade.SetItemUpgradeFromLocation

```lua
C_ItemUpgrade.SetItemUpgradeFromLocation(itemToSet)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemToSet` | ItemLocation | no |  |

**Example**

```lua
C_ItemUpgrade.SetItemUpgradeFromLocation(6948)
```

### C_ItemUpgrade.UpgradeItem

```lua
C_ItemUpgrade.UpgradeItem(numUpgrades)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numUpgrades` | number | no | (default: 1) |

**Example**

```lua
C_ItemUpgrade.UpgradeItem(0)
```

## Events

### ITEM_UPGRADE_FAILED

### ITEM_UPGRADE_MASTER_SET_ITEM

### ITEM_UPGRADE_MASTER_UPDATE

## Types

### ItemUpgradeCostDiscountInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDiscounted` | bool | no |  |
| `discountHighWatermark` | number | no |  |
| `isPartialTwoHandDiscount` | bool | no |  |
| `isAccountWideDiscount` | bool | no |  |
| `doesCurrentCharacterMeetHighWatermark` | bool | no | Reflects whether current character meets discount's high watermark, even if discount itself is account-wide |

### ItemUpgradeCurrencyCost (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |
| `currencyID` | number | no |  |
| `discountInfo` | ItemUpgradeCostDiscountInfo | no |  |

### ItemUpgradeItemCost (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |
| `itemID` | number | no |  |
| `discountInfo` | ItemUpgradeCostDiscountInfo | no |  |

### ItemUpgradeItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconID` | number | no |  |
| `name` | string | no |  |
| `itemUpgradeable` | bool | no |  |
| `displayQuality` | number | no |  |
| `highWatermarkSlot` | number | no |  |
| `currUpgrade` | number | no |  |
| `maxUpgrade` | number | no |  |
| `minItemLevel` | number | no |  |
| `maxItemLevel` | number | no |  |
| `upgradeLevelInfos` | ItemUpgradeLevelInfo[] | no |  |
| `customUpgradeString` | string | yes |  |
| `upgradeCostTypesForSeason` | ItemUpgradeSeasonalCostType[] | no |  |

### ItemUpgradeLevelInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `upgradeLevel` | number | no |  |
| `displayQuality` | number | no |  |
| `itemLevelIncrement` | number | no |  |
| `levelStats` | ItemUpgradeStat[] | no |  |
| `currencyCostsToUpgrade` | ItemUpgradeCurrencyCost[] | no |  |
| `itemCostsToUpgrade` | ItemUpgradeItemCost[] | no |  |
| `moneyCost` | WOWMONEY | yes |  |
| `failureMessage` | string | yes |  |

### ItemUpgradeSeasonalCostType (Structure)

Costs are made up of either an Item OR a Currency, so either itemID or currencyID will be nil

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |
| `currencyID` | number | yes |  |
| `orderIndex` | number | no |  |
| `sourceString` | string | yes |  |

### ItemUpgradeStat (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayString` | string | no |  |
| `statValue` | number | no |  |
| `active` | bool | no |  |

