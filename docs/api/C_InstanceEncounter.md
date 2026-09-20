# C_InstanceEncounter

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **6** events · **0** types

## Functions

### C_InstanceEncounter.IsEncounterInProgress

```lua
isInProgress = C_InstanceEncounter.IsEncounterInProgress()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInProgress` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInProgress = C_InstanceEncounter.IsEncounterInProgress()
```

### C_InstanceEncounter.IsEncounterLimitingResurrections

```lua
isLimitingResurrections = C_InstanceEncounter.IsEncounterLimitingResurrections()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLimitingResurrections` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLimitingResurrections = C_InstanceEncounter.IsEncounterLimitingResurrections()
```

### C_InstanceEncounter.IsEncounterSuppressingRelease

```lua
isSuppressingRelease = C_InstanceEncounter.IsEncounterSuppressingRelease()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSuppressingRelease` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSuppressingRelease = C_InstanceEncounter.IsEncounterSuppressingRelease()
```

### C_InstanceEncounter.ShouldShowTimelineForEncounter

```lua
shouldShow = C_InstanceEncounter.ShouldShowTimelineForEncounter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldShow` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldShow = C_InstanceEncounter.ShouldShowTimelineForEncounter()
```

## Events

### ENCOUNTER_STATE_CHANGED

Signaled when the in-progress state of an encounter changes.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInProgress` | bool | no |  |

### INSTANCE_ENCOUNTER_ADD_TIMER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeRemaining` | number | no |  |

### INSTANCE_ENCOUNTER_ENGAGE_UNIT

### INSTANCE_ENCOUNTER_OBJECTIVE_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectiveID` | number | no |  |

### INSTANCE_ENCOUNTER_OBJECTIVE_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectiveID` | number | no |  |
| `objectiveProgress` | number | no |  |

### INSTANCE_ENCOUNTER_OBJECTIVE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectiveID` | number | no |  |
| `objectiveProgress` | number | no |  |

