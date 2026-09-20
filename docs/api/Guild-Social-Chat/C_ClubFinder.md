# C_ClubFinder

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**55** functions · **15** events · **10** types

## Functions

### C_ClubFinder.ApplicantAcceptClubInvite

```lua
C_ClubFinder.ApplicantAcceptClubInvite(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ApplicantAcceptClubInvite(UnitGUID("player"))
```

### C_ClubFinder.ApplicantDeclineClubInvite

```lua
C_ClubFinder.ApplicantDeclineClubInvite(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ApplicantDeclineClubInvite(UnitGUID("player"))
```

### C_ClubFinder.CancelMembershipRequest

```lua
C_ClubFinder.CancelMembershipRequest(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.CancelMembershipRequest(UnitGUID("player"))
```

### C_ClubFinder.CheckAllPlayerApplicantSettings

```lua
C_ClubFinder.CheckAllPlayerApplicantSettings()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.CheckAllPlayerApplicantSettings()
```

### C_ClubFinder.ClearAllFinderCache

```lua
C_ClubFinder.ClearAllFinderCache()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ClearAllFinderCache()
```

### C_ClubFinder.ClearClubApplicantsCache

```lua
C_ClubFinder.ClearClubApplicantsCache()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ClearClubApplicantsCache()
```

### C_ClubFinder.ClearClubFinderPostingsCache

```lua
C_ClubFinder.ClearClubFinderPostingsCache()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ClearClubFinderPostingsCache()
```

### C_ClubFinder.DoesPlayerBelongToClubFromClubGUID

```lua
belongsToClub = C_ClubFinder.DoesPlayerBelongToClubFromClubGUID(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `belongsToClub` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local belongsToClub = C_ClubFinder.DoesPlayerBelongToClubFromClubGUID(UnitGUID("player"))
```

### C_ClubFinder.GetClubFinderDisableReason

```lua
disableReason = C_ClubFinder.GetClubFinderDisableReason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disableReason` | ClubFinderDisableReason | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local disableReason = C_ClubFinder.GetClubFinderDisableReason()
```

### C_ClubFinder.GetClubRecruitmentSettings

```lua
settings = C_ClubFinder.GetClubRecruitmentSettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `settings` | ClubSettingsInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local settings = C_ClubFinder.GetClubRecruitmentSettings()
```

### C_ClubFinder.GetClubTypeFromFinderGUID

```lua
clubType = C_ClubFinder.GetClubTypeFromFinderGUID(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubType` | ClubFinderRequestType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubType = C_ClubFinder.GetClubTypeFromFinderGUID(UnitGUID("player"))
```

### C_ClubFinder.GetFocusIndexFromFlag

```lua
index = C_ClubFinder.GetFocusIndexFromFlag(flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flags` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local index = C_ClubFinder.GetFocusIndexFromFlag(0)
```

### C_ClubFinder.GetPlayerApplicantLocaleFlags

```lua
localeFlags = C_ClubFinder.GetPlayerApplicantLocaleFlags()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeFlags` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local localeFlags = C_ClubFinder.GetPlayerApplicantLocaleFlags()
```

### C_ClubFinder.GetPlayerApplicantSettings

```lua
settings = C_ClubFinder.GetPlayerApplicantSettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `settings` | ClubSettingsInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local settings = C_ClubFinder.GetPlayerApplicantSettings()
```

### C_ClubFinder.GetPlayerClubApplicationStatus

```lua
clubStatus = C_ClubFinder.GetPlayerClubApplicationStatus(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubStatus` | PlayerClubRequestStatus | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubStatus = C_ClubFinder.GetPlayerClubApplicationStatus(UnitGUID("player"))
```

### C_ClubFinder.GetPlayerSettingsFocusFlagsSelectedCount

```lua
focusCount = C_ClubFinder.GetPlayerSettingsFocusFlagsSelectedCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `focusCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local focusCount = C_ClubFinder.GetPlayerSettingsFocusFlagsSelectedCount()
```

### C_ClubFinder.GetPostingIDFromClubFinderGUID

```lua
postingID = C_ClubFinder.GetPostingIDFromClubFinderGUID(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local postingID = C_ClubFinder.GetPostingIDFromClubFinderGUID(UnitGUID("player"))
```

### C_ClubFinder.GetRecruitingClubInfoFromClubID

```lua
clubInfo = C_ClubFinder.GetRecruitingClubInfoFromClubID(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubInfo` | RecruitingClubInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubInfo = C_ClubFinder.GetRecruitingClubInfoFromClubID(clubId)
```

### C_ClubFinder.GetRecruitingClubInfoFromFinderGUID

```lua
clubInfo = C_ClubFinder.GetRecruitingClubInfoFromFinderGUID(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubInfo` | RecruitingClubInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clubInfo = C_ClubFinder.GetRecruitingClubInfoFromFinderGUID(UnitGUID("player"))
```

### C_ClubFinder.GetStatusOfPostingFromClubId

```lua
postingFlags = C_ClubFinder.GetStatusOfPostingFromClubId(postingID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingID` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingFlags` | ClubFinderClubPostingStatusFlags[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local postingFlags = C_ClubFinder.GetStatusOfPostingFromClubId(postingID)
```

### C_ClubFinder.GetTotalMatchingCommunityListSize

```lua
totalSize = C_ClubFinder.GetTotalMatchingCommunityListSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalSize` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalSize = C_ClubFinder.GetTotalMatchingCommunityListSize()
```

### C_ClubFinder.GetTotalMatchingGuildListSize

```lua
totalSize = C_ClubFinder.GetTotalMatchingGuildListSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalSize` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalSize = C_ClubFinder.GetTotalMatchingGuildListSize()
```

### C_ClubFinder.HasAlreadyAppliedToLinkedPosting

```lua
hasAlreadyApplied = C_ClubFinder.HasAlreadyAppliedToLinkedPosting(clubFinderGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAlreadyApplied` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAlreadyApplied = C_ClubFinder.HasAlreadyAppliedToLinkedPosting(UnitGUID("player"))
```

### C_ClubFinder.HasPostingBeenDelisted

```lua
postingDelisted = C_ClubFinder.HasPostingBeenDelisted(postingID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingID` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingDelisted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local postingDelisted = C_ClubFinder.HasPostingBeenDelisted(postingID)
```

### C_ClubFinder.IsCommunityFinderEnabled

```lua
isEnabled = C_ClubFinder.IsCommunityFinderEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_ClubFinder.IsCommunityFinderEnabled()
```

### C_ClubFinder.IsEnabled

```lua
isEnabled = C_ClubFinder.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_ClubFinder.IsEnabled()
```

### C_ClubFinder.IsListingEnabledFromFlags

```lua
isListed = C_ClubFinder.IsListingEnabledFromFlags(flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flags` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isListed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isListed = C_ClubFinder.IsListingEnabledFromFlags(0)
```

### C_ClubFinder.IsPostingBanned

```lua
postingBanned = C_ClubFinder.IsPostingBanned(postingID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingID` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `postingBanned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local postingBanned = C_ClubFinder.IsPostingBanned(postingID)
```

### C_ClubFinder.IsValidSearchString

```lua
isApproved = C_ClubFinder.IsValidSearchString(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApproved` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isApproved = C_ClubFinder.IsValidSearchString("")
```

### C_ClubFinder.LookupClubPostingFromClubFinderGUID

```lua
C_ClubFinder.LookupClubPostingFromClubFinderGUID(clubFinderGUID, isLinkedPosting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `isLinkedPosting` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.LookupClubPostingFromClubFinderGUID(UnitGUID("player"), false)
```

### C_ClubFinder.PlayerGetClubInvitationList

```lua
inviteList = C_ClubFinder.PlayerGetClubInvitationList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inviteList` | RecruitingClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inviteList = C_ClubFinder.PlayerGetClubInvitationList()
```

### C_ClubFinder.PlayerRequestPendingClubsList

```lua
C_ClubFinder.PlayerRequestPendingClubsList(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.PlayerRequestPendingClubsList(Enum.ClubFinderRequestType.None)
```

### C_ClubFinder.PlayerReturnPendingCommunitiesList

```lua
info = C_ClubFinder.PlayerReturnPendingCommunitiesList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RecruitingClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ClubFinder.PlayerReturnPendingCommunitiesList()
```

### C_ClubFinder.PlayerReturnPendingGuildsList

```lua
info = C_ClubFinder.PlayerReturnPendingGuildsList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RecruitingClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ClubFinder.PlayerReturnPendingGuildsList()
```

### C_ClubFinder.PostClub

```lua
succesful = C_ClubFinder.PostClub(clubId, itemLevelRequirement, name, description, avatarId, specs, type, crossFaction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |
| `itemLevelRequirement` | number | no |  |
| `name` | string | no |  |
| `description` | string | no |  |
| `avatarId` | number | no |  |
| `specs` | number[] | no |  |
| `type` | ClubFinderRequestType | no |  |
| `crossFaction` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `succesful` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local succesful = C_ClubFinder.PostClub(clubId, 6948, "", "", 0, specs, Enum.ClubFinderRequestType.None, false)
```

### C_ClubFinder.RequestApplicantList

```lua
C_ClubFinder.RequestApplicantList(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestApplicantList(Enum.ClubFinderRequestType.None)
```

### C_ClubFinder.RequestClubsList

```lua
C_ClubFinder.RequestClubsList(guildListRequested, searchString, specIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildListRequested` | bool | no |  |
| `searchString` | string | no |  |
| `specIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestClubsList(false, "", specIDs)
```

### C_ClubFinder.RequestMembershipToClub

```lua
C_ClubFinder.RequestMembershipToClub(clubFinderGUID, comment, specIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `comment` | string | no |  |
| `specIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestMembershipToClub(UnitGUID("player"), "", specIDs)
```

### C_ClubFinder.RequestNextCommunityPage

```lua
C_ClubFinder.RequestNextCommunityPage(startingIndex, pageSize)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startingIndex` | number | no |  |
| `pageSize` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestNextCommunityPage(1, 0)
```

### C_ClubFinder.RequestNextGuildPage

```lua
C_ClubFinder.RequestNextGuildPage(startingIndex, pageSize)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startingIndex` | number | no |  |
| `pageSize` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestNextGuildPage(1, 0)
```

### C_ClubFinder.RequestPostingInformationFromClubId

```lua
success = C_ClubFinder.RequestPostingInformationFromClubId(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_ClubFinder.RequestPostingInformationFromClubId(clubId)
```

### C_ClubFinder.RequestSubscribedClubPostingIDs

```lua
C_ClubFinder.RequestSubscribedClubPostingIDs()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RequestSubscribedClubPostingIDs()
```

### C_ClubFinder.ResetClubPostingMapCache

```lua
C_ClubFinder.ResetClubPostingMapCache()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.ResetClubPostingMapCache()
```

### C_ClubFinder.RespondToApplicant

```lua
C_ClubFinder.RespondToApplicant(clubFinderGUID, playerGUID, shouldAccept, requestType, playerName, forceAccept, [reported])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `playerGUID` | WOWGUID | no |  |
| `shouldAccept` | bool | no |  |
| `requestType` | ClubFinderRequestType | no |  |
| `playerName` | string | no |  |
| `forceAccept` | bool | no |  |
| `reported` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.RespondToApplicant(UnitGUID("player"), UnitGUID("player"), false, Enum.ClubFinderRequestType.None, "", false)
```

### C_ClubFinder.ReturnClubApplicantList

```lua
info = C_ClubFinder.ReturnClubApplicantList(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubFinderApplicantInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ClubFinder.ReturnClubApplicantList(clubId)
```

### C_ClubFinder.ReturnMatchingCommunityList

```lua
recruitingClubs = C_ClubFinder.ReturnMatchingCommunityList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recruitingClubs` | RecruitingClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recruitingClubs = C_ClubFinder.ReturnMatchingCommunityList()
```

### C_ClubFinder.ReturnMatchingGuildList

```lua
recruitingClubs = C_ClubFinder.ReturnMatchingGuildList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recruitingClubs` | RecruitingClubInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local recruitingClubs = C_ClubFinder.ReturnMatchingGuildList()
```

### C_ClubFinder.ReturnPendingClubApplicantList

```lua
info = C_ClubFinder.ReturnPendingClubApplicantList(clubId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ClubFinderApplicantInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ClubFinder.ReturnPendingClubApplicantList(clubId)
```

### C_ClubFinder.SendChatWhisper

```lua
C_ClubFinder.SendChatWhisper(clubFinderGUID, playerGUID, applicantType, name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `playerGUID` | WOWGUID | no |  |
| `applicantType` | ClubFinderRequestType | no |  |
| `name` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SendChatWhisper(UnitGUID("player"), UnitGUID("player"), Enum.ClubFinderRequestType.None, "")
```

### C_ClubFinder.SetAllRecruitmentSettings

```lua
C_ClubFinder.SetAllRecruitmentSettings(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SetAllRecruitmentSettings(0)
```

### C_ClubFinder.SetPlayerApplicantLocaleFlags

```lua
C_ClubFinder.SetPlayerApplicantLocaleFlags(localeFlags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeFlags` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SetPlayerApplicantLocaleFlags(0)
```

### C_ClubFinder.SetPlayerApplicantSettings

```lua
C_ClubFinder.SetPlayerApplicantSettings(index, checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SetPlayerApplicantSettings(1, false)
```

### C_ClubFinder.SetRecruitmentLocale

```lua
C_ClubFinder.SetRecruitmentLocale(locale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SetRecruitmentLocale(0)
```

### C_ClubFinder.SetRecruitmentSettings

```lua
C_ClubFinder.SetRecruitmentSettings(index, checked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |
| `checked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClubFinder.SetRecruitmentSettings(1, false)
```

### C_ClubFinder.ShouldShowClubFinder

```lua
shouldShow = C_ClubFinder.ShouldShowClubFinder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_ClubFinder.ShouldShowClubFinder()
```

## Events

### CLUB_FINDER_APPLICANT_INVITE_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUIDs` | WOWGUID[] | no |  |

### CLUB_FINDER_APPLICATIONS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |
| `clubFinderGUIDs` | WOWGUID[] | no |  |

### CLUB_FINDER_CAN_WHISPER_APPLICANT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `applicant` | WOWGUID | no |  |

### CLUB_FINDER_CLUB_LIST_RETURNED

Signals when we recieve club data that can be used

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

### CLUB_FINDER_CLUB_REPORTED

Sends an update to the UI about a reported guild or community.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |
| `clubFinderGUID` | WOWGUID | no |  |

### CLUB_FINDER_COMMUNITY_OFFLINE_JOIN

Signals to the UI that you (the player) have joined a community offline.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubId` | ClubId | no |  |

### CLUB_FINDER_ENABLED_OR_DISABLED

Sends an update to the UI that the club finder feature has been enabled or disabled.

### CLUB_FINDER_GUILD_REALM_NAME_UPDATED

Sends an update to the UI if the realm name of a guild was found asynchronously.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `realmName` | string | no |  |

### CLUB_FINDER_LINKED_CLUB_RETURNED

When a player clicks a club link, this returns that information back about the club they clicked on

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubInfo` | RecruitingClubInfo | no |  |

### CLUB_FINDER_MEMBERSHIP_LIST_CHANGED

### CLUB_FINDER_PLAYER_PENDING_LIST_RECIEVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

### CLUB_FINDER_POST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUIDs` | WOWGUID[] | no |  |

### CLUB_FINDER_RECRUIT_LIST_CHANGED

### CLUB_FINDER_RECRUITMENT_POST_RETURNED

Signals when our recruitment post we just requested is returned back to us

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

### CLUB_FINDER_RECRUITS_UPDATED

Signals when we recieve the recruits list

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClubFinderRequestType | no |  |

## Types

### ClubFinderApplicantInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `playerGUID` | WOWGUID | no |  |
| `closed` | number | no |  |
| `name` | string | no |  |
| `message` | string | no |  |
| `level` | number | no |  |
| `classID` | number | no |  |
| `ilvl` | number | no |  |
| `specIds` | number[] | no |  |
| `requestStatus` | PlayerClubRequestStatus | no |  |
| `lookupSuccess` | bool | no |  |
| `lastUpdatedTime` | BigInteger | no |  |
| `faction` | number | no |  |

### ClubFinderApplicationUpdateType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubFinderApplicationUpdateType | no |  |
| `AcceptInvite` | ClubFinderApplicationUpdateType | no |  |
| `DeclineInvite` | ClubFinderApplicationUpdateType | no |  |
| `Cancel` | ClubFinderApplicationUpdateType | no |  |

### ClubFinderClubPostingStatusFlags (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubFinderClubPostingStatusFlags | no |  |
| `NeedsCacheUpdate` | ClubFinderClubPostingStatusFlags | no |  |
| `ForceDescriptionChange` | ClubFinderClubPostingStatusFlags | no |  |
| `ForceNameChange` | ClubFinderClubPostingStatusFlags | no |  |
| `UnderReview` | ClubFinderClubPostingStatusFlags | no |  |
| `Banned` | ClubFinderClubPostingStatusFlags | no |  |
| `FakePost` | ClubFinderClubPostingStatusFlags | no |  |
| `PendingDelete` | ClubFinderClubPostingStatusFlags | no |  |
| `PostDelisted` | ClubFinderClubPostingStatusFlags | no |  |

### ClubFinderDisableReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Muted` | ClubFinderDisableReason | no |  |
| `Silenced` | ClubFinderDisableReason | no |  |
| `VeteranTrial` | ClubFinderDisableReason | no |  |

### ClubFinderPostingReportType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `PostersName` | ClubFinderPostingReportType | no |  |
| `ClubName` | ClubFinderPostingReportType | no |  |
| `PostingDescription` | ClubFinderPostingReportType | no |  |
| `ApplicantsName` | ClubFinderPostingReportType | no |  |
| `JoinNote` | ClubFinderPostingReportType | no |  |

### ClubFinderRequestType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubFinderRequestType | no |  |
| `Guild` | ClubFinderRequestType | no |  |
| `Community` | ClubFinderRequestType | no |  |
| `All` | ClubFinderRequestType | no |  |

### ClubFinderSettingFlags (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ClubFinderSettingFlags | no |  |
| `Dungeons` | ClubFinderSettingFlags | no |  |
| `Raids` | ClubFinderSettingFlags | no |  |
| `PvP` | ClubFinderSettingFlags | no |  |
| `RP` | ClubFinderSettingFlags | no |  |
| `Social` | ClubFinderSettingFlags | no |  |
| `Small` | ClubFinderSettingFlags | no |  |
| `Medium` | ClubFinderSettingFlags | no |  |
| `Large` | ClubFinderSettingFlags | no |  |
| `Tank` | ClubFinderSettingFlags | no |  |
| `Healer` | ClubFinderSettingFlags | no |  |
| `Damage` | ClubFinderSettingFlags | no |  |
| `EnableListing` | ClubFinderSettingFlags | no |  |
| `MaxLevelOnly` | ClubFinderSettingFlags | no |  |
| `AutoAccept` | ClubFinderSettingFlags | no |  |
| `FactionHorde` | ClubFinderSettingFlags | no |  |
| `FactionAlliance` | ClubFinderSettingFlags | no |  |
| `FactionNeutral` | ClubFinderSettingFlags | no |  |
| `SortRelevance` | ClubFinderSettingFlags | no |  |
| `SortMemberCount` | ClubFinderSettingFlags | no |  |
| `SortNewest` | ClubFinderSettingFlags | no |  |
| `LanguageReserved1` | ClubFinderSettingFlags | no |  |
| `LanguageReserved2` | ClubFinderSettingFlags | no |  |
| `LanguageReserved3` | ClubFinderSettingFlags | no |  |
| `LanguageReserved4` | ClubFinderSettingFlags | no |  |
| `LanguageReserved5` | ClubFinderSettingFlags | no |  |

### ClubSettingsInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playStyleDungeon` | bool | no |  |
| `playStyleRaids` | bool | no |  |
| `playStylePvp` | bool | no |  |
| `playStyleRP` | bool | no |  |
| `playStyleSocial` | bool | no |  |
| `roleTank` | bool | no |  |
| `roleHealer` | bool | no |  |
| `roleDps` | bool | no |  |
| `sizeSmall` | bool | no |  |
| `sizeMedium` | bool | no |  |
| `sizeLarge` | bool | no |  |
| `maxLevelOnly` | bool | no |  |
| `enableListing` | bool | no |  |
| `sortRelevance` | bool | no |  |
| `sortMembers` | bool | no |  |
| `sortNewest` | bool | no |  |
| `autoAccept` | bool | no |  |
| `crossFaction` | bool | no |  |

### PlayerClubRequestStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | PlayerClubRequestStatus | no |  |
| `Pending` | PlayerClubRequestStatus | no |  |
| `AutoApproved` | PlayerClubRequestStatus | no |  |
| `Declined` | PlayerClubRequestStatus | no |  |
| `Approved` | PlayerClubRequestStatus | no |  |
| `Joined` | PlayerClubRequestStatus | no |  |
| `JoinedAnother` | PlayerClubRequestStatus | no |  |
| `Canceled` | PlayerClubRequestStatus | no |  |

### RecruitingClubInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clubFinderGUID` | WOWGUID | no |  |
| `numActiveMembers` | number | no |  |
| `name` | string | no |  |
| `comment` | string | no |  |
| `guildLeader` | string | no |  |
| `isGuild` | bool | no |  |
| `emblemInfo` | number | no |  |
| `tabardInfo` | GuildTabardInfo | yes |  |
| `recruitingSpecIds` | number[] | no |  |
| `recruitmentFlags` | number | no |  |
| `localeSet` | bool | no |  |
| `recruitmentLocale` | number | no |  |
| `minILvl` | number | no |  |
| `cached` | number | no |  |
| `cacheRequested` | number | no |  |
| `lastPosterGUID` | WOWGUID | no |  |
| `clubId` | ClubId | no |  |
| `lastUpdatedTime` | BigInteger | no |  |
| `isCrossFaction` | bool | no |  |
| `realmName` | string | yes |  |

