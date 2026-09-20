# C_TaskQuest

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**12** functions · **0** events · **0** types

## Functions

### C_TaskQuest.DoesMapShowTaskQuestObjectives

```lua
showsTaskQuestObjectives = C_TaskQuest.DoesMapShowTaskQuestObjectives(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showsTaskQuestObjectives` | bool | no |  |

**Example**

```lua
local showsTaskQuestObjectives = C_TaskQuest.DoesMapShowTaskQuestObjectives(0)
```

### C_TaskQuest.GetQuestInfoByQuestID

```lua
questTitle, factionID, capped, displayAsObjective = C_TaskQuest.GetQuestInfoByQuestID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questTitle` | cstring | no |  |
| `factionID` | number | yes |  |
| `capped` | bool | yes |  |
| `displayAsObjective` | bool | yes |  |

**Example**

```lua
local questTitle, factionID, capped, displayAsObjective = C_TaskQuest.GetQuestInfoByQuestID(0)
```

### C_TaskQuest.GetQuestLocation

```lua
locationX, locationY = C_TaskQuest.GetQuestLocation(questID, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationX` | number | no |  |
| `locationY` | number | no |  |

**Example**

```lua
local locationX, locationY = C_TaskQuest.GetQuestLocation(0, 0)
```

### C_TaskQuest.GetQuestProgressBarInfo

```lua
progress = C_TaskQuest.GetQuestProgressBarInfo(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | no |  |

**Example**

```lua
local progress = C_TaskQuest.GetQuestProgressBarInfo(0)
```

### C_TaskQuest.GetQuestsOnMap

```lua
taskPOIs = C_TaskQuest.GetQuestsOnMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `taskPOIs` | QuestPOIMapInfo[] | no |  |

**Example**

```lua
local taskPOIs = C_TaskQuest.GetQuestsOnMap(0)
```

### C_TaskQuest.GetQuestTimeLeftMinutes

```lua
minutesLeft = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minutesLeft` | number | no |  |

**Example**

```lua
local minutesLeft = C_TaskQuest.GetQuestTimeLeftMinutes(0)
```

### C_TaskQuest.GetQuestTimeLeftSeconds

```lua
secondsLeft = C_TaskQuest.GetQuestTimeLeftSeconds(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secondsLeft` | number | no |  |

**Example**

```lua
local secondsLeft = C_TaskQuest.GetQuestTimeLeftSeconds(0)
```

### C_TaskQuest.GetQuestUIWidgetSetByType

```lua
widgetSet = C_TaskQuest.GetQuestUIWidgetSetByType(questID, type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `type` | MapIconUIWidgetSetType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetSet` | number | no |  |

**Example**

```lua
local widgetSet = C_TaskQuest.GetQuestUIWidgetSetByType(0, type)
```

### C_TaskQuest.GetQuestZoneID

```lua
uiMapID = C_TaskQuest.GetQuestZoneID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Example**

```lua
local uiMapID = C_TaskQuest.GetQuestZoneID(0)
```

### C_TaskQuest.GetThreatQuests

```lua
quests = C_TaskQuest.GetThreatQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quests` | number[] | no |  |

**Example**

```lua
local quests = C_TaskQuest.GetThreatQuests()
```

### C_TaskQuest.IsActive

```lua
active = C_TaskQuest.IsActive(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example**

```lua
local active = C_TaskQuest.IsActive(0)
```

### C_TaskQuest.RequestPreloadRewardData

```lua
C_TaskQuest.RequestPreloadRewardData(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example**

```lua
C_TaskQuest.RequestPreloadRewardData(0)
```

