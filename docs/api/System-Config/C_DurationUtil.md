# C_DurationUtil

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**3** functions · **0** events · **0** types

## Functions

### C_DurationUtil.CreateDuration

Creates a zero duration container that can represent a time span.

```lua
duration = C_DurationUtil.CreateDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_DurationUtil.CreateDuration()
```

### C_DurationUtil.CreateDurationTextBinding

Creates a duration text binding, which automatically updates a font string with formatted text derived from a duration object.

```lua
binding = C_DurationUtil.CreateDurationTextBinding()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `binding` | DurationTextBinding | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local binding = C_DurationUtil.CreateDurationTextBinding()
```

### C_DurationUtil.CreateManualClock

Creates a manually driven time source for use with duration objects.

```lua
clock = C_DurationUtil.CreateManualClock()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clock` | LuaDurationManualClock | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clock = C_DurationUtil.CreateManualClock()
```

