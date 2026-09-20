# PerformanceScript

[← API index](../README.md) · group: [AddOns & Scripting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetScriptCPUUsage()
```

### PerformanceScript.ResetCPUUsage

```lua
ResetCPUUsage()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetCPUUsage()
```

### PerformanceScript.UpdateAddOnCPUUsage

```lua
UpdateAddOnCPUUsage()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UpdateAddOnCPUUsage()
```

### PerformanceScript.UpdateAddOnMemoryUsage

```lua
UpdateAddOnMemoryUsage()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UpdateAddOnMemoryUsage()
```

