# AbbreviatedNumberFormatterAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **0** events · **0** types

## Functions

### AbbreviatedNumberFormatterAPI.AddBreakpoint

Adds a new breakpoint to the formatter.

```lua
AddBreakpoint(breakpoint)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoint` | NumberAbbreviationBreakpoint | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddBreakpoint(breakpoint)
```

### AbbreviatedNumberFormatterAPI.ClearBreakpoints

Removes all configured breakpoints from the formatter.

```lua
ClearBreakpoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearBreakpoints()
```

### AbbreviatedNumberFormatterAPI.Copy

Returns a new copy of this formatter.

```lua
copy = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `copy` | AbbreviatedNumberFormatter | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local copy = Copy()
```

### AbbreviatedNumberFormatterAPI.GetBreakpoints

Returns a list of all configured breakpoints on this formatter.

```lua
breakpoints = GetBreakpoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoints` | NumberAbbreviationBreakpoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local breakpoints = GetBreakpoints()
```

### AbbreviatedNumberFormatterAPI.ResetBreakpoints

Removes all configured breakpoints from the formatter and replaces them with appropriate defaults for the client locale.

```lua
ResetBreakpoints()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetBreakpoints()
```

### AbbreviatedNumberFormatterAPI.SetBreakpoints

Replaces all breakpoints on the formatter.

```lua
SetBreakpoints(breakpoints)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoints` | NumberAbbreviationBreakpoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBreakpoints(breakpoints)
```

