# C_GuildBank

[← API index](../README.md) · group: [Auction, Mail & Trade](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**1** functions · **10** events · **0** types

## Functions

### C_GuildBank.IsGuildBankEnabled

```lua
enabled = C_GuildBank.IsGuildBankEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GuildBank.IsGuildBankEnabled()
```

## Events

### GUILDBANKBAGSLOTS_CHANGED

### GUILDBANKFRAME_CLOSED

### GUILDBANKFRAME_OPENED

### GUILDBANK_ITEM_LOCK_CHANGED

### GUILDBANKLOG_UPDATE

### GUILDBANK_TEXT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildBankTab` | luaIndex | no |  |

### GUILDBANK_UPDATE_MONEY

### GUILDBANK_UPDATE_TABS

### GUILDBANK_UPDATE_TEXT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildBankTab` | number | no |  |

### GUILDBANK_UPDATE_WITHDRAWMONEY

