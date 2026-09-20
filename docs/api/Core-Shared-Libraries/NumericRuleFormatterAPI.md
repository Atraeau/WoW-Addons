# NumericRuleFormatterAPI

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **0** events · **0** types

## Functions

### NumericRuleFormatterAPI.AddBreakpoint

Adds a new breakpoint to the formatter.

```lua
AddBreakpoint(breakpoint)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoint` | NumericRuleFormatBreakpoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddBreakpoint(breakpoint)
```

### NumericRuleFormatterAPI.ClearBreakpoints

Removes all configured breakpoints from the formatter.

```lua
ClearBreakpoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearBreakpoints()
```

### NumericRuleFormatterAPI.Copy

Returns a new copy of this formatter.

```lua
copy = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `copy` | NumericRuleFormatter | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local copy = Copy()
```

### NumericRuleFormatterAPI.GetBreakpoints

Returns a list of all configured breakpoints on this formatter.

```lua
breakpoints = GetBreakpoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoints` | NumericRuleFormatBreakpoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local breakpoints = GetBreakpoints()
```

### NumericRuleFormatterAPI.SetBreakpoints

Replaces all breakpoints on the formatter.

```lua
SetBreakpoints(breakpoints)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoints` | NumericRuleFormatBreakpoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBreakpoints(breakpoints)
```

