# C_WeeklyRewards

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**21** functions · **2** events · **6** types

## Functions

### C_WeeklyRewards.AreRewardsForCurrentRewardPeriod

```lua
isCurrentPeriod = C_WeeklyRewards.AreRewardsForCurrentRewardPeriod()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCurrentPeriod` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCurrentPeriod = C_WeeklyRewards.AreRewardsForCurrentRewardPeriod()
```

### C_WeeklyRewards.CanClaimRewards

```lua
canClaimRewards = C_WeeklyRewards.CanClaimRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canClaimRewards` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canClaimRewards = C_WeeklyRewards.CanClaimRewards()
```

### C_WeeklyRewards.ClaimReward

```lua
C_WeeklyRewards.ClaimReward(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WeeklyRewards.ClaimReward(0)
```

### C_WeeklyRewards.CloseInteraction

```lua
C_WeeklyRewards.CloseInteraction()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WeeklyRewards.CloseInteraction()
```

### C_WeeklyRewards.GetActivities

```lua
activities = C_WeeklyRewards.GetActivities([type])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | WeeklyRewardChestThresholdType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activities` | WeeklyRewardActivityInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activities = C_WeeklyRewards.GetActivities()
```

### C_WeeklyRewards.GetActivityEncounterInfo

```lua
info = C_WeeklyRewards.GetActivityEncounterInfo(type, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | WeeklyRewardChestThresholdType | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | WeeklyRewardActivityEncounterInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_WeeklyRewards.GetActivityEncounterInfo(type, 1)
```

### C_WeeklyRewards.GetConquestWeeklyProgress

```lua
weeklyProgress = C_WeeklyRewards.GetConquestWeeklyProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weeklyProgress` | ConquestWeeklyProgress | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local weeklyProgress = C_WeeklyRewards.GetConquestWeeklyProgress()
```

### C_WeeklyRewards.GetDifficultyIDForActivityTier

```lua
difficultyID = C_WeeklyRewards.GetDifficultyIDForActivityTier(activityTierID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityTierID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local difficultyID = C_WeeklyRewards.GetDifficultyIDForActivityTier(0)
```

### C_WeeklyRewards.GetExampleRewardItemHyperlinks

```lua
hyperlink, upgradeHyperlink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | string | no |  |
| `upgradeHyperlink` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hyperlink, upgradeHyperlink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(0)
```

### C_WeeklyRewards.GetItemHyperlink

```lua
hyperlink = C_WeeklyRewards.GetItemHyperlink(itemDBID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemDBID` | WeeklyRewardItemDBID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperlink` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hyperlink = C_WeeklyRewards.GetItemHyperlink(6948)
```

### C_WeeklyRewards.GetNextActivitiesIncrease

```lua
hasSeasonData, nextActivityTierID, nextLevel, itemLevel = C_WeeklyRewards.GetNextActivitiesIncrease(activityTierID, level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityTierID` | number | no |  |
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSeasonData` | bool | no |  |
| `nextActivityTierID` | number | yes |  |
| `nextLevel` | number | yes |  |
| `itemLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSeasonData, nextActivityTierID, nextLevel, itemLevel = C_WeeklyRewards.GetNextActivitiesIncrease(0, 0)
```

### C_WeeklyRewards.GetNextMythicPlusIncrease

```lua
hasSeasonData, nextMythicPlusLevel, itemLevel = C_WeeklyRewards.GetNextMythicPlusIncrease(mythicPlusLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mythicPlusLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSeasonData` | bool | no |  |
| `nextMythicPlusLevel` | number | yes |  |
| `itemLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSeasonData, nextMythicPlusLevel, itemLevel = C_WeeklyRewards.GetNextMythicPlusIncrease(0)
```

### C_WeeklyRewards.GetNumCompletedDungeonRuns

```lua
numHeroic, numMythic, numMythicPlus = C_WeeklyRewards.GetNumCompletedDungeonRuns()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numHeroic` | number | no |  |
| `numMythic` | number | no |  |
| `numMythicPlus` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numHeroic, numMythic, numMythicPlus = C_WeeklyRewards.GetNumCompletedDungeonRuns()
```

### C_WeeklyRewards.GetSortedProgressForActivity

```lua
progress = C_WeeklyRewards.GetSortedProgressForActivity(type, combineSharedDifficulty)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | WeeklyRewardChestThresholdType | no |  |
| `combineSharedDifficulty` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | WeeklyRewardActivityTierProgress[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local progress = C_WeeklyRewards.GetSortedProgressForActivity(type, false)
```

### C_WeeklyRewards.HasAvailableRewards

```lua
hasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAvailableRewards` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
```

### C_WeeklyRewards.HasGeneratedRewards

```lua
hasGeneratedRewards = C_WeeklyRewards.HasGeneratedRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasGeneratedRewards` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasGeneratedRewards = C_WeeklyRewards.HasGeneratedRewards()
```

### C_WeeklyRewards.HasInteraction

```lua
isInteracting = C_WeeklyRewards.HasInteraction()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInteracting` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInteracting = C_WeeklyRewards.HasInteraction()
```

### C_WeeklyRewards.IsWeeklyChestRetired

```lua
isRetired = C_WeeklyRewards.IsWeeklyChestRetired()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRetired` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRetired = C_WeeklyRewards.IsWeeklyChestRetired()
```

### C_WeeklyRewards.OnUIInteract

```lua
C_WeeklyRewards.OnUIInteract()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WeeklyRewards.OnUIInteract()
```

### C_WeeklyRewards.ShouldShowFinalRetirementMessage

```lua
showRetirementMessage = C_WeeklyRewards.ShouldShowFinalRetirementMessage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showRetirementMessage` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local showRetirementMessage = C_WeeklyRewards.ShouldShowFinalRetirementMessage()
```

### C_WeeklyRewards.ShouldShowRetirementMessage

```lua
showRetirementMessage = C_WeeklyRewards.ShouldShowRetirementMessage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showRetirementMessage` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local showRetirementMessage = C_WeeklyRewards.ShouldShowRetirementMessage()
```

## Events

### WEEKLY_REWARDS_ITEM_CHANGED

### WEEKLY_REWARDS_UPDATE

## Types

### ConquestProgressBarDisplayType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `FirstChest` | ConquestProgressBarDisplayType | no |  |
| `AdditionalChest` | ConquestProgressBarDisplayType | no |  |
| `Seasonal` | ConquestProgressBarDisplayType | no |  |

### ConquestWeeklyProgress (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |
| `maxProgress` | number | no |  |
| `displayType` | ConquestProgressBarDisplayType | no |  |
| `unlocksCompleted` | number | no |  |
| `maxUnlocks` | number | no |  |
| `sampleItemHyperlink` | string | no |  |

### WeeklyRewardActivityEncounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterID` | number | no |  |
| `bestDifficulty` | number | no |  |
| `uiOrder` | number | no |  |
| `instanceID` | number | no |  |

### WeeklyRewardActivityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | WeeklyRewardChestThresholdType | no |  |
| `index` | luaIndex | no |  |
| `threshold` | number | no |  |
| `progress` | number | no |  |
| `id` | number | no |  |
| `activityTierID` | number | no |  |
| `level` | number | no |  |
| `claimID` | number | yes |  |
| `raidString` | cstring | yes |  |
| `rewards` | WeeklyRewardActivityRewardInfo[] | no |  |

### WeeklyRewardActivityRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | CachedRewardType | no |  |
| `id` | number | no |  |
| `quantity` | number | no |  |
| `itemDBID` | WeeklyRewardItemDBID | yes |  |

### WeeklyRewardActivityTierProgress (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityTierID` | number | no |  |
| `difficulty` | number | no |  |
| `numPoints` | number | no |  |

