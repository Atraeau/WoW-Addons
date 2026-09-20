# C_FriendList

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**31** functions · **27** events · **2** types

## Functions

### C_FriendList.AddFriend

```lua
C_FriendList.AddFriend(name, [notes])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `notes` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.AddFriend("")
```

### C_FriendList.AddIgnore

```lua
added = C_FriendList.AddIgnore(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `added` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local added = C_FriendList.AddIgnore("")
```

### C_FriendList.AddOrDelIgnore

```lua
C_FriendList.AddOrDelIgnore(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.AddOrDelIgnore("")
```

### C_FriendList.AddOrRemoveFriend

```lua
C_FriendList.AddOrRemoveFriend(name, notes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `notes` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.AddOrRemoveFriend("", "")
```

### C_FriendList.DelIgnore

```lua
removed = C_FriendList.DelIgnore(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local removed = C_FriendList.DelIgnore("")
```

### C_FriendList.DelIgnoreByIndex

```lua
C_FriendList.DelIgnoreByIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.DelIgnoreByIndex(1)
```

### C_FriendList.GetFriendInfo

```lua
info = C_FriendList.GetFriendInfo(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | FriendInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_FriendList.GetFriendInfo("")
```

### C_FriendList.GetFriendInfoByIndex

```lua
info = C_FriendList.GetFriendInfoByIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | FriendInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_FriendList.GetFriendInfoByIndex(1)
```

### C_FriendList.GetIgnoreName

```lua
name = C_FriendList.GetIgnoreName(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_FriendList.GetIgnoreName(1)
```

### C_FriendList.GetNumFriends

```lua
numFriends = C_FriendList.GetNumFriends()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFriends` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numFriends = C_FriendList.GetNumFriends()
```

### C_FriendList.GetNumIgnores

```lua
numIgnores = C_FriendList.GetNumIgnores()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numIgnores` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numIgnores = C_FriendList.GetNumIgnores()
```

### C_FriendList.GetNumOnlineFriends

```lua
numOnline = C_FriendList.GetNumOnlineFriends()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numOnline` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numOnline = C_FriendList.GetNumOnlineFriends()
```

### C_FriendList.GetNumWhoResults

```lua
numWhos, totalNumWhos = C_FriendList.GetNumWhoResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numWhos` | number | no |  |
| `totalNumWhos` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numWhos, totalNumWhos = C_FriendList.GetNumWhoResults()
```

### C_FriendList.GetSelectedFriend

```lua
index = C_FriendList.GetSelectedFriend()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local index = C_FriendList.GetSelectedFriend()
```

### C_FriendList.GetSelectedIgnore

```lua
index = C_FriendList.GetSelectedIgnore()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local index = C_FriendList.GetSelectedIgnore()
```

### C_FriendList.GetWhoInfo

```lua
info = C_FriendList.GetWhoInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | WhoInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_FriendList.GetWhoInfo(1)
```

### C_FriendList.IsFriend

```lua
isFriend = C_FriendList.IsFriend(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFriend` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFriend = C_FriendList.IsFriend(UnitGUID("player"))
```

### C_FriendList.IsIgnored

```lua
isIgnored = C_FriendList.IsIgnored(token)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnored` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnored = C_FriendList.IsIgnored("")
```

### C_FriendList.IsIgnoredByGuid

```lua
isIgnored = C_FriendList.IsIgnoredByGuid(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnored` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnored = C_FriendList.IsIgnoredByGuid(UnitGUID("player"))
```

### C_FriendList.IsLegacyFriendSystemEnabled

```lua
isLegacyFriendSystemEnabled = C_FriendList.IsLegacyFriendSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLegacyFriendSystemEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLegacyFriendSystemEnabled = C_FriendList.IsLegacyFriendSystemEnabled()
```

### C_FriendList.IsOnIgnoredList

```lua
isIgnored = C_FriendList.IsOnIgnoredList(token)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIgnored` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isIgnored = C_FriendList.IsOnIgnoredList("")
```

### C_FriendList.RemoveFriend

```lua
removed = C_FriendList.RemoveFriend(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local removed = C_FriendList.RemoveFriend("")
```

### C_FriendList.RemoveFriendByIndex

```lua
C_FriendList.RemoveFriendByIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.RemoveFriendByIndex(1)
```

### C_FriendList.SendWho

```lua
C_FriendList.SendWho(filter, [origin])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filter` | cstring | no |  |
| `origin` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SendWho("HELPFUL")
```

### C_FriendList.SetFriendNotes

```lua
found = C_FriendList.SetFriendNotes(name, notes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `notes` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `found` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local found = C_FriendList.SetFriendNotes("", "")
```

### C_FriendList.SetFriendNotesByIndex

```lua
C_FriendList.SetFriendNotesByIndex(index, notes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `notes` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SetFriendNotesByIndex(1, "")
```

### C_FriendList.SetSelectedFriend

```lua
C_FriendList.SetSelectedFriend(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SetSelectedFriend(1)
```

### C_FriendList.SetSelectedIgnore

```lua
C_FriendList.SetSelectedIgnore(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SetSelectedIgnore(1)
```

### C_FriendList.SetWhoToUi

```lua
C_FriendList.SetWhoToUi(whoToUi)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `whoToUi` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SetWhoToUi(false)
```

### C_FriendList.ShowFriends

```lua
C_FriendList.ShowFriends()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.ShowFriends()
```

### C_FriendList.SortWho

```lua
C_FriendList.SortWho(sorting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sorting` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_FriendList.SortWho("")
```

## Events

### BATTLE_NET_FRIEND_TAG_ENABLED_STATUS_UPDATED

### BATTLE_NET_TITLE_FRIEND_CUSTOM_NAME_ENABLED_STATUS_UPDATED

### BN_BLOCK_FAILED_TOO_MANY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blockType` | cstring | no |  |

### BN_BLOCK_LIST_UPDATED

### BN_CHAT_WHISPER_UNDELIVERABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `senderID` | number | no |  |

### BN_CONNECTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `suppressNotification` | bool | no | (default: False) |

### BN_CUSTOM_MESSAGE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | yes |  |

### BN_CUSTOM_MESSAGE_LOADED

### BN_DISCONNECTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |
| `suppressNotification` | bool | no | (default: False) |

### BN_FRIEND_ACCOUNT_OFFLINE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendId` | number | no |  |
| `isCompanionApp` | bool | no | (default: False) |

### BN_FRIEND_ACCOUNT_ONLINE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendId` | number | no |  |
| `isCompanionApp` | bool | no | (default: False) |

### BN_FRIEND_INFO_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendIndex` | luaIndex | yes |  |

### BN_FRIEND_INVITE_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountID` | number | no |  |

### BN_FRIEND_INVITE_LIST_INITIALIZED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listSize` | number | no |  |

### BN_FRIEND_INVITE_REMOVED

### BN_FRIEND_LIST_SIZE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountID` | number | yes |  |

### BN_INFO_CHANGED

### BN_REQUEST_FOF_SUCCEEDED

### CONFIRM_BATTLE_NET_FRIEND_INVITE_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `friendLevel` | BattleNetFriendLevel | no |  |

### FRIENDLIST_UPDATE

### IGNORELIST_UPDATE

### LEGACY_FRIEND_SYSTEM_STATUS_UPDATED

### MUTELIST_UPDATE

### NEW_MATCHMAKING_PARTY_INVITE

### REJECTED_MATCHMAKING_PARTY_INVITE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### SOCIAL_UI_FRIENDS_LIST_SYSTEM_STATUS_UPDATED

### WHO_LIST_UPDATE

## Types

### FriendInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `connected` | bool | no |  |
| `name` | string | no |  |
| `className` | string | yes |  |
| `area` | string | yes |  |
| `notes` | string | yes |  |
| `guid` | WOWGUID | no |  |
| `level` | number | no |  |
| `dnd` | bool | no |  |
| `afk` | bool | no |  |
| `rafLinkType` | RafLinkType | no |  |

### WhoInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullName` | string | no |  |
| `fullGuildName` | string | no |  |
| `level` | number | no |  |
| `raceStr` | string | no |  |
| `classStr` | string | no |  |
| `area` | string | no |  |
| `filename` | string | yes |  |
| `gender` | number | no |  |
| `timerunningSeasonID` | number | yes |  |

