# SecondsFormatterAPI

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**35** functions · **0** events · **0** types

## Functions

### SecondsFormatterAPI.CanApproximate

Returns true if the given number of seconds is within an appropriate range for approximated formatting.

```lua
canApproximate = CanApproximate(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canApproximate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canApproximate = CanApproximate(seconds)
```

### SecondsFormatterAPI.CanRoundUpIntervals

Returns true if the formatter can promote values to higher interval bands.

```lua
canRound = CanRoundUpIntervals()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRound` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canRound = CanRoundUpIntervals()
```

### SecondsFormatterAPI.CanRoundUpLastUnit

Returns true if the formatter should round the final unit up rather than down.

```lua
canRound = CanRoundUpLastUnit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRound` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canRound = CanRoundUpLastUnit()
```

### SecondsFormatterAPI.EvaluateDesiredUnitCount

Returns the unit count that a given number of seconds will use for formatting.

```lua
count = EvaluateDesiredUnitCount(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = EvaluateDesiredUnitCount(seconds)
```

### SecondsFormatterAPI.EvaluateMaxInterval

Returns the maximum interval band that a given number of seconds will use for formatting.

```lua
interval = EvaluateMaxInterval(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interval = EvaluateMaxInterval(seconds)
```

### SecondsFormatterAPI.EvaluateMinInterval

Returns the minimum interval band that a given number of seconds will use for formatting.

```lua
interval = EvaluateMinInterval(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interval = EvaluateMinInterval(seconds)
```

### SecondsFormatterAPI.Format

Formats a number of seconds and returns the resulting string.

```lua
formattedSeconds = Format(seconds, [abbreviation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |
| `abbreviation` | SecondsFormatterAbbreviation | yes | Optional abbreviation mode to use in-place of the default. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formattedSeconds` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local formattedSeconds = Format(seconds)
```

### SecondsFormatterAPI.FormatZero

Returns formatted string representing a zero second duration.

```lua
formattedSeconds = FormatZero([abbreviation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `abbreviation` | SecondsFormatterAbbreviation | yes | Optional abbreviation mode to use in-place of the default. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formattedSeconds` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local formattedSeconds = FormatZero()
```

### SecondsFormatterAPI.GetApproximationSeconds

Returns the threshold below which numeric values are formatted as approximated strings.

```lua
approximationSeconds = GetApproximationSeconds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `approximationSeconds` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local approximationSeconds = GetApproximationSeconds()
```

### SecondsFormatterAPI.GetConvertToLower

Returns true if the formatter should lowercase all unit format strings.

```lua
convert = GetConvertToLower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `convert` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local convert = GetConvertToLower()
```

### SecondsFormatterAPI.GetDefaultAbbreviation

Returns the default abbreviation mode used for formatting.

```lua
abbreviation = GetDefaultAbbreviation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `abbreviation` | SecondsFormatterAbbreviation | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local abbreviation = GetDefaultAbbreviation()
```

### SecondsFormatterAPI.GetDesiredUnitCount

Returns the desired unit count for formatting.

```lua
count = GetDesiredUnitCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | yes | Nil if configured to use a curve. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = GetDesiredUnitCount()
```

### SecondsFormatterAPI.GetDesiredUnitCountCurve

Returns the desired unit count curve for formatting.

```lua
curve = GetDesiredUnitCountCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | yes | Nil if configured to static unit count. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curve = GetDesiredUnitCountCurve()
```

### SecondsFormatterAPI.GetMaxInterval

Returns the maximum interval band permitted for formatting.

```lua
interval = GetMaxInterval()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | yes | Nil if configured to use a curve. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interval = GetMaxInterval()
```

### SecondsFormatterAPI.GetMaxIntervalCurve

Returns the maximum interval band curve permitted for formatting.

```lua
curve = GetMaxIntervalCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | yes | Nil if configured to static interval band. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curve = GetMaxIntervalCurve()
```

### SecondsFormatterAPI.GetMillisecondsThreshold

Returns the threshold below which a value will be formatted as a decimal number of seconds with one place for milliseconds (eg. '3.4')

```lua
threshold = GetMillisecondsThreshold()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `threshold` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local threshold = GetMillisecondsThreshold()
```

### SecondsFormatterAPI.GetMinInterval

Returns the minimum interval band permitted for formatting.

```lua
interval = GetMinInterval()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | yes | Nil if configured to use a curve. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interval = GetMinInterval()
```

### SecondsFormatterAPI.GetMinIntervalCurve

Returns the minimum interval band curve permitted for formatting.

```lua
curve = GetMinIntervalCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | yes | Nil if configured to static interval band. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curve = GetMinIntervalCurve()
```

### SecondsFormatterAPI.GetRounding

Returns how fractional seconds are rounded when not displaying milliseconds.

```lua
rounding = GetRounding()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rounding` | SecondsFormatterRounding | no | The configured rounding mode. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rounding = GetRounding()
```

### SecondsFormatterAPI.GetStripIntervalWhitespace

Returns the whitespace stripping mode of the formatter.

```lua
strip = GetStripIntervalWhitespace()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strip` | SecondsFormatterIntervalWhitespace | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local strip = GetStripIntervalWhitespace()
```

### SecondsFormatterAPI.Reset

Resets all stored configuration of the formatter.

```lua
Reset()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Reset()
```

### SecondsFormatterAPI.SetApproximationSeconds

Configures the formatter to render numeric values between zero and this value as approximated strings (eg. '< 1m').

```lua
SetApproximationSeconds(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetApproximationSeconds(seconds)
```

### SecondsFormatterAPI.SetCanRoundUpIntervals

Configures the formatter to promote intervals if values are large enough (eg. '60m' -> '1h').

```lua
SetCanRoundUpIntervals(canRound)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRound` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCanRoundUpIntervals(false)
```

### SecondsFormatterAPI.SetCanRoundUpLastUnit

Configures the formatter to round the last formatted unit up, rather than down.

```lua
SetCanRoundUpLastUnit(canRound)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRound` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCanRoundUpLastUnit(false)
```

### SecondsFormatterAPI.SetConvertToLower

Configures the formatter to convert all interval format strings to lowercase.

```lua
SetConvertToLower(convert)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `convert` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetConvertToLower(false)
```

### SecondsFormatterAPI.SetDefaultAbbreviation

Sets the default abbreviation mode used for formatting.

```lua
SetDefaultAbbreviation(abbreviation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `abbreviation` | SecondsFormatterAbbreviation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDefaultAbbreviation(abbreviation)
```

### SecondsFormatterAPI.SetDesiredUnitCount

Sets the desired unit count used for formatting.

```lua
SetDesiredUnitCount(count)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDesiredUnitCount(0)
```

### SecondsFormatterAPI.SetDesiredUnitCountCurve

Sets the desired unit count used for formatting to a curve that will be evaluated with seconds values to produce a desired unit count.

```lua
SetDesiredUnitCountCurve(curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDesiredUnitCountCurve(curve)
```

### SecondsFormatterAPI.SetMaxInterval

Sets the maximum interval band used for formatting.

```lua
SetMaxInterval(interval)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMaxInterval(interval)
```

### SecondsFormatterAPI.SetMaxIntervalCurve

Sets the maximum interval band used for formatting to a curve that will be evaluated with seconds values to produce a value matching a SecondsFormatterInterval enum member.

```lua
SetMaxIntervalCurve(curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMaxIntervalCurve(curve)
```

### SecondsFormatterAPI.SetMillisecondsThreshold

Sets the threshold below which a value will be formatted as a decimal number of seconds with one place for milliseconds (eg. '3.4')

```lua
SetMillisecondsThreshold(threshold)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `threshold` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMillisecondsThreshold(threshold)
```

### SecondsFormatterAPI.SetMinInterval

Sets the minimum interval band used for formatting.

```lua
SetMinInterval(interval)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interval` | SecondsFormatterInterval | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMinInterval(interval)
```

### SecondsFormatterAPI.SetMinIntervalCurve

Sets the minimum interval band used for formatting to a curve that will be evaluated with seconds values to produce a value matching a SecondsFormatterInterval enum member.

```lua
SetMinIntervalCurve(curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMinIntervalCurve(curve)
```

### SecondsFormatterAPI.SetRounding

Sets how fractional seconds are rounded when not displaying milliseconds.

```lua
SetRounding(rounding)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rounding` | SecondsFormatterRounding | no | The rounding mode to use. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRounding(rounding)
```

### SecondsFormatterAPI.SetStripIntervalWhitespace

Sets the whitespace stripping mode for the formatter.

```lua
SetStripIntervalWhitespace(strip)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strip` | SecondsFormatterIntervalWhitespace | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetStripIntervalWhitespace(strip)
```

