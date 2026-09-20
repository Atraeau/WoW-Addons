# C_SocialUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **1** events · **3** types

## Functions

### C_SocialUI.IsSystemEnabled

```lua
isSocialUISystemEnabled = C_SocialUI.IsSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSocialUISystemEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSocialUISystemEnabled = C_SocialUI.IsSystemEnabled()
```

## Events

### SOCIAL_UI_SYSTEM_STATUS_UPDATED

## Types

### SocialSystemType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Friends` | SocialSystemType | no |  |
| `QuickJoin` | SocialSystemType | no |  |
| `RaidList` | SocialSystemType | no |  |
| `RecruitAFriend` | SocialSystemType | no |  |
| `RecentAllies` | SocialSystemType | no |  |

### SocialUIBlockType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | SocialUIBlockType | no |  |
| `Ignore` | SocialUIBlockType | no |  |
| `BattleNetInviteBlock` | SocialUIBlockType | no |  |

### SocialUIPresenceType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Unknown` | SocialUIPresenceType | no |  |
| `Online` | SocialUIPresenceType | no |  |
| `Offline` | SocialUIPresenceType | no |  |
| `Away` | SocialUIPresenceType | no |  |
| `Busy` | SocialUIPresenceType | no |  |
| `AppearOffline` | SocialUIPresenceType | no |  |

