# math

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **0** events · **0** types

## Functions

### math.clamp

Clamps a value to the inclusive range defined by the minimum and maximum values.

```lua
clampedValue = math.clamp(value, minimum, maximum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to clamp. |
| `minimum` | number | no | The inclusive lower bound. |
| `maximum` | number | no | The inclusive upper bound. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clampedValue` | number | no | The clamped value. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clampedValue = math.clamp(0, 0, 0)
```

### math.isfinite

Returns whether a value is finite.

```lua
finite = math.isfinite(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to inspect. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `finite` | bool | no | True if the value is neither infinite nor NaN; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local finite = math.isfinite(0)
```

### math.isinf

Returns whether a value is positive or negative infinity.

```lua
infinite = math.isinf(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to inspect. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infinite` | bool | no | True if the value is positive or negative infinity; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infinite = math.isinf(0)
```

### math.isnan

Returns whether a value is NaN.

```lua
nan = math.isnan(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to inspect. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nan` | bool | no | True if the value is NaN; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nan = math.isnan(0)
```

### math.lerp

Linearly interpolates between two values.

```lua
interpolatedValue = math.lerp(startValue, endValue, amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startValue` | number | no | The value returned when the interpolation amount is 0. |
| `endValue` | number | no | The value returned when the interpolation amount is 1. |
| `amount` | number | no | The interpolation amount. Values outside [0, 1] extrapolate beyond the two values. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interpolatedValue` | number | no | The interpolated value. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local interpolatedValue = math.lerp(0, 0, 0)
```

### math.normalize

Returns the relative position of a value within a range, where the minimum maps to 0 and the maximum maps to 1.

```lua
normalizedValue = math.normalize(value, minimum, maximum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to normalize. |
| `minimum` | number | no | The value that maps to 0. |
| `maximum` | number | no | The value that maps to 1. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `normalizedValue` | number | no | The normalized value. Values outside the input range produce results outside [0, 1]. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local normalizedValue = math.normalize(0, 0, 0)
```

### math.remap

Maps a value from one range to the corresponding position in another range.

```lua
remappedValue = math.remap(value, sourceMinimum, sourceMaximum, destinationMinimum, destinationMaximum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to map. |
| `sourceMinimum` | number | no | The lower endpoint of the source range. |
| `sourceMaximum` | number | no | The upper endpoint of the source range. |
| `destinationMinimum` | number | no | The lower endpoint of the destination range. |
| `destinationMaximum` | number | no | The upper endpoint of the destination range. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `remappedValue` | number | no | The mapped value. Values outside the source range are extrapolated beyond the destination range. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local remappedValue = math.remap(0, 0, 0, 0, 0)
```

### math.round

Rounds a value to the specified number of decimal places, with halfway values rounded away from zero.

```lua
roundedValue = math.round(value, decimalPlaces)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to round. |
| `decimalPlaces` | number | no | The number of decimal places to preserve. Negative values round to positions left of the decimal point. (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roundedValue` | number | no | The rounded value. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roundedValue = math.round(0, 0)
```

### math.saturate

Clamps a value to the inclusive range [0, 1].

```lua
saturatedValue = math.saturate(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to clamp. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `saturatedValue` | number | no | The value clamped to the inclusive range [0, 1]. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local saturatedValue = math.saturate(0)
```

### math.sign

Returns -1 for negative values, 0 for zero, and 1 for positive values.

```lua
sign = math.sign(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value whose sign will be returned. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sign` | number | no | The sign of the value. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sign = math.sign(0)
```

### math.wrap

Wraps a value into the half-open range [minimum, maximum).

```lua
wrapped = math.wrap(value, minimum, maximum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no | The value to wrap. |
| `minimum` | number | no | The inclusive lower bound of the range. |
| `maximum` | number | no | The exclusive upper bound of the range. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrapped` | number | no | The wrapped value, greater than or equal to minimum and less than maximum. If minimum equals maximum, returns minimum. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wrapped = math.wrap(0, 0, 0)
```

