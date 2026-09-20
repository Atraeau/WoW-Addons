# C_NeighborhoodInitiative

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**20** functions · **6** events · **7** types

## Functions

### C_NeighborhoodInitiative.AddTrackedInitiativeTask

```lua
C_NeighborhoodInitiative.AddTrackedInitiativeTask(initiativeTaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTaskID` | number | no |  |

**Example**

```lua
C_NeighborhoodInitiative.AddTrackedInitiativeTask(0)
```

### C_NeighborhoodInitiative.GetActiveNeighborhood

```lua
neighborhoodGUID = C_NeighborhoodInitiative.GetActiveNeighborhood()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |

**Example**

```lua
local neighborhoodGUID = C_NeighborhoodInitiative.GetActiveNeighborhood()
```

### C_NeighborhoodInitiative.GetAvailableHouseXP

```lua
availabeXP = C_NeighborhoodInitiative.GetAvailableHouseXP()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `availabeXP` | number | no |  |

**Example**

```lua
local availabeXP = C_NeighborhoodInitiative.GetAvailableHouseXP()
```

### C_NeighborhoodInitiative.GetInitiativeActivityLogInfo

```lua
info = C_NeighborhoodInitiative.GetInitiativeActivityLogInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | InitiativeActivityLogInfo | yes |  |

**Example**

```lua
local info = C_NeighborhoodInitiative.GetInitiativeActivityLogInfo()
```

### C_NeighborhoodInitiative.GetInitiativeTaskChatLink

```lua
link = C_NeighborhoodInitiative.GetInitiativeTaskChatLink(initiativeTaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTaskID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_NeighborhoodInitiative.GetInitiativeTaskChatLink(0)
```

### C_NeighborhoodInitiative.GetInitiativeTaskInfo

```lua
info = C_NeighborhoodInitiative.GetInitiativeTaskInfo(initiativeTaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTaskID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | InitiativeTaskInfo | yes |  |

**Example**

```lua
local info = C_NeighborhoodInitiative.GetInitiativeTaskInfo(0)
```

### C_NeighborhoodInitiative.GetInitiativeTaskRewardScaling

```lua
scaledAmount = C_NeighborhoodInitiative.GetInitiativeTaskRewardScaling(taskID, numItems)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `taskID` | number | no |  |
| `numItems` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaledAmount` | number | no |  |

**Example**

```lua
local scaledAmount = C_NeighborhoodInitiative.GetInitiativeTaskRewardScaling(0, 6948)
```

### C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo

```lua
info = C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | NeighborhoodInitiativeInfo | yes |  |

**Example**

```lua
local info = C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo()
```

### C_NeighborhoodInitiative.GetRequiredLevel

```lua
reqLevel = C_NeighborhoodInitiative.GetRequiredLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reqLevel` | number | no |  |

**Example**

```lua
local reqLevel = C_NeighborhoodInitiative.GetRequiredLevel()
```

### C_NeighborhoodInitiative.GetTrackedInitiativeTasks

```lua
trackedInitiativeTasks = C_NeighborhoodInitiative.GetTrackedInitiativeTasks()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedInitiativeTasks` | InitiativeTasksTracked | no |  |

**Example**

```lua
local trackedInitiativeTasks = C_NeighborhoodInitiative.GetTrackedInitiativeTasks()
```

### C_NeighborhoodInitiative.IsInitiativeEnabled

```lua
enabled = C_NeighborhoodInitiative.IsInitiativeEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_NeighborhoodInitiative.IsInitiativeEnabled()
```

### C_NeighborhoodInitiative.IsPlayerInNeighborhoodGroup

```lua
inValidGroup = C_NeighborhoodInitiative.IsPlayerInNeighborhoodGroup()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inValidGroup` | bool | no |  |

**Example**

```lua
local inValidGroup = C_NeighborhoodInitiative.IsPlayerInNeighborhoodGroup()
```

### C_NeighborhoodInitiative.IsViewingActiveNeighborhood

```lua
isViewingActiveNeighborhood = C_NeighborhoodInitiative.IsViewingActiveNeighborhood()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isViewingActiveNeighborhood` | bool | no |  |

**Example**

```lua
local isViewingActiveNeighborhood = C_NeighborhoodInitiative.IsViewingActiveNeighborhood()
```

### C_NeighborhoodInitiative.PlayerHasInitiativeAccess

```lua
success = C_NeighborhoodInitiative.PlayerHasInitiativeAccess()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_NeighborhoodInitiative.PlayerHasInitiativeAccess()
```

### C_NeighborhoodInitiative.PlayerMeetsRequiredLevel

```lua
success = C_NeighborhoodInitiative.PlayerMeetsRequiredLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_NeighborhoodInitiative.PlayerMeetsRequiredLevel()
```

### C_NeighborhoodInitiative.RemoveTrackedInitiativeTask

```lua
C_NeighborhoodInitiative.RemoveTrackedInitiativeTask(initiativeTaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTaskID` | number | no |  |

**Example**

```lua
C_NeighborhoodInitiative.RemoveTrackedInitiativeTask(0)
```

### C_NeighborhoodInitiative.RequestInitiativeActivityLog

```lua
C_NeighborhoodInitiative.RequestInitiativeActivityLog()
```

**Example**

```lua
C_NeighborhoodInitiative.RequestInitiativeActivityLog()
```

### C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo

```lua
C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo()
```

**Example**

```lua
C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo()
```

### C_NeighborhoodInitiative.SetActiveNeighborhood

```lua
C_NeighborhoodInitiative.SetActiveNeighborhood(neighborhoodGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |

**Example**

```lua
C_NeighborhoodInitiative.SetActiveNeighborhood("Creature-0-0000-0-0-0-0")
```

### C_NeighborhoodInitiative.SetViewingNeighborhood

```lua
C_NeighborhoodInitiative.SetViewingNeighborhood(neighborhoodGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `neighborhoodGUID` | WOWGUID | no |  |

**Example**

```lua
C_NeighborhoodInitiative.SetViewingNeighborhood("Creature-0-0000-0-0-0-0")
```

## Events

### INITIATIVE_ACTIVITY_LOG_UPDATED

### INITIATIVE_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTitle` | string | no |  |

### INITIATIVE_TASK_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `taskName` | string | no |  |

### INITIATIVE_TASKS_TRACKED_LIST_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `initiativeTaskID` | number | no |  |
| `added` | bool | no |  |

### INITIATIVE_TASKS_TRACKED_UPDATED

### NEIGHBORHOOD_INITIATIVE_UPDATED

## Types

### InitiativeActivityLogEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `taskID` | number | no |  |
| `playerName` | string | no |  |
| `taskName` | cstring | no |  |
| `completionTime` | time_t | no |  |
| `amount` | number | no |  |

### InitiativeActivityLogInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoaded` | bool | no |  |
| `neighborhoodGUID` | WOWGUID | no |  |
| `nextUpdateTime` | time_t | no |  |
| `taskActivity` | InitiativeActivityLogEntry[] | no |  |

### InitiativeMilestoneInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milestoneOrderIndex` | number | no |  |
| `requiredContributionAmount` | number | no |  |
| `rewards` | InitiativeMilestoneRewardInfo[] | no |  |

### InitiativeMilestoneRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `description` | string | no |  |
| `decorID` | number | no |  |
| `decorQuantity` | number | no |  |
| `favor` | number | no |  |
| `money` | WOWMONEY | no |  |
| `rewardQuestID` | number | no |  |

### InitiativeTaskInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `taskName` | cstring | no |  |
| `description` | string | no |  |
| `progressContributionAmount` | number | no |  |
| `tracked` | bool | no |  |
| `supersedes` | number | no |  |
| `timesCompleted` | number | no |  |
| `completed` | bool | no |  |
| `inProgress` | bool | no |  |
| `taskType` | NeighborhoodInitiativeTaskType | no |  |
| `sortOrder` | number | no |  |
| `rewardQuestID` | number | no |  |
| `requirementsList` | CriteriaRequirement[] | no |  |
| `criteriaList` | CriteriaRequiredValue[] | no |  |

### InitiativeTasksTracked (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedIDs` | number[] | no |  |

### NeighborhoodInitiativeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoaded` | bool | no |  |
| `neighborhoodGUID` | WOWGUID | no |  |
| `initiativeID` | number | no |  |
| `currentCycleID` | number | no |  |
| `progressRequired` | number | no |  |
| `currentProgress` | number | no |  |
| `playerTotalContribution` | number | no |  |
| `duration` | time_t | no |  |
| `tasks` | InitiativeTaskInfo[] | no |  |
| `milestones` | InitiativeMilestoneInfo[] | no |  |
| `title` | string | no |  |
| `description` | string | no |  |

