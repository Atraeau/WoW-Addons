# C_LFGList

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**52** functions · **17** events · **11** types

## Functions

### C_LFGList.CanActiveEntryUseAutoAccept

```lua
canUseAutoAccept = C_LFGList.CanActiveEntryUseAutoAccept()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseAutoAccept` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUseAutoAccept = C_LFGList.CanActiveEntryUseAutoAccept()
```

### C_LFGList.CanCreateQuestGroup

```lua
canCreate = C_LFGList.CanCreateQuestGroup(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCreate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canCreate = C_LFGList.CanCreateQuestGroup(0)
```

### C_LFGList.CanCreateScenarioGroup

```lua
canCreate = C_LFGList.CanCreateScenarioGroup(scenarioID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCreate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canCreate = C_LFGList.CanCreateScenarioGroup(0)
```

### C_LFGList.ClearApplicationTextFields

```lua
C_LFGList.ClearApplicationTextFields()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.ClearApplicationTextFields()
```

### C_LFGList.ClearCreationTextFields

```lua
C_LFGList.ClearCreationTextFields()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.ClearCreationTextFields()
```

### C_LFGList.ClearSearchTextFields

```lua
C_LFGList.ClearSearchTextFields()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.ClearSearchTextFields()
```

### C_LFGList.ConfirmCensoredActiveEntry

```lua
C_LFGList.ConfirmCensoredActiveEntry()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.ConfirmCensoredActiveEntry()
```

### C_LFGList.CopyActiveEntryInfoToCreationFields

```lua
C_LFGList.CopyActiveEntryInfoToCreationFields()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.CopyActiveEntryInfoToCreationFields()
```

### C_LFGList.CreateListing

```lua
success = C_LFGList.CreateListing(createData)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `createData` | LfgListingCreateData | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_LFGList.CreateListing(createData)
```

### C_LFGList.CreateScenarioListing

```lua
canCreate = C_LFGList.CreateScenarioListing(activityID, itemLevel, autoAccept, privateGroup, scenarioID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `itemLevel` | number | no |  |
| `autoAccept` | bool | no |  |
| `privateGroup` | bool | no |  |
| `scenarioID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCreate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canCreate = C_LFGList.CreateScenarioListing(0, 6948, false, false, 0)
```

### C_LFGList.DoesCensoredTextMatch

```lua
isMatch = C_LFGList.DoesCensoredTextMatch(name, comment)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `comment` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMatch` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMatch = C_LFGList.DoesCensoredTextMatch("", "")
```

### C_LFGList.DoesEntryTitleMatchPrebuiltTitle

```lua
matches = C_LFGList.DoesEntryTitleMatchPrebuiltTitle(activityID, groupID, [playstyle], [generalPlaystyle])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `groupID` | number | no |  |
| `playstyle` | LFGEntryPlaystyle | yes |  |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matches` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matches = C_LFGList.DoesEntryTitleMatchPrebuiltTitle(0, 0)
```

### C_LFGList.GetActiveEntryInfo

```lua
entryData = C_LFGList.GetActiveEntryInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryData` | LfgEntryData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local entryData = C_LFGList.GetActiveEntryInfo()
```

### C_LFGList.GetActivityFullName

```lua
fullName = C_LFGList.GetActivityFullName(activityID, [questID], [showWarmode])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `questID` | number | yes |  |
| `showWarmode` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fullName = C_LFGList.GetActivityFullName(0)
```

### C_LFGList.GetActivityGroupInfo

```lua
name, orderIndex = C_LFGList.GetActivityGroupInfo(groupID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `orderIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, orderIndex = C_LFGList.GetActivityGroupInfo(0)
```

### C_LFGList.GetActivityInfoTable

```lua
activityInfo = C_LFGList.GetActivityInfoTable(activityID, [questID], [showWarmode])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `questID` | number | yes |  |
| `showWarmode` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityInfo` | GroupFinderActivityInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activityInfo = C_LFGList.GetActivityInfoTable(0)
```

### C_LFGList.GetAdvancedFilter

```lua
options = C_LFGList.GetAdvancedFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | AdvancedFilterOptions | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local options = C_LFGList.GetAdvancedFilter()
```

### C_LFGList.GetApplicantBestDungeonScore

```lua
bestDungeonScoreForListing = C_LFGList.GetApplicantBestDungeonScore(localID, applicantIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localID` | number | no |  |
| `applicantIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bestDungeonScoreForListing` | BestDungeonScoreMapInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bestDungeonScoreForListing = C_LFGList.GetApplicantBestDungeonScore(0, 1)
```

### C_LFGList.GetApplicantDungeonScoreForListing

```lua
bestDungeonScoreForListing = C_LFGList.GetApplicantDungeonScoreForListing(localID, applicantIndex, activityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localID` | number | no |  |
| `applicantIndex` | luaIndex | no |  |
| `activityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bestDungeonScoreForListing` | BestDungeonScoreMapInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bestDungeonScoreForListing = C_LFGList.GetApplicantDungeonScoreForListing(0, 1, 0)
```

### C_LFGList.GetApplicantInfo

```lua
applicantData = C_LFGList.GetApplicantInfo(applicantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `applicantID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `applicantData` | LfgApplicantData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local applicantData = C_LFGList.GetApplicantInfo(0)
```

### C_LFGList.GetApplicantPvpRatingInfoForListing

```lua
pvpRatingInfo = C_LFGList.GetApplicantPvpRatingInfoForListing(localID, applicantIndex, activityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localID` | number | no |  |
| `applicantIndex` | luaIndex | no |  |
| `activityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpRatingInfo` | PvpRatingInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pvpRatingInfo = C_LFGList.GetApplicantPvpRatingInfoForListing(0, 1, 0)
```

### C_LFGList.GetAvailableActivityGroups

```lua
activityIDs = C_LFGList.GetAvailableActivityGroups(categoryID, filter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `filter` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activityIDs = C_LFGList.GetAvailableActivityGroups(0, "HELPFUL")
```

### C_LFGList.GetFilteredSearchResults

```lua
totalResultsFound, filteredResults = C_LFGList.GetFilteredSearchResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalResultsFound` | number | no | (default: 0) |
| `filteredResults` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalResultsFound, filteredResults = C_LFGList.GetFilteredSearchResults()
```

### C_LFGList.GetGroupLeaverCountsByRole

```lua
tankLeavers, healerLeavers, damageLeavers = C_LFGList.GetGroupLeaverCountsByRole()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tankLeavers` | number | no |  |
| `healerLeavers` | number | no |  |
| `damageLeavers` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tankLeavers, healerLeavers, damageLeavers = C_LFGList.GetGroupLeaverCountsByRole()
```

### C_LFGList.GetKeystoneForActivity

```lua
level = C_LFGList.GetKeystoneForActivity(activityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local level = C_LFGList.GetKeystoneForActivity(0)
```

### C_LFGList.GetLfgCategoryInfo

```lua
categoryData = C_LFGList.GetLfgCategoryInfo(categoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryData` | LfgCategoryData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local categoryData = C_LFGList.GetLfgCategoryInfo(0)
```

### C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel

```lua
activityID, groupID, keystoneLevel = C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel(getTimewalking)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `getTimewalking` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `groupID` | number | no |  |
| `keystoneLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activityID, groupID, keystoneLevel = C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel(false)
```

### C_LFGList.GetPlaystyleString

```lua
playstyleString = C_LFGList.GetPlaystyleString(playstyle, generalPlaystyle, activityInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playstyle` | LFGEntryPlaystyle | no |  |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | no |  |
| `activityInfo` | GroupFinderActivityInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playstyleString` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local playstyleString = C_LFGList.GetPlaystyleString(playstyle, generalPlaystyle, activityInfo)
```

### C_LFGList.GetPremadeGroupFinderStyle

```lua
style = C_LFGList.GetPremadeGroupFinderStyle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `style` | PremadeGroupFinderStyle | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local style = C_LFGList.GetPremadeGroupFinderStyle()
```

### C_LFGList.GetSearchResultInfo

```lua
searchResultData = C_LFGList.GetSearchResultInfo(searchResultID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultData` | LfgSearchResultData | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local searchResultData = C_LFGList.GetSearchResultInfo(0)
```

### C_LFGList.GetSearchResultLeaderInfo

```lua
leaderInfo = C_LFGList.GetSearchResultLeaderInfo(searchResultID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `leaderInfo` | LfgSearchResultPlayerInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local leaderInfo = C_LFGList.GetSearchResultLeaderInfo(0)
```

### C_LFGList.GetSearchResultPlayerInfo

```lua
playerInfo = C_LFGList.GetSearchResultPlayerInfo(searchResultID, memberIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |
| `memberIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerInfo` | LfgSearchResultPlayerInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local playerInfo = C_LFGList.GetSearchResultPlayerInfo(0, 1)
```

### C_LFGList.GetSearchResults

```lua
totalResultsFound, results = C_LFGList.GetSearchResults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalResultsFound` | number | no | (default: 0) |
| `results` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalResultsFound, results = C_LFGList.GetSearchResults()
```

### C_LFGList.HasActiveEntryInfo

```lua
hasActiveEntryInfo = C_LFGList.HasActiveEntryInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasActiveEntryInfo` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasActiveEntryInfo = C_LFGList.HasActiveEntryInfo()
```

### C_LFGList.HasSearchResultInfo

```lua
hasSearchResultInfo = C_LFGList.HasSearchResultInfo(searchResultID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSearchResultInfo` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSearchResultInfo = C_LFGList.HasSearchResultInfo(0)
```

### C_LFGList.IsCensoredActiveEntryUnresolved

```lua
isUnresolved = C_LFGList.IsCensoredActiveEntryUnresolved()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnresolved` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUnresolved = C_LFGList.IsCensoredActiveEntryUnresolved()
```

### C_LFGList.IsPlayerAuthenticatedForLFG

```lua
isAuthenticated = C_LFGList.IsPlayerAuthenticatedForLFG([activityCategoryID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityCategoryID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAuthenticated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAuthenticated = C_LFGList.IsPlayerAuthenticatedForLFG()
```

### C_LFGList.IsPlayerValidForEndgameFieldEdits

```lua
isValid = C_LFGList.IsPlayerValidForEndgameFieldEdits()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_LFGList.IsPlayerValidForEndgameFieldEdits()
```

### C_LFGList.IsPremadeGroupFinderEnabled

```lua
enabled = C_LFGList.IsPremadeGroupFinderEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_LFGList.IsPremadeGroupFinderEnabled()
```

### C_LFGList.ListingUsesEndgameEditRestrictions

```lua
isEndgameListing = C_LFGList.ListingUsesEndgameEditRestrictions(activityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEndgameListing` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEndgameListing = C_LFGList.ListingUsesEndgameEditRestrictions(0)
```

### C_LFGList.ReportGroupAsAdvertisement

```lua
C_LFGList.ReportGroupAsAdvertisement(searchResultID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.ReportGroupAsAdvertisement(0)
```

### C_LFGList.RevealCensoredActiveEntry

```lua
C_LFGList.RevealCensoredActiveEntry()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.RevealCensoredActiveEntry()
```

### C_LFGList.RevealCensoredSearchResult

```lua
C_LFGList.RevealCensoredSearchResult(searchResultID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.RevealCensoredSearchResult(0)
```

### C_LFGList.SaveAdvancedFilter

```lua
C_LFGList.SaveAdvancedFilter(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | AdvancedFilterOptions | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.SaveAdvancedFilter(options)
```

### C_LFGList.Search

```lua
C_LFGList.Search(categoryID, filter, preferredFilters, [languageFilter], [searchCrossFactionListings], [advancedFilter], [activityIDsFilter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |
| `filter` | number | no | (default: 0) |
| `preferredFilters` | number | no | (default: 0) |
| `languageFilter` | WowLocale | yes |  |
| `searchCrossFactionListings` | bool | yes | (default: False) |
| `advancedFilter` | AdvancedFilterOptions | yes |  |
| `activityIDsFilter` | number[] | yes | Activity IDs to filter by. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.Search(0, "HELPFUL", "HELPFUL")
```

### C_LFGList.SetEntryTitle

```lua
C_LFGList.SetEntryTitle(activityID, groupID, [playstyle], [generalPlaystyle])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `groupID` | number | no |  |
| `playstyle` | LFGEntryPlaystyle | yes |  |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.SetEntryTitle(0, 0)
```

### C_LFGList.SetSearchToActivity

```lua
C_LFGList.SetSearchToActivity(activityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.SetSearchToActivity(0)
```

### C_LFGList.SetSearchToQuestID

```lua
C_LFGList.SetSearchToQuestID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.SetSearchToQuestID(0)
```

### C_LFGList.SetSearchToScenarioID

```lua
C_LFGList.SetSearchToScenarioID(scenarioID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGList.SetSearchToScenarioID(0)
```

### C_LFGList.UpdateListing

```lua
success = C_LFGList.UpdateListing(createData)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `createData` | LfgListingCreateData | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_LFGList.UpdateListing(createData)
```

### C_LFGList.ValidateRequiredDungeonScore

```lua
passes = C_LFGList.ValidateRequiredDungeonScore(dungeonScore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonScore` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `passes` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local passes = C_LFGList.ValidateRequiredDungeonScore(0)
```

### C_LFGList.ValidateRequiredPvpRatingForActivity

```lua
passes = C_LFGList.ValidateRequiredPvpRatingForActivity(activityID, rating)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `rating` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `passes` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local passes = C_LFGList.ValidateRequiredPvpRatingForActivity(0, 0)
```

## Events

### LFG_GROUP_DELISTED_LEADERSHIP_CHANGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listingName` | string | no |  |
| `automaticDelistTimeRemaining` | number | no |  |

### LFG_LIST_ACTIVE_ENTRY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `created` | bool | yes |  |

### LFG_LIST_APPLICANT_LIST_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newPendingEntry` | bool | yes |  |
| `newPendingEntryWithData` | bool | yes |  |

### LFG_LIST_APPLICANT_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `applicantID` | number | no |  |

### LFG_LIST_APPLICATION_STATUS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |
| `newStatus` | cstring | no |  |
| `oldStatus` | cstring | no |  |
| `groupName` | kstringLfgListChat | no |  |

### LFG_LIST_AVAILABILITY_UPDATE

### LFG_LIST_CENSORED_ACTIVE_ENTRY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCensored` | bool | no |  |

### LFG_LIST_ENTRY_CREATION_FAILED

### LFG_LIST_ENTRY_EXPIRED_TIMEOUT

### LFG_LIST_ENTRY_EXPIRED_TOO_MANY_PLAYERS

### LFG_LIST_JOINED_GROUP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |
| `groupName` | kstringLfgListChat | no |  |

### LFG_LIST_REVEALED_CENSORED_ACTIVE_ENTRY

### LFG_LIST_SEARCH_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | cstring | yes |  |

### LFG_LIST_SEARCH_RESULTS_RECEIVED

### LFG_LIST_SEARCH_RESULT_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |

### LFG_LIST_SHOW_SEARCH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityIDsFilter` | number[] | yes |  |

### LFG_LIST_UPDATE_SEARCH_RESULTS

## Types

### AdvancedFilterOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `needsTank` | bool | no | (default: False) |
| `needsHealer` | bool | no | (default: False) |
| `needsDamage` | bool | no | (default: False) |
| `needsMyClass` | bool | no | (default: False) |
| `hasTank` | bool | no | (default: False) |
| `hasHealer` | bool | no | (default: False) |
| `activities` | number[] | no | Activity group IDs to filter by. |
| `minimumRating` | number | no | (default: 0) |
| `difficultyNormal` | bool | no | (default: False) |
| `difficultyHeroic` | bool | no | (default: False) |
| `difficultyMythic` | bool | no | (default: False) |
| `difficultyMythicPlus` | bool | no | (default: False) |
| `generalPlaystyle1` | bool | no | (default: False) |
| `generalPlaystyle2` | bool | no | (default: False) |
| `generalPlaystyle3` | bool | no | (default: False) |
| `generalPlaystyle4` | bool | no | (default: False) |

### BestDungeonScoreMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapScore` | number | no |  |
| `mapName` | string | no |  |
| `bestRunLevel` | number | no |  |
| `finishedSuccess` | bool | no |  |
| `bestRunDurationMs` | number | no |  |
| `bestLevelIncrement` | number | no |  |

### GroupFinderActivityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullName` | string | no |  |
| `shortName` | string | no |  |
| `categoryID` | number | no |  |
| `groupFinderActivityGroupID` | number | no |  |
| `ilvlSuggestion` | number | no |  |
| `filters` | number | no |  |
| `minLevel` | number | no |  |
| `minLevelSuggestion` | number | no |  |
| `maxLevelSuggestion` | number | no |  |
| `maxNumPlayers` | number | no |  |
| `displayType` | LFGListDisplayType | no |  |
| `orderIndex` | number | no |  |
| `useHonorLevel` | bool | no |  |
| `showQuickJoinToast` | bool | no |  |
| `isMythicPlusActivity` | bool | no |  |
| `isRatedPvpActivity` | bool | no |  |
| `isCurrentRaidActivity` | bool | no |  |
| `isPvpActivity` | bool | no |  |
| `isMythicActivity` | bool | no |  |
| `allowCrossFaction` | bool | no |  |
| `isHeroicActivity` | bool | no |  |
| `isNormalActivity` | bool | no |  |
| `mapID` | number | no |  |
| `difficultyID` | number | no |  |
| `redirectedDifficultyID` | number | no |  |
| `useDungeonRoleExpectations` | bool | no |  |

### LfgApplicantData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `applicantID` | number | no |  |
| `applicationStatus` | cstring | no |  |
| `pendingApplicationStatus` | cstring | yes |  |
| `numMembers` | number | no |  |
| `isNew` | bool | no |  |
| `comment` | kstringLfgListApplicant | no |  |
| `displayOrderID` | number | no |  |

### LfgCategoryData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `searchPromptOverride` | cstring | yes |  |
| `separateRecommended` | bool | no |  |
| `autoChooseActivity` | bool | no |  |
| `preferCurrentArea` | bool | no |  |
| `showPlaystyleDropdown` | bool | no |  |
| `allowCrossFaction` | bool | no |  |

### LfgEntryData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityIDs` | number[] | no |  |
| `requiredItemLevel` | number | no |  |
| `requiredHonorLevel` | number | no |  |
| `name` | kstringLfgListApplicant | no |  |
| `comment` | kstringLfgListApplicant | no |  |
| `voiceChat` | kstringLfgListApplicant | no |  |
| `censored` | bool | no |  |
| `duration` | time_t | no |  |
| `autoAccept` | bool | no |  |
| `privateGroup` | bool | no |  |
| `questID` | number | yes |  |
| `requiredDungeonScore` | number | yes |  |
| `requiredPvpRating` | number | yes |  |
| `playstyle` | LFGEntryPlaystyle | yes |  |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | yes |  |
| `isCrossFactionListing` | bool | no |  |
| `newPlayerFriendly` | bool | no |  |

### LfgListingCreateData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityIDs` | number[] | no |  |
| `questID` | number | yes |  |
| `isAutoAccept` | bool | no | (default: False) |
| `isCrossFactionListing` | bool | no | (default: False) |
| `isPrivateGroup` | bool | no | (default: False) |
| `newPlayerFriendly` | bool | no | (default: False) |
| `playstyle` | LFGEntryPlaystyle | no | (default: None) |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | no | (default: None) |
| `requiredDungeonScore` | number | no | (default: 0) |
| `requiredItemLevel` | number | no | (default: 0) |
| `requiredPvpRating` | number | no | (default: 0) |

### LfgSearchResultData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchResultID` | number | no |  |
| `activityIDs` | number[] | no |  |
| `leaderName` | string | yes |  |
| `name` | kstringLfgListSearch | no |  |
| `comment` | kstringLfgListSearch | no |  |
| `voiceChat` | kstringLfgListSearch | no |  |
| `censored` | bool | no |  |
| `requiredItemLevel` | number | no |  |
| `requiredHonorLevel` | number | no |  |
| `hasSelf` | bool | no |  |
| `numMembers` | number | no |  |
| `numBNetFriends` | number | no |  |
| `numCharFriends` | number | no |  |
| `numGuildMates` | number | no |  |
| `isDelisted` | bool | no |  |
| `autoAccept` | bool | no |  |
| `isWarMode` | bool | no |  |
| `age` | time_t | no |  |
| `questID` | number | yes |  |
| `leaderOverallDungeonScore` | number | yes |  |
| `leaderDungeonScoreInfo` | BestDungeonScoreMapInfo[] | no |  |
| `leaderBestDungeonScoreInfo` | BestDungeonScoreMapInfo | yes |  |
| `leaderPvpRatingInfo` | PvpRatingInfo[] | no |  |
| `requiredDungeonScore` | number | yes |  |
| `requiredPvpRating` | number | yes |  |
| `playstyle` | LFGEntryPlaystyle | yes |  |
| `generalPlaystyle` | LFGEntryGeneralPlaystyle | yes |  |
| `crossFactionListing` | bool | yes |  |
| `leaderFactionGroup` | number | no |  |
| `newPlayerFriendly` | bool | yes |  |
| `partyGUID` | WOWGUID | no |  |

### LfgSearchResultPlayerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `level` | number | yes |  |
| `areaName` | cstring | yes |  |
| `className` | cstring | no |  |
| `classFilename` | cstring | no |  |
| `specName` | cstring | yes |  |
| `assignedRole` | cstring | no |  |
| `lfgRoles` | LFGRoles | no |  |
| `isLeader` | bool | no |  |
| `isLeaver` | bool | no | (default: False) |

### PvpRatingInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bracket` | number | no |  |
| `rating` | number | no |  |
| `activityName` | string | no |  |
| `tier` | number | no |  |

### WowLocale (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enUS` | bool | no | (default: False) |
| `koKR` | bool | no | (default: False) |
| `frFR` | bool | no | (default: False) |
| `deDE` | bool | no | (default: False) |
| `zhCN` | bool | no | (default: False) |
| `zhTW` | bool | no | (default: False) |
| `esES` | bool | no | (default: False) |
| `esMX` | bool | no | (default: False) |
| `ruRU` | bool | no | (default: False) |
| `ptBR` | bool | no | (default: False) |
| `itIT` | bool | no | (default: False) |

