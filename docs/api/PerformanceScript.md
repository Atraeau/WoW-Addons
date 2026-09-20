# PerformanceScript

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **0** events · **0** types

## Functions

### PerformanceScript.GetAddOnCPUUsage

```lua
result = GetAddOnCPUUsage(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetAddOnCPUUsage(name)
```

### PerformanceScript.GetAddOnMemoryUsage

```lua
result = GetAddOnMemoryUsage(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetAddOnMemoryUsage(name)
```

### PerformanceScript.GetEventCPUUsage

```lua
call_time, call_count = GetEventCPUUsage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `call_time` | number | no |  |
| `call_count` | number | no |  |

**Example**

```lua
local call_time, call_count = GetEventCPUUsage()
```

### PerformanceScript.GetFrameCPUUsage

```lua
call_time, call_count = GetFrameCPUUsage(frame, includeChildren)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frame` | SimpleFrame | no |  |
| `includeChildren` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `call_time` | number | no |  |
| `call_count` | number | no |  |

**Example**

```lua
local call_time, call_count = GetFrameCPUUsage(frame, false)
```

### PerformanceScript.GetFunctionCPUUsage

```lua
call_time, call_count = GetFunctionCPUUsage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `call_time` | number | no |  |
| `call_count` | number | no |  |

**Example**

```lua
local call_time, call_count = GetFunctionCPUUsage()
```

### PerformanceScript.GetScriptCPUUsage

```lua
result = GetScriptCPUUsage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetScriptCPUUsage()
```

### PerformanceScript.ResetCPUUsage

```lua
ResetCPUUsage()
```

**Example**

```lua
ResetCPUUsage()
```

### PerformanceScript.UpdateAddOnCPUUsage

```lua
UpdateAddOnCPUUsage()
```

**Example**

```lua
UpdateAddOnCPUUsage()
```

### PerformanceScript.UpdateAddOnMemoryUsage

```lua
UpdateAddOnMemoryUsage()
```

**Example**

```lua
UpdateAddOnMemoryUsage()
```

