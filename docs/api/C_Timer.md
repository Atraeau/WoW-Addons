# C_Timer

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **2** types

## Functions

### C_Timer.After

```lua
C_Timer.After(seconds, callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | number | no |  |
| `callback` | TimerCallback | no |  |

**Example**

```lua
-- Run a function once after a delay (in seconds)
C_Timer.After(2, function()
    print("2 seconds later")
end)
```

### C_Timer.NewTicker

```lua
cbObject = C_Timer.NewTicker(seconds, callback, [iterations])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | number | no |  |
| `callback` | TickerCallback | no |  |
| `iterations` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cbObject` | TickerCallback | no |  |

**Example**

```lua
-- Repeat every 5s; pass a 3rd arg to limit iterations (omit for infinite)
local ticker = C_Timer.NewTicker(5, function()
    print("tick")
end, 3)
-- ticker:Cancel()  -- stop early
```

### C_Timer.NewTimedSignalMap

Creates a new timed signal map that invokes the supplied callback with each key as it becomes due.

```lua
signalMap = C_Timer.NewTimedSignalMap(callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `callback` | TimedSignalMapCallback | no | Callback to execute when each entry becomes due. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `signalMap` | TimedSignalMap | no | The newly created timed signal map. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local signalMap = C_Timer.NewTimedSignalMap(callback)
```

### C_Timer.NewTimer

```lua
cbObject = C_Timer.NewTimer(seconds, callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | number | no |  |
| `callback` | TickerCallback | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cbObject` | TickerCallback | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cbObject = C_Timer.NewTimer(0, callback)
```

## Types

### TickerCallback (CallbackType)

### TimerCallback (CallbackType)

