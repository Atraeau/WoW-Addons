# C_MythicPlus

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**21** functions · **2** events · **6** types

## Functions

### C_MythicPlus.GetCurrentAffixes

```lua
affixIDs = C_MythicPlus.GetCurrentAffixes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `affixIDs` | MythicPlusKeystoneAffix[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local affixIDs = C_MythicPlus.GetCurrentAffixes()
```

### C_MythicPlus.GetCurrentSeason

```lua
seasonID = C_MythicPlus.GetCurrentSeason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seasonID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seasonID = C_MythicPlus.GetCurrentSeason()
```

### C_MythicPlus.GetCurrentSeasonValues

```lua
displaySeasonID, milestoneSeasonID, rewardSeasonID = C_MythicPlus.GetCurrentSeasonValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displaySeasonID` | number | no |  |
| `milestoneSeasonID` | number | no |  |
| `rewardSeasonID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local displaySeasonID, milestoneSeasonID, rewardSeasonID = C_MythicPlus.GetCurrentSeasonValues()
```

### C_MythicPlus.GetCurrentUIDisplaySeason

```lua
seasonID = C_MythicPlus.GetCurrentUIDisplaySeason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seasonID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seasonID = C_MythicPlus.GetCurrentUIDisplaySeason()
```

### C_MythicPlus.GetEndOfRunGearSequenceLevel

```lua
sequenceLevel = C_MythicPlus.GetEndOfRunGearSequenceLevel(keystoneLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keystoneLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sequenceLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sequenceLevel = C_MythicPlus.GetEndOfRunGearSequenceLevel(0)
```

### C_MythicPlus.GetLastWeeklyBestInformation

```lua
challengeMapId, level = C_MythicPlus.GetLastWeeklyBestInformation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `challengeMapId` | number | no |  |
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local challengeMapId, level = C_MythicPlus.GetLastWeeklyBestInformation()
```

### C_MythicPlus.GetOwnedKeystoneChallengeMapID

```lua
challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `challengeMapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local challengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
```

### C_MythicPlus.GetOwnedKeystoneLevel

```lua
keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keyStoneLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
```

### C_MythicPlus.GetOwnedKeystoneMapID

```lua
mapID = C_MythicPlus.GetOwnedKeystoneMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapID = C_MythicPlus.GetOwnedKeystoneMapID()
```

### C_MythicPlus.GetRewardLevelForDifficultyLevel

```lua
weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(difficultyLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weeklyRewardLevel` | number | no |  |
| `endOfRunRewardLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(0)
```

### C_MythicPlus.GetRewardLevelFromKeystoneLevel

```lua
rewardLevel = C_MythicPlus.GetRewardLevelFromKeystoneLevel(keystoneLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keystoneLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewardLevel = C_MythicPlus.GetRewardLevelFromKeystoneLevel(0)
```

### C_MythicPlus.GetRunHistory

```lua
runs = C_MythicPlus.GetRunHistory(includePreviousWeeks, includeIncompleteRuns, currentSeasonOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `includePreviousWeeks` | bool | no | (default: False) |
| `includeIncompleteRuns` | bool | no | (default: False) |
| `currentSeasonOnly` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runs` | MythicPlusRunInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local runs = C_MythicPlus.GetRunHistory(false, false, false)
```

### C_MythicPlus.GetSeasonBestAffixScoreInfoForMap

Gets the active players best runs by the seasonal tracked affixes as well as their overall score for the current season.

```lua
affixScores, bestOverAllScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapChallengeModeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `affixScores` | MythicPlusAffixScoreInfo[] | no |  |
| `bestOverAllScore` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local affixScores, bestOverAllScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(0)
```

### C_MythicPlus.GetSeasonBestForMap

```lua
intimeInfo, overtimeInfo = C_MythicPlus.GetSeasonBestForMap(mapChallengeModeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `intimeInfo` | MapSeasonBestInfo | yes |  |
| `overtimeInfo` | MapSeasonBestInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local intimeInfo, overtimeInfo = C_MythicPlus.GetSeasonBestForMap(0)
```

### C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion

```lua
bestSeasonScore, bestSeason = C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bestSeasonScore` | number | no |  |
| `bestSeason` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bestSeasonScore, bestSeason = C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion()
```

### C_MythicPlus.GetWeeklyBestForMap

```lua
durationSec, level, completionDate, affixIDs, members, dungeonScore = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSec` | number | no |  |
| `level` | number | no |  |
| `completionDate` | CalendarTime | no |  |
| `affixIDs` | number[] | no |  |
| `members` | MythicPlusMember[] | no |  |
| `dungeonScore` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local durationSec, level, completionDate, affixIDs, members, dungeonScore = C_MythicPlus.GetWeeklyBestForMap(0)
```

### C_MythicPlus.GetWeeklyChestRewardLevel

```lua
currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentWeekBestLevel` | number | no |  |
| `weeklyRewardLevel` | number | no |  |
| `nextDifficultyWeeklyRewardLevel` | number | no |  |
| `nextBestLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel()
```

### C_MythicPlus.IsMythicPlusActive

```lua
isMythicPlusActive = C_MythicPlus.IsMythicPlusActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMythicPlusActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMythicPlusActive = C_MythicPlus.IsMythicPlusActive()
```

### C_MythicPlus.RequestCurrentAffixes

```lua
C_MythicPlus.RequestCurrentAffixes()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MythicPlus.RequestCurrentAffixes()
```

### C_MythicPlus.RequestMapInfo

```lua
C_MythicPlus.RequestMapInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MythicPlus.RequestMapInfo()
```

### C_MythicPlus.RequestRewards

```lua
C_MythicPlus.RequestRewards()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MythicPlus.RequestRewards()
```

## Events

### MYTHIC_PLUS_CURRENT_AFFIX_UPDATE

### MYTHIC_PLUS_NEW_WEEKLY_RECORD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |
| `completionMilliseconds` | number | no |  |
| `level` | number | no |  |

## Types

### MapSeasonBestInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationSec` | number | no |  |
| `level` | number | no |  |
| `completionDate` | CalendarTime | no |  |
| `affixIDs` | number[] | no |  |
| `members` | MythicPlusMember[] | no |  |
| `dungeonScore` | number | no |  |

### MythicPlusDate (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `year` | number | no |  |
| `month` | number | no |  |
| `day` | number | no |  |
| `hour` | number | no |  |
| `minute` | number | no |  |
| `weekday` | luaIndex | no |  |

### MythicPlusKeystoneAffix (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `seasonID` | number | no |  |

### MythicPlusMember (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `specID` | number | no |  |
| `classID` | number | no |  |

### MythicPlusRunInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |
| `level` | number | no |  |
| `thisWeek` | bool | no |  |
| `completed` | bool | no |  |
| `runScore` | number | no |  |
| `durationSec` | number | no |  |
| `completionDate` | CalendarTime | no |  |
| `season` | number | no |  |

### SeasonTimeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bestTime` | number | no |  |
| `lastTime` | number | no |  |
| `medal` | number | no |  |

