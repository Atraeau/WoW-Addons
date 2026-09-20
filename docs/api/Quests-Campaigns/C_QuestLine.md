# C_QuestLine

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **0** events · **2** types

## Functions

### C_QuestLine.GetAvailableQuestLines

```lua
questLines = C_QuestLine.GetAvailableQuestLines(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLines` | QuestLineInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questLines = C_QuestLine.GetAvailableQuestLines(0)
```

### C_QuestLine.GetForceVisibleQuests

```lua
questIDs = C_QuestLine.GetForceVisibleQuests(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questIDs = C_QuestLine.GetForceVisibleQuests(0)
```

### C_QuestLine.GetQuestLineInfo

```lua
questLineInfo = C_QuestLine.GetQuestLineInfo(questID, [uiMapID], displayableOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `uiMapID` | number | yes |  |
| `displayableOnly` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLineInfo` | QuestLineInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questLineInfo = C_QuestLine.GetQuestLineInfo(0, false)
```

### C_QuestLine.GetQuestLineQuests

```lua
questIDs = C_QuestLine.GetQuestLineQuests(questLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questIDs = C_QuestLine.GetQuestLineQuests(0)
```

### C_QuestLine.IsComplete

```lua
isComplete = C_QuestLine.IsComplete(questLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isComplete` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isComplete = C_QuestLine.IsComplete(0)
```

### C_QuestLine.QuestLineIgnoresAccountCompletedFiltering

```lua
questLineIgnoresAccountCompletedFiltering = C_QuestLine.QuestLineIgnoresAccountCompletedFiltering(uiMapID, questLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `questLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLineIgnoresAccountCompletedFiltering` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questLineIgnoresAccountCompletedFiltering = C_QuestLine.QuestLineIgnoresAccountCompletedFiltering(0, 0)
```

### C_QuestLine.RequestQuestLinesForMap

```lua
C_QuestLine.RequestQuestLinesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_QuestLine.RequestQuestLinesForMap(0)
```

## Types

### QuestLineFloorLocation (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Above` | QuestLineFloorLocation | no |  |
| `Below` | QuestLineFloorLocation | no |  |
| `Same` | QuestLineFloorLocation | no |  |

### QuestLineInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questLineName` | cstring | no |  |
| `questName` | cstring | no |  |
| `questLineID` | number | no |  |
| `questID` | number | no |  |
| `x` | number | no |  |
| `y` | number | no |  |
| `isHidden` | bool | no |  |
| `isLegendary` | bool | no |  |
| `isLocalStory` | bool | no |  |
| `isDaily` | bool | no |  |
| `isCampaign` | bool | no |  |
| `isImportant` | bool | no |  |
| `isAccountCompleted` | bool | no |  |
| `isCombatAllyQuest` | bool | no |  |
| `isMeta` | bool | no |  |
| `inProgress` | bool | no |  |
| `isQuestStart` | bool | no |  |
| `floorLocation` | QuestLineFloorLocation | no |  |
| `startMapID` | number | no |  |

