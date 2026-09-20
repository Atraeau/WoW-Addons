# C_LimitedInput

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **0** events · **1** types

## Functions

### C_LimitedInput.LimitedInputAllowed

```lua
allowed = C_LimitedInput.LimitedInputAllowed(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | LimitedInputType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example**

```lua
local allowed = C_LimitedInput.LimitedInputAllowed(type)
```

## Types

### LimitedInputType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `MouseMove` | LimitedInputType | no |  |
| `MouseDown` | LimitedInputType | no |  |
| `MouseUp` | LimitedInputType | no |  |
| `MouseWheel` | LimitedInputType | no |  |

