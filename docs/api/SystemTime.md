# SystemTime

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **0** events · **0** types

## Functions

### SystemTime.GetGameTime

```lua
hour, minute = GetGameTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hour` | number | no |  |
| `minute` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hour, minute = GetGameTime()
```

### SystemTime.GetLocalGameTime

```lua
hour, minute = GetLocalGameTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hour` | number | no |  |
| `minute` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hour, minute = GetLocalGameTime()
```

### SystemTime.GetServerTime

```lua
time = GetServerTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = GetServerTime()
```

### SystemTime.GetSessionTime

```lua
time = GetSessionTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = GetSessionTime()
```

### SystemTime.GetTickTime

```lua
time = GetTickTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = GetTickTime()
```

### SystemTime.GetTime

```lua
time = GetTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example**

```lua
-- High-precision seconds since client start; use for timers/throttling, not wall-clock.
local start = GetTime()
-- ... later ...
print(("elapsed: %.3fs"):format(GetTime() - start))
```

### SystemTime.IsUsingFixedTimeStep

```lua
isUsingFixedTimeStep = IsUsingFixedTimeStep()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingFixedTimeStep` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUsingFixedTimeStep = IsUsingFixedTimeStep()
```

