# C_AccountStore

[← API index](../README.md) · group: [Store, Account & Services](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **5** events · **3** types

## Functions

### C_AccountStore.BeginPurchase

```lua
purchaseStarted = C_AccountStore.BeginPurchase(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `purchaseStarted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local purchaseStarted = C_AccountStore.BeginPurchase(6948)
```

### C_AccountStore.GetCategories

```lua
categories = C_AccountStore.GetCategories(storeFrontID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categories` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categories = C_AccountStore.GetCategories(0)
```

### C_AccountStore.GetCategoryInfo

```lua
info = C_AccountStore.GetCategoryInfo(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AccountStoreCategoryInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AccountStore.GetCategoryInfo(0)
```

### C_AccountStore.GetCategoryItems

```lua
itemIDs = C_AccountStore.GetCategoryItems(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemIDs = C_AccountStore.GetCategoryItems(0)
```

### C_AccountStore.GetCurrencyAvailable

```lua
amount = C_AccountStore.GetCurrencyAvailable(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount = C_AccountStore.GetCurrencyAvailable(0)
```

### C_AccountStore.GetCurrencyIDForStore

```lua
currencyID = C_AccountStore.GetCurrencyIDForStore(storeFrontID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencyID = C_AccountStore.GetCurrencyIDForStore(0)
```

### C_AccountStore.GetCurrencyInfo

```lua
info = C_AccountStore.GetCurrencyInfo(currencyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AccountStoreCurrencyInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AccountStore.GetCurrencyInfo(0)
```

### C_AccountStore.GetItemInfo

```lua
info = C_AccountStore.GetItemInfo(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AccountStoreItemInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AccountStore.GetItemInfo(6948)
```

### C_AccountStore.GetStoreFrontState

```lua
state = C_AccountStore.GetStoreFrontState(storeFrontID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | AccountStoreState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_AccountStore.GetStoreFrontState(0)
```

### C_AccountStore.RefundItem

```lua
refundStarted = C_AccountStore.RefundItem(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundStarted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local refundStarted = C_AccountStore.RefundItem(6948)
```

### C_AccountStore.RequestStoreFrontInfoUpdate

```lua
C_AccountStore.RequestStoreFrontInfoUpdate(storeFrontID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AccountStore.RequestStoreFrontInfoUpdate(0)
```

## Events

### ACCOUNT_STORE_CURRENCY_AVAILABLE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |

### ACCOUNT_STORE_FRONT_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

### ACCOUNT_STORE_ITEM_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### ACCOUNT_STORE_TRANSACTION_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | AccountStoreTransactionResult | no |  |

### STORE_FRONT_STATE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `storeFrontID` | number | no |  |

## Types

### AccountStoreCategoryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `type` | AccountStoreCategoryType | no |  |
| `icon` | fileID | no |  |

### AccountStoreCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `amount` | number | no |  |
| `maxQuantity` | number | yes |  |
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

### AccountStoreItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `status` | AccountStoreItemStatus | no |  |
| `mode` | AccountStoreItemMode | no |  |
| `currencyID` | number | no |  |
| `flags` | AccountStoreItemFlag | no |  |
| `customUIModelSceneID` | number | yes |  |
| `name` | cstring | no |  |
| `description` | cstring | yes |  |
| `price` | number | no |  |
| `nonrefundable` | bool | no |  |
| `creatureDisplayID` | number | yes |  |
| `transmogSetID` | number | yes |  |
| `displayIcon` | fileID | yes |  |
| `refundSecondsRemaining` | time_t | yes |  |

