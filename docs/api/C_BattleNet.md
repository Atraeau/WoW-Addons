# C_BattleNet

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**32** functions · **0** events · **4** types

## Functions

### C_BattleNet.AreFriendTagsEnabled

```lua
areFriendTagsEnabled = C_BattleNet.AreFriendTagsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areFriendTagsEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areFriendTagsEnabled = C_BattleNet.AreFriendTagsEnabled()
```

### C_BattleNet.AreHighResTexturesInstalled

```lua
installed = C_BattleNet.AreHighResTexturesInstalled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `installed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local installed = C_BattleNet.AreHighResTexturesInstalled()
```

### C_BattleNet.AreTitleFriendCustomNamesEnabled

```lua
areTitleFriendCustomNamesEnabled = C_BattleNet.AreTitleFriendCustomNamesEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areTitleFriendCustomNamesEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areTitleFriendCustomNamesEnabled = C_BattleNet.AreTitleFriendCustomNamesEnabled()
```

### C_BattleNet.AreTitleFriendsEnabled

```lua
areTitleFriendsEnabled = C_BattleNet.AreTitleFriendsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areTitleFriendsEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areTitleFriendsEnabled = C_BattleNet.AreTitleFriendsEnabled()
```

### C_BattleNet.BNCheckBattleTagInviteToRecentAlly

```lua
C_BattleNet.BNCheckBattleTagInviteToRecentAlly(recentAllyGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentAllyGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.BNCheckBattleTagInviteToRecentAlly(UnitGUID("player"))
```

### C_BattleNet.BNCheckTitleFriendInviteToUnit

```lua
C_BattleNet.BNCheckTitleFriendInviteToUnit(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.BNCheckTitleFriendInviteToUnit("player")
```

### C_BattleNet.CanToggleHighResTexturesWithoutClientReload

```lua
canToggle = C_BattleNet.CanToggleHighResTexturesWithoutClientReload()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canToggle` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canToggle = C_BattleNet.CanToggleHighResTexturesWithoutClientReload()
```

### C_BattleNet.GetAccountInfoByGUID

```lua
accountInfo = C_BattleNet.GetAccountInfoByGUID(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountInfo` | BNetAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accountInfo = C_BattleNet.GetAccountInfoByGUID(UnitGUID("player"))
```

### C_BattleNet.GetAccountInfoByID

```lua
accountInfo = C_BattleNet.GetAccountInfoByID(id, [wowAccountGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `wowAccountGUID` | WOWGUID | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountInfo` | BNetAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accountInfo = C_BattleNet.GetAccountInfoByID(0)
```

### C_BattleNet.GetCustomTitleFriendName

```lua
customName = C_BattleNet.GetCustomTitleFriendName(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local customName = C_BattleNet.GetCustomTitleFriendName(0)
```

### C_BattleNet.GetFriendAccountInfo

```lua
accountInfo = C_BattleNet.GetFriendAccountInfo(friendIndex, [wowAccountGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendIndex` | luaIndex | no |  |
| `wowAccountGUID` | WOWGUID | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountInfo` | BNetAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accountInfo = C_BattleNet.GetFriendAccountInfo(1)
```

### C_BattleNet.GetFriendGameAccountInfo

```lua
gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(friendIndex, accountIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendIndex` | luaIndex | no |  |
| `accountIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountInfo` | BNetGameAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(1, 1)
```

### C_BattleNet.GetFriendInviteInfo

```lua
inviteInfo = C_BattleNet.GetFriendInviteInfo(inviteIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteInfo` | BNetFriendInviteInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inviteInfo = C_BattleNet.GetFriendInviteInfo(1)
```

### C_BattleNet.GetFriendNumGameAccounts

```lua
numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(friendIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numGameAccounts` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(1)
```

### C_BattleNet.GetGameAccountInfoByGUID

```lua
gameAccountInfo = C_BattleNet.GetGameAccountInfoByGUID(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountInfo` | BNetGameAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameAccountInfo = C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
```

### C_BattleNet.GetGameAccountInfoByID

```lua
gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountInfo` | BNetGameAccountInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(0)
```

### C_BattleNet.InstallHighResTextures

```lua
C_BattleNet.InstallHighResTextures()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.InstallHighResTextures()
```

### C_BattleNet.InviteFriend

```lua
C_BattleNet.InviteFriend(gameAccountID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.InviteFriend(0)
```

### C_BattleNet.IsBattleNetFriendsListEnabled

```lua
isBattleNetFriendsListEnabled = C_BattleNet.IsBattleNetFriendsListEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBattleNetFriendsListEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBattleNetFriendsListEnabled = C_BattleNet.IsBattleNetFriendsListEnabled()
```

### C_BattleNet.IsBattleNetFriendsListSupported

```lua
isBattleNetFriendsListSupported = C_BattleNet.IsBattleNetFriendsListSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBattleNetFriendsListSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBattleNetFriendsListSupported = C_BattleNet.IsBattleNetFriendsListSupported()
```

### C_BattleNet.IsFriendTagSupportedForCurrentGameType

```lua
isFriendTagSupportedForCurrentGameType = C_BattleNet.IsFriendTagSupportedForCurrentGameType(friendTag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendTag` | BattleNetFriendTag | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFriendTagSupportedForCurrentGameType` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFriendTagSupportedForCurrentGameType = C_BattleNet.IsFriendTagSupportedForCurrentGameType(friendTag)
```

### C_BattleNet.SearchFriends

```lua
friendsData = C_BattleNet.SearchFriends(searchInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchInfo` | AuroraFriendsSearchInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendsData` | luaIndex[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local friendsData = C_BattleNet.SearchFriends(searchInfo)
```

### C_BattleNet.SendGameData

```lua
result = C_BattleNet.SendGameData(gameAccountID, prefix, data)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountID` | number | no |  |
| `prefix` | stringView | no |  |
| `data` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendAddonMessageResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_BattleNet.SendGameData(0, prefix, data)
```

### C_BattleNet.SendTitleFriendInviteByName

```lua
C_BattleNet.SendTitleFriendInviteByName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SendTitleFriendInviteByName("")
```

### C_BattleNet.SendVerifiedBattleNetFriendInvite

```lua
C_BattleNet.SendVerifiedBattleNetFriendInvite()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SendVerifiedBattleNetFriendInvite()
```

### C_BattleNet.SendWhisper

```lua
success = C_BattleNet.SendWhisper(bnetAccountID, text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bnetAccountID` | number | no |  |
| `text` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_BattleNet.SendWhisper(0, text)
```

### C_BattleNet.SetAFK

```lua
C_BattleNet.SetAFK(isAFK)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAFK` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SetAFK(false)
```

### C_BattleNet.SetAppearOffline

```lua
C_BattleNet.SetAppearOffline(isAppearOffline)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAppearOffline` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SetAppearOffline(false)
```

### C_BattleNet.SetCustomMessage

```lua
success = C_BattleNet.SetCustomMessage(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_BattleNet.SetCustomMessage("")
```

### C_BattleNet.SetCustomTitleFriendName

```lua
C_BattleNet.SetCustomTitleFriendName(id, customName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `customName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SetCustomTitleFriendName(0, "")
```

### C_BattleNet.SetDND

```lua
C_BattleNet.SetDND(isDND)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDND` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SetDND(false)
```

### C_BattleNet.SetFriendTags

```lua
C_BattleNet.SetFriendTags(id, friendTags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `friendTags` | BattleNetFriendTag[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_BattleNet.SetFriendTags(0, friendTags)
```

## Types

### AuroraFriendsSearchInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchText` | string | no |  |
| `isOnline` | bool | no |  |
| `isOffline` | bool | no |  |
| `isDND` | bool | no |  |
| `isAFK` | bool | no |  |
| `isInQueue` | bool | no |  |
| `isAvailableForQueue` | bool | no |  |
| `tags` | BattleNetFriendTag[] | no |  |

### BNetAccountInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bnetAccountID` | number | no |  |
| `accountName` | string | no |  |
| `battleTag` | string | no |  |
| `isFriend` | bool | no |  |
| `isBattleTagFriend` | bool | no |  |
| `friendLevel` | BattleNetFriendLevel | yes |  |
| `lastOnlineTime` | number | no |  |
| `isAFK` | bool | no |  |
| `isDND` | bool | no |  |
| `isFavorite` | bool | no |  |
| `friendTags` | BattleNetFriendTag[] | no |  |
| `appearOffline` | bool | no |  |
| `customMessage` | string | no |  |
| `customMessageTime` | number | no |  |
| `note` | string | no |  |
| `rafLinkType` | RafLinkType | no |  |
| `gameAccountInfo` | BNetGameAccountInfo | no |  |

### BNetFriendInviteInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteID` | number | no |  |
| `accountName` | kstringAuroraName | no |  |
| `creationTimestamp` | number | no |  |
| `friendLevel` | BattleNetFriendLevel | yes |  |

### BNetGameAccountInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountID` | number | no |  |
| `clientProgram` | string | no |  |
| `isOnline` | bool | no |  |
| `isGameBusy` | bool | no |  |
| `isGameAFK` | bool | no |  |
| `isAppearOffline` | bool | no |  |
| `wowProjectID` | number | yes |  |
| `characterName` | string | yes |  |
| `realmName` | string | yes |  |
| `realmDisplayName` | string | yes |  |
| `realmID` | number | yes |  |
| `factionName` | string | yes |  |
| `raceName` | string | yes |  |
| `classID` | number | yes |  |
| `className` | string | yes |  |
| `classFilename` | cstring | yes |  |
| `areaName` | string | yes |  |
| `characterLevel` | number | yes |  |
| `richPresence` | string | yes |  |
| `playerGuid` | WOWGUID | yes |  |
| `canSummon` | bool | no |  |
| `hasFocus` | bool | no |  |
| `regionID` | number | no |  |
| `isInCurrentRegion` | bool | no |  |
| `timerunningSeasonID` | number | yes |  |

