# LuaDurationClockObjectAPI

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 70790, interface 16001) on 2026-11-05 13:35:56.

**1** functions · **0** events · **0** types

## Functions

### LuaDurationClockObjectAPI.GetTime

Returns the current time value represented by this clock.

```lua
time = GetTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | FrameTime | no |  |

**Example**

```lua
-- High-precision seconds since client start; use for timers/throttling, not wall-clock.
local start = GetTime()
-- ... later ...
print(("elapsed: %.3fs"):format(GetTime() - start))
```
