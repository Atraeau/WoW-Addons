# C_PlayerMentorship

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **2** events · **0** types

## Functions

### C_PlayerMentorship.GetMentorLevelRequirement

```lua
level = C_PlayerMentorship.GetMentorLevelRequirement()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local level = C_PlayerMentorship.GetMentorLevelRequirement()
```

### C_PlayerMentorship.GetMentorRequirements

```lua
achievementIDs, optionalAchievementIDs, optionalCompleteAtLeastCount = C_PlayerMentorship.GetMentorRequirements()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementIDs` | number[] | no |  |
| `optionalAchievementIDs` | number[] | no |  |
| `optionalCompleteAtLeastCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local achievementIDs, optionalAchievementIDs, optionalCompleteAtLeastCount = C_PlayerMentorship.GetMentorRequirements()
```

### C_PlayerMentorship.GetMentorshipStatus

```lua
status = C_PlayerMentorship.GetMentorshipStatus(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | PlayerMentorshipStatus | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_PlayerMentorship.GetMentorshipStatus(playerLocation)
```

### C_PlayerMentorship.IsActivePlayerConsideredNewcomer

```lua
isConsideredNewcomer = C_PlayerMentorship.IsActivePlayerConsideredNewcomer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConsideredNewcomer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isConsideredNewcomer = C_PlayerMentorship.IsActivePlayerConsideredNewcomer()
```

### C_PlayerMentorship.IsMentorRestricted

```lua
isRestricted = C_PlayerMentorship.IsMentorRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRestricted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRestricted = C_PlayerMentorship.IsMentorRestricted()
```

## Events

### MENTORSHIP_STATUS_CHANGED

### NEWCOMER_GRADUATION

