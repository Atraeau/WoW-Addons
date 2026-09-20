# C_SocialRestrictions

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **3** events · **0** types

## Functions

### C_SocialRestrictions.AcknowledgeRegionalChatDisabled

```lua
C_SocialRestrictions.AcknowledgeRegionalChatDisabled()
```

**Example**

```lua
C_SocialRestrictions.AcknowledgeRegionalChatDisabled()
```

### C_SocialRestrictions.CanReceiveChat

Returns true if the player meets all conditions that allow them to receive chat messages.

```lua
canReceiveChat = C_SocialRestrictions.CanReceiveChat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canReceiveChat` | bool | no |  |

**Example**

```lua
local canReceiveChat = C_SocialRestrictions.CanReceiveChat()
```

### C_SocialRestrictions.CanSendChat

Returns true if the player meets all conditions that allow them to send chat messages.

```lua
canSendChat = C_SocialRestrictions.CanSendChat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSendChat` | bool | no |  |

**Example**

```lua
local canSendChat = C_SocialRestrictions.CanSendChat()
```

### C_SocialRestrictions.IsChatDisabled

```lua
disabled = C_SocialRestrictions.IsChatDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example**

```lua
local disabled = C_SocialRestrictions.IsChatDisabled()
```

### C_SocialRestrictions.IsFriendsDisabled

```lua
disabled = C_SocialRestrictions.IsFriendsDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example**

```lua
local disabled = C_SocialRestrictions.IsFriendsDisabled()
```

### C_SocialRestrictions.IsMuted

```lua
isMuted = C_SocialRestrictions.IsMuted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMuted` | bool | no |  |

**Example**

```lua
local isMuted = C_SocialRestrictions.IsMuted()
```

### C_SocialRestrictions.IsSilenced

```lua
isSilenced = C_SocialRestrictions.IsSilenced()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSilenced` | bool | no |  |

**Example**

```lua
local isSilenced = C_SocialRestrictions.IsSilenced()
```

### C_SocialRestrictions.IsSquelched

```lua
isSquelched = C_SocialRestrictions.IsSquelched()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSquelched` | bool | no |  |

**Example**

```lua
local isSquelched = C_SocialRestrictions.IsSquelched()
```

### C_SocialRestrictions.SetChatDisabled

```lua
C_SocialRestrictions.SetChatDisabled(disabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example**

```lua
C_SocialRestrictions.SetChatDisabled(false)
```

## Events

### ALERT_REGIONAL_CHAT_DISABLED

### CHAT_DISABLED_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

### CHAT_DISABLED_CHANGE_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

