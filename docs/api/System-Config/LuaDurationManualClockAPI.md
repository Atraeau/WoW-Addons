# LuaDurationManualClockAPI

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **0** events · **0** types

## Functions

### LuaDurationManualClockAPI.AdvanceTime

Advances the clock by a specified number of seconds.

```lua
AdvanceTime(delta)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delta` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AdvanceTime(delta)
```

### LuaDurationManualClockAPI.ResetTime

Resets the clock to a zero time value.

```lua
ResetTime()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetTime()
```

### LuaDurationManualClockAPI.RewindTime

Rewinds the clock by a specified number of seconds.

```lua
RewindTime(delta)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delta` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RewindTime(delta)
```

### LuaDurationManualClockAPI.SetTime

Sets the current clock timestamp to a given value.

```lua
SetTime(time)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | FrameTime | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTime(time)
```

