# FrameAPICooldown

[← API index](../README.md) · group: [Spells, Auras & Talents](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**46** functions · **0** events · **0** types

## Functions

### FrameAPICooldown.Clear

```lua
Clear()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Clear()
```

### FrameAPICooldown.GetCooldownDisplayDuration

The returned duration unit is milliseconds, unaffected by modRate.

```lua
duration = GetCooldownDisplayDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = GetCooldownDisplayDuration()
```

### FrameAPICooldown.GetCooldownDuration

The returned duration unit is milliseconds and is multiplied by the modRate.

```lua
duration = GetCooldownDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = GetCooldownDuration()
```

### FrameAPICooldown.GetCooldownTimes

```lua
start, duration = GetCooldownTimes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | number | no |  |
| `duration` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local start, duration = GetCooldownTimes()
```

### FrameAPICooldown.GetCountdownAbbrevThreshold

Returns the threshold below which cooldown numbers are displayed as an abbreviated form without a unit suffix (eg. '1:31').

```lua
seconds = GetCountdownAbbrevThreshold()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = GetCountdownAbbrevThreshold()
```

### FrameAPICooldown.GetCountdownFontString

```lua
countdownString = GetCountdownFontString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `countdownString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local countdownString = GetCountdownFontString()
```

### FrameAPICooldown.GetCountdownFormatter

```lua
formatter = GetCountdownFormatter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local formatter = GetCountdownFormatter()
```

### FrameAPICooldown.GetCountdownMillisecondsThreshold

Returns the threshold below which cooldown numbers are displayed as a decimal value with one place for milliseconds (eg. '8.7').

```lua
seconds = GetCountdownMillisecondsThreshold()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = GetCountdownMillisecondsThreshold()
```

### FrameAPICooldown.GetDrawBling

```lua
drawBling = GetDrawBling()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawBling` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local drawBling = GetDrawBling()
```

### FrameAPICooldown.GetDrawEdge

```lua
drawEdge = GetDrawEdge()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawEdge` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local drawEdge = GetDrawEdge()
```

### FrameAPICooldown.GetDrawSwipe

```lua
drawSwipe = GetDrawSwipe()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawSwipe` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local drawSwipe = GetDrawSwipe()
```

### FrameAPICooldown.GetEdgeScale

```lua
edgeScale = GetEdgeScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `edgeScale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local edgeScale = GetEdgeScale()
```

### FrameAPICooldown.GetHideCountdownNumbers

```lua
hideNumbers = GetHideCountdownNumbers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hideNumbers` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hideNumbers = GetHideCountdownNumbers()
```

### FrameAPICooldown.GetMinimumCountdownDuration

```lua
milliseconds = GetMinimumCountdownDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milliseconds` | Milliseconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local milliseconds = GetMinimumCountdownDuration()
```

### FrameAPICooldown.GetReverse

```lua
reverse = GetReverse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reverse = GetReverse()
```

### FrameAPICooldown.GetRotation

```lua
rotationRadians = GetRotation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotationRadians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rotationRadians = GetRotation()
```

### FrameAPICooldown.GetUseAuraDisplayTime

```lua
useAuraDisplayTime = GetUseAuraDisplayTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useAuraDisplayTime` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local useAuraDisplayTime = GetUseAuraDisplayTime()
```

### FrameAPICooldown.IsPaused

```lua
isPaused = IsPaused()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPaused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPaused = IsPaused()
```

### FrameAPICooldown.Pause

```lua
Pause()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Pause()
```

### FrameAPICooldown.Resume

```lua
Resume()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Resume()
```

### FrameAPICooldown.SetBlingTexture

```lua
SetBlingTexture(texture, colorR, colorG, colorB, colorA)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | FileAsset | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetBlingTexture(texture, 0, 0, 0, 0)
```

### FrameAPICooldown.SetCooldown

```lua
SetCooldown(start, duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | Seconds | no |  |
| `duration` | Seconds | no |  |
| `modRate` | number | no | (default: 1) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCooldown(start, duration, 0)
```

### FrameAPICooldown.SetCooldownDuration

```lua
SetCooldownDuration(duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | Seconds | no |  |
| `modRate` | number | no | (default: 1) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCooldownDuration(duration, 0)
```

### FrameAPICooldown.SetCooldownFromDurationObject

```lua
SetCooldownFromDurationObject(duration, clearIfZero)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |
| `clearIfZero` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCooldownFromDurationObject(duration, false)
```

### FrameAPICooldown.SetCooldownFromExpirationTime

```lua
SetCooldownFromExpirationTime(expirationTime, duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expirationTime` | Seconds | no |  |
| `duration` | Seconds | no |  |
| `modRate` | number | no | (default: 1) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCooldownFromExpirationTime(expirationTime, duration, 0)
```

### FrameAPICooldown.SetCooldownUNIX

```lua
SetCooldownUNIX(start, duration, modRate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | number | no |  |
| `duration` | number | no |  |
| `modRate` | number | no | (default: 1) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCooldownUNIX(0, 0, 0)
```

### FrameAPICooldown.SetCountdownAbbrevThreshold

Sets the threshold below which cooldown numbers are displayed as an abbreviated form without a unit suffix (eg. '1:31').

```lua
SetCountdownAbbrevThreshold(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no | Number of seconds below which numbers will be abbreviated. If above one hour or below one minute, no abbreviation will be performed. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCountdownAbbrevThreshold(seconds)
```

### FrameAPICooldown.SetCountdownFont

```lua
SetCountdownFont(fontName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCountdownFont("")
```

### FrameAPICooldown.SetCountdownFormatter

```lua
SetCountdownFormatter([formatter])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericFormatter | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCountdownFormatter()
```

### FrameAPICooldown.SetCountdownMillisecondsThreshold

Sets the threshold below which cooldown numbers are displayed as a decimal value with one place for milliseconds (eg. '8.7').

```lua
SetCountdownMillisecondsThreshold(seconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | Seconds | no | Number of seconds below which numbers are displayed with milliseconds. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCountdownMillisecondsThreshold(seconds)
```

### FrameAPICooldown.SetDrawBling

```lua
SetDrawBling(drawBling)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawBling` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawBling(false)
```

### FrameAPICooldown.SetDrawEdge

```lua
SetDrawEdge(drawEdge)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawEdge` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawEdge(false)
```

### FrameAPICooldown.SetDrawSwipe

```lua
SetDrawSwipe(drawSwipe)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `drawSwipe` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawSwipe(false)
```

### FrameAPICooldown.SetEdgeColor

```lua
SetEdgeColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEdgeColor(0, 0, 0)
```

### FrameAPICooldown.SetEdgeScale

```lua
SetEdgeScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEdgeScale(0)
```

### FrameAPICooldown.SetEdgeTexture

```lua
SetEdgeTexture(texture, colorR, colorG, colorB, colorA)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | FileAsset | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEdgeTexture(texture, 0, 0, 0, 0)
```

### FrameAPICooldown.SetHideCountdownNumbers

```lua
SetHideCountdownNumbers(hideNumbers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hideNumbers` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHideCountdownNumbers(false)
```

### FrameAPICooldown.SetMinimumCountdownDuration

Controls the minimum duration above which countdown text will be shown. This is applied based upon the total duration of the cooldown, not the remaining duration as it ticks down.

```lua
SetMinimumCountdownDuration(milliseconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `milliseconds` | Milliseconds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMinimumCountdownDuration(milliseconds)
```

### FrameAPICooldown.SetPaused

```lua
SetPaused(paused)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `paused` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPaused(false)
```

### FrameAPICooldown.SetReverse

```lua
SetReverse(reverse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reverse` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetReverse(false)
```

### FrameAPICooldown.SetRotation

```lua
SetRotation(rotationRadians)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotationRadians` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRotation(0)
```

### FrameAPICooldown.SetSwipeColor

```lua
SetSwipeColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSwipeColor(0, 0, 0)
```

### FrameAPICooldown.SetSwipeTexture

```lua
SetSwipeTexture([texture], colorR, colorG, colorB, colorA)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | FileAsset | yes |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSwipeTexture(0, 0, 0, 0)
```

### FrameAPICooldown.SetTexCoordRange

```lua
SetTexCoordRange(low, high)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `low` | vector2 | no |  |
| `high` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTexCoordRange(low, high)
```

### FrameAPICooldown.SetUseAuraDisplayTime

Aura durations are displayed slightly differently than cooldown durations. Setting this to true will adjust the display logic to stay in sync with aura timers.

```lua
SetUseAuraDisplayTime(useAuraDisplayTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useAuraDisplayTime` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseAuraDisplayTime(false)
```

### FrameAPICooldown.SetUseCircularEdge

```lua
SetUseCircularEdge(useCircularEdge)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useCircularEdge` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUseCircularEdge(false)
```

