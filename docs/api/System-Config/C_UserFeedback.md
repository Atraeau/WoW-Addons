# C_UserFeedback

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **0** events · **0** types

## Functions

### C_UserFeedback.SubmitBug

```lua
success = C_UserFeedback.SubmitBug(bugInfo, suppressNotification)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bugInfo` | cstring | no |  |
| `suppressNotification` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_UserFeedback.SubmitBug("", false)
```

### C_UserFeedback.SubmitSuggestion

```lua
success = C_UserFeedback.SubmitSuggestion(suggestion)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `suggestion` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_UserFeedback.SubmitSuggestion("")
```

