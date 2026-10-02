# C_SocialRestrictions

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**12** functions · **4** events · **0** types

## Functions

### C_SocialRestrictions.AcknowledgeAgeVerificationRestriction

```lua
C_SocialRestrictions.AcknowledgeAgeVerificationRestriction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SocialRestrictions.AcknowledgeAgeVerificationRestriction()
```

### C_SocialRestrictions.AcknowledgeRegionalChatDisabled

```lua
C_SocialRestrictions.AcknowledgeRegionalChatDisabled()
```

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSendChat = C_SocialRestrictions.CanSendChat()
```

### C_SocialRestrictions.IsAgeVerificationRestricted

Returns true if the account is restricted by the Age Verification feature.

```lua
restricted = C_SocialRestrictions.IsAgeVerificationRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restricted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restricted = C_SocialRestrictions.IsAgeVerificationRestricted()
```

### C_SocialRestrictions.IsAgeVerificationRestrictedMinor

Returns true if the Age Verification restriction is because the account belongs to a minor, as opposed to an adult who has not yet verified their age.

```lua
isMinor = C_SocialRestrictions.IsAgeVerificationRestrictedMinor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMinor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMinor = C_SocialRestrictions.IsAgeVerificationRestrictedMinor()
```

### C_SocialRestrictions.IsChatDisabled

```lua
disabled = C_SocialRestrictions.IsChatDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SocialRestrictions.SetChatDisabled(false)
```

## Events

### ALERT_AGE_VERIFICATION_RESTRICTED

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
