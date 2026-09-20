# C_PartyInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**55** functions · **33** events · **1** types

## Functions

### C_PartyInfo.AllowedToDoPartyConversion

```lua
allowed = C_PartyInfo.AllowedToDoPartyConversion(toRaid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `toRaid` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowed = C_PartyInfo.AllowedToDoPartyConversion(false)
```

### C_PartyInfo.CanFormCrossFactionParties

```lua
canFormCrossFactionParties = C_PartyInfo.CanFormCrossFactionParties()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canFormCrossFactionParties` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canFormCrossFactionParties = C_PartyInfo.CanFormCrossFactionParties()
```

### C_PartyInfo.CanInvite

```lua
allowedToInvite = C_PartyInfo.CanInvite()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowedToInvite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allowedToInvite = C_PartyInfo.CanInvite()
```

### C_PartyInfo.CanStartInstanceAbandonVote

Returns whether it's possible to start a vote at this time

```lua
canStart = C_PartyInfo.CanStartInstanceAbandonVote()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canStart` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canStart = C_PartyInfo.CanStartInstanceAbandonVote()
```

### C_PartyInfo.ChallengeModeRestrictionsActive

```lua
restrictionsActive = C_PartyInfo.ChallengeModeRestrictionsActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictionsActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restrictionsActive = C_PartyInfo.ChallengeModeRestrictionsActive()
```

### C_PartyInfo.ConfirmConvertToRaid

Immediately convert to raid with no regard for potentially destructive actions.

```lua
C_PartyInfo.ConfirmConvertToRaid()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmConvertToRaid()
```

### C_PartyInfo.ConfirmInviteTravelPass

```lua
C_PartyInfo.ConfirmInviteTravelPass(targetName, targetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `targetGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmInviteTravelPass("", UnitGUID("player"))
```

### C_PartyInfo.ConfirmInviteUnit

Immediately invites the named unit to a party, with no regard for potentially destructive actions.

```lua
C_PartyInfo.ConfirmInviteUnit(targetName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmInviteUnit("")
```

### C_PartyInfo.ConfirmLeaveParty

Immediately leave the party with no regard for potentially destructive actions

```lua
C_PartyInfo.ConfirmLeaveParty([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmLeaveParty()
```

### C_PartyInfo.ConfirmReadyCheck

```lua
C_PartyInfo.ConfirmReadyCheck(isReady)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmReadyCheck(false)
```

### C_PartyInfo.ConfirmRequestInviteFromUnit

Immediately request an invite into the target party, this is the confirmation function to call after RequestInviteFromUnit, or if you would like to skip the confirmation process.

```lua
C_PartyInfo.ConfirmRequestInviteFromUnit(targetName, [tank], [healer], [dps])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `tank` | bool | yes |  |
| `healer` | bool | yes |  |
| `dps` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConfirmRequestInviteFromUnit("")
```

### C_PartyInfo.ConvertToParty

```lua
C_PartyInfo.ConvertToParty()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConvertToParty()
```

### C_PartyInfo.ConvertToRaid

Usually this will convert to raid immediately. In some cases (e.g. PartySync) the user will be prompted to confirm converting to raid, because it's potentially destructive.

```lua
C_PartyInfo.ConvertToRaid()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.ConvertToRaid()
```

### C_PartyInfo.DelveTeleportOut

```lua
C_PartyInfo.DelveTeleportOut()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.DelveTeleportOut()
```

### C_PartyInfo.DemoteAssistant

```lua
C_PartyInfo.DemoteAssistant(name, [exactNameMatch])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `exactNameMatch` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.DemoteAssistant("")
```

### C_PartyInfo.DoCountdown

```lua
success = C_PartyInfo.DoCountdown(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_PartyInfo.DoCountdown(0)
```

### C_PartyInfo.DoReadyCheck

```lua
C_PartyInfo.DoReadyCheck()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.DoReadyCheck()
```

### C_PartyInfo.GetActiveCategories

```lua
categories = C_PartyInfo.GetActiveCategories()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categories` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categories = C_PartyInfo.GetActiveCategories()
```

### C_PartyInfo.GetAvailableLootMethods

```lua
methods = C_PartyInfo.GetAvailableLootMethods()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `methods` | LootMethod[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local methods = C_PartyInfo.GetAvailableLootMethods()
```

### C_PartyInfo.GetInstanceAbandonShutdownTime

Returns the total duration of the shutdown time after a vote passes and how much time is left before it ends

```lua
durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonShutdownTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSeconds` | number | no | (default: 0) |
| `timeLeftSeconds` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonShutdownTime()
```

### C_PartyInfo.GetInstanceAbandonVoteCooldownTime

Returns the total duration of the abandon vote cooldown and how much time is left before it ends

```lua
durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonVoteCooldownTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSeconds` | number | no | (default: 0) |
| `timeLeftSeconds` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonVoteCooldownTime()
```

### C_PartyInfo.GetInstanceAbandonVoteRequirements

Returns values controlling the vote

```lua
votesRequired, keystoneOwnerVoteWeight = C_PartyInfo.GetInstanceAbandonVoteRequirements()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `votesRequired` | number | no | (default: 0) |
| `keystoneOwnerVoteWeight` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local votesRequired, keystoneOwnerVoteWeight = C_PartyInfo.GetInstanceAbandonVoteRequirements()
```

### C_PartyInfo.GetInstanceAbandonVoteResponse

Returns how the player voted, nil for not yet

```lua
response = C_PartyInfo.GetInstanceAbandonVoteResponse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `response` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local response = C_PartyInfo.GetInstanceAbandonVoteResponse()
```

### C_PartyInfo.GetInstanceAbandonVoteTime

Returns the total duration of the vote and how much time is left before it ends

```lua
durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonVoteTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSeconds` | number | no | (default: 0) |
| `timeLeftSeconds` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSeconds, timeLeftSeconds = C_PartyInfo.GetInstanceAbandonVoteTime()
```

### C_PartyInfo.GetInviteConfirmationInvalidQueues

```lua
invalidQueues = C_PartyInfo.GetInviteConfirmationInvalidQueues(inviteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invalidQueues` | QueueSpecificInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invalidQueues = C_PartyInfo.GetInviteConfirmationInvalidQueues(UnitGUID("player"))
```

### C_PartyInfo.GetInviteReferralInfo

```lua
outReferredByGuid, outReferredByName, outRelationType, outIsQuickJoin, outClubId = C_PartyInfo.GetInviteReferralInfo(inviteGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outReferredByGuid` | WOWGUID | no |  |
| `outReferredByName` | cstring | no |  |
| `outRelationType` | PartyRequestJoinRelation | no |  |
| `outIsQuickJoin` | bool | no |  |
| `outClubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local outReferredByGuid, outReferredByName, outRelationType, outIsQuickJoin, outClubId = C_PartyInfo.GetInviteReferralInfo(UnitGUID("player"))
```

### C_PartyInfo.GetLootMethod

```lua
method, masterLootPartyID, masterLooterRaidID = C_PartyInfo.GetLootMethod()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `method` | LootMethod | no |  |
| `masterLootPartyID` | number | yes |  |
| `masterLooterRaidID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local method, masterLootPartyID, masterLooterRaidID = C_PartyInfo.GetLootMethod()
```

### C_PartyInfo.GetLootMethodStyle

```lua
methodStyle = C_PartyInfo.GetLootMethodStyle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `methodStyle` | LootMethodStyles | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local methodStyle = C_PartyInfo.GetLootMethodStyle()
```

### C_PartyInfo.GetMinItemLevel

```lua
minItemLevel, playerNameWithLowestItemLevel = C_PartyInfo.GetMinItemLevel(avgItemLevelCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `avgItemLevelCategory` | AvgItemLevelCategories | no | The active party is always used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minItemLevel` | number | no |  |
| `playerNameWithLowestItemLevel` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minItemLevel, playerNameWithLowestItemLevel = C_PartyInfo.GetMinItemLevel(6948)
```

### C_PartyInfo.GetMinLevel

```lua
minLevel = C_PartyInfo.GetMinLevel([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | yes | If not provided, the active party is used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minLevel = C_PartyInfo.GetMinLevel()
```

### C_PartyInfo.GetNumInstanceAbandonGroupVoteResponses

Returns how many players have voted either way

```lua
count = C_PartyInfo.GetNumInstanceAbandonGroupVoteResponses()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = C_PartyInfo.GetNumInstanceAbandonGroupVoteResponses()
```

### C_PartyInfo.GetRestrictPings

```lua
restrictTo = C_PartyInfo.GetRestrictPings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictTo` | RestrictPingsTo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restrictTo = C_PartyInfo.GetRestrictPings()
```

### C_PartyInfo.InviteUnit

Attempt to invite the named unit to a party, requires confirmation in some cases (e.g. the party will convert to a raid, or if there is a party sync in progress).

```lua
C_PartyInfo.InviteUnit(targetName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.InviteUnit("")
```

### C_PartyInfo.IsChallengeModeActive

```lua
active = C_PartyInfo.IsChallengeModeActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_PartyInfo.IsChallengeModeActive()
```

### C_PartyInfo.IsChallengeModeKeystoneOwner

```lua
isKeystoneOwner = C_PartyInfo.IsChallengeModeKeystoneOwner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKeystoneOwner` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isKeystoneOwner = C_PartyInfo.IsChallengeModeKeystoneOwner()
```

### C_PartyInfo.IsCrossFactionParty

```lua
isCrossFactionParty = C_PartyInfo.IsCrossFactionParty([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | yes | If not provided, the active party is used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCrossFactionParty` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCrossFactionParty = C_PartyInfo.IsCrossFactionParty()
```

### C_PartyInfo.IsDelveComplete

```lua
isDelveComplete = C_PartyInfo.IsDelveComplete()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDelveComplete` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDelveComplete = C_PartyInfo.IsDelveComplete()
```

### C_PartyInfo.IsDelveInProgress

```lua
isDelveComplete = C_PartyInfo.IsDelveInProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDelveComplete` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDelveComplete = C_PartyInfo.IsDelveInProgress()
```

### C_PartyInfo.IsGUIDInGroup

```lua
isInGroup = C_PartyInfo.IsGUIDInGroup(guid, [category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `category` | luaIndex | yes | If not provided, the active party is used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInGroup` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInGroup = C_PartyInfo.IsGUIDInGroup(UnitGUID("player"))
```

### C_PartyInfo.IsLootMethodAvailable

```lua
available = C_PartyInfo.IsLootMethodAvailable(method)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `method` | LootMethod | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `available` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local available = C_PartyInfo.IsLootMethodAvailable(method)
```

### C_PartyInfo.IsPartyFull

```lua
isFull = C_PartyInfo.IsPartyFull([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | yes | If not provided, the active party is used |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFull` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFull = C_PartyInfo.IsPartyFull()
```

### C_PartyInfo.IsPartyInJailersTower

```lua
isPartyInJailersTower = C_PartyInfo.IsPartyInJailersTower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPartyInJailersTower` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPartyInJailersTower = C_PartyInfo.IsPartyInJailersTower()
```

### C_PartyInfo.IsPartyWalkIn

```lua
isPartyWalkIn = C_PartyInfo.IsPartyWalkIn()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPartyWalkIn` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPartyWalkIn = C_PartyInfo.IsPartyWalkIn()
```

### C_PartyInfo.IsRaidListEnabled

```lua
isRaidListEnabled = C_PartyInfo.IsRaidListEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRaidListEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRaidListEnabled = C_PartyInfo.IsRaidListEnabled()
```

### C_PartyInfo.IsRaidListSupported

```lua
isRaidListSupported = C_PartyInfo.IsRaidListSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRaidListSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRaidListSupported = C_PartyInfo.IsRaidListSupported()
```

### C_PartyInfo.LeaveParty

Usually this will leave the party immediately. In some cases (e.g. PartySync) the user will be prompted to confirm leaving the party, because it's potentially destructive

```lua
C_PartyInfo.LeaveParty([category])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.LeaveParty()
```

### C_PartyInfo.PromoteToAssistant

```lua
C_PartyInfo.PromoteToAssistant(name, [exactNameMatch])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `exactNameMatch` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.PromoteToAssistant("")
```

### C_PartyInfo.PromoteToLeader

```lua
C_PartyInfo.PromoteToLeader(name, [exactNameMatch])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `exactNameMatch` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.PromoteToLeader("")
```

### C_PartyInfo.RequestInviteFromUnit

Attempt to request an invite into the target party, requires confirmation in some cases (e.g. there is a party sync in progress).

```lua
C_PartyInfo.RequestInviteFromUnit(targetName, [tank], [healer], [dps])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `tank` | bool | yes |  |
| `healer` | bool | yes |  |
| `dps` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.RequestInviteFromUnit("")
```

### C_PartyInfo.SetEveryoneIsAssistant

```lua
updated = C_PartyInfo.SetEveryoneIsAssistant(isAssistant)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAssistant` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local updated = C_PartyInfo.SetEveryoneIsAssistant(false)
```

### C_PartyInfo.SetInstanceAbandonVoteResponse

Vote on whether to abandon instance, true for yes, false for no

```lua
C_PartyInfo.SetInstanceAbandonVoteResponse(response)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `response` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.SetInstanceAbandonVoteResponse(false)
```

### C_PartyInfo.SetLootMethod

```lua
success = C_PartyInfo.SetLootMethod(method, [lootMaster])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `method` | LootMethod | no |  |
| `lootMaster` | string | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_PartyInfo.SetLootMethod(method)
```

### C_PartyInfo.SetRestrictPings

```lua
C_PartyInfo.SetRestrictPings(restrictTo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictTo` | RestrictPingsTo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.SetRestrictPings(restrictTo)
```

### C_PartyInfo.StartInstanceAbandonVote

Start the vote

```lua
C_PartyInfo.StartInstanceAbandonVote()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.StartInstanceAbandonVote()
```

### C_PartyInfo.UninviteUnit

```lua
C_PartyInfo.UninviteUnit(name, [reason], [exactNameMatch])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `reason` | cstring | yes |  |
| `exactNameMatch` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyInfo.UninviteUnit("")
```

## Events

### BNET_REQUEST_INVITE_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameAccountID` | number | no |  |
| `questSessionActive` | bool | no |  |
| `tank` | bool | no |  |
| `healer` | bool | no |  |
| `dps` | bool | no |  |

### CONVERT_TO_RAID_CONFIRMATION

### ENTERED_DIFFERENT_INSTANCE_FROM_PARTY

### GROUP_FORMED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | number | no |  |
| `partyGUID` | WOWGUID | no |  |

### GROUP_INVITE_CONFIRMATION

### GROUP_JOINED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | number | no |  |
| `partyGUID` | WOWGUID | no |  |

### GROUP_LEFT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | number | no |  |
| `partyGUID` | WOWGUID | no |  |

### GROUP_ROSTER_UPDATE

### INSTANCE_ABANDON_VOTE_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `votePassed` | bool | no |  |

### INSTANCE_ABANDON_VOTE_STARTED

### INSTANCE_ABANDON_VOTE_UPDATED

### INSTANCE_BOOT_START

### INSTANCE_BOOT_STOP

### INSTANCE_GROUP_SIZE_CHANGED

### INVITE_TO_PARTY_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `willConvertToRaid` | bool | no |  |
| `questSessionActive` | bool | no |  |

### INVITE_TRAVEL_PASS_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `targetGUID` | WOWGUID | no |  |
| `willConvertToRaid` | bool | no |  |
| `questSessionActive` | bool | no |  |

### LEAVE_PARTY_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | LeavePartyConfirmReason | no |  |

### PARTY_INVITE_CANCEL

### PARTY_INVITE_REQUEST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `isTank` | bool | no |  |
| `isHealer` | bool | no |  |
| `isDamage` | bool | no |  |
| `isNativeRealm` | bool | no |  |
| `allowMultipleRoles` | bool | no |  |
| `inviterGUID` | WOWGUID | no |  |
| `questSessionActive` | bool | no |  |

### PARTY_LEADER_CHANGED

### PARTY_LFG_RESTRICTED

### PARTY_LOOT_METHOD_CHANGED

### PARTY_MEMBER_DISABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PARTY_MEMBER_ENABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_DIFFICULTY_CHANGED

### PLAYER_ROLES_ASSIGNED

### RAID_ROSTER_UPDATE

### READY_CHECK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiatorName` | cstring | no |  |
| `readyCheckTimeLeft` | time_t | no |  |

### READY_CHECK_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `isReady` | bool | no |  |

### READY_CHECK_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `preempted` | bool | no |  |

### REQUEST_INVITE_CONFIRMATION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |
| `partyLevelLink` | number | no |  |
| `questSessionActive` | bool | no |  |
| `tank` | bool | yes |  |
| `healer` | bool | yes |  |
| `dps` | bool | yes |  |

### SOCIAL_UI_RAID_LIST_SYSTEM_STATUS_UPDATED

### VOTE_KICK_REASON_NEEDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `resultGUID` | WOWGUID | no |  |

## Types

### LeavePartyConfirmReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `QuestSync` | LeavePartyConfirmReason | no |  |
| `RestrictedChallengeMode` | LeavePartyConfirmReason | no |  |

