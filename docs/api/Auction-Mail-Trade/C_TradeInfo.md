# C_TradeInfo

[← API index](../README.md) · group: [Auction, Mail & Trade](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **15** events · **0** types

## Functions

### C_TradeInfo.AddTradeMoney

Adds any cursor-held money to the current trade offer.

```lua
C_TradeInfo.AddTradeMoney()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeInfo.AddTradeMoney()
```

### C_TradeInfo.PickupTradeMoney

```lua
C_TradeInfo.PickupTradeMoney(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeInfo.PickupTradeMoney(0)
```

### C_TradeInfo.SetTradeMoney

Sets the amount of money in the current trade offer.

```lua
C_TradeInfo.SetTradeMoney(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | WOWMONEY | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_TradeInfo.SetTradeMoney(0)
```

### C_TradeInfo.ShouldShowTradeOfferWarning

```lua
shouldShow = C_TradeInfo.ShouldShowTradeOfferWarning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_TradeInfo.ShouldShowTradeOfferWarning()
```

## Events

### PLAYER_TRADE_CURRENCY

### PLAYER_TRADE_MONEY

### TRADE_ACCEPT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerAccepted` | number | no |  |
| `targetAccepted` | number | no |  |

### TRADE_CLOSED

### TRADE_CURRENCY_CHANGED

### TRADE_MONEY_CHANGED

### TRADE_PLAYER_ITEM_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tradeSlotIndex` | number | no |  |

### TRADE_POTENTIAL_BIND_ENCHANT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canBecomeBoundForTrade` | bool | no |  |

### TRADE_POTENTIAL_REMOVE_TRANSMOG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | cstring | no |  |
| `tradeSlotIndex` | number | no |  |

### TRADE_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### TRADE_REQUEST_CANCEL

### TRADE_SHOW

### TRADE_TARGET_ITEM_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tradeSlotIndex` | number | no |  |

### TRADE_UPDATE

### TRADE_UPDATE_WARNINGS

