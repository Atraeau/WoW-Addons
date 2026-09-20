# LuaDurationObjectAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**31** functions · **0** events · **0** types

## Functions

### LuaDurationObjectAPI.Assign

Copies another duration object and assigns it to this one.

```lua
Assign(other)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `other` | LuaDurationObject | no |  |

**Example**

```lua
Assign(other)
```

### LuaDurationObjectAPI.Copy

Returns a copy of this duration object.

```lua
copy = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `copy` | LuaDurationObject | no |  |

**Example**

```lua
local copy = Copy()
```

### LuaDurationObjectAPI.EvaluateElapsedDuration

Calculates the elapsed duration in seconds and evaluates it against a supplied curve.

```lua
result = EvaluateElapsedDuration(curve, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example**

```lua
local result = EvaluateElapsedDuration(curve, modifier)
```

### LuaDurationObjectAPI.EvaluateElapsedPercent

Calculates the elapsed duration as a percentage value and evaluates it against a supplied curve.

```lua
result = EvaluateElapsedPercent(curve, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example**

```lua
local result = EvaluateElapsedPercent(curve, modifier)
```

### LuaDurationObjectAPI.EvaluateRemainingDuration

Calculates the remaining duration in seconds and evaluates it against a supplied curve.

```lua
result = EvaluateRemainingDuration(curve, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example**

```lua
local result = EvaluateRemainingDuration(curve, modifier)
```

### LuaDurationObjectAPI.EvaluateRemainingPercent

Calculates the remaining duration as a percentage value and evaluates it against a supplied curve.

```lua
result = EvaluateRemainingPercent(curve, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example**

```lua
local result = EvaluateRemainingPercent(curve, modifier)
```

### LuaDurationObjectAPI.EvaluateTotalDuration

Calculates the total duration in seconds and evaluates it against a supplied curve.

```lua
result = EvaluateTotalDuration(curve, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example**

```lua
local result = EvaluateTotalDuration(curve, modifier)
```

### LuaDurationObjectAPI.FormatElapsedDuration

Formats the elapsed duration of this object to a string.

```lua
formatted = FormatElapsedDuration(formatter, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatted` | string | no |  |

**Example**

```lua
local formatted = FormatElapsedDuration(formatter, modifier)
```

### LuaDurationObjectAPI.FormatRemainingDuration

Formats the remaining duration of this object to a string.

```lua
formatted = FormatRemainingDuration(formatter, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatted` | string | no |  |

**Example**

```lua
local formatted = FormatRemainingDuration(formatter, modifier)
```

### LuaDurationObjectAPI.FormatTotalDuration

Formats the total duration of this object to a string.

```lua
formatted = FormatTotalDuration(formatter, modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | no |  |
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatted` | string | no |  |

**Example**

```lua
local formatted = FormatTotalDuration(formatter, modifier)
```

### LuaDurationObjectAPI.GetClock

Returns the clock source used by this object.

```lua
clock = GetClock()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clock` | LuaDurationClock | yes | If nil, the duration object is using an internal default clock source equivalent to GetTime(). |

**Example**

```lua
local clock = GetClock()
```

### LuaDurationObjectAPI.GetClockTime

Returns the current time of the clock source used by this object.

```lua
clockTime = GetClockTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clockTime` | FrameTime | no |  |

**Example**

```lua
local clockTime = GetClockTime()
```

### LuaDurationObjectAPI.GetElapsedDuration

Calculates the elapsed duration of the stored time span.

```lua
elapsedDuration = GetElapsedDuration(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elapsedDuration` | Seconds | no |  |

**Example**

```lua
local elapsedDuration = GetElapsedDuration(modifier)
```

### LuaDurationObjectAPI.GetElapsedPercent

Calculates the elapsed duration as a percentage value.

```lua
elapsedPercent = GetElapsedPercent(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elapsedPercent` | number | no |  |

**Example**

```lua
local elapsedPercent = GetElapsedPercent(modifier)
```

### LuaDurationObjectAPI.GetEndTime

Calculates the end time of the stored time span.

```lua
endTime = GetEndTime(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `endTime` | FrameTime | no |  |

**Example**

```lua
local endTime = GetEndTime(modifier)
```

### LuaDurationObjectAPI.GetModRate

Returns the divisor used to convert a duration from real time to base time.

```lua
modRate = GetModRate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modRate` | number | no |  |

**Example**

```lua
local modRate = GetModRate()
```

### LuaDurationObjectAPI.GetRemainingDuration

Calculates the remaining duration of the stored time span.

```lua
remainingDuration = GetRemainingDuration(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `remainingDuration` | Seconds | no |  |

**Example**

```lua
local remainingDuration = GetRemainingDuration(modifier)
```

### LuaDurationObjectAPI.GetRemainingPercent

Calculates the remaining duration as a percentage value.

```lua
remainingPercent = GetRemainingPercent(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `remainingPercent` | number | no |  |

**Example**

```lua
local remainingPercent = GetRemainingPercent(modifier)
```

### LuaDurationObjectAPI.GetStartTime

Calculates the start time of the stored time span.

```lua
startTime = GetStartTime(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | FrameTime | no |  |

**Example**

```lua
local startTime = GetStartTime(modifier)
```

### LuaDurationObjectAPI.GetTotalDuration

Calculates the total duration of the stored time span.

```lua
totalDuration = GetTotalDuration(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalDuration` | Seconds | no |  |

**Example**

```lua
local totalDuration = GetTotalDuration(modifier)
```

### LuaDurationObjectAPI.HasExpired

Returns true once the duration has reached its end time.

```lua
hasExpired = HasExpired(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasExpired` | bool | no |  |

**Example**

```lua
local hasExpired = HasExpired(modifier)
```

### LuaDurationObjectAPI.HasSecretValues

Returns true if the duration has been configured with any secret values.

```lua
hasSecretValues = HasSecretValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretValues` | bool | no |  |

**Example**

```lua
local hasSecretValues = HasSecretValues()
```

### LuaDurationObjectAPI.HasStarted

Returns true once the duration has reached its start time.

```lua
hasStarted = HasStarted(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasStarted` | bool | no |  |

**Example**

```lua
local hasStarted = HasStarted(modifier)
```

### LuaDurationObjectAPI.IsActive

Returns true while the duration is at or after its start time and before its end time.

```lua
isActive = IsActive(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no | (default: RealTime) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example**

```lua
local isActive = IsActive(modifier)
```

### LuaDurationObjectAPI.IsZero

Returns true if the duration object is measuring a zero duration time span.

```lua
isZero = IsZero()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isZero` | bool | no |  |

**Example**

```lua
local isZero = IsZero()
```

### LuaDurationObjectAPI.Reset

Resets the duration object to represent a zero duration time span.

```lua
Reset()
```

**Example**

```lua
Reset()
```

### LuaDurationObjectAPI.SetClock

Configures the clock source used by this object.

```lua
SetClock([clock])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clock` | LuaDurationClock | yes | If nil, the duration object will use an internal default clock source equivalent to GetTime(). |

**Example**

```lua
SetClock()
```

### LuaDurationObjectAPI.SetTimeFromEnd

Configures the duration object to represent an end time and a duration.

```lua
SetTimeFromEnd(endTime, duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `endTime` | FrameTime | no |  |
| `duration` | Seconds | no |  |
| `modRate` | number | no | Optional divisor for converting this time span to a base time. (default: 1) |

**Example**

```lua
SetTimeFromEnd(endTime, duration, 0)
```

### LuaDurationObjectAPI.SetTimeFromStart

Configures the duration object to represent a start time and a duration.

```lua
SetTimeFromStart(startTime, duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | FrameTime | no |  |
| `duration` | Seconds | no |  |
| `modRate` | number | no | Optional divisor for converting this time span to a base time. (default: 1) |

**Example**

```lua
SetTimeFromStart(startTime, duration, 0)
```

### LuaDurationObjectAPI.SetTimeSpan

Configures the duration object to represent a fixed start and end time span. If the end time is earlier than the start time, the duration will clamp to zero.

```lua
SetTimeSpan(startTime, endTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | FrameTime | no |  |
| `endTime` | FrameTime | no |  |

**Example**

```lua
SetTimeSpan(startTime, endTime)
```

### LuaDurationObjectAPI.SetToDefaults

Resets all state on the duration, and clears the secret values flag.

```lua
SetToDefaults()
```

**Example**

```lua
SetToDefaults()
```

