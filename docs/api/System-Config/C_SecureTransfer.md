# C_SecureTransfer

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 70790, interface 16001) on 2026-11-05 13:35:56.

**14** functions · **6** events · **2** types

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

### C_SecureTransfer.GetMailReceiveInfo

```lua
mailInfo = C_SecureTransfer.GetMailReceiveInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mailInfo` | MailReceiveInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mailInfo = C_SecureTransfer.GetMailReceiveInfo()
```

### C_SecureTransfer.GetMailSendInfo

```lua
mailInfo = C_SecureTransfer.GetMailSendInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mailInfo` | MailSendInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mailInfo = C_SecureTransfer.GetMailSendInfo()
```

### C_SecureTransfer.GetTradePartner

```lua
name = C_SecureTransfer.GetTradePartner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

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

### C_SecureTransfer.ShouldShowTradeRMTWarning

```lua
shouldShow = C_SecureTransfer.ShouldShowTradeRMTWarning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_SecureTransfer.ShouldShowTradeRMTWarning()
```

### C_SecureTransfer.TakeMailMoney

```lua
C_SecureTransfer.TakeMailMoney()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SecureTransfer.TakeMailMoney()
```

## Events

### SECURE_TRANSFER_CANCEL

### SECURE_TRANSFER_CONFIRM_HOUSING_PURCHASE

### SECURE_TRANSFER_CONFIRM_SEND_MAIL

### SECURE_TRANSFER_CONFIRM_TAKE_MAIL_MONEY

### SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT

### SECURE_TRANSFER_HOUSING_CURRENCY_PURCHASE_CONFIRMATION

## Types

### MailReceiveInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sender` | string | no |  |
| `money` | number | no |  |

### MailSendInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | string | no |  |
| `sendMoney` | number | no |  |
