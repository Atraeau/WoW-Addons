# C_QuestLog

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**93** functions · **17** events · **10** types

## Functions

### C_QuestLog.AbandonQuest

```lua
C_QuestLog.AbandonQuest()
```

**Example**

```lua
C_QuestLog.AbandonQuest()
```

### C_QuestLog.AddQuestWatch

```lua
wasWatched = C_QuestLog.AddQuestWatch(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasWatched` | bool | no |  |

**Example**

```lua
local wasWatched = C_QuestLog.AddQuestWatch(0)
```

### C_QuestLog.AddWorldQuestWatch

```lua
wasWatched = C_QuestLog.AddWorldQuestWatch(questID, [watchType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `watchType` | QuestWatchType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasWatched` | bool | no |  |

**Example**

```lua
local wasWatched = C_QuestLog.AddWorldQuestWatch(0)
```

### C_QuestLog.CanAbandonQuest

```lua
canAbandon = C_QuestLog.CanAbandonQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAbandon` | bool | no |  |

**Example**

```lua
local canAbandon = C_QuestLog.CanAbandonQuest(0)
```

### C_QuestLog.DoesQuestAwardReputationWithFaction

```lua
awardsReputation = C_QuestLog.DoesQuestAwardReputationWithFaction(questID, targetFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `targetFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `awardsReputation` | bool | no |  |

**Example**

```lua
local awardsReputation = C_QuestLog.DoesQuestAwardReputationWithFaction(0, 0)
```

### C_QuestLog.GetAbandonQuest

```lua
questID = C_QuestLog.GetAbandonQuest()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
local questID = C_QuestLog.GetAbandonQuest()
```

### C_QuestLog.GetAbandonQuestItems

```lua
itemIDs = C_QuestLog.GetAbandonQuestItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example**

```lua
local itemIDs = C_QuestLog.GetAbandonQuestItems()
```

### C_QuestLog.GetActivePreyQuest

```lua
questID = C_QuestLog.GetActivePreyQuest()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
local questID = C_QuestLog.GetActivePreyQuest()
```

### C_QuestLog.GetActiveThreatMaps

```lua
uiMapIDs = C_QuestLog.GetActiveThreatMaps()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapIDs` | number[] | no |  |

**Example**

```lua
local uiMapIDs = C_QuestLog.GetActiveThreatMaps()
```

### C_QuestLog.GetAllCompletedQuestIDs

```lua
quests = C_QuestLog.GetAllCompletedQuestIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quests` | number[] | no |  |

**Example**

```lua
local quests = C_QuestLog.GetAllCompletedQuestIDs()
```

### C_QuestLog.GetBountiesForMapID

```lua
bounties = C_QuestLog.GetBountiesForMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bounties` | BountyInfo[] | yes |  |

**Example**

```lua
local bounties = C_QuestLog.GetBountiesForMapID(0)
```

### C_QuestLog.GetBountySetInfoForMapID

```lua
displayLocation, lockQuestID, bountySetID, isActivitySet = C_QuestLog.GetBountySetInfoForMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayLocation` | MapOverlayDisplayLocation | no |  |
| `lockQuestID` | number | no |  |
| `bountySetID` | number | no |  |
| `isActivitySet` | bool | no |  |

**Example**

```lua
local displayLocation, lockQuestID, bountySetID, isActivitySet = C_QuestLog.GetBountySetInfoForMapID(0)
```

### C_QuestLog.GetDistanceSqToQuest

```lua
distanceSq, onContinent = C_QuestLog.GetDistanceSqToQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distanceSq` | number | no |  |
| `onContinent` | bool | no |  |

**Example**

```lua
local distanceSq, onContinent = C_QuestLog.GetDistanceSqToQuest(0)
```

### C_QuestLog.GetHeaderIndexForQuest

```lua
index = C_QuestLog.GetHeaderIndexForQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | yes |  |

**Example**

```lua
local index = C_QuestLog.GetHeaderIndexForQuest(0)
```

### C_QuestLog.GetInfo

```lua
info = C_QuestLog.GetInfo(questLogIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLogIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | QuestInfo | yes |  |

**Example**

```lua
local info = C_QuestLog.GetInfo(1)
```

### C_QuestLog.GetLogIndexForQuestID

Only returns a log index for actual quests, not headers

```lua
questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLogIndex` | luaIndex | yes |  |

**Example**

```lua
local questLogIndex = C_QuestLog.GetLogIndexForQuestID(0)
```

### C_QuestLog.GetMapForQuestPOIs

```lua
uiMapID = C_QuestLog.GetMapForQuestPOIs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
local uiMapID = C_QuestLog.GetMapForQuestPOIs()
```

### C_QuestLog.GetMaxNumQuests

This is the maximum number of quests a player can be on, including hidden quests, world quests, emissaries etc

```lua
maxNumQuests = C_QuestLog.GetMaxNumQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxNumQuests` | number | no |  |

**Example**

```lua
local maxNumQuests = C_QuestLog.GetMaxNumQuests()
```

### C_QuestLog.GetMaxNumQuestsCanAccept

This is the maximum number of standard quests a player can accept. These are quests that are normally visible in the quest log.

```lua
maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxNumQuestsCanAccept` | number | no |  |

**Example**

```lua
local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
```

### C_QuestLog.GetNextWaypoint

```lua
mapID, x, y = C_QuestLog.GetNextWaypoint(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `x` | number | no |  |
| `y` | number | no |  |

**Example**

```lua
local mapID, x, y = C_QuestLog.GetNextWaypoint(0)
```

### C_QuestLog.GetNextWaypointForMap

```lua
x, y = C_QuestLog.GetNextWaypointForMap(questID, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |

**Example**

```lua
local x, y = C_QuestLog.GetNextWaypointForMap(0, 0)
```

### C_QuestLog.GetNextWaypointText

```lua
waypointText = C_QuestLog.GetNextWaypointText(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `waypointText` | string | no |  |

**Example**

```lua
local waypointText = C_QuestLog.GetNextWaypointText(0)
```

### C_QuestLog.GetNumQuestLogEntries

```lua
numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numShownEntries` | number | no |  |
| `numQuests` | number | no |  |

**Example**

```lua
local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
```

### C_QuestLog.GetNumQuestObjectives

```lua
leaderboardCount = C_QuestLog.GetNumQuestObjectives(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `leaderboardCount` | number | no |  |

**Example**

```lua
local leaderboardCount = C_QuestLog.GetNumQuestObjectives(0)
```

### C_QuestLog.GetNumQuestWatches

```lua
numQuestWatches = C_QuestLog.GetNumQuestWatches()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numQuestWatches` | number | no |  |

**Example**

```lua
local numQuestWatches = C_QuestLog.GetNumQuestWatches()
```

### C_QuestLog.GetNumWorldQuestWatches

```lua
numQuestWatches = C_QuestLog.GetNumWorldQuestWatches()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numQuestWatches` | number | no |  |

**Example**

```lua
local numQuestWatches = C_QuestLog.GetNumWorldQuestWatches()
```

### C_QuestLog.GetQuestAdditionalHighlights

```lua
uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `worldQuests` | bool | no |  |
| `worldQuestsElite` | bool | no |  |
| `dungeons` | bool | no |  |
| `treasures` | bool | no |  |

**Example**

```lua
local uiMapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(0)
```

### C_QuestLog.GetQuestDetailsTheme

```lua
theme = C_QuestLog.GetQuestDetailsTheme(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `theme` | QuestTheme | yes |  |

**Example**

```lua
local theme = C_QuestLog.GetQuestDetailsTheme(0)
```

### C_QuestLog.GetQuestDifficultyLevel

```lua
level = C_QuestLog.GetQuestDifficultyLevel(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example**

```lua
local level = C_QuestLog.GetQuestDifficultyLevel(0)
```

### C_QuestLog.GetQuestIDForLogIndex

Only returns a questID for actual quests, not headers

```lua
questID = C_QuestLog.GetQuestIDForLogIndex(questLogIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLogIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example**

```lua
local questID = C_QuestLog.GetQuestIDForLogIndex(1)
```

### C_QuestLog.GetQuestIDForQuestWatchIndex

```lua
questID = C_QuestLog.GetQuestIDForQuestWatchIndex(questWatchIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questWatchIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example**

```lua
local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(1)
```

### C_QuestLog.GetQuestIDForWorldQuestWatchIndex

```lua
questID = C_QuestLog.GetQuestIDForWorldQuestWatchIndex(questWatchIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questWatchIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example**

```lua
local questID = C_QuestLog.GetQuestIDForWorldQuestWatchIndex(1)
```

### C_QuestLog.GetQuestLogMajorFactionReputationRewards

```lua
reputationRewards = C_QuestLog.GetQuestLogMajorFactionReputationRewards(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reputationRewards` | QuestRewardReputationInfo[] | no |  |

**Example**

```lua
local reputationRewards = C_QuestLog.GetQuestLogMajorFactionReputationRewards(0)
```

### C_QuestLog.GetQuestLogPortraitGiver

```lua
portraitGiver, portraitGiverText, portraitGiverName, portraitGiverMount, portraitGiverModelSceneID = C_QuestLog.GetQuestLogPortraitGiver([questLogIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLogIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `portraitGiver` | number | no |  |
| `portraitGiverText` | cstring | no |  |
| `portraitGiverName` | cstring | no |  |
| `portraitGiverMount` | number | no |  |
| `portraitGiverModelSceneID` | number | yes |  |

**Example**

```lua
local portraitGiver, portraitGiverText, portraitGiverName, portraitGiverMount, portraitGiverModelSceneID = C_QuestLog.GetQuestLogPortraitGiver()
```

### C_QuestLog.GetQuestObjectives

```lua
objectives = C_QuestLog.GetQuestObjectives(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectives` | QuestObjectiveInfo[] | no |  |

**Example**

```lua
local objectives = C_QuestLog.GetQuestObjectives(0)
```

### C_QuestLog.GetQuestRewardCurrencies

```lua
questRewardCurrencies = C_QuestLog.GetQuestRewardCurrencies(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRewardCurrencies` | QuestRewardCurrencyInfo[] | no |  |

**Example**

```lua
local questRewardCurrencies = C_QuestLog.GetQuestRewardCurrencies(0)
```

### C_QuestLog.GetQuestRewardCurrencyInfo

```lua
questRewardCurrencyInfo = C_QuestLog.GetQuestRewardCurrencyInfo(questID, currencyIndex, isChoice)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `currencyIndex` | luaIndex | no |  |
| `isChoice` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRewardCurrencyInfo` | QuestRewardCurrencyInfo | yes |  |

**Example**

```lua
local questRewardCurrencyInfo = C_QuestLog.GetQuestRewardCurrencyInfo(0, 1, false)
```

### C_QuestLog.GetQuestsOnMap

```lua
quests = C_QuestLog.GetQuestsOnMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quests` | QuestPOIMapInfo[] | no |  |

**Example**

```lua
local quests = C_QuestLog.GetQuestsOnMap(0)
```

### C_QuestLog.GetQuestTagInfo

```lua
info = C_QuestLog.GetQuestTagInfo(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | QuestTagInfo | yes |  |

**Example**

```lua
local info = C_QuestLog.GetQuestTagInfo(0)
```

### C_QuestLog.GetQuestTimers

```lua
questTimers = C_QuestLog.GetQuestTimers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questTimers` | QuestTimerInfo[] | no |  |

**Example**

```lua
local questTimers = C_QuestLog.GetQuestTimers()
```

### C_QuestLog.GetQuestType

```lua
questType = C_QuestLog.GetQuestType(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questType` | number | yes |  |

**Example**

```lua
local questType = C_QuestLog.GetQuestType(0)
```

### C_QuestLog.GetQuestWatchType

```lua
watchType = C_QuestLog.GetQuestWatchType(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `watchType` | QuestWatchType | yes |  |

**Example**

```lua
local watchType = C_QuestLog.GetQuestWatchType(0)
```

### C_QuestLog.GetRequiredMoney

Uses the selected quest if no questID is provided

```lua
requiredMoney = C_QuestLog.GetRequiredMoney([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requiredMoney` | number | no |  |

**Example**

```lua
local requiredMoney = C_QuestLog.GetRequiredMoney()
```

### C_QuestLog.GetSelectedQuest

```lua
questID = C_QuestLog.GetSelectedQuest()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
local questID = C_QuestLog.GetSelectedQuest()
```

### C_QuestLog.GetSuggestedGroupSize

```lua
suggestedGroupSize = C_QuestLog.GetSuggestedGroupSize(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `suggestedGroupSize` | number | no |  |

**Example**

```lua
local suggestedGroupSize = C_QuestLog.GetSuggestedGroupSize(0)
```

### C_QuestLog.GetTimeAllowed

```lua
totalTime, elapsedTime = C_QuestLog.GetTimeAllowed(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalTime` | number | no |  |
| `elapsedTime` | number | no |  |

**Example**

```lua
local totalTime, elapsedTime = C_QuestLog.GetTimeAllowed(0)
```

### C_QuestLog.GetTitleForLogIndex

Returns a valid title for anything that is in the quest log.

```lua
title = C_QuestLog.GetTitleForLogIndex(questLogIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLogIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | yes |  |

**Example**

```lua
local title = C_QuestLog.GetTitleForLogIndex(1)
```

### C_QuestLog.GetTitleForQuestID

Only returns a valid title for quests, header titles cannot be discovered using this.

```lua
title = C_QuestLog.GetTitleForQuestID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | yes |  |

**Example**

```lua
local title = C_QuestLog.GetTitleForQuestID(0)
```

### C_QuestLog.GetTrivialRange

```lua
range = C_QuestLog.GetTrivialRange()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `range` | number | no |  |

**Example**

```lua
local range = C_QuestLog.GetTrivialRange()
```

### C_QuestLog.GetZoneStoryInfo

```lua
achievementID, storyMapID = C_QuestLog.GetZoneStoryInfo(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |
| `storyMapID` | number | no |  |

**Example**

```lua
local achievementID, storyMapID = C_QuestLog.GetZoneStoryInfo(0)
```

### C_QuestLog.HasActiveThreats

```lua
hasActiveThreats = C_QuestLog.HasActiveThreats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasActiveThreats` | bool | no |  |

**Example**

```lua
local hasActiveThreats = C_QuestLog.HasActiveThreats()
```

### C_QuestLog.IsAccountQuest

```lua
isAccountQuest = C_QuestLog.IsAccountQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccountQuest` | bool | no |  |

**Example**

```lua
local isAccountQuest = C_QuestLog.IsAccountQuest(0)
```

### C_QuestLog.IsComplete

```lua
isComplete = C_QuestLog.IsComplete(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isComplete` | bool | no |  |

**Example**

```lua
local isComplete = C_QuestLog.IsComplete(0)
```

### C_QuestLog.IsEliteQuest

```lua
isEliteQuest = C_QuestLog.IsEliteQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEliteQuest` | bool | no |  |

**Example**

```lua
local isEliteQuest = C_QuestLog.IsEliteQuest(0)
```

### C_QuestLog.IsFailed

```lua
isFailed = C_QuestLog.IsFailed(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFailed` | bool | no |  |

**Example**

```lua
local isFailed = C_QuestLog.IsFailed(0)
```

### C_QuestLog.IsImportantQuest

```lua
isImportant = C_QuestLog.IsImportantQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isImportant` | bool | no |  |

**Example**

```lua
local isImportant = C_QuestLog.IsImportantQuest(0)
```

### C_QuestLog.IsMetaQuest

```lua
isMeta = C_QuestLog.IsMetaQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMeta` | bool | no |  |

**Example**

```lua
local isMeta = C_QuestLog.IsMetaQuest(0)
```

### C_QuestLog.IsOnMap

```lua
onMap, hasLocalPOI = C_QuestLog.IsOnMap(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onMap` | bool | no |  |
| `hasLocalPOI` | bool | no |  |

**Example**

```lua
local onMap, hasLocalPOI = C_QuestLog.IsOnMap(0)
```

### C_QuestLog.IsOnQuest

```lua
isOnQuest = C_QuestLog.IsOnQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOnQuest` | bool | no |  |

**Example**

```lua
local isOnQuest = C_QuestLog.IsOnQuest(0)
```

### C_QuestLog.IsPushableQuest

```lua
isPushable = C_QuestLog.IsPushableQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPushable` | bool | no |  |

**Example**

```lua
local isPushable = C_QuestLog.IsPushableQuest(0)
```

### C_QuestLog.IsQuestBounty

```lua
isBounty = C_QuestLog.IsQuestBounty(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBounty` | bool | no |  |

**Example**

```lua
local isBounty = C_QuestLog.IsQuestBounty(0)
```

### C_QuestLog.IsQuestCalling

```lua
isCalling = C_QuestLog.IsQuestCalling(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCalling` | bool | no |  |

**Example**

```lua
local isCalling = C_QuestLog.IsQuestCalling(0)
```

### C_QuestLog.IsQuestCriteriaForBounty

```lua
isCriteriaForBounty = C_QuestLog.IsQuestCriteriaForBounty(questID, bountyQuestID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `bountyQuestID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCriteriaForBounty` | bool | no |  |

**Example**

```lua
local isCriteriaForBounty = C_QuestLog.IsQuestCriteriaForBounty(0, 0)
```

### C_QuestLog.IsQuestDisabledForSession

```lua
isDisabled = C_QuestLog.IsQuestDisabledForSession(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisabled` | bool | no |  |

**Example**

```lua
local isDisabled = C_QuestLog.IsQuestDisabledForSession(0)
```

### C_QuestLog.IsQuestFlaggedCompleted

```lua
isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCompleted` | bool | no |  |

**Example**

```lua
local isCompleted = C_QuestLog.IsQuestFlaggedCompleted(0)
```

### C_QuestLog.IsQuestFlaggedCompletedOnAccount

```lua
isCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCompletedOnAccount` | bool | no |  |

**Example**

```lua
local isCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount(0)
```

### C_QuestLog.IsQuestFromContentPush

```lua
isFromContentPush = C_QuestLog.IsQuestFromContentPush(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFromContentPush` | bool | no |  |

**Example**

```lua
local isFromContentPush = C_QuestLog.IsQuestFromContentPush(0)
```

### C_QuestLog.IsQuestInvasion

```lua
isInvasion = C_QuestLog.IsQuestInvasion(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInvasion` | bool | no |  |

**Example**

```lua
local isInvasion = C_QuestLog.IsQuestInvasion(0)
```

### C_QuestLog.IsQuestReplayable

```lua
isReplayable = C_QuestLog.IsQuestReplayable(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReplayable` | bool | no |  |

**Example**

```lua
local isReplayable = C_QuestLog.IsQuestReplayable(0)
```

### C_QuestLog.IsQuestReplayedRecently

```lua
recentlyReplayed = C_QuestLog.IsQuestReplayedRecently(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recentlyReplayed` | bool | no |  |

**Example**

```lua
local recentlyReplayed = C_QuestLog.IsQuestReplayedRecently(0)
```

### C_QuestLog.IsQuestTask

```lua
isTask = C_QuestLog.IsQuestTask(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTask` | bool | no |  |

**Example**

```lua
local isTask = C_QuestLog.IsQuestTask(0)
```

### C_QuestLog.IsQuestTrivial

```lua
isTrivial = C_QuestLog.IsQuestTrivial(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrivial` | bool | no |  |

**Example**

```lua
local isTrivial = C_QuestLog.IsQuestTrivial(0)
```

### C_QuestLog.IsRepeatableQuest

```lua
isRepeatable = C_QuestLog.IsRepeatableQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRepeatable` | bool | no |  |

**Example**

```lua
local isRepeatable = C_QuestLog.IsRepeatableQuest(0)
```

### C_QuestLog.IsThreatQuest

```lua
isThreat = C_QuestLog.IsThreatQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isThreat` | bool | no |  |

**Example**

```lua
local isThreat = C_QuestLog.IsThreatQuest(0)
```

### C_QuestLog.IsUnitOnQuest

```lua
isOnQuest = C_QuestLog.IsUnitOnQuest(unit, questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOnQuest` | bool | no |  |

**Example**

```lua
local isOnQuest = C_QuestLog.IsUnitOnQuest("player", 0)
```

### C_QuestLog.IsWorldQuest

```lua
isWorldQuest = C_QuestLog.IsWorldQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWorldQuest` | bool | no |  |

**Example**

```lua
local isWorldQuest = C_QuestLog.IsWorldQuest(0)
```

### C_QuestLog.QuestCanHaveWarModeBonus

Tests whether a quest is eligible for warmode bonuses (e.g. most world quests, some daily quests

```lua
hasBonus = C_QuestLog.QuestCanHaveWarModeBonus(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBonus` | bool | no |  |

**Example**

```lua
local hasBonus = C_QuestLog.QuestCanHaveWarModeBonus(0)
```

### C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer

```lua
questContainsFirstTimeRepBonusForPlayer = C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questContainsFirstTimeRepBonusForPlayer` | bool | no |  |

**Example**

```lua
local questContainsFirstTimeRepBonusForPlayer = C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(0)
```

### C_QuestLog.QuestHasQuestSessionBonus

```lua
hasBonus = C_QuestLog.QuestHasQuestSessionBonus(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBonus` | bool | no |  |

**Example**

```lua
local hasBonus = C_QuestLog.QuestHasQuestSessionBonus(0)
```

### C_QuestLog.QuestHasWarModeBonus

Tests whether a quest in the player's quest log that is eligible for warmode bonuses (see 'QuestCanHaveWarModeBOnus') has been completed in warmode (including accepting it)

```lua
hasBonus = C_QuestLog.QuestHasWarModeBonus(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBonus` | bool | no |  |

**Example**

```lua
local hasBonus = C_QuestLog.QuestHasWarModeBonus(0)
```

### C_QuestLog.QuestIgnoresAccountCompletedFiltering

```lua
questIgnoresAccountCompletedFiltering = C_QuestLog.QuestIgnoresAccountCompletedFiltering(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questIgnoresAccountCompletedFiltering` | bool | no |  |

**Example**

```lua
local questIgnoresAccountCompletedFiltering = C_QuestLog.QuestIgnoresAccountCompletedFiltering(0)
```

### C_QuestLog.ReadyForTurnIn

```lua
readyForTurnIn = C_QuestLog.ReadyForTurnIn(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `readyForTurnIn` | bool | yes |  |

**Example**

```lua
local readyForTurnIn = C_QuestLog.ReadyForTurnIn(0)
```

### C_QuestLog.RemoveQuestWatch

```lua
wasRemoved = C_QuestLog.RemoveQuestWatch(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasRemoved` | bool | no |  |

**Example**

```lua
local wasRemoved = C_QuestLog.RemoveQuestWatch(0)
```

### C_QuestLog.RemoveWorldQuestWatch

```lua
wasRemoved = C_QuestLog.RemoveWorldQuestWatch(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasRemoved` | bool | no |  |

**Example**

```lua
local wasRemoved = C_QuestLog.RemoveWorldQuestWatch(0)
```

### C_QuestLog.RequestLoadQuestByID

```lua
C_QuestLog.RequestLoadQuestByID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
C_QuestLog.RequestLoadQuestByID(0)
```

### C_QuestLog.SetAbandonQuest

```lua
C_QuestLog.SetAbandonQuest()
```

**Example**

```lua
C_QuestLog.SetAbandonQuest()
```

### C_QuestLog.SetMapForQuestPOIs

```lua
C_QuestLog.SetMapForQuestPOIs(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
C_QuestLog.SetMapForQuestPOIs(0)
```

### C_QuestLog.SetSelectedQuest

```lua
C_QuestLog.SetSelectedQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
C_QuestLog.SetSelectedQuest(0)
```

### C_QuestLog.ShouldDisplayTimeRemaining

```lua
displayTimeRemaining = C_QuestLog.ShouldDisplayTimeRemaining(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayTimeRemaining` | bool | no |  |

**Example**

```lua
local displayTimeRemaining = C_QuestLog.ShouldDisplayTimeRemaining(0)
```

### C_QuestLog.ShouldShowQuestRewards

```lua
shouldShow = C_QuestLog.ShouldShowQuestRewards(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example**

```lua
local shouldShow = C_QuestLog.ShouldShowQuestRewards(0)
```

### C_QuestLog.SortQuestWatches

```lua
C_QuestLog.SortQuestWatches()
```

**Example**

```lua
C_QuestLog.SortQuestWatches()
```

### C_QuestLog.UnitIsRelatedToActiveQuest

```lua
isRelatedToActiveQuest = C_QuestLog.UnitIsRelatedToActiveQuest(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRelatedToActiveQuest` | bool | no |  |

**Example**

```lua
local isRelatedToActiveQuest = C_QuestLog.UnitIsRelatedToActiveQuest("player")
```

### C_QuestLog.UpdateCampaignHeaders

```lua
C_QuestLog.UpdateCampaignHeaders()
```

**Example**

```lua
C_QuestLog.UpdateCampaignHeaders()
```

## Events

### QUEST_ACCEPTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questId` | number | no |  |

### QUEST_AUTOCOMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questId` | number | no |  |

### QUEST_COMPLETE

### QUEST_DATA_LOAD_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `success` | bool | no |  |

### QUEST_DETAIL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questStartItemID` | number | yes |  |

### QUESTLINE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requestRequired` | bool | no |  |

### QUEST_LOG_CRITERIA_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `specificTreeID` | number | no |  |
| `description` | cstring | no |  |
| `numFulfilled` | number | no |  |
| `numRequired` | number | no |  |

### QUEST_LOG_UPDATE

### QUEST_POI_UPDATE

### QUEST_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `wasReplayQuest` | bool | no |  |

### QUEST_TURNED_IN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `xpReward` | number | no |  |
| `moneyReward` | number | no |  |

### QUEST_WATCH_LIST_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `added` | bool | yes |  |

### QUEST_WATCH_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

### TASK_PROGRESS_UPDATE

### TREASURE_PICKER_CACHE_FLUSH

### WAYPOINT_UPDATE

### WORLD_QUEST_COMPLETED_BY_SPELL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

## Types

### MapOverlayDisplayLocation (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | MapOverlayDisplayLocation | no |  |
| `BottomLeft` | MapOverlayDisplayLocation | no |  |
| `TopLeft` | MapOverlayDisplayLocation | no |  |
| `BottomRight` | MapOverlayDisplayLocation | no |  |
| `TopRight` | MapOverlayDisplayLocation | no |  |
| `Hidden` | MapOverlayDisplayLocation | no |  |

### QuestFrequency (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | QuestFrequency | no |  |
| `Daily` | QuestFrequency | no |  |
| `Weekly` | QuestFrequency | no |  |
| `ResetByScheduler` | QuestFrequency | no |  |

### QuestInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `questLogIndex` | luaIndex | no |  |
| `questID` | number | no |  |
| `campaignID` | number | yes |  |
| `level` | number | no |  |
| `difficultyLevel` | number | no |  |
| `suggestedGroup` | number | no |  |
| `frequency` | QuestFrequency | yes |  |
| `isHeader` | bool | no |  |
| `useMinimalHeader` | bool | no |  |
| `sortAsNormalQuest` | bool | no |  |
| `isCollapsed` | bool | no |  |
| `startEvent` | bool | no |  |
| `isTask` | bool | no |  |
| `isBounty` | bool | no |  |
| `isStory` | bool | no |  |
| `isScaling` | bool | no |  |
| `isOnMap` | bool | no |  |
| `hasLocalPOI` | bool | no |  |
| `isHidden` | bool | no |  |
| `isAutoComplete` | bool | no |  |
| `overridesSortOrder` | bool | no |  |
| `readyForTranslation` | bool | no | (default: True) |
| `isInternalOnly` | bool | no |  |
| `isAbandonOnDisable` | bool | no |  |
| `headerSortKey` | number | yes |  |
| `questClassification` | QuestClassification | no |  |

### QuestObjectiveInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `type` | string | no |  |
| `finished` | bool | no |  |
| `numFulfilled` | number | no |  |
| `numRequired` | number | no |  |
| `objectiveType` | QuestObjectiveType | yes |  |

### QuestTag (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Group` | QuestTag | no |  |
| `PvP` | QuestTag | no |  |
| `Raid` | QuestTag | no |  |
| `Dungeon` | QuestTag | no |  |
| `Legendary` | QuestTag | no |  |
| `Heroic` | QuestTag | no |  |
| `Raid10` | QuestTag | no |  |
| `Raid25` | QuestTag | no |  |
| `Scenario` | QuestTag | no |  |
| `Account` | QuestTag | no |  |
| `CombatAlly` | QuestTag | no |  |
| `Delve` | QuestTag | no |  |

### QuestTagInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tagName` | cstring | no |  |
| `tagID` | number | no |  |
| `worldQuestType` | number | yes |  |
| `quality` | WorldQuestQuality | yes |  |
| `tradeskillLineID` | number | yes |  |
| `isElite` | bool | yes |  |
| `displayExpiration` | bool | yes |  |

### QuestTheme (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `background` | textureAtlas | no |  |
| `seal` | textureAtlas | no |  |
| `signature` | cstring | no |  |
| `poiIcon` | textureAtlas | no |  |
| `mapPinInfo` | UIMapPinInfo | yes |  |

### QuestTimerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `questTimer` | number | no |  |

### QuestWatchType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Automatic` | QuestWatchType | no |  |
| `Manual` | QuestWatchType | no |  |

### WorldQuestQuality (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Common` | WorldQuestQuality | no |  |
| `Rare` | WorldQuestQuality | no |  |
| `Epic` | WorldQuestQuality | no |  |

