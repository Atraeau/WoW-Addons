# C_AddOnProfiler

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **0** events · **4** types

## Functions

### C_AddOnProfiler.AddMeasuredCallEvent

Adds a measured event to any ongoing measured calls. If no such calls are currently taking place, this function does nothing.

```lua
C_AddOnProfiler.AddMeasuredCallEvent(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | stringView | no | User-defined string describing the measured event. This should be kept under 48 bytes to avoid memory allocations. |

**Example**

```lua
C_AddOnProfiler.AddMeasuredCallEvent(name)
```

### C_AddOnProfiler.AddPerformanceMessageShown

Internal API for telemetry.

```lua
C_AddOnProfiler.AddPerformanceMessageShown(msg)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `msg` | AddOnPerformanceMessage | no |  |

**Example**

```lua
C_AddOnProfiler.AddPerformanceMessageShown(msg)
```

### C_AddOnProfiler.CheckForPerformanceMessage

Optimized check for determining if AddOns are severely impacting UI performance.

```lua
msg = C_AddOnProfiler.CheckForPerformanceMessage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `msg` | AddOnPerformanceMessage | no |  |

**Example**

```lua
local msg = C_AddOnProfiler.CheckForPerformanceMessage()
```

### C_AddOnProfiler.GetAddOnMetric

Gets an AddOn profiler value - all times returned are in milliseconds.

```lua
result = C_AddOnProfiler.GetAddOnMetric(name, metric)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `metric` | AddOnProfilerMetric | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = C_AddOnProfiler.GetAddOnMetric("", metric)
```

### C_AddOnProfiler.GetApplicationMetric

Overall profiling data for the entire application (not just the UI)

```lua
result = C_AddOnProfiler.GetApplicationMetric(metric)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `metric` | AddOnProfilerMetric | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = C_AddOnProfiler.GetApplicationMetric(metric)
```

### C_AddOnProfiler.GetOverallMetric

Overall profiling data for all addons

```lua
result = C_AddOnProfiler.GetOverallMetric(metric)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `metric` | AddOnProfilerMetric | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = C_AddOnProfiler.GetOverallMetric(metric)
```

### C_AddOnProfiler.GetTicksPerSecond

Returns the number of profiling clock ticks that occur within a single real-time second.

```lua
frequency = C_AddOnProfiler.GetTicksPerSecond()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frequency` | BigInteger | no |  |

**Example**

```lua
local frequency = C_AddOnProfiler.GetTicksPerSecond()
```

### C_AddOnProfiler.GetTopKAddOnsForMetric

Gets top K AddOns for a given metric.

```lua
results = C_AddOnProfiler.GetTopKAddOnsForMetric(metric, k)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `metric` | AddOnProfilerMetric | no |  |
| `k` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `results` | AddOnProfilerResult[] | no |  |

**Example**

```lua
local results = C_AddOnProfiler.GetTopKAddOnsForMetric(metric, 0)
```

### C_AddOnProfiler.IsEnabled

AddOn profiler will be enabled for all users, but this will return false if it ever isn't

```lua
enabled = C_AddOnProfiler.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_AddOnProfiler.IsEnabled()
```

### C_AddOnProfiler.MeasureCall

Performs a profiled measurement of a single function call with any supplied arguments.

```lua
results, returns = C_AddOnProfiler.MeasureCall(func, arguments)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `func` | LuaValueVariant | no |  |
| `arguments` | LuaValueVariant | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `results` | AddOnProfilerCallResults | no |  |
| `returns` | LuaValueVariant | no |  |

**Example**

```lua
local results, returns = C_AddOnProfiler.MeasureCall(func, arguments)
```

## Types

### AddOnPerformanceMessage (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | AddOnPerformanceMessageType | no |  |
| `metric` | AddOnProfilerMetric | no |  |
| `addOnName` | string | yes |  |
| `metricValue` | number | no |  |
| `thresholdValue` | number | no |  |

### AddOnProfilerCallEvent (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no | User-defined string describing the measured event. |
| `allocatedBytes` | BigUInteger | no | Snapshot of the allocated byte count when this event was recorded. |
| `deallocatedBytes` | BigUInteger | no | Snapshot of the deallocated byte count when this event was recorded. |
| `elapsedMilliseconds` | number | no | Snapshot of the elapsed milliseconds when this event was recorded. |
| `elapsedTicks` | BigInteger | no | Snapshot of the elapsed tick count when this event was recorded. |

### AddOnProfilerCallResults (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elapsedMilliseconds` | number | no | Total number of milliseconds spent executing the function. |
| `elapsedTicks` | BigInteger | no | Total number of profiling clock ticks spent executing the function. |
| `allocatedBytes` | BigUInteger | no | Total number of bytes allocated during call execution. |
| `deallocatedBytes` | BigUInteger | no | Total number of bytes deallocated during call execution. |
| `events` | AddOnProfilerCallEvent[] | no | Events recorded by any AddMeasuredCallEvent calls that took place during function execution. |

### AddOnProfilerResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `addOnName` | cstring | no |  |
| `metricValue` | number | no |  |

