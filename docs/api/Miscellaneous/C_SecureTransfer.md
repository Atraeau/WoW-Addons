# C_SecureTransfer

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **5** events · **1** types

## Functions

### C_SecureTransfer.AcceptTrade

```lua
C_SecureTransfer.AcceptTrade()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.AcceptTrade()
```

### C_SecureTransfer.Cancel

```lua
C_SecureTransfer.Cancel()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.Cancel()
```

### C_SecureTransfer.CompleteHousingPurchase

```lua
C_SecureTransfer.CompleteHousingPurchase()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.CompleteHousingPurchase()
```

### C_SecureTransfer.CompleteHousingVCPurchase

```lua
C_SecureTransfer.CompleteHousingVCPurchase()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.CompleteHousingVCPurchase()
```

### C_SecureTransfer.GetHousingPurchaseCost

```lua
totalCost = C_SecureTransfer.GetHousingPurchaseCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalCost` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalCost = C_SecureTransfer.GetHousingPurchaseCost()
```

### C_SecureTransfer.GetHousingPurchaseQuantity

```lua
quantity = C_SecureTransfer.GetHousingPurchaseQuantity()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quantity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local quantity = C_SecureTransfer.GetHousingPurchaseQuantity()
```

### C_SecureTransfer.GetHousingVCPurchaseProductID

```lua
productID = C_SecureTransfer.GetHousingVCPurchaseProductID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `productID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local productID = C_SecureTransfer.GetHousingVCPurchaseProductID()
```

### C_SecureTransfer.GetMailInfo

```lua
mailInfo = C_SecureTransfer.GetMailInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mailInfo` | MailInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mailInfo = C_SecureTransfer.GetMailInfo()
```

### C_SecureTransfer.GetTradePartner

```lua
name = C_SecureTransfer.GetTradePartner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_SecureTransfer.GetTradePartner()
```

### C_SecureTransfer.SendMail

```lua
C_SecureTransfer.SendMail()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.SendMail()
```

### C_SecureTransfer.ShouldShowTradeOfferWarning

```lua
shouldShow = C_SecureTransfer.ShouldShowTradeOfferWarning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_SecureTransfer.ShouldShowTradeOfferWarning()
```

## Events

### SECURE_TRANSFER_CANCEL

### SECURE_TRANSFER_CONFIRM_HOUSING_PURCHASE

### SECURE_TRANSFER_CONFIRM_SEND_MAIL

### SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT

### SECURE_TRANSFER_HOUSING_CURRENCY_PURCHASE_CONFIRMATION

## Types

### MailInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | string | no |  |
| `sendMoney` | number | no |  |

