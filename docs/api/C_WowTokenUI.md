# C_WowTokenUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **15** events · **0** types

## Functions

### C_WowTokenUI.ShouldDisplayInAuctionHouse

```lua
displayInAH = C_WowTokenUI.ShouldDisplayInAuctionHouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayInAH` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local displayInAH = C_WowTokenUI.ShouldDisplayInAuctionHouse()
```

### C_WowTokenUI.StartTokenSell

```lua
C_WowTokenUI.StartTokenSell(tokenGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tokenGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WowTokenUI.StartTokenSell(UnitGUID("player"))
```

## Events

### TOKEN_AUCTION_SOLD

### TOKEN_BUY_CONFIRM_REQUIRED

### TOKEN_BUY_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### TOKEN_CAN_VETERAN_BUY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### TOKEN_DISTRIBUTIONS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### TOKEN_MARKET_PRICE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### TOKEN_REDEEM_BALANCE_UPDATED

### TOKEN_REDEEM_CONFIRM_REQUIRED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `choiceType` | luaIndex | no |  |

### TOKEN_REDEEM_FRAME_SHOW

### TOKEN_REDEEM_GAME_TIME_UPDATED

### TOKEN_REDEEM_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | luaIndex | no |  |
| `choiceType` | luaIndex | no |  |

### TOKEN_SELL_CONFIRMED

### TOKEN_SELL_CONFIRM_REQUIRED

### TOKEN_SELL_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

### TOKEN_STATUS_CHANGED

