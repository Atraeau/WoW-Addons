# C_MerchantFrame

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **4** events · **1** types

## Functions

### C_MerchantFrame.GetBuybackItemID

```lua
buybackItemID = C_MerchantFrame.GetBuybackItemID(buybackSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buybackSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buybackItemID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buybackItemID = C_MerchantFrame.GetBuybackItemID(1)
```

### C_MerchantFrame.GetItemInfo

```lua
info = C_MerchantFrame.GetItemInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | MerchantItemInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_MerchantFrame.GetItemInfo(1)
```

### C_MerchantFrame.GetMerchantCurrencies

```lua
currencies = C_MerchantFrame.GetMerchantCurrencies()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencies` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencies = C_MerchantFrame.GetMerchantCurrencies()
```

### C_MerchantFrame.GetNumJunkItems

```lua
numJunkItems = C_MerchantFrame.GetNumJunkItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numJunkItems` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numJunkItems = C_MerchantFrame.GetNumJunkItems()
```

### C_MerchantFrame.IsMerchantItemRefundable

```lua
refundable = C_MerchantFrame.IsMerchantItemRefundable(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `refundable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local refundable = C_MerchantFrame.IsMerchantItemRefundable(1)
```

### C_MerchantFrame.IsSellAllJunkEnabled

```lua
enabled = C_MerchantFrame.IsSellAllJunkEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_MerchantFrame.IsSellAllJunkEnabled()
```

### C_MerchantFrame.SellAllJunkItems

```lua
C_MerchantFrame.SellAllJunkItems()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MerchantFrame.SellAllJunkItems()
```

## Events

### MERCHANT_CLOSED

### MERCHANT_FILTER_ITEM_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

### MERCHANT_SHOW

### MERCHANT_UPDATE

## Types

### MerchantItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `texture` | fileID | no |  |
| `price` | number | no | (default: 0) |
| `stackCount` | number | no | (default: 0) |
| `numAvailable` | number | no | (default: 0) |
| `isPurchasable` | bool | no | (default: False) |
| `isUsable` | bool | no | (default: False) |
| `hasExtendedCost` | bool | no | (default: False) |
| `currencyID` | number | yes |  |
| `spellID` | number | yes |  |
| `isQuestStartItem` | bool | no | (default: False) |

