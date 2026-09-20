# C_IslandsQueue

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **2** events · **1** types

## Functions

### C_IslandsQueue.CloseIslandsQueueScreen

```lua
C_IslandsQueue.CloseIslandsQueueScreen()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_IslandsQueue.CloseIslandsQueueScreen()
```

### C_IslandsQueue.GetIslandDifficultyInfo

```lua
islandDifficultyInfo = C_IslandsQueue.GetIslandDifficultyInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `islandDifficultyInfo` | IslandsQueueDifficultyInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local islandDifficultyInfo = C_IslandsQueue.GetIslandDifficultyInfo()
```

### C_IslandsQueue.GetIslandsMaxGroupSize

```lua
maxGroupSize = C_IslandsQueue.GetIslandsMaxGroupSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxGroupSize` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxGroupSize = C_IslandsQueue.GetIslandsMaxGroupSize()
```

### C_IslandsQueue.GetIslandsWeeklyQuestID

```lua
questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
```

### C_IslandsQueue.QueueForIsland

```lua
C_IslandsQueue.QueueForIsland(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_IslandsQueue.QueueForIsland(0)
```

### C_IslandsQueue.RequestPreloadRewardData

```lua
C_IslandsQueue.RequestPreloadRewardData(questId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_IslandsQueue.RequestPreloadRewardData(0)
```

## Events

### ISLANDS_QUEUE_CLOSE

### ISLANDS_QUEUE_OPEN

## Types

### IslandsQueueDifficultyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyId` | number | no |  |
| `previewRewardQuestId` | number | no |  |

