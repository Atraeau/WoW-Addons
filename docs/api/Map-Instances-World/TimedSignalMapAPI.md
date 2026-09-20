# TimedSignalMapAPI

[← API index](../README.md) · group: [Map, Instances & World](README.md)

An object that manages a collection of integer keys, each scheduled to signal at a specific time. When a key's time arrives it is removed from the map and passed to the map's callback, letting you track many keyed deadlines through a single callback rather than scheduling each one individually.

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**8** functions · **0** events · **0** types

## Functions

### TimedSignalMapAPI.CancelAllSignals

Cancels all scheduled signals.

```lua
CancelAllSignals()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
CancelAllSignals()
```

### TimedSignalMapAPI.CancelSignal

Cancels the scheduled signal for the specified key, if one exists.

```lua
CancelSignal(key)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | Key to cancel. No effect if the key is not scheduled. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
CancelSignal(0)
```

### TimedSignalMapAPI.GetNextSignal

Returns the next key due to signal along with its scheduled time.

```lua
key, time = GetNextSignal()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | The key that has been scheduled. |
| `time` | FrameTime | no | Absolute time, on the same clock as GetTime(), at which the key is scheduled to signal. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local key, time = GetNextSignal()
```

### TimedSignalMapAPI.GetSignalCount

Returns the number of keys currently scheduled to signal.

```lua
count = GetSignalCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | size | no | Count of scheduled keys. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = GetSignalCount()
```

### TimedSignalMapAPI.GetSignalTime

Returns the absolute time at which the specified key is scheduled to signal.

```lua
time = GetSignalTime(key)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | Key to query. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | FrameTime | yes | Absolute time the key will signal; nil if not scheduled. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = GetSignalTime(0)
```

### TimedSignalMapAPI.HasSignal

Returns whether the specified key is currently scheduled to signal.

```lua
hasSignal = HasSignal(key)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | Key to test. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSignal` | bool | no | True if the key is scheduled to signal. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSignal = HasSignal(0)
```

### TimedSignalMapAPI.SignalAfter

Schedules the specified key to signal after a delay from the current time, replacing any existing schedule for that key.

```lua
SignalAfter(key, secondsFromNow)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | Key to signal. Re-scheduling an existing key replaces its time. |
| `secondsFromNow` | Seconds | no | Delay in seconds from now, converted to an absolute time when scheduled. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SignalAfter(0, secondsFromNow)
```

### TimedSignalMapAPI.SignalAt

Schedules the specified key to signal at an absolute time, replacing any existing schedule for that key.

```lua
SignalAt(key, time)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | number | no | Key to signal. Re-scheduling an existing key replaces its time. |
| `time` | FrameTime | no | Absolute time at which to signal, on the same clock as GetTime(). |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SignalAt(0, time)
```

