# C_AchievementInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **11** events · **0** types

## Functions

### C_AchievementInfo.AreGuildAchievementsEnabled

```lua
enabled = C_AchievementInfo.AreGuildAchievementsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_AchievementInfo.AreGuildAchievementsEnabled()
```

### C_AchievementInfo.GetRewardItemID

```lua
rewardItemID = C_AchievementInfo.GetRewardItemID(achievementID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardItemID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewardItemID = C_AchievementInfo.GetRewardItemID(0)
```

### C_AchievementInfo.GetSupercedingAchievements

```lua
supercedingAchievements = C_AchievementInfo.GetSupercedingAchievements(achievementID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `supercedingAchievements` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local supercedingAchievements = C_AchievementInfo.GetSupercedingAchievements(0)
```

### C_AchievementInfo.IsGuildAchievement

```lua
isGuild = C_AchievementInfo.IsGuildAchievement(achievementId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isGuild = C_AchievementInfo.IsGuildAchievement(0)
```

### C_AchievementInfo.IsValidAchievement

```lua
isValidAchievement = C_AchievementInfo.IsValidAchievement(achievementId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidAchievement` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValidAchievement = C_AchievementInfo.IsValidAchievement(0)
```

### C_AchievementInfo.SetPortraitTexture

```lua
C_AchievementInfo.SetPortraitTexture(textureObject)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_AchievementInfo.SetPortraitTexture(textureObject)
```

## Events

### ACHIEVEMENT_EARNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |
| `alreadyEarned` | bool | yes |  |

### ACHIEVEMENT_PLAYER_NAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

### ACHIEVEMENT_SEARCH_UPDATED

### CRITERIA_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criteriaID` | number | no |  |

### CRITERIA_EARNED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |
| `description` | cstring | no |  |
| `achievementAlreadyEarnedOnAccount` | bool | no |  |

### CRITERIA_UPDATE

### INSPECT_ACHIEVEMENT_READY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

### RECEIVED_ACHIEVEMENT_LIST

### RECEIVED_ACHIEVEMENT_MEMBER_LIST

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

### TRACKED_ACHIEVEMENT_LIST_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | yes |  |
| `added` | bool | yes |  |

### TRACKED_ACHIEVEMENT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |
| `criteriaID` | number | yes |  |
| `elapsed` | time_t | yes |  |
| `duration` | number | yes |  |

