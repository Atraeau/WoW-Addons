# C_ChallengeMode

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**29** functions · **14** events · **7** types

## Functions

### C_ChallengeMode.CanUseKeystoneInCurrentMap

```lua
canUse = C_ChallengeMode.CanUseKeystoneInCurrentMap(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |

**Example**

```lua
local canUse = C_ChallengeMode.CanUseKeystoneInCurrentMap(6948)
```

### C_ChallengeMode.ClearKeystone

```lua
C_ChallengeMode.ClearKeystone()
```

**Example**

```lua
C_ChallengeMode.ClearKeystone()
```

### C_ChallengeMode.CloseKeystoneFrame

```lua
C_ChallengeMode.CloseKeystoneFrame()
```

**Example**

```lua
C_ChallengeMode.CloseKeystoneFrame()
```

### C_ChallengeMode.GetActiveChallengeMapID

```lua
mapChallengeModeID = C_ChallengeMode.GetActiveChallengeMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | yes |  |

**Example**

```lua
local mapChallengeModeID = C_ChallengeMode.GetActiveChallengeMapID()
```

### C_ChallengeMode.GetActiveKeystoneInfo

```lua
activeKeystoneLevel, activeAffixIDs, wasActiveKeystoneCharged = C_ChallengeMode.GetActiveKeystoneInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeKeystoneLevel` | number | no |  |
| `activeAffixIDs` | number[] | no |  |
| `wasActiveKeystoneCharged` | bool | no |  |

**Example**

```lua
local activeKeystoneLevel, activeAffixIDs, wasActiveKeystoneCharged = C_ChallengeMode.GetActiveKeystoneInfo()
```

### C_ChallengeMode.GetAffixInfo

```lua
name, description, filedataid = C_ChallengeMode.GetAffixInfo(affixID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `affixID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `filedataid` | number | no |  |

**Example**

```lua
local name, description, filedataid = C_ChallengeMode.GetAffixInfo(0)
```

### C_ChallengeMode.GetChallengeCompletionInfo

```lua
info = C_ChallengeMode.GetChallengeCompletionInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ChallengeCompletionInfo | no |  |

**Example**

```lua
local info = C_ChallengeMode.GetChallengeCompletionInfo()
```

### C_ChallengeMode.GetDeathCount

```lua
numDeaths, timeLost = C_ChallengeMode.GetDeathCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDeaths` | number | no |  |
| `timeLost` | number | no |  |

**Example**

```lua
local numDeaths, timeLost = C_ChallengeMode.GetDeathCount()
```

### C_ChallengeMode.GetDungeonScoreRarityColor

Returns a color value from the passed in overall season M+ rating.

```lua
scoreColor = C_ChallengeMode.GetDungeonScoreRarityColor(dungeonScore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonScore` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scoreColor` | colorRGB | no |  |

**Example**

```lua
local scoreColor = C_ChallengeMode.GetDungeonScoreRarityColor(0)
```

### C_ChallengeMode.GetGuildLeaders

```lua
topAttempt = C_ChallengeMode.GetGuildLeaders()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `topAttempt` | ChallengeModeGuildTopAttempt[] | no |  |

**Example**

```lua
local topAttempt = C_ChallengeMode.GetGuildLeaders()
```

### C_ChallengeMode.GetKeystoneLevelRarityColor

Returns a color value from the passed in keystone level.

```lua
levelScore = C_ChallengeMode.GetKeystoneLevelRarityColor(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelScore` | colorRGB | no |  |

**Example**

```lua
local levelScore = C_ChallengeMode.GetKeystoneLevelRarityColor(0)
```

### C_ChallengeMode.GetLeaverPenaltyWarningTimeLeft

Returns how much time is left before player is automatically flagged as a leaver (and removed from the group) for exiting a restricted challenge mode instance

```lua
timeLeftSeconds = C_ChallengeMode.GetLeaverPenaltyWarningTimeLeft()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeftSeconds` | number | no | (default: 0) |

**Example**

```lua
local timeLeftSeconds = C_ChallengeMode.GetLeaverPenaltyWarningTimeLeft()
```

### C_ChallengeMode.GetMapScoreInfo

```lua
displayScores = C_ChallengeMode.GetMapScoreInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayScores` | MythicPlusRatingLinkInfo[] | no |  |

**Example**

```lua
local displayScores = C_ChallengeMode.GetMapScoreInfo()
```

### C_ChallengeMode.GetMapTable

```lua
mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeIDs` | number[] | no |  |

**Example**

```lua
local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
```

### C_ChallengeMode.GetMapUIInfo

```lua
name, id, timeLimit, texture, backgroundTexture, mapID = C_ChallengeMode.GetMapUIInfo(mapChallengeModeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `id` | number | no |  |
| `timeLimit` | number | no |  |
| `texture` | number | yes |  |
| `backgroundTexture` | number | no |  |
| `mapID` | number | no |  |

**Example**

```lua
local name, id, timeLimit, texture, backgroundTexture, mapID = C_ChallengeMode.GetMapUIInfo(0)
```

### C_ChallengeMode.GetOverallDungeonScore

Gets the overall season mythic+ rating for the player.

```lua
overallDungeonScore = C_ChallengeMode.GetOverallDungeonScore()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overallDungeonScore` | number | no |  |

**Example**

```lua
local overallDungeonScore = C_ChallengeMode.GetOverallDungeonScore()
```

### C_ChallengeMode.GetPowerLevelDamageHealthMod

```lua
damageMod, healthMod = C_ChallengeMode.GetPowerLevelDamageHealthMod(powerLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `damageMod` | number | no |  |
| `healthMod` | number | no |  |

**Example**

```lua
local damageMod, healthMod = C_ChallengeMode.GetPowerLevelDamageHealthMod(0)
```

### C_ChallengeMode.GetSlottedKeystoneInfo

```lua
mapChallengeModeID, affixIDs, keystoneLevel = C_ChallengeMode.GetSlottedKeystoneInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |
| `affixIDs` | number[] | no |  |
| `keystoneLevel` | number | no |  |

**Example**

```lua
local mapChallengeModeID, affixIDs, keystoneLevel = C_ChallengeMode.GetSlottedKeystoneInfo()
```

### C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor

Returns a color value from the passed in mythic+ rating from the combined affix scores for a specific dungeon

```lua
specificDungeonOverallScoreColor = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(specificDungeonOverallScore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specificDungeonOverallScore` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specificDungeonOverallScoreColor` | colorRGB | no |  |

**Example**

```lua
local specificDungeonOverallScoreColor = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(0)
```

### C_ChallengeMode.GetSpecificDungeonScoreRarityColor

Returns a color value from the passed in mythic+ rating for a specific dungeon.

```lua
specificDungeonScoreColor = C_ChallengeMode.GetSpecificDungeonScoreRarityColor(specificDungeonScore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specificDungeonScore` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specificDungeonScoreColor` | colorRGB | no |  |

**Example**

```lua
local specificDungeonScoreColor = C_ChallengeMode.GetSpecificDungeonScoreRarityColor(0)
```

### C_ChallengeMode.GetStartTime

```lua
startTime = C_ChallengeMode.GetStartTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |

**Example**

```lua
local startTime = C_ChallengeMode.GetStartTime()
```

### C_ChallengeMode.HasSlottedKeystone

```lua
hasSlottedKeystone = C_ChallengeMode.HasSlottedKeystone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSlottedKeystone` | bool | no |  |

**Example**

```lua
local hasSlottedKeystone = C_ChallengeMode.HasSlottedKeystone()
```

### C_ChallengeMode.IsChallengeModeActive

```lua
challengeModeActive = C_ChallengeMode.IsChallengeModeActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `challengeModeActive` | bool | no |  |

**Example**

```lua
local challengeModeActive = C_ChallengeMode.IsChallengeModeActive()
```

### C_ChallengeMode.IsChallengeModeResettable

```lua
canReset = C_ChallengeMode.IsChallengeModeResettable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canReset` | bool | no |  |

**Example**

```lua
local canReset = C_ChallengeMode.IsChallengeModeResettable()
```

### C_ChallengeMode.RemoveKeystone

```lua
removalSuccessful = C_ChallengeMode.RemoveKeystone()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removalSuccessful` | bool | no |  |

**Example**

```lua
local removalSuccessful = C_ChallengeMode.RemoveKeystone()
```

### C_ChallengeMode.RequestLeaders

```lua
C_ChallengeMode.RequestLeaders(mapChallengeModeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |

**Example**

```lua
C_ChallengeMode.RequestLeaders(0)
```

### C_ChallengeMode.Reset

```lua
C_ChallengeMode.Reset()
```

**Example**

```lua
C_ChallengeMode.Reset()
```

### C_ChallengeMode.SlotKeystone

```lua
C_ChallengeMode.SlotKeystone()
```

**Example**

```lua
C_ChallengeMode.SlotKeystone()
```

### C_ChallengeMode.StartChallengeMode

```lua
success = C_ChallengeMode.StartChallengeMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ChallengeMode.StartChallengeMode()
```

## Events

### CHALLENGE_MODE_COMPLETED

### CHALLENGE_MODE_COMPLETED_REWARDS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `medal` | number | no |  |
| `timeMS` | number | no |  |
| `money` | number | no |  |
| `rewards` | ChallengeModeReward[] | no |  |

### CHALLENGE_MODE_DEATH_COUNT_UPDATED

### CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN

### CHALLENGE_MODE_KEYSTONE_SLOTTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keystoneID` | number | no |  |

### CHALLENGE_MODE_LEADERBOARD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `challengeModeID` | number | no |  |
| `page` | number | no |  |
| `results` | MythicPlusLeaderboardResult[] | no |  |

### CHALLENGE_MODE_LEADERS_UPDATE

### CHALLENGE_MODE_LEAVER_TIMER_ENDED

### CHALLENGE_MODE_LEAVER_TIMER_STARTED

### CHALLENGE_MODE_MAPS_UPDATE

### CHALLENGE_MODE_MEMBER_INFO_UPDATED

### CHALLENGE_MODE_NEW_RECORD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `timeMS` | number | no |  |
| `medal` | number | no |  |

### CHALLENGE_MODE_RESET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

### CHALLENGE_MODE_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

## Types

### ChallengeCompletionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no | (default: 0) |
| `level` | number | no | (default: 0) |
| `time` | number | no | (default: 0) |
| `onTime` | bool | no | (default: False) |
| `keystoneUpgradeLevels` | number | no | (default: 0) |
| `practiceRun` | bool | no | (default: False) |
| `oldOverallDungeonScore` | number | yes |  |
| `newOverallDungeonScore` | number | yes |  |
| `isMapRecord` | bool | no | (default: False) |
| `isAffixRecord` | bool | no | (default: False) |
| `isEligibleForScore` | bool | no | (default: False) |
| `members` | ChallengeModeCompletionMemberInfo[] | no |  |

### ChallengeModeBestTime (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapChallengeModeID` | number | no |  |
| `durationMs` | number | no |  |
| `members` | ChallengeModeBestTimeMember[] | no |  |

### ChallengeModeBestTimeMember (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `classFileName` | cstring | no |  |
| `className` | cstring | no |  |
| `specializationID` | number | no |  |

### ChallengeModeCompletionMemberInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `memberGUID` | WOWGUID | no |  |
| `name` | string | no |  |

### ChallengeModeGuildAttemptMember (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `classFileName` | cstring | no |  |

### ChallengeModeGuildTopAttempt (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `classFileName` | cstring | no |  |
| `keystoneLevel` | number | no |  |
| `mapChallengeModeID` | number | no |  |
| `isYou` | bool | no |  |
| `members` | ChallengeModeGuildAttemptMember[] | no |  |

### ChallengeModeReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardID` | number | no |  |
| `displayInfoID` | number | no |  |
| `quantity` | number | no |  |
| `isCurrency` | bool | no |  |

