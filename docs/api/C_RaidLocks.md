# C_RaidLocks

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **0** types

## Functions

### C_RaidLocks.GetRedirectedDifficultyID

```lua
redirectedDifficultyID = C_RaidLocks.GetRedirectedDifficultyID(mapID, difficultyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `difficultyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `redirectedDifficultyID` | number | no |  |

**Example**

```lua
local redirectedDifficultyID = C_RaidLocks.GetRedirectedDifficultyID(0, 0)
```

### C_RaidLocks.IsEncounterComplete

```lua
encounterIsComplete = C_RaidLocks.IsEncounterComplete(mapID, encounterID, [difficultyID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `encounterID` | number | no |  |
| `difficultyID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounterIsComplete` | bool | no |  |

**Example**

```lua
local encounterIsComplete = C_RaidLocks.IsEncounterComplete(0, 0)
```

### C_RaidLocks.IsRaidLockExtendFeatureEnabled

```lua
raidLockExtendFeatureEnabled = C_RaidLocks.IsRaidLockExtendFeatureEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raidLockExtendFeatureEnabled` | bool | no |  |

**Example**

```lua
local raidLockExtendFeatureEnabled = C_RaidLocks.IsRaidLockExtendFeatureEnabled()
```

### C_RaidLocks.IsRaidLockExtendFeatureSupported

```lua
raidLockExtendFeatureSupported = C_RaidLocks.IsRaidLockExtendFeatureSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raidLockExtendFeatureSupported` | bool | no |  |

**Example**

```lua
local raidLockExtendFeatureSupported = C_RaidLocks.IsRaidLockExtendFeatureSupported()
```

