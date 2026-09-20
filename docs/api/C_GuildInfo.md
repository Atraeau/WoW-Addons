# C_GuildInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**39** functions · **33** events · **2** types

## Functions

### C_GuildInfo.AreGuildEventsEnabled

```lua
enabled = C_GuildInfo.AreGuildEventsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GuildInfo.AreGuildEventsEnabled()
```

### C_GuildInfo.CanEditOfficerNote

```lua
canEditOfficerNote = C_GuildInfo.CanEditOfficerNote()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEditOfficerNote` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canEditOfficerNote = C_GuildInfo.CanEditOfficerNote()
```

### C_GuildInfo.CanSpeakInGuildChat

```lua
canSpeakInGuildChat = C_GuildInfo.CanSpeakInGuildChat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSpeakInGuildChat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSpeakInGuildChat = C_GuildInfo.CanSpeakInGuildChat()
```

### C_GuildInfo.CanViewOfficerNote

```lua
canViewOfficerNote = C_GuildInfo.CanViewOfficerNote()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canViewOfficerNote` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canViewOfficerNote = C_GuildInfo.CanViewOfficerNote()
```

### C_GuildInfo.Demote

```lua
C_GuildInfo.Demote(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Demote("")
```

### C_GuildInfo.Disband

```lua
C_GuildInfo.Disband()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Disband()
```

### C_GuildInfo.GetGuildNewsInfo

```lua
newsInfo = C_GuildInfo.GetGuildNewsInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newsInfo` | GuildNewsInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local newsInfo = C_GuildInfo.GetGuildNewsInfo(1)
```

### C_GuildInfo.GetGuildRankOrder

```lua
rankOrder = C_GuildInfo.GetGuildRankOrder(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rankOrder` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rankOrder = C_GuildInfo.GetGuildRankOrder(UnitGUID("player"))
```

### C_GuildInfo.GetGuildTabardInfo

```lua
tabardInfo = C_GuildInfo.GetGuildTabardInfo([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabardInfo` | GuildTabardInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tabardInfo = C_GuildInfo.GetGuildTabardInfo()
```

### C_GuildInfo.GetInfoText

```lua
infoText = C_GuildInfo.GetInfoText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infoText` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infoText = C_GuildInfo.GetInfoText()
```

### C_GuildInfo.GetMOTD

```lua
motd = C_GuildInfo.GetMOTD()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `motd` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local motd = C_GuildInfo.GetMOTD()
```

### C_GuildInfo.GetPreferredPlaySettings

```lua
loaded, preferredLocaleID, preferredDatacenterLocalityID, lastPreferredLocaleChangeDate, lastPreferredDatacenterLocalityChangeDate, changeCooldownDays = C_GuildInfo.GetPreferredPlaySettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loaded` | bool | no |  |
| `preferredLocaleID` | number | no |  |
| `preferredDatacenterLocalityID` | number | no |  |
| `lastPreferredLocaleChangeDate` | time_t | no |  |
| `lastPreferredDatacenterLocalityChangeDate` | time_t | no |  |
| `changeCooldownDays` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loaded, preferredLocaleID, preferredDatacenterLocalityID, lastPreferredLocaleChangeDate, lastPreferredDatacenterLocalityChangeDate, changeCooldownDays = C_GuildInfo.GetPreferredPlaySettings()
```

### C_GuildInfo.GetPreferredPlaySettingsFeatures

```lua
canChangeLocale, canChangeDatacenterLocality = C_GuildInfo.GetPreferredPlaySettingsFeatures()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChangeLocale` | bool | no |  |
| `canChangeDatacenterLocality` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canChangeLocale, canChangeDatacenterLocality = C_GuildInfo.GetPreferredPlaySettingsFeatures()
```

### C_GuildInfo.GuildControlGetRankFlags

```lua
permissions = C_GuildInfo.GuildControlGetRankFlags(rankOrder)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rankOrder` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `permissions` | bool[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local permissions = C_GuildInfo.GuildControlGetRankFlags(1)
```

### C_GuildInfo.GuildRoster

```lua
C_GuildInfo.GuildRoster()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.GuildRoster()
```

### C_GuildInfo.Invite

```lua
C_GuildInfo.Invite(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Invite("")
```

### C_GuildInfo.IsDiscordStreamSeparate

```lua
separateStream = C_GuildInfo.IsDiscordStreamSeparate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `separateStream` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local separateStream = C_GuildInfo.IsDiscordStreamSeparate()
```

### C_GuildInfo.IsEncounterGuildNewsEnabled

```lua
enabled = C_GuildInfo.IsEncounterGuildNewsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GuildInfo.IsEncounterGuildNewsEnabled()
```

### C_GuildInfo.IsGuildOfficer

```lua
isOfficer = C_GuildInfo.IsGuildOfficer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOfficer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isOfficer = C_GuildInfo.IsGuildOfficer()
```

### C_GuildInfo.IsGuildRankAssignmentAllowed

```lua
isGuildRankAssignmentAllowed = C_GuildInfo.IsGuildRankAssignmentAllowed(guid, rankOrder)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `rankOrder` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGuildRankAssignmentAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isGuildRankAssignmentAllowed = C_GuildInfo.IsGuildRankAssignmentAllowed(UnitGUID("player"), 1)
```

### C_GuildInfo.IsGuildReputationEnabled

```lua
enabled = C_GuildInfo.IsGuildReputationEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GuildInfo.IsGuildReputationEnabled()
```

### C_GuildInfo.Leave

```lua
C_GuildInfo.Leave()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Leave()
```

### C_GuildInfo.MemberExistsByName

```lua
exists = C_GuildInfo.MemberExistsByName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exists` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local exists = C_GuildInfo.MemberExistsByName("")
```

### C_GuildInfo.Promote

```lua
C_GuildInfo.Promote(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Promote("")
```

### C_GuildInfo.QueryGuildMemberRecipes

```lua
C_GuildInfo.QueryGuildMemberRecipes(guildMemberGUID, skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildMemberGUID` | WOWGUID | no |  |
| `skillLineID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.QueryGuildMemberRecipes(UnitGUID("player"), 0)
```

### C_GuildInfo.QueryGuildMembersForRecipe

```lua
updatedRecipeSpellID = C_GuildInfo.QueryGuildMembersForRecipe(skillLineID, recipeSpellID, [recipeLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |
| `recipeSpellID` | number | no |  |
| `recipeLevel` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updatedRecipeSpellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local updatedRecipeSpellID = C_GuildInfo.QueryGuildMembersForRecipe(0, 2050)
```

### C_GuildInfo.RemoveFromGuild

```lua
C_GuildInfo.RemoveFromGuild(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.RemoveFromGuild(UnitGUID("player"))
```

### C_GuildInfo.RequestGuildRename

```lua
C_GuildInfo.RequestGuildRename(desiredName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desiredName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.RequestGuildRename("")
```

### C_GuildInfo.RequestGuildRenameRefund

```lua
C_GuildInfo.RequestGuildRenameRefund()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.RequestGuildRenameRefund()
```

### C_GuildInfo.RequestPreferredPlaySettings

```lua
startedSuccessfully = C_GuildInfo.RequestPreferredPlaySettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startedSuccessfully` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local startedSuccessfully = C_GuildInfo.RequestPreferredPlaySettings()
```

### C_GuildInfo.RequestRenameNameCheck

```lua
C_GuildInfo.RequestRenameNameCheck(desiredName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desiredName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.RequestRenameNameCheck("")
```

### C_GuildInfo.RequestRenameStatus

```lua
ableToRequest = C_GuildInfo.RequestRenameStatus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ableToRequest` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ableToRequest = C_GuildInfo.RequestRenameStatus()
```

### C_GuildInfo.SetGuildRankOrder

```lua
C_GuildInfo.SetGuildRankOrder(guid, rankOrder)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `rankOrder` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.SetGuildRankOrder(UnitGUID("player"), 1)
```

### C_GuildInfo.SetInfoText

```lua
C_GuildInfo.SetInfoText(infoText)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infoText` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.SetInfoText("")
```

### C_GuildInfo.SetLeader

```lua
C_GuildInfo.SetLeader(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.SetLeader("")
```

### C_GuildInfo.SetMOTD

```lua
C_GuildInfo.SetMOTD(motd)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `motd` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.SetMOTD("")
```

### C_GuildInfo.SetNote

```lua
C_GuildInfo.SetNote(guid, note, isPublic)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `note` | cstring | no |  |
| `isPublic` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.SetNote(UnitGUID("player"), "", false)
```

### C_GuildInfo.SetPreferredPlaySettings

```lua
startedSuccessfully = C_GuildInfo.SetPreferredPlaySettings(preferredLocaleID, preferredDatacenterLocalityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `preferredLocaleID` | number | no | (default: 0) |
| `preferredDatacenterLocalityID` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startedSuccessfully` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local startedSuccessfully = C_GuildInfo.SetPreferredPlaySettings(0, 0)
```

### C_GuildInfo.Uninvite

```lua
C_GuildInfo.Uninvite(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GuildInfo.Uninvite("")
```

## Events

### CLOSE_TABARD_FRAME

### DISABLE_DECLINE_GUILD_INVITE

### ENABLE_DECLINE_GUILD_INVITE

### GUILD_CHALLENGE_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `challengeType` | number | no |  |
| `currentCount` | number | no |  |
| `maxCount` | number | no |  |
| `goldAwarded` | number | no |  |

### GUILD_CHALLENGE_UPDATED

### GUILD_EVENT_LOG_UPDATE

### GUILD_INVITE_CANCEL

### GUILD_INVITE_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviter` | cstring | no |  |
| `guildName` | cstring | no |  |
| `guildAchievementPoints` | number | no |  |
| `oldGuildName` | cstring | no |  |
| `isNewGuild` | bool | yes |  |
| `tabardInfo` | GuildTabardInfo | yes |  |

### GUILD_MOTD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `motdText` | cstring | no |  |

### GUILD_NEWS_UPDATE

### GUILD_PARTY_STATE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inGuildParty` | bool | no |  |

### GUILD_PREFERRED_PLAY_SETTINGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | PreferredPlaySettingsStatus | no |  |
| `preferredLocaleID` | number | no |  |
| `preferredDatacenterLocalityID` | number | no |  |
| `lastPreferredLocaleChangeDate` | time_t | no |  |
| `lastPreferredDatacenterLocalityChangeDate` | time_t | no |  |

### GUILD_RANKS_UPDATE

### GUILD_RANKS_UPDATE_ACTIVE_PLAYER

### GUILD_RECIPE_KNOWN_BY_MEMBERS

### GUILD_REGISTRAR_CLOSED

### GUILD_REGISTRAR_SHOW

### GUILD_RENAME_NAME_CHECK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desiredName` | cstring | no |  |
| `status` | GuildErrorType | no |  |
| `nameErrorToken` | cstring | yes |  |

### GUILD_RENAME_REFUND_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildName` | cstring | no |  |
| `status` | GuildErrorType | no |  |

### GUILD_RENAME_REQUIRED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flagSet` | bool | no |  |

### GUILD_RENAME_STATUS_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | GuildRenameStatus | no |  |

### GUILD_REWARDS_LIST

### GUILD_REWARDS_LIST_UPDATE

### GUILD_ROSTER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRequestRosterUpdate` | bool | no |  |

### GUILDTABARD_UPDATE

### GUILD_TRADESKILL_UPDATE

### OPEN_TABARD_FRAME

### PLAYER_GUILD_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### REQUESTED_GUILD_RENAME_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newName` | cstring | no |  |
| `status` | GuildErrorType | no |  |

### REQUIRED_GUILD_RENAME_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### TABARD_CANSAVE_CHANGED

### TABARD_SAVE_PENDING

### UNIT_GUILD_LEVEL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newLevel` | number | no |  |

## Types

### GuildNewsInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSticky` | bool | no |  |
| `isHeader` | bool | no |  |
| `newsType` | number | no |  |
| `whoText` | string | yes |  |
| `whatText` | string | yes |  |
| `newsDataID` | number | no |  |
| `data` | number[] | no |  |
| `weekday` | number | no |  |
| `day` | number | no |  |
| `month` | number | no |  |
| `year` | number | no |  |
| `guildMembersPresent` | number | no |  |

### GuildRenameStatus (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNameChangeEnabled` | bool | no |  |
| `isPlayerGuildMaster` | bool | no |  |
| `refundEligibleEndTime` | time_t | no |  |
| `nextRenameTime` | time_t | no |  |
| `renamePrice` | WOWMONEY | no |  |
| `refundAmount` | WOWMONEY | no |  |
| `currentGuildMoney` | WOWMONEY | no |  |
| `result` | GuildErrorType | no |  |
| `oldGuildName` | cstring | no |  |
| `reservedName` | cstring | no |  |
| `reservedNameExpirationTime` | time_t | no |  |

