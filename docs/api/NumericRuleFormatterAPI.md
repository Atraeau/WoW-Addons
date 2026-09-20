# NumericRuleFormatterAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

```lua
AddBreakpoint(breakpoint)
```

### NumericRuleFormatterAPI.ClearBreakpoints

Removes all configured breakpoints from the formatter.

```lua
ClearBreakpoints()
```

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
SetBreakpoints(breakpoints)
```

