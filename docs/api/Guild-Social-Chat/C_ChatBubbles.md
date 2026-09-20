# C_ChatBubbles

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**1** functions · **0** events · **0** types

## Functions

### C_ChatBubbles.GetAllChatBubbles

```lua
chatBubbles = C_ChatBubbles.GetAllChatBubbles(includeForbidden)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `includeForbidden` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chatBubbles` | ChatBubbleFrame[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chatBubbles = C_ChatBubbles.GetAllChatBubbles(false)
```

