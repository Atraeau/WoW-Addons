# C_CurrencyInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**43** functions · **8** events · **6** types

## Functions

### C_CurrencyInfo.CanTransferCurrency

```lua
canTransferCurrency, failureReason = C_CurrencyInfo.CanTransferCurrency(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canTransferCurrency` | bool | no |  |
| `failureReason` | AccountCurrencyTransferResult | yes |  |

**Example**

```lua
local canTransferCurrency, failureReason = C_CurrencyInfo.CanTransferCurrency(0)
```

### C_CurrencyInfo.DoesCurrentFilterRequireAccountCurrencyData

```lua
doesCurrentFilterRequireAccountCurrencyData = C_CurrencyInfo.DoesCurrentFilterRequireAccountCurrencyData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesCurrentFilterRequireAccountCurrencyData` | bool | no |  |

**Example**

```lua
local doesCurrentFilterRequireAccountCurrencyData = C_CurrencyInfo.DoesCurrentFilterRequireAccountCurrencyData()
```

### C_CurrencyInfo.DoesWarModeBonusApply

```lua
warModeApplies, limitOncePerTooltip = C_CurrencyInfo.DoesWarModeBonusApply(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeApplies` | bool | yes |  |
| `limitOncePerTooltip` | bool | yes |  |

**Example**

```lua
local warModeApplies, limitOncePerTooltip = C_CurrencyInfo.DoesWarModeBonusApply(0)
```

### C_CurrencyInfo.ExpandCurrencyList

```lua
C_CurrencyInfo.ExpandCurrencyList(index, expand)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `expand` | bool | no |  |

**Example**

```lua
C_CurrencyInfo.ExpandCurrencyList(1, false)
```

### C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters

```lua
accountCurrencyData = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountCurrencyData` | CharacterCurrencyData[] | no |  |

**Example**

```lua
local accountCurrencyData = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(0)
```

### C_CurrencyInfo.FetchCurrencyTransferTransactions

```lua
currencyTransferTransactions = C_CurrencyInfo.FetchCurrencyTransferTransactions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyTransferTransactions` | CurrencyTransferTransaction[] | no |  |

**Example**

```lua
local currencyTransferTransactions = C_CurrencyInfo.FetchCurrencyTransferTransactions()
```

### C_CurrencyInfo.GetAzeriteCurrencyID

```lua
azeriteCurrencyID = C_CurrencyInfo.GetAzeriteCurrencyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `azeriteCurrencyID` | number | no |  |

**Example**

```lua
local azeriteCurrencyID = C_CurrencyInfo.GetAzeriteCurrencyID()
```

### C_CurrencyInfo.GetBackpackCurrencyInfo

```lua
info = C_CurrencyInfo.GetBackpackCurrencyInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | BackpackCurrencyInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetBackpackCurrencyInfo(1)
```

### C_CurrencyInfo.GetBasicCurrencyInfo

```lua
info = C_CurrencyInfo.GetBasicCurrencyInfo(currencyType, [quantity])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | no |  |
| `quantity` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CurrencyDisplayInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetBasicCurrencyInfo(0)
```

### C_CurrencyInfo.GetCoinIcon

```lua
result = C_CurrencyInfo.GetCoinIcon(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | fileID | no |  |

**Example**

```lua
local result = C_CurrencyInfo.GetCoinIcon(amount)
```

### C_CurrencyInfo.GetCoinText

```lua
result = C_CurrencyInfo.GetCoinText(amount, separator)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |
| `separator` | cstring | no | (default: , ) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_CurrencyInfo.GetCoinText(amount, "")
```

### C_CurrencyInfo.GetCoinTextureString

```lua
result = C_CurrencyInfo.GetCoinTextureString(amount, fontHeight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |
| `fontHeight` | number | no | (default: 14) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = C_CurrencyInfo.GetCoinTextureString(amount, 0)
```

### C_CurrencyInfo.GetCostToTransferCurrency

```lua
totalQuantityConsumed = C_CurrencyInfo.GetCostToTransferCurrency(currencyID, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `quantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalQuantityConsumed` | number | yes |  |

**Example**

```lua
local totalQuantityConsumed = C_CurrencyInfo.GetCostToTransferCurrency(0, 0)
```

### C_CurrencyInfo.GetCurrencyContainerInfo

```lua
info = C_CurrencyInfo.GetCurrencyContainerInfo(currencyType, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | no |  |
| `quantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CurrencyDisplayInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetCurrencyContainerInfo(0, 0)
```

### C_CurrencyInfo.GetCurrencyDescription

```lua
description = C_CurrencyInfo.GetCurrencyDescription(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |

**Example**

```lua
local description = C_CurrencyInfo.GetCurrencyDescription(0)
```

### C_CurrencyInfo.GetCurrencyFilter

```lua
filterType = C_CurrencyInfo.GetCurrencyFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterType` | CurrencyFilterType | no |  |

**Example**

```lua
local filterType = C_CurrencyInfo.GetCurrencyFilter()
```

### C_CurrencyInfo.GetCurrencyIDFromLink

```lua
currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyLink` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Example**

```lua
local currencyID = C_CurrencyInfo.GetCurrencyIDFromLink("")
```

### C_CurrencyInfo.GetCurrencyInfo

```lua
info = C_CurrencyInfo.GetCurrencyInfo(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CurrencyInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetCurrencyInfo(0)
```

### C_CurrencyInfo.GetCurrencyInfoFromLink

```lua
info = C_CurrencyInfo.GetCurrencyInfoFromLink(link)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CurrencyInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetCurrencyInfoFromLink("")
```

### C_CurrencyInfo.GetCurrencyLink

```lua
link = C_CurrencyInfo.GetCurrencyLink(type, [amount])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |
| `amount` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_CurrencyInfo.GetCurrencyLink(0)
```

### C_CurrencyInfo.GetCurrencyListInfo

```lua
info = C_CurrencyInfo.GetCurrencyListInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CurrencyInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetCurrencyListInfo(1)
```

### C_CurrencyInfo.GetCurrencyListLink

```lua
link = C_CurrencyInfo.GetCurrencyListLink(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_CurrencyInfo.GetCurrencyListLink(1)
```

### C_CurrencyInfo.GetCurrencyListSize

```lua
currencyListSize = C_CurrencyInfo.GetCurrencyListSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyListSize` | number | no |  |

**Example**

```lua
local currencyListSize = C_CurrencyInfo.GetCurrencyListSize()
```

### C_CurrencyInfo.GetDragonIslesSuppliesCurrencyID

```lua
dragonIslesSuppliesCurrencyID = C_CurrencyInfo.GetDragonIslesSuppliesCurrencyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dragonIslesSuppliesCurrencyID` | number | no |  |

**Example**

```lua
local dragonIslesSuppliesCurrencyID = C_CurrencyInfo.GetDragonIslesSuppliesCurrencyID()
```

### C_CurrencyInfo.GetFactionGrantedByCurrency

Gets the faction ID for currency that is immediately converted into reputation with that faction instead.

```lua
factionID = C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | yes |  |

**Example**

```lua
local factionID = C_CurrencyInfo.GetFactionGrantedByCurrency(0)
```

### C_CurrencyInfo.GetMaxTransferableAmountFromQuantity

```lua
maxTransferableAmount = C_CurrencyInfo.GetMaxTransferableAmountFromQuantity(currencyID, requestedQuantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `requestedQuantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxTransferableAmount` | number | yes |  |

**Example**

```lua
local maxTransferableAmount = C_CurrencyInfo.GetMaxTransferableAmountFromQuantity(0, 0)
```

### C_CurrencyInfo.GetPlayerCurrencyCategoryInfo

```lua
info = C_CurrencyInfo.GetPlayerCurrencyCategoryInfo(categoryID, includeAccountWide)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `includeAccountWide` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PlayerCurrencyCategoryInfo | no |  |

**Example**

```lua
local info = C_CurrencyInfo.GetPlayerCurrencyCategoryInfo(0, false)
```

### C_CurrencyInfo.GetWarResourcesCurrencyID

```lua
warResourceCurrencyID = C_CurrencyInfo.GetWarResourcesCurrencyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warResourceCurrencyID` | number | no |  |

**Example**

```lua
local warResourceCurrencyID = C_CurrencyInfo.GetWarResourcesCurrencyID()
```

### C_CurrencyInfo.IsAccountCharacterCurrencyDataReady

```lua
isReady = C_CurrencyInfo.IsAccountCharacterCurrencyDataReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example**

```lua
local isReady = C_CurrencyInfo.IsAccountCharacterCurrencyDataReady()
```

### C_CurrencyInfo.IsAccountTransferableCurrency

```lua
isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccountTransferableCurrency` | bool | no |  |

**Example**

```lua
local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(0)
```

### C_CurrencyInfo.IsAccountWideCurrency

```lua
isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccountWideCurrency` | bool | no |  |

**Example**

```lua
local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(0)
```

### C_CurrencyInfo.IsCurrencyContainer

```lua
isCurrencyContainer = C_CurrencyInfo.IsCurrencyContainer(currencyID, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `quantity` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCurrencyContainer` | bool | no |  |

**Example**

```lua
local isCurrencyContainer = C_CurrencyInfo.IsCurrencyContainer(0, 0)
```

### C_CurrencyInfo.IsCurrencyTransferInProgress

```lua
currencyTransferInProgress = C_CurrencyInfo.IsCurrencyTransferInProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyTransferInProgress` | bool | no |  |

**Example**

```lua
local currencyTransferInProgress = C_CurrencyInfo.IsCurrencyTransferInProgress()
```

### C_CurrencyInfo.IsCurrencyTransferTransactionDataReady

```lua
isReady = C_CurrencyInfo.IsCurrencyTransferTransactionDataReady()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example**

```lua
local isReady = C_CurrencyInfo.IsCurrencyTransferTransactionDataReady()
```

### C_CurrencyInfo.PickupCurrency

```lua
C_CurrencyInfo.PickupCurrency(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |

**Example**

```lua
C_CurrencyInfo.PickupCurrency(0)
```

### C_CurrencyInfo.PlayerHasMaxQuantity

```lua
hasMaxQuantity = C_CurrencyInfo.PlayerHasMaxQuantity(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxQuantity` | bool | no |  |

**Example**

```lua
local hasMaxQuantity = C_CurrencyInfo.PlayerHasMaxQuantity(0)
```

### C_CurrencyInfo.PlayerHasMaxWeeklyQuantity

```lua
hasMaxWeeklyQuantity = C_CurrencyInfo.PlayerHasMaxWeeklyQuantity(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxWeeklyQuantity` | bool | no |  |

**Example**

```lua
local hasMaxWeeklyQuantity = C_CurrencyInfo.PlayerHasMaxWeeklyQuantity(0)
```

### C_CurrencyInfo.RequestCurrencyDataForAccountCharacters

```lua
C_CurrencyInfo.RequestCurrencyDataForAccountCharacters()
```

**Example**

```lua
C_CurrencyInfo.RequestCurrencyDataForAccountCharacters()
```

### C_CurrencyInfo.RequestCurrencyFromAccountCharacter

```lua
C_CurrencyInfo.RequestCurrencyFromAccountCharacter(sourceCharacterGUID, currencyID, quantity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceCharacterGUID` | WOWGUID | no |  |
| `currencyID` | number | no |  |
| `quantity` | number | no |  |

**Example**

```lua
C_CurrencyInfo.RequestCurrencyFromAccountCharacter("Creature-0-0000-0-0-0-0", 0, 0)
```

### C_CurrencyInfo.SetCurrencyBackpack

```lua
C_CurrencyInfo.SetCurrencyBackpack(index, backpack)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `backpack` | bool | no |  |

**Example**

```lua
C_CurrencyInfo.SetCurrencyBackpack(1, false)
```

### C_CurrencyInfo.SetCurrencyBackpackByID

```lua
C_CurrencyInfo.SetCurrencyBackpackByID(currencyType, backpack)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | no |  |
| `backpack` | bool | no |  |

**Example**

```lua
C_CurrencyInfo.SetCurrencyBackpackByID(0, false)
```

### C_CurrencyInfo.SetCurrencyFilter

```lua
C_CurrencyInfo.SetCurrencyFilter(filterType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterType` | CurrencyFilterType | no |  |

**Example**

```lua
C_CurrencyInfo.SetCurrencyFilter("HELPFUL")
```

### C_CurrencyInfo.SetCurrencyUnused

```lua
C_CurrencyInfo.SetCurrencyUnused(index, unused)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `unused` | bool | no |  |

**Example**

```lua
C_CurrencyInfo.SetCurrencyUnused(1, false)
```

## Events

### ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED

### ACCOUNT_MONEY

### CURRENCY_DISPLAY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | yes |  |
| `quantity` | number | yes |  |
| `quantityChange` | number | yes |  |
| `quantityGainSource` | number | yes |  |
| `destroyReason` | number | yes |  |

### CURRENCY_TRANSFER_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `failureReason` | AccountCurrencyTransferResult | no |  |

### CURRENCY_TRANSFER_INITIATED

### CURRENCY_TRANSFER_LOG_UPDATE

### CURRENCY_TRANSFER_SUCCESS

### PLAYER_MONEY

## Types

### BackpackCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `quantity` | number | no |  |
| `iconFileID` | fileID | no |  |
| `currencyTypesID` | number | no |  |

### CharacterCurrencyData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterGUID` | WOWGUID | no |  |
| `characterName` | string | no |  |
| `fullCharacterName` | string | no |  |
| `currencyID` | number | no |  |
| `quantity` | number | no |  |

### CurrencyDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |
| `icon` | number | no |  |
| `quality` | number | no |  |
| `displayAmount` | number | no |  |
| `actualAmount` | number | no |  |

### CurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `currencyID` | number | no |  |
| `isHeader` | bool | no |  |
| `isHeaderExpanded` | bool | no |  |
| `currencyListDepth` | number | no |  |
| `isTypeUnused` | bool | no |  |
| `isShowInBackpack` | bool | no |  |
| `quantity` | number | no |  |
| `trackedQuantity` | number | no |  |
| `iconFileID` | fileID | no |  |
| `maxQuantity` | number | no |  |
| `canEarnPerWeek` | bool | no |  |
| `quantityEarnedThisWeek` | number | no |  |
| `isTradeable` | bool | no |  |
| `quality` | ItemQuality | no |  |
| `maxWeeklyQuantity` | number | no |  |
| `totalEarned` | number | no |  |
| `discovered` | bool | no |  |
| `useTotalEarnedForMaxQty` | bool | no |  |
| `isAccountWide` | bool | no |  |
| `isAccountTransferable` | bool | no |  |
| `transferPercentage` | number | yes |  |
| `rechargingCycleDurationMS` | number | no |  |
| `rechargingAmountPerCycle` | number | no |  |

### CurrencyTransferTransaction (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceCharacterGUID` | WOWGUID | no |  |
| `sourceCharacterName` | string | no |  |
| `fullSourceCharacterName` | string | no |  |
| `destinationCharacterGUID` | WOWGUID | no |  |
| `destinationCharacterName` | string | no |  |
| `fullDestinationCharacterName` | string | no |  |
| `currencyType` | number | no |  |
| `quantityTransferred` | number | no |  |
| `totalQuantityConsumed` | number | no |  |
| `timestamp` | time_t | no |  |

### PlayerCurrencyCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryName` | cstring | no |  |
| `currencyTypes` | number[] | no |  |
| `childCategories` | number[] | no |  |

