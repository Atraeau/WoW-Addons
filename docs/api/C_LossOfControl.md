# C_LossOfControl

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **6** events · **1** types

## Functions

### C_LossOfControl.GetActiveLossOfControlData

```lua
event = C_LossOfControl.GetActiveLossOfControlData(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `event` | LossOfControlData | yes |  |

**Example**

```lua
local event = C_LossOfControl.GetActiveLossOfControlData(1)
```

### C_LossOfControl.GetActiveLossOfControlDataByUnit

```lua
event = C_LossOfControl.GetActiveLossOfControlDataByUnit(unitToken, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `event` | LossOfControlData | yes |  |

**Example**

```lua
local event = C_LossOfControl.GetActiveLossOfControlDataByUnit("player", 1)
```

### C_LossOfControl.GetActiveLossOfControlDataCount

```lua
count = C_LossOfControl.GetActiveLossOfControlDataCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example**

```lua
local count = C_LossOfControl.GetActiveLossOfControlDataCount()
```

### C_LossOfControl.GetActiveLossOfControlDataCountByUnit

```lua
count = C_LossOfControl.GetActiveLossOfControlDataCountByUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example**

```lua
local count = C_LossOfControl.GetActiveLossOfControlDataCountByUnit("player")
```

### C_LossOfControl.GetActiveLossOfControlDuration

```lua
duration = C_LossOfControl.GetActiveLossOfControlDuration(unitToken, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | yes |  |

**Example**

```lua
local duration = C_LossOfControl.GetActiveLossOfControlDuration("player", 1)
```

## Events

### LOSS_OF_CONTROL_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `effectIndex` | luaIndex | no |  |

### LOSS_OF_CONTROL_COMMENTATOR_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `victim` | WOWGUID | no |  |
| `effectIndex` | luaIndex | no |  |

### LOSS_OF_CONTROL_COMMENTATOR_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `victim` | WOWGUID | no |  |

### LOSS_OF_CONTROL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_CONTROL_GAINED

### PLAYER_CONTROL_LOST

## Types

### LossOfControlData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locType` | cstring | no |  |
| `spellID` | number | no |  |
| `displayText` | cstring | no |  |
| `iconTexture` | number | no |  |
| `startTime` | number | yes |  |
| `timeRemaining` | number | yes |  |
| `duration` | number | yes |  |
| `lockoutSchool` | number | no |  |
| `priority` | number | no |  |
| `displayType` | number | no |  |
| `auraInstanceID` | number | yes |  |

