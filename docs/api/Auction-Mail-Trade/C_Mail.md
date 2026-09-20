# C_Mail

[← API index](../README.md) · group: [Auction, Mail & Trade](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **13** events · **0** types

## Functions

### C_Mail.CanCheckInbox

```lua
canCheckInbox, secondsUntilAllowed = C_Mail.CanCheckInbox()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCheckInbox` | bool | no |  |
| `secondsUntilAllowed` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canCheckInbox, secondsUntilAllowed = C_Mail.CanCheckInbox()
```

### C_Mail.GetCraftingOrderMailInfo

```lua
info = C_Mail.GetCraftingOrderMailInfo(inboxIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inboxIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingOrderMailInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Mail.GetCraftingOrderMailInfo(1)
```

### C_Mail.HasInboxMoney

```lua
inboxItemHasMoneyAttached = C_Mail.HasInboxMoney(inboxIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inboxIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inboxItemHasMoneyAttached` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inboxItemHasMoneyAttached = C_Mail.HasInboxMoney(1)
```

### C_Mail.IsCommandPending

```lua
isCommandPending = C_Mail.IsCommandPending()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCommandPending` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCommandPending = C_Mail.IsCommandPending()
```

### C_Mail.SetOpeningAll

```lua
C_Mail.SetOpeningAll(openingAll)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `openingAll` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Mail.SetOpeningAll(false)
```

## Events

### CLOSE_INBOX_ITEM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mailIndex` | luaIndex | no |  |

### MAIL_CLOSED

### MAIL_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

### MAIL_INBOX_UPDATE

### MAIL_LOCK_SEND_ITEMS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attachSlot` | luaIndex | no |  |
| `itemLink` | cstring | no |  |

### MAIL_SEND_INFO_UPDATE

### MAIL_SEND_SUCCESS

### MAIL_SHOW

### MAIL_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

### MAIL_UNLOCK_SEND_ITEMS

### SEND_MAIL_COD_CHANGED

### SEND_MAIL_MONEY_CHANGED

### UPDATE_PENDING_MAIL

