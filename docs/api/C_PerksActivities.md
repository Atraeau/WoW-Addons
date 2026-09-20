# C_PerksActivities

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **4** events · **7** types

## Functions

### C_PerksActivities.AddTrackedPerksActivity

```lua
C_PerksActivities.AddTrackedPerksActivity(perksActivityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |

**Example**

```lua
C_PerksActivities.AddTrackedPerksActivity(0)
```

### C_PerksActivities.ClearPerksActivitiesPendingCompletion

```lua
C_PerksActivities.ClearPerksActivitiesPendingCompletion()
```

**Example**

```lua
C_PerksActivities.ClearPerksActivitiesPendingCompletion()
```

### C_PerksActivities.GetAllPerksActivityTags

```lua
tags = C_PerksActivities.GetAllPerksActivityTags()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tags` | PerksActivityTags | no |  |

**Example**

```lua
local tags = C_PerksActivities.GetAllPerksActivityTags()
```

### C_PerksActivities.GetPerksActivitiesInfo

```lua
info = C_PerksActivities.GetPerksActivitiesInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PerksActivitiesInfo | no |  |

**Example**

```lua
local info = C_PerksActivities.GetPerksActivitiesInfo()
```

### C_PerksActivities.GetPerksActivitiesPendingCompletion

```lua
pending = C_PerksActivities.GetPerksActivitiesPendingCompletion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pending` | PerksActivitiesPending | no |  |

**Example**

```lua
local pending = C_PerksActivities.GetPerksActivitiesPendingCompletion()
```

### C_PerksActivities.GetPerksActivityChatLink

```lua
link = C_PerksActivities.GetPerksActivityChatLink(perksActivityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_PerksActivities.GetPerksActivityChatLink(0)
```

### C_PerksActivities.GetPerksActivityInfo

```lua
info = C_PerksActivities.GetPerksActivityInfo(perksActivityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PerksActivityInfo | yes |  |

**Example**

```lua
local info = C_PerksActivities.GetPerksActivityInfo(0)
```

### C_PerksActivities.GetPerksUIThemePrefix

```lua
kitPrefix = C_PerksActivities.GetPerksUIThemePrefix()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `kitPrefix` | string | no |  |

**Example**

```lua
local kitPrefix = C_PerksActivities.GetPerksUIThemePrefix()
```

### C_PerksActivities.GetTrackedPerksActivities

```lua
trackedPerksActivities = C_PerksActivities.GetTrackedPerksActivities()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedPerksActivities` | PerksActivitiesTracked | no |  |

**Example**

```lua
local trackedPerksActivities = C_PerksActivities.GetTrackedPerksActivities()
```

### C_PerksActivities.RemoveTrackedPerksActivity

```lua
C_PerksActivities.RemoveTrackedPerksActivity(perksActivityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |

**Example**

```lua
C_PerksActivities.RemoveTrackedPerksActivity(0)
```

## Events

### PERKS_ACTIVITIES_TRACKED_LIST_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |
| `added` | bool | no |  |

### PERKS_ACTIVITIES_TRACKED_UPDATED

### PERKS_ACTIVITIES_UPDATED

### PERKS_ACTIVITY_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perksActivityID` | number | no |  |

## Types

### PerksActivitiesInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activePerksMonth` | number | no |  |
| `displayMonthName` | cstring | no |  |
| `secondsRemaining` | time_t | no |  |
| `activities` | PerksActivityInfo[] | no |  |
| `thresholds` | PerksActivityThresholdInfo[] | no |  |

### PerksActivitiesPending (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pendingIDs` | number[] | no |  |

### PerksActivitiesTracked (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedIDs` | number[] | no |  |

### PerksActivityCondition (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMet` | bool | no |  |
| `text` | cstring | no |  |
| `uiPriority` | number | no |  |

### PerksActivityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `activityName` | cstring | no |  |
| `description` | string | no |  |
| `thresholdContributionAmount` | number | no |  |
| `completed` | bool | no |  |
| `inProgress` | bool | no |  |
| `tracked` | bool | no |  |
| `supersedes` | number | no |  |
| `uiPriority` | number | no |  |
| `areAllConditionsMet` | bool | no |  |
| `conditions` | PerksActivityCondition[] | no |  |
| `eventName` | cstring | yes |  |
| `eventStartTime` | time_t | yes |  |
| `eventEndTime` | time_t | yes |  |
| `requirementsList` | CriteriaRequirement[] | no |  |
| `criteriaList` | CriteriaRequiredValue[] | no |  |
| `tagNames` | string[] | no |  |

### PerksActivityTags (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tagName` | string[] | no |  |

### PerksActivityThresholdInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `thresholdOrderIndex` | number | no |  |
| `currencyAwardAmount` | number | no |  |
| `requiredContributionAmount` | number | no |  |
| `pendingReward` | bool | no |  |
| `itemReward` | number | yes |  |

