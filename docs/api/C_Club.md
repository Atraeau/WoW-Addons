# C_Club

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**84** functions · **30** events · **24** types

## Functions

### C_Club.AcceptInvitation

```lua
C_Club.AcceptInvitation(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.AcceptInvitation(clubId)
```

### C_Club.AddClubStreamChatChannel

```lua
C_Club.AddClubStreamChatChannel(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.AddClubStreamChatChannel(clubId, streamId)
```

### C_Club.AdvanceStreamViewMarker

```lua
C_Club.AdvanceStreamViewMarker(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.AdvanceStreamViewMarker(clubId, streamId)
```

### C_Club.AreMembersReady

```lua
membersReady = C_Club.AreMembersReady(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `membersReady` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local membersReady = C_Club.AreMembersReady(clubId)
```

### C_Club.AssignMemberRole

```lua
C_Club.AssignMemberRole(clubId, memberId, roleId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |
| `roleId` | ClubRoleIdentifier | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.AssignMemberRole(clubId, memberId, roleId)
```

### C_Club.CanResolvePlayerLocationFromClubMessageData

```lua
canResolve = C_Club.CanResolvePlayerLocationFromClubMessageData(clubId, streamId, epoch, position)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `epoch` | BigUInteger | no |  |
| `position` | BigUInteger | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canResolve` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canResolve = C_Club.CanResolvePlayerLocationFromClubMessageData(clubId, streamId, epoch, position)
```

### C_Club.ClearAutoAdvanceStreamViewMarker

```lua
C_Club.ClearAutoAdvanceStreamViewMarker()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.ClearAutoAdvanceStreamViewMarker()
```

### C_Club.ClearClubPresenceSubscription

```lua
C_Club.ClearClubPresenceSubscription()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.ClearClubPresenceSubscription()
```

### C_Club.CompareBattleNetDisplayName

```lua
comparison = C_Club.CompareBattleNetDisplayName(clubId, lhsMemberId, rhsMemberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `lhsMemberId` | number | no |  |
| `rhsMemberId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comparison` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local comparison = C_Club.CompareBattleNetDisplayName(clubId, 0, 0)
```

### C_Club.CreateClub

```lua
C_Club.CreateClub(name, [shortName], description, clubType, avatarId, [isCrossFaction])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `shortName` | string | yes |  |
| `description` | string | no |  |
| `clubType` | ClubType | no | Valid types are BattleNet or Character |
| `avatarId` | number | no |  |
| `isCrossFaction` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.CreateClub("", "", Enum.ClubType.BattleNet, 0)
```

### C_Club.CreateStream

Check the canCreateStream privilege.

```lua
C_Club.CreateStream(clubId, name, subject, leadersAndModeratorsOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `name` | string | no |  |
| `subject` | string | no |  |
| `leadersAndModeratorsOnly` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.CreateStream(clubId, "", "", false)
```

### C_Club.CreateTicket

Check canCreateTicket privilege.

```lua
C_Club.CreateTicket(clubId, [allowedRedeemCount], [duration], [defaultStreamId], [isCrossFaction])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `allowedRedeemCount` | number | yes | Number of uses. nil means unlimited |
| `duration` | number | yes | Duration in seconds. nil never expires |
| `defaultStreamId` | ClubStreamId | yes |  |
| `isCrossFaction` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.CreateTicket(clubId)
```

### C_Club.DeclineInvitation

```lua
C_Club.DeclineInvitation(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.DeclineInvitation(clubId)
```

### C_Club.DestroyClub

Check the canDestroy privilege.

```lua
C_Club.DestroyClub(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.DestroyClub(clubId)
```

### C_Club.DestroyMessage

```lua
C_Club.DestroyMessage(clubId, streamId, messageId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.DestroyMessage(clubId, streamId, messageId)
```

### C_Club.DestroyStream

Check canDestroyStream privilege.

```lua
C_Club.DestroyStream(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.DestroyStream(clubId, streamId)
```

### C_Club.DestroyTicket

Check canDestroyTicket privilege.

```lua
C_Club.DestroyTicket(clubId, ticketId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `ticketId` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.DestroyTicket(clubId, "")
```

### C_Club.DoesAnyCommunityHaveUnreadMessages

```lua
hasUnreadMessages = C_Club.DoesAnyCommunityHaveUnreadMessages()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUnreadMessages` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasUnreadMessages = C_Club.DoesAnyCommunityHaveUnreadMessages()
```

### C_Club.DoesCommunityHaveMembersOfTheOppositeFaction

```lua
hasMembersOfOppositeFaction = C_Club.DoesCommunityHaveMembersOfTheOppositeFaction(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMembersOfOppositeFaction` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMembersOfOppositeFaction = C_Club.DoesCommunityHaveMembersOfTheOppositeFaction(clubId)
```

### C_Club.EditClub

nil arguments will not change existing club data

```lua
C_Club.EditClub(clubId, [name], [shortName], [description], [avatarId], [broadcast], [crossFaction])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `name` | string | yes |  |
| `shortName` | string | yes |  |
| `description` | string | yes |  |
| `avatarId` | number | yes |  |
| `broadcast` | string | yes |  |
| `crossFaction` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.EditClub(clubId)
```

### C_Club.EditMessage

```lua
C_Club.EditMessage(clubId, streamId, messageId, message)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |
| `message` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.EditMessage(clubId, streamId, messageId, "")
```

### C_Club.EditStream

Check the canSetStreamName, canSetStreamSubject, canSetStreamAccess privileges. nil arguments will not change existing stream data.

```lua
C_Club.EditStream(clubId, streamId, [name], [subject], [leadersAndModeratorsOnly])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `name` | string | yes |  |
| `subject` | string | yes |  |
| `leadersAndModeratorsOnly` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.EditStream(clubId, streamId)
```

### C_Club.Flush

```lua
C_Club.Flush()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.Flush()
```

### C_Club.FocusCommunityStreams

```lua
C_Club.FocusCommunityStreams()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.FocusCommunityStreams()
```

### C_Club.FocusMembers

```lua
C_Club.FocusMembers(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.FocusMembers(clubId)
```

### C_Club.FocusStream

```lua
focused = C_Club.FocusStream(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `focused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local focused = C_Club.FocusStream(clubId, streamId)
```

### C_Club.GetAssignableRoles

```lua
assignableRoles = C_Club.GetAssignableRoles(clubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `assignableRoles` | ClubRoleIdentifier[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local assignableRoles = C_Club.GetAssignableRoles(clubId, memberId)
```

### C_Club.GetAvatarIdList

listen for AVATAR_LIST_UPDATED event. This can happen if we haven't downloaded the battle.net avatar list yet

```lua
avatarIds = C_Club.GetAvatarIdList(clubType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `avatarIds` | number[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local avatarIds = C_Club.GetAvatarIdList(Enum.ClubType.BattleNet)
```

### C_Club.GetClubCapacity

```lua
capacity = C_Club.GetClubCapacity()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `capacity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local capacity = C_Club.GetClubCapacity()
```

### C_Club.GetClubInfo

```lua
info = C_Club.GetClubInfo(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Club.GetClubInfo(clubId)
```

### C_Club.GetClubLimits

```lua
clubLimits = C_Club.GetClubLimits(clubType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubLimits` | ClubLimits | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubLimits = C_Club.GetClubLimits(Enum.ClubType.BattleNet)
```

### C_Club.GetClubMembers

```lua
members = C_Club.GetClubMembers(clubId, [streamId])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `members` | ClubMemberOpaqueId[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local members = C_Club.GetClubMembers(clubId)
```

### C_Club.GetClubPrivileges

The privileges for the logged in user for this club

```lua
privilegeInfo = C_Club.GetClubPrivileges(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `privilegeInfo` | ClubPrivilegeInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local privilegeInfo = C_Club.GetClubPrivileges(clubId)
```

### C_Club.GetClubStreamNotificationSettings

```lua
settings = C_Club.GetClubStreamNotificationSettings(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `settings` | ClubStreamNotificationSetting[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local settings = C_Club.GetClubStreamNotificationSettings(clubId)
```

### C_Club.GetCommunityNameResultText

```lua
errorCode = C_Club.GetCommunityNameResultText(result)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ValidateNameResult | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorCode` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local errorCode = C_Club.GetCommunityNameResultText(result)
```

### C_Club.GetGuildClubId

```lua
guildClubId = C_Club.GetGuildClubId()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildClubId` | ClubId | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local guildClubId = C_Club.GetGuildClubId()
```

### C_Club.GetInfoFromLastCommunityChatLine

```lua
messageInfo, clubId, streamId, clubType = C_Club.GetInfoFromLastCommunityChatLine()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageInfo` | ClubMessageInfo | no |  |
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `clubType` | ClubType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local messageInfo, clubId, streamId, clubType = C_Club.GetInfoFromLastCommunityChatLine()
```

### C_Club.GetInvitationCandidates

Returns a list of players that you can send a request to a Battle.net club. Returns an empty list for Character based clubs

```lua
candidates = C_Club.GetInvitationCandidates([filter], [maxResults], [cursorPosition], [allowFullMatch], clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filter` | string | yes |  |
| `maxResults` | number | yes |  |
| `cursorPosition` | number | yes |  |
| `allowFullMatch` | bool | yes |  |
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `candidates` | ClubInvitationCandidateInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local candidates = C_Club.GetInvitationCandidates(clubId)
```

### C_Club.GetInvitationInfo

Get info about a specific club the active player has been invited to.

```lua
invitation = C_Club.GetInvitationInfo(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitation` | ClubSelfInvitationInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invitation = C_Club.GetInvitationInfo(clubId)
```

### C_Club.GetInvitationsForClub

Get the pending invitations for this club. Call RequestInvitationsForClub() to retrieve invitations from server.

```lua
invitations = C_Club.GetInvitationsForClub(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitations` | ClubInvitationInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invitations = C_Club.GetInvitationsForClub(clubId)
```

### C_Club.GetInvitationsForSelf

These are the clubs the active player has been invited to.

```lua
invitations = C_Club.GetInvitationsForSelf()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitations` | ClubSelfInvitationInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invitations = C_Club.GetInvitationsForSelf()
```

### C_Club.GetLastTicketResponse

```lua
error, info, showError = C_Club.GetLastTicketResponse(ticket)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ticket` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | ClubErrorType | no |  |
| `info` | ClubInfo | yes |  |
| `showError` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local error, info, showError = C_Club.GetLastTicketResponse("")
```

### C_Club.GetMemberInfo

```lua
info = C_Club.GetMemberInfo(clubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubMemberInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Club.GetMemberInfo(clubId, memberId)
```

### C_Club.GetMemberInfoForSelf

Info for the logged in user for this club

```lua
info = C_Club.GetMemberInfoForSelf(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubMemberInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_Club.GetMemberInfoForSelf(clubId)
```

### C_Club.GetMessageInfo

Get info about a particular message.

```lua
message = C_Club.GetMessageInfo(clubId, streamId, messageId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `message` | ClubMessageInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local message = C_Club.GetMessageInfo(clubId, streamId, messageId)
```

### C_Club.GetMessageRanges

Get the ranges of the messages currently downloaded.

```lua
ranges = C_Club.GetMessageRanges(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ranges` | ClubMessageRange[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ranges = C_Club.GetMessageRanges(clubId, streamId)
```

### C_Club.GetMessagesBefore

Get downloaded messages before (and including) the specified messageId limited by count. These are filtered by ignored players

```lua
messages = C_Club.GetMessagesBefore(clubId, streamId, newest, count)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `newest` | ClubMessageIdentifier | no |  |
| `count` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messages` | ClubMessageInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local messages = C_Club.GetMessagesBefore(clubId, streamId, newest, 0)
```

### C_Club.GetMessagesInRange

Get downloaded messages in the given range. These are filtered by ignored players

```lua
messages = C_Club.GetMessagesInRange(clubId, streamId, oldest, newest)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `oldest` | ClubMessageIdentifier | no |  |
| `newest` | ClubMessageIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messages` | ClubMessageInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local messages = C_Club.GetMessagesInRange(clubId, streamId, oldest, newest)
```

### C_Club.GetStreamInfo

```lua
streamInfo = C_Club.GetStreamInfo(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `streamInfo` | ClubStreamInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local streamInfo = C_Club.GetStreamInfo(clubId, streamId)
```

### C_Club.GetStreams

```lua
streams = C_Club.GetStreams(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `streams` | ClubStreamInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local streams = C_Club.GetStreams(clubId)
```

### C_Club.GetStreamViewMarker

```lua
lastReadTime = C_Club.GetStreamViewMarker(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lastReadTime` | BigUInteger | yes | nil if stream view is at current |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lastReadTime = C_Club.GetStreamViewMarker(clubId, streamId)
```

### C_Club.GetSubscribedClubs

```lua
clubs = C_Club.GetSubscribedClubs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubs` | ClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubs = C_Club.GetSubscribedClubs()
```

### C_Club.GetTickets

Get the existing tickets for this club. Call RequestTickets() to retrieve tickets from server.

```lua
tickets = C_Club.GetTickets(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tickets` | ClubTicketInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tickets = C_Club.GetTickets(clubId)
```

### C_Club.IsAccountMuted

```lua
accountMuted = C_Club.IsAccountMuted(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountMuted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accountMuted = C_Club.IsAccountMuted(clubId)
```

### C_Club.IsBeginningOfStream

Returns whether the given message is the first message in the stream, taking into account ignored messages

```lua
isBeginningOfStream = C_Club.IsBeginningOfStream(clubId, streamId, messageId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBeginningOfStream` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBeginningOfStream = C_Club.IsBeginningOfStream(clubId, streamId, messageId)
```

### C_Club.IsEnabled

```lua
clubsEnabled = C_Club.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubsEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubsEnabled = C_Club.IsEnabled()
```

### C_Club.IsRestricted

```lua
restrictionReason = C_Club.IsRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictionReason` | ClubRestrictionReason | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restrictionReason = C_Club.IsRestricted()
```

### C_Club.IsSubscribedToStream

```lua
subscribed = C_Club.IsSubscribedToStream(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subscribed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local subscribed = C_Club.IsSubscribedToStream(clubId, streamId)
```

### C_Club.KickMember

Check kickableRoleIds privilege.

```lua
C_Club.KickMember(clubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.KickMember(clubId, memberId)
```

### C_Club.LeaveClub

```lua
C_Club.LeaveClub(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.LeaveClub(clubId)
```

### C_Club.RedeemTicket

```lua
C_Club.RedeemTicket(ticketId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ticketId` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.RedeemTicket("")
```

### C_Club.RequestInvitationsForClub

Request invitations for this club from server. Check canGetInvitation privilege.

```lua
C_Club.RequestInvitationsForClub(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.RequestInvitationsForClub(clubId)
```

### C_Club.RequestMoreMessagesBefore

Call this when the user scrolls near the top of the message view, and more need to be displayed. The history will be downloaded backwards (newest to oldest).

```lua
alreadyHasMessages = C_Club.RequestMoreMessagesBefore(clubId, streamId, [messageId], [count])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | yes |  |
| `count` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alreadyHasMessages` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local alreadyHasMessages = C_Club.RequestMoreMessagesBefore(clubId, streamId)
```

### C_Club.RequestTicket

```lua
C_Club.RequestTicket(ticketId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ticketId` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.RequestTicket("")
```

### C_Club.RequestTickets

Request tickets from server. Check canGetTicket privilege.

```lua
C_Club.RequestTickets(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.RequestTickets(clubId)
```

### C_Club.RevokeInvitation

Check canRevokeOwnInvitation or canRevokeOtherInvitation

```lua
C_Club.RevokeInvitation(clubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.RevokeInvitation(clubId, memberId)
```

### C_Club.SendBattleTagFriendRequest

```lua
C_Club.SendBattleTagFriendRequest(guildClubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildClubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SendBattleTagFriendRequest(guildClubId, memberId)
```

### C_Club.SendCharacterInvitation

```lua
C_Club.SendCharacterInvitation(clubId, character)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `character` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SendCharacterInvitation(clubId, "")
```

### C_Club.SendInvitation

Check the canSendInvitation privilege.

```lua
C_Club.SendInvitation(clubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SendInvitation(clubId, memberId)
```

### C_Club.SendMessage

```lua
C_Club.SendMessage(clubId, streamId, message)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `message` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SendMessage(clubId, streamId, "")
```

### C_Club.SendTitleFriendRequest

```lua
C_Club.SendTitleFriendRequest(guildClubId, memberId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildClubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SendTitleFriendRequest(guildClubId, memberId)
```

### C_Club.SetAutoAdvanceStreamViewMarker

Only one stream can be set for auto-advance at a time. Focused streams will have their view times advanced automatically.

```lua
C_Club.SetAutoAdvanceStreamViewMarker(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetAutoAdvanceStreamViewMarker(clubId, streamId)
```

### C_Club.SetAvatarTexture

```lua
C_Club.SetAvatarTexture(texture, avatarId, clubType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |
| `avatarId` | number | no |  |
| `clubType` | ClubType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetAvatarTexture(texture, 0, Enum.ClubType.BattleNet)
```

### C_Club.SetClubMemberNote

Check the canSetOwnMemberNote and canSetOtherMemberNote privileges.

```lua
C_Club.SetClubMemberNote(clubId, memberId, note)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |
| `note` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetClubMemberNote(clubId, memberId, "")
```

### C_Club.SetClubPresenceSubscription

You can only be subscribed to 0 or 1 clubs for presence.  Subscribing to a new club automatically unsuscribes you to existing subscription.

```lua
C_Club.SetClubPresenceSubscription(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetClubPresenceSubscription(clubId)
```

### C_Club.SetClubStreamNotificationSettings

```lua
C_Club.SetClubStreamNotificationSettings(clubId, settings)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `settings` | ClubStreamNotificationSetting[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetClubStreamNotificationSettings(clubId, settings)
```

### C_Club.SetCommunityID

```lua
C_Club.SetCommunityID(communityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `communityID` | BigUInteger | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetCommunityID("player")
```

### C_Club.SetFavorite

```lua
C_Club.SetFavorite(clubId, isFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetFavorite(clubId, false)
```

### C_Club.SetSocialQueueingEnabled

```lua
C_Club.SetSocialQueueingEnabled(clubId, enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.SetSocialQueueingEnabled(clubId, false)
```

### C_Club.ShouldAllowClubType

```lua
clubTypeIsAllowed = C_Club.ShouldAllowClubType(clubType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubTypeIsAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubTypeIsAllowed = C_Club.ShouldAllowClubType(Enum.ClubType.BattleNet)
```

### C_Club.UnfocusAllStreams

```lua
C_Club.UnfocusAllStreams(unsubscribe)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unsubscribe` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.UnfocusAllStreams(false)
```

### C_Club.UnfocusMembers

```lua
C_Club.UnfocusMembers(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.UnfocusMembers(clubId)
```

### C_Club.UnfocusStream

```lua
C_Club.UnfocusStream(clubId, streamId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Club.UnfocusStream(clubId, streamId)
```

### C_Club.ValidateText

```lua
result = C_Club.ValidateText(clubType, text, clubFieldType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubType | no |  |
| `text` | string | no |  |
| `clubFieldType` | ClubFieldType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ValidateNameResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_Club.ValidateText(Enum.ClubType.BattleNet, "", Enum.ClubFieldType.ClubName)
```

## Events

### AVATAR_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubType | no |  |

### CLUB_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `action` | ClubActionType | no |  |
| `error` | ClubErrorType | no |  |
| `clubType` | ClubType | no |  |

### CLUB_INVITATION_ADDED_FOR_SELF

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitation` | ClubSelfInvitationInfo | no |  |

### CLUB_INVITATION_REMOVED_FOR_SELF

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitationId` | ClubInvitationId | no |  |

### CLUB_INVITATIONS_RECEIVED_FOR_CLUB

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_MEMBER_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

### CLUB_MEMBER_PRESENCE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |
| `presence` | ClubMemberPresence | no |  |

### CLUB_MEMBER_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

### CLUB_MEMBER_ROLE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |
| `roleId` | number | no |  |

### CLUB_MEMBERS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_MEMBER_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |

### CLUB_MESSAGE_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |

### CLUB_MESSAGE_HISTORY_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `downloadedRange` | ClubMessageRange | no | Range of history messages received. |
| `contiguousRange` | ClubMessageRange | no | Range of contiguous messages that the received messages are in. |

### CLUB_MESSAGE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `messageId` | ClubMessageIdentifier | no |  |

### CLUB_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_REMOVED_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubName` | string | no |  |
| `clubRemovedReason` | ClubRemovedReason | no |  |

### CLUB_SELF_MEMBER_ROLE_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `roleId` | number | no |  |

### CLUB_STREAM_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

### CLUB_STREAM_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

### CLUB_STREAMS_LOADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_STREAM_SUBSCRIBED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

### CLUB_STREAM_UNSUBSCRIBED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

### CLUB_STREAM_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |

### CLUB_TICKET_CREATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `ticketInfo` | ClubTicketInfo | no |  |

### CLUB_TICKET_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ticket` | string | no |  |

### CLUB_TICKETS_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### INITIAL_CLUBS_LOADED

### STREAM_VIEW_MARKER_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `streamId` | ClubStreamId | no |  |
| `lastReadTime` | BigUInteger | yes | nil if stream view is at current |

## Types

### ClubActionType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ErrorClubActionSubscribe` | ClubActionType | no |  |
| `ErrorClubActionCreate` | ClubActionType | no |  |
| `ErrorClubActionEdit` | ClubActionType | no |  |
| `ErrorClubActionDestroy` | ClubActionType | no |  |
| `ErrorClubActionLeave` | ClubActionType | no |  |
| `ErrorClubActionCreateTicket` | ClubActionType | no |  |
| `ErrorClubActionDestroyTicket` | ClubActionType | no |  |
| `ErrorClubActionRedeemTicket` | ClubActionType | no |  |
| `ErrorClubActionGetTicket` | ClubActionType | no |  |
| `ErrorClubActionGetTickets` | ClubActionType | no |  |
| `ErrorClubActionGetBans` | ClubActionType | no |  |
| `ErrorClubActionGetInvitations` | ClubActionType | no |  |
| `ErrorClubActionRevokeInvitation` | ClubActionType | no |  |
| `ErrorClubActionAcceptInvitation` | ClubActionType | no |  |
| `ErrorClubActionDeclineInvitation` | ClubActionType | no |  |
| `ErrorClubActionCreateStream` | ClubActionType | no |  |
| `ErrorClubActionEditStream` | ClubActionType | no |  |
| `ErrorClubActionDestroyStream` | ClubActionType | no |  |
| `ErrorClubActionInviteMember` | ClubActionType | no |  |
| `ErrorClubActionEditMember` | ClubActionType | no |  |
| `ErrorClubActionEditMemberNote` | ClubActionType | no |  |
| `ErrorClubActionKickMember` | ClubActionType | no |  |
| `ErrorClubActionAddBan` | ClubActionType | no |  |
| `ErrorClubActionRemoveBan` | ClubActionType | no |  |
| `ErrorClubActionCreateMessage` | ClubActionType | no |  |
| `ErrorClubActionEditMessage` | ClubActionType | no |  |
| `ErrorClubActionDestroyMessage` | ClubActionType | no |  |

### ClubErrorType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ErrorCommunitiesNone` | ClubErrorType | no |  |
| `ErrorCommunitiesUnknown` | ClubErrorType | no |  |
| `ErrorCommunitiesNeutralFaction` | ClubErrorType | no |  |
| `ErrorCommunitiesUnknownRealm` | ClubErrorType | no |  |
| `ErrorCommunitiesBadTarget` | ClubErrorType | no |  |
| `ErrorCommunitiesWrongFaction` | ClubErrorType | no |  |
| `ErrorCommunitiesRestricted` | ClubErrorType | no |  |
| `ErrorCommunitiesIgnored` | ClubErrorType | no |  |
| `ErrorCommunitiesGuild` | ClubErrorType | no |  |
| `ErrorCommunitiesWrongRegion` | ClubErrorType | no |  |
| `ErrorCommunitiesUnknownTicket` | ClubErrorType | no |  |
| `ErrorCommunitiesMissingShortName` | ClubErrorType | no |  |
| `ErrorCommunitiesProfanity` | ClubErrorType | no |  |
| `ErrorCommunitiesTrial` | ClubErrorType | no |  |
| `ErrorCommunitiesVeteranTrial` | ClubErrorType | no |  |
| `ErrorCommunitiesChatMute` | ClubErrorType | no |  |
| `ErrorClubFull` | ClubErrorType | no |  |
| `ErrorClubNoClub` | ClubErrorType | no |  |
| `ErrorClubNotMember` | ClubErrorType | no |  |
| `ErrorClubAlreadyMember` | ClubErrorType | no |  |
| `ErrorClubNoSuchMember` | ClubErrorType | no |  |
| `ErrorClubNoSuchInvitation` | ClubErrorType | no |  |
| `ErrorClubInvitationAlreadyExists` | ClubErrorType | no |  |
| `ErrorClubInvalidRoleID` | ClubErrorType | no |  |
| `ErrorClubInsufficientPrivileges` | ClubErrorType | no |  |
| `ErrorClubTooManyClubsJoined` | ClubErrorType | no |  |
| `ErrorClubVoiceFull` | ClubErrorType | no |  |
| `ErrorClubStreamNoStream` | ClubErrorType | no |  |
| `ErrorClubStreamInvalidName` | ClubErrorType | no |  |
| `ErrorClubStreamCountAtMin` | ClubErrorType | no |  |
| `ErrorClubStreamCountAtMax` | ClubErrorType | no |  |
| `ErrorClubMemberHasRequiredRole` | ClubErrorType | no |  |
| `ErrorClubSentInvitationCountAtMax` | ClubErrorType | no |  |
| `ErrorClubReceivedInvitationCountAtMax` | ClubErrorType | no |  |
| `ErrorClubTargetIsBanned` | ClubErrorType | no |  |
| `ErrorClubBanAlreadyExists` | ClubErrorType | no |  |
| `ErrorClubBanCountAtMax` | ClubErrorType | no |  |
| `ErrorClubTicketCountAtMax` | ClubErrorType | no |  |
| `ErrorClubTicketNoSuchTicket` | ClubErrorType | no |  |
| `ErrorClubTicketHasConsumedAllowedRedeemCount` | ClubErrorType | no |  |
| `ErrorClubDoesntAllowCrossFaction` | ClubErrorType | no |  |
| `ErrorClubEditHasCrossFactionMembers` | ClubErrorType | no |  |

### ClubFieldType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ClubName` | ClubFieldType | no |  |
| `ClubShortName` | ClubFieldType | no |  |
| `ClubDescription` | ClubFieldType | no |  |
| `ClubBroadcast` | ClubFieldType | no |  |
| `ClubStreamName` | ClubFieldType | no |  |
| `ClubStreamSubject` | ClubFieldType | no |  |
| `NumTypes` | ClubFieldType | no |  |

### ClubInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `name` | string | no |  |
| `shortName` | string | yes |  |
| `description` | string | no |  |
| `broadcast` | string | no |  |
| `clubType` | ClubType | no |  |
| `avatarId` | number | no |  |
| `memberCount` | number | yes |  |
| `favoriteTimeStamp` | BigUInteger | yes |  |
| `joinTime` | BigUInteger | yes |  |
| `socialQueueingEnabled` | bool | yes |  |
| `crossFaction` | bool | yes |  |

### ClubInvitationCandidateInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberId` | ClubMemberOpaqueId | no |  |
| `name` | string | no |  |
| `priority` | luaIndex | no |  |
| `status` | ClubInvitationCandidateStatus | no |  |

### ClubInvitationCandidateStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Available` | ClubInvitationCandidateStatus | no |  |
| `InvitePending` | ClubInvitationCandidateStatus | no |  |
| `AlreadyMember` | ClubInvitationCandidateStatus | no |  |

### ClubInvitationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitationId` | ClubInvitationId | no |  |
| `isMyInvitation` | bool | no |  |
| `invitee` | ClubMemberInfo | no |  |

### ClubLimits (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumNumberOfStreams` | number | no |  |

### ClubMemberInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSelf` | bool | no |  |
| `memberId` | ClubMemberOpaqueId | no |  |
| `name` | string | yes | name may be encoded as a Kstring |
| `role` | ClubRoleIdentifier | yes |  |
| `presence` | ClubMemberPresence | no |  |
| `clubType` | ClubType | yes |  |
| `guid` | WOWGUID | yes |  |
| `bnetAccountId` | number | yes |  |
| `memberNote` | string | yes |  |
| `officerNote` | string | yes |  |
| `classID` | number | yes |  |
| `race` | number | yes |  |
| `level` | number | yes |  |
| `zone` | string | yes |  |
| `achievementPoints` | number | yes |  |
| `profession1ID` | number | yes |  |
| `profession1Rank` | number | yes |  |
| `profession1Name` | string | yes |  |
| `profession2ID` | number | yes |  |
| `profession2Rank` | number | yes |  |
| `profession2Name` | string | yes |  |
| `lastOnlineYear` | number | yes |  |
| `lastOnlineMonth` | number | yes |  |
| `lastOnlineDay` | number | yes |  |
| `lastOnlineHour` | number | yes |  |
| `guildRank` | string | yes |  |
| `guildRankOrder` | luaIndex | yes |  |
| `isRemoteChat` | bool | yes |  |
| `overallDungeonScore` | number | yes |  |
| `faction` | PvPFaction | yes |  |
| `timerunningSeasonID` | number | yes |  |
| `discordInfo` | DiscordChatInfo | yes |  |

### ClubMemberPresence (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Unknown` | ClubMemberPresence | no |  |
| `Online` | ClubMemberPresence | no |  |
| `OnlineMobile` | ClubMemberPresence | no |  |
| `Offline` | ClubMemberPresence | no |  |
| `Away` | ClubMemberPresence | no |  |
| `Busy` | ClubMemberPresence | no |  |

### ClubMessageIdentifier (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `epoch` | BigUInteger | no | number of microseconds since the UNIX epoch. |
| `position` | BigUInteger | no | sort order for messages at the same time |

### ClubMessageInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageId` | ClubMessageIdentifier | no |  |
| `content` | kstringClubMessage | no |  |
| `author` | ClubMemberInfo | no |  |
| `destroyer` | ClubMemberInfo | yes | May be nil even if the message has been destroyed |
| `destroyed` | bool | no |  |
| `edited` | bool | no |  |

### ClubMessageRange (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldestMessageId` | ClubMessageIdentifier | no |  |
| `newestMessageId` | ClubMessageIdentifier | no |  |

### ClubPrivilegeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDestroy` | bool | no |  |
| `canSetAttribute` | bool | no |  |
| `canSetName` | bool | no |  |
| `canSetDescription` | bool | no |  |
| `canSetAvatar` | bool | no |  |
| `canSetBroadcast` | bool | no |  |
| `canSetPrivacyLevel` | bool | no |  |
| `canSetOwnMemberAttribute` | bool | no |  |
| `canSetOtherMemberAttribute` | bool | no |  |
| `canSetOwnMemberNote` | bool | no |  |
| `canSetOtherMemberNote` | bool | no |  |
| `canSetOwnVoiceState` | bool | no |  |
| `canSetOwnPresenceLevel` | bool | no |  |
| `canUseVoice` | bool | no |  |
| `canVoiceMuteMemberForAll` | bool | no |  |
| `canGetInvitation` | bool | no |  |
| `canSendInvitation` | bool | no |  |
| `canSendGuestInvitation` | bool | no |  |
| `canRevokeOwnInvitation` | bool | no |  |
| `canRevokeOtherInvitation` | bool | no |  |
| `canGetBan` | bool | no |  |
| `canGetSuggestion` | bool | no |  |
| `canSuggestMember` | bool | no |  |
| `canGetTicket` | bool | no |  |
| `canCreateTicket` | bool | no |  |
| `canDestroyTicket` | bool | no |  |
| `canAddBan` | bool | no |  |
| `canRemoveBan` | bool | no |  |
| `canCreateStream` | bool | no |  |
| `canDestroyStream` | bool | no |  |
| `canSetStreamPosition` | bool | no |  |
| `canSetStreamAttribute` | bool | no |  |
| `canSetStreamName` | bool | no |  |
| `canSetStreamSubject` | bool | no |  |
| `canSetStreamAccess` | bool | no |  |
| `canSetStreamVoiceLevel` | bool | no |  |
| `canCreateMessage` | bool | no |  |
| `canDestroyOwnMessage` | bool | no |  |
| `canDestroyOtherMessage` | bool | no |  |
| `canEditOwnMessage` | bool | no |  |
| `canPinMessage` | bool | no |  |
| `kickableRoleIds` | number[] | no | Roles that can be kicked and banned |

### ClubRemovedReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubRemovedReason | no |  |
| `Banned` | ClubRemovedReason | no |  |
| `Removed` | ClubRemovedReason | no |  |
| `ClubDestroyed` | ClubRemovedReason | no |  |

### ClubRestrictionReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubRestrictionReason | no |  |
| `Unavailable` | ClubRestrictionReason | no |  |

### ClubRoleInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roleId` | number | no |  |
| `name` | string | no |  |
| `required` | bool | no | At least one user must be in this role |
| `unique` | bool | no | At most one user can be in this role |

### ClubSelfInvitationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invitationId` | ClubInvitationId | no |  |
| `club` | ClubInfo | no |  |
| `inviter` | ClubMemberInfo | no |  |
| `leaders` | ClubMemberInfo[] | no |  |

### ClubStreamInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `streamId` | ClubStreamId | no |  |
| `name` | string | no |  |
| `subject` | string | no |  |
| `leadersAndModeratorsOnly` | bool | no |  |
| `streamType` | ClubStreamType | no |  |
| `creationTime` | BigUInteger | no |  |

### ClubStreamNotificationFilter (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubStreamNotificationFilter | no |  |
| `Mention` | ClubStreamNotificationFilter | no |  |
| `All` | ClubStreamNotificationFilter | no |  |

### ClubStreamNotificationSetting (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `streamId` | ClubStreamId | no |  |
| `filter` | ClubStreamNotificationFilter | no |  |

### ClubStreamType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `General` | ClubStreamType | no |  |
| `Guild` | ClubStreamType | no |  |
| `Officer` | ClubStreamType | no |  |
| `Discord` | ClubStreamType | no |  |
| `Other` | ClubStreamType | no |  |

### ClubTicketInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ticketId` | string | no |  |
| `allowedRedeemCount` | number | no |  |
| `currentRedeemCount` | number | no |  |
| `creationTime` | BigUInteger | no | Creation time in microseconds since the UNIX epoch. |
| `expirationTime` | BigUInteger | no | Expiration time in microseconds since the UNIX epoch. |
| `defaultStreamId` | ClubStreamId | yes |  |
| `creator` | ClubMemberInfo | no |  |

### ClubType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `BattleNet` | ClubType | no |  |
| `Character` | ClubType | no |  |
| `Guild` | ClubType | no |  |
| `Other` | ClubType | no |  |

