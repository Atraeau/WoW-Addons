# DurationTextBindingObjectAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**30** functions · **0** events · **0** types

## Functions

### DurationTextBindingObjectAPI.Assign

Copies another duration text binding and assigns it to this one.

```lua
Assign(other)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `other` | DurationTextBinding | no |  |

**Example**

```lua
Assign(other)
```

### DurationTextBindingObjectAPI.CanFormatText

Returns true if this binding has enough configuration to produce formatted text.

```lua
canFormatText = CanFormatText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canFormatText` | bool | no |  |

**Example**

```lua
local canFormatText = CanFormatText()
```

### DurationTextBindingObjectAPI.CanUpdateFontString

Returns true if this binding has enough configuration to update its font string with formatted text.

```lua
canUpdateText = CanUpdateFontString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUpdateText` | bool | no |  |

**Example**

```lua
local canUpdateText = CanUpdateFontString()
```

### DurationTextBindingObjectAPI.ClearTextColorCurve

Clears the text color curve used by this binding.

```lua
ClearTextColorCurve()
```

**Example**

```lua
ClearTextColorCurve()
```

### DurationTextBindingObjectAPI.Copy

Returns a copy of this duration text binding.

```lua
copy = Copy()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `copy` | DurationTextBinding | no |  |

**Example**

```lua
local copy = Copy()
```

### DurationTextBindingObjectAPI.Disable

Disables automatic updates for this duration text binding.

```lua
Disable()
```

**Example**

```lua
Disable()
```

### DurationTextBindingObjectAPI.Enable

Enables automatic updates for this duration text binding.

```lua
Enable()
```

**Example**

```lua
Enable()
```

### DurationTextBindingObjectAPI.GetDuration

Returns the duration object used by this duration text binding.

```lua
duration = GetDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | yes |  |

**Example**

```lua
local duration = GetDuration()
```

### DurationTextBindingObjectAPI.GetExpiredText

Returns the text shown when the duration has fully expired.

```lua
text = GetExpiredText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | yes |  |

**Example**

```lua
local text = GetExpiredText()
```

### DurationTextBindingObjectAPI.GetFontString

Returns the font string updated by this duration text binding.

```lua
fontString = GetFontString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontString` | SimpleFontString | yes |  |

**Example**

```lua
local fontString = GetFontString()
```

### DurationTextBindingObjectAPI.GetFormattedText

Returns the text that would currently be assigned to the configured font string.

```lua
text = GetFormattedText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = GetFormattedText()
```

### DurationTextBindingObjectAPI.GetFormattedTextColor

Returns the text color that would currently be assigned to the configured font string.

```lua
color = GetFormattedTextColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |

**Example**

```lua
local color = GetFormattedTextColor()
```

### DurationTextBindingObjectAPI.GetTextColorCurve

Returns the text color curve used by this binding.

```lua
curve, property = GetTextColorCurve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaColorCurveObject | no |  |
| `property` | DurationTextBindingProperty | no |  |

**Example**

```lua
local curve, property = GetTextColorCurve()
```

### DurationTextBindingObjectAPI.GetTimeModifier

Returns the time modifier used when sampling duration values for this binding.

```lua
modifier = GetTimeModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no |  |

**Example**

```lua
local modifier = GetTimeModifier()
```

### DurationTextBindingObjectAPI.GetUpdateInterval

Returns the minimum number of seconds between automatic text updates. A value of zero updates every game tick.

```lua
updateInterval = GetUpdateInterval()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updateInterval` | number | no |  |

**Example**

```lua
local updateInterval = GetUpdateInterval()
```

### DurationTextBindingObjectAPI.GetZeroDurationText

Returns the text shown when the duration is not configured, or represents a zero-duration time span.

```lua
text = GetZeroDurationText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | yes |  |

**Example**

```lua
local text = GetZeroDurationText()
```

### DurationTextBindingObjectAPI.HasSecretValues

Returns true if the duration text binding has been configured with any secret values.

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

### DurationTextBindingObjectAPI.IsEnabled

Returns true if this duration text binding updates its font string automatically.

```lua
enabled = IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsEnabled()
```

### DurationTextBindingObjectAPI.SetDuration

Configures the duration object used by this duration text binding.

```lua
SetDuration(duration)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
SetDuration(duration)
```

### DurationTextBindingObjectAPI.SetEnabled

Configures whether this duration text binding updates its font string automatically.

```lua
SetEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
SetEnabled(false)
```

### DurationTextBindingObjectAPI.SetExpiredText

Configures the text shown when the duration has fully expired.

```lua
SetExpiredText([text])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | yes |  |

**Example**

```lua
SetExpiredText()
```

### DurationTextBindingObjectAPI.SetFontString

Configures the font string updated by this duration text binding.

```lua
SetFontString(fontString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontString` | SimpleFontString | no |  |

**Example**

```lua
SetFontString(fontString)
```

### DurationTextBindingObjectAPI.SetFormatter

Configures the text format used by this duration text binding to display the remaining duration using the supplied formatter.

```lua
SetFormatter(formatter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | no |  |

**Example**

```lua
SetFormatter(formatter)
```

### DurationTextBindingObjectAPI.SetTextColorCurve

Configures this duration text binding to adjust fontstring text color by evaluating a duration property through a curve.

```lua
SetTextColorCurve(curve, property)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaColorCurveObject | no |  |
| `property` | DurationTextBindingProperty | no |  |

**Example**

```lua
SetTextColorCurve(curve, property)
```

### DurationTextBindingObjectAPI.SetTextFormat

Configures the text format used by this duration text binding. The format string may contain '{}' placeholders, each of which is substituted by the corresponding component in the supplied array.

```lua
SetTextFormat(formatString, components)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatString` | stringView | no |  |
| `components` | DurationTextBindingFormatComponent[] | no |  |

**Example**

```lua
SetTextFormat(formatString, components)
```

### DurationTextBindingObjectAPI.SetTimeModifier

Configures the time modifier used when sampling duration values for this binding.

```lua
SetTimeModifier(modifier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifier` | DurationTimeModifier | no |  |

**Example**

```lua
SetTimeModifier(modifier)
```

### DurationTextBindingObjectAPI.SetToDefaults

Resets this duration text binding to its default state, clearing the configured font string, duration, format, formatter, and fallback text.

```lua
SetToDefaults()
```

**Example**

```lua
SetToDefaults()
```

### DurationTextBindingObjectAPI.SetUpdateInterval

Configures the minimum number of seconds between automatic text updates. A value of zero updates every game tick.

```lua
SetUpdateInterval(updateInterval)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updateInterval` | number | no |  |

**Example**

```lua
SetUpdateInterval(0)
```

### DurationTextBindingObjectAPI.SetZeroDurationText

Configures the text shown when the duration is not configured, or represents a zero-duration time span.

```lua
SetZeroDurationText([text])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | yes |  |

**Example**

```lua
SetZeroDurationText()
```

### DurationTextBindingObjectAPI.UpdateFontString

Immediately updates the configured font string from the current duration state.

```lua
UpdateFontString()
```

**Example**

```lua
UpdateFontString()
```

