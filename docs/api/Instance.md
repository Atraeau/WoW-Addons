# Instance

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**18** functions · **0** events · **3** types

## Functions

### Instance.CanChangePlayerDifficulty

```lua
canChange, notOnCooldown = CanChangePlayerDifficulty()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChange` | bool | no |  |
| `notOnCooldown` | bool | no |  |

**Example**

```lua
local canChange, notOnCooldown = CanChangePlayerDifficulty()
```

### Instance.CanMapChangeDifficulty

```lua
canChange = CanMapChangeDifficulty([mapID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChange` | bool | no |  |

**Example**

```lua
local canChange = CanMapChangeDifficulty()
```

### Instance.CanShowResetInstances

```lua
result = CanShowResetInstances()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CanShowResetInstances()
```

### Instance.GetBaseDifficultyID

```lua
baseDifficultyID = GetBaseDifficultyID(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseDifficultyID` | number | no |  |

**Example**

```lua
local baseDifficultyID = GetBaseDifficultyID(0)
```

### Instance.GetDifficultyInfo

```lua
name, instanceType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID, isLFR, minPlayers, maxPlayers, isUserSelectable = GetDifficultyInfo(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `instanceType` | cstring | no |  |
| `isHeroic` | bool | no |  |
| `isChallengeMode` | bool | no |  |
| `displayHeroic` | bool | no |  |
| `displayMythic` | bool | no |  |
| `toggleDifficultyID` | number | yes |  |
| `isLFR` | bool | no |  |
| `minPlayers` | number | yes |  |
| `maxPlayers` | number | yes |  |
| `isUserSelectable` | bool | no |  |

**Example**

```lua
local name, instanceType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID, isLFR, minPlayers, maxPlayers, isUserSelectable = GetDifficultyInfo(0)
```

### Instance.GetDungeonDifficultyID

```lua
result = GetDungeonDifficultyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetDungeonDifficultyID()
```

### Instance.GetInstanceBootTimeRemaining

```lua
result = GetInstanceBootTimeRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetInstanceBootTimeRemaining()
```

### Instance.GetInstanceInfo

```lua
name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, lfgDungeonID, hasWorldTier = GetInstanceInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `instanceType` | cstring | no |  |
| `difficultyID` | number | no |  |
| `difficultyName` | cstring | no |  |
| `maxPlayers` | number | no |  |
| `dynamicDifficulty` | number | no |  |
| `isDynamic` | bool | yes |  |
| `instanceID` | number | no |  |
| `instanceGroupSize` | number | no |  |
| `lfgDungeonID` | number | yes |  |
| `hasWorldTier` | bool | no | (default: False) |

**Example**

```lua
local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, lfgDungeonID, hasWorldTier = GetInstanceInfo()
```

### Instance.GetInstanceLockTimeRemaining

```lua
timeLeft, extending, encountersTotal, encountersCompleted = GetInstanceLockTimeRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeft` | number | no |  |
| `extending` | bool | no |  |
| `encountersTotal` | number | no |  |
| `encountersCompleted` | number | no |  |

**Example**

```lua
local timeLeft, extending, encountersTotal, encountersCompleted = GetInstanceLockTimeRemaining()
```

### Instance.GetInstanceLockTimeRemainingEncounter

```lua
encounterName, texture, isKilled, ineligible = GetInstanceLockTimeRemainingEncounter(encounterIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterName` | cstring | no |  |
| `texture` | cstring | no |  |
| `isKilled` | bool | no |  |
| `ineligible` | bool | no |  |

**Example**

```lua
local encounterName, texture, isKilled, ineligible = GetInstanceLockTimeRemainingEncounter(1)
```

### Instance.GetLegacyRaidDifficultyID

```lua
result = GetLegacyRaidDifficultyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetLegacyRaidDifficultyID()
```

### Instance.GetRaidDifficultyID

```lua
result = GetRaidDifficultyID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetRaidDifficultyID()
```

### Instance.IsInInstance

```lua
isInInstance, instanceType = IsInInstance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInInstance` | bool | no |  |
| `instanceType` | cstring | no |  |

**Example**

```lua
local isInInstance, instanceType = IsInInstance()
```

### Instance.IsLegacyDifficulty

```lua
result = IsLegacyDifficulty(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = IsLegacyDifficulty(0)
```

### Instance.ResetInstances

```lua
ResetInstances()
```

**Example**

```lua
ResetInstances()
```

### Instance.SetDungeonDifficultyID

```lua
SetDungeonDifficultyID(difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |

**Example**

```lua
SetDungeonDifficultyID(0)
```

### Instance.SetLegacyRaidDifficultyID

```lua
SetLegacyRaidDifficultyID(difficultyID, force)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |
| `force` | bool | no | (default: False) |

**Example**

```lua
SetLegacyRaidDifficultyID(0, false)
```

### Instance.SetRaidDifficultyID

```lua
SetRaidDifficultyID(difficultyID, force)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficultyID` | number | no |  |
| `force` | bool | no | (default: False) |

**Example**

```lua
SetRaidDifficultyID(0, false)
```

## Types

### DifficultyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `instanceType` | cstring | no |  |
| `isHeroic` | bool | no |  |
| `isChallengeMode` | bool | no |  |
| `displayHeroic` | bool | no |  |
| `displayMythic` | bool | no |  |
| `toggleDifficultyID` | number | yes |  |
| `isLFR` | bool | no |  |
| `minPlayers` | number | yes |  |
| `maxPlayers` | number | yes |  |
| `isUserSelectable` | bool | no |  |

### DungeonEncounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterName` | cstring | no |  |
| `texture` | cstring | no |  |
| `isKilled` | bool | no |  |
| `ineligible` | bool | no |  |

### InstanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `instanceType` | cstring | no |  |
| `difficultyID` | number | no |  |
| `difficultyName` | cstring | no |  |
| `maxPlayers` | number | no |  |
| `dynamicDifficulty` | number | no |  |
| `isDynamic` | bool | yes |  |
| `instanceID` | number | no |  |
| `instanceGroupSize` | number | no |  |
| `lfgDungeonID` | number | yes |  |
| `hasWorldTier` | bool | no | (default: False) |

