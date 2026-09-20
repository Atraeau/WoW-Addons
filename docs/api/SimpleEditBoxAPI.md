# SimpleEditBoxAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**79** functions · **0** events · **0** types

## Functions

### SimpleEditBoxAPI.AddHistoryLine

```lua
AddHistoryLine(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
AddHistoryLine("")
```

### SimpleEditBoxAPI.ClearFocus

```lua
ClearFocus()
```

**Example**

```lua
ClearFocus()
```

### SimpleEditBoxAPI.ClearHighlightText

```lua
ClearHighlightText()
```

**Example**

```lua
ClearHighlightText()
```

### SimpleEditBoxAPI.ClearHistory

```lua
ClearHistory()
```

**Example**

```lua
ClearHistory()
```

### SimpleEditBoxAPI.Disable

```lua
Disable()
```

**Example**

```lua
Disable()
```

### SimpleEditBoxAPI.Enable

```lua
Enable()
```

**Example**

```lua
Enable()
```

### SimpleEditBoxAPI.GetAltArrowKeyMode

```lua
altMode = GetAltArrowKeyMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `altMode` | bool | no |  |

**Example**

```lua
local altMode = GetAltArrowKeyMode()
```

### SimpleEditBoxAPI.GetBlinkSpeed

```lua
cursorBlinkSpeedSec = GetBlinkSpeed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cursorBlinkSpeedSec` | number | no |  |

**Example**

```lua
local cursorBlinkSpeedSec = GetBlinkSpeed()
```

### SimpleEditBoxAPI.GetCursorPosition

```lua
cursorPosition = GetCursorPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cursorPosition` | number | no |  |

**Example**

```lua
local cursorPosition = GetCursorPosition()
```

### SimpleEditBoxAPI.GetDisplayText

```lua
displayText = GetDisplayText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayText` | string | no |  |

**Example**

```lua
local displayText = GetDisplayText()
```

### SimpleEditBoxAPI.GetFont

```lua
name, fontHeight, flags = GetFont()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `fontHeight` | uiUnit | no |  |
| `flags` | TBFFlags | no |  |

**Example**

```lua
local name, fontHeight, flags = GetFont()
```

### SimpleEditBoxAPI.GetFontObject

```lua
font = GetFontObject()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example**

```lua
local font = GetFontObject()
```

### SimpleEditBoxAPI.GetHighlightColor

```lua
colorR, colorG, colorB, colorA = GetHighlightColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example**

```lua
local colorR, colorG, colorB, colorA = GetHighlightColor()
```

### SimpleEditBoxAPI.GetHistoryLines

```lua
numHistoryLines = GetHistoryLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numHistoryLines` | number | no |  |

**Example**

```lua
local numHistoryLines = GetHistoryLines()
```

### SimpleEditBoxAPI.GetIndentedWordWrap

```lua
isIndented = GetIndentedWordWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIndented` | bool | no |  |

**Example**

```lua
local isIndented = GetIndentedWordWrap()
```

### SimpleEditBoxAPI.GetInputLanguage

```lua
language = GetInputLanguage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `language` | cstring | no |  |

**Example**

```lua
local language = GetInputLanguage()
```

### SimpleEditBoxAPI.GetJustifyH

```lua
justifyH = GetJustifyH()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyH` | JustifyHorizontal | no |  |

**Example**

```lua
local justifyH = GetJustifyH()
```

### SimpleEditBoxAPI.GetJustifyV

```lua
justifyV = GetJustifyV()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyV` | JustifyVertical | no |  |

**Example**

```lua
local justifyV = GetJustifyV()
```

### SimpleEditBoxAPI.GetMaxBytes

```lua
maxBytes = GetMaxBytes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBytes` | number | no |  |

**Example**

```lua
local maxBytes = GetMaxBytes()
```

### SimpleEditBoxAPI.GetMaxLetters

```lua
maxLetters = GetMaxLetters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLetters` | number | no |  |

**Example**

```lua
local maxLetters = GetMaxLetters()
```

### SimpleEditBoxAPI.GetNumber

```lua
number = GetNumber()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | yes |  |

**Example**

```lua
local number = GetNumber()
```

### SimpleEditBoxAPI.GetNumLetters

```lua
numLetters = GetNumLetters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numLetters` | number | no |  |

**Example**

```lua
local numLetters = GetNumLetters()
```

### SimpleEditBoxAPI.GetNumLines

```lua
lines = GetNumLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lines` | number | no |  |

**Example**

```lua
local lines = GetNumLines()
```

### SimpleEditBoxAPI.GetShadowColor

```lua
colorR, colorG, colorB, colorA = GetShadowColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example**

```lua
local colorR, colorG, colorB, colorA = GetShadowColor()
```

### SimpleEditBoxAPI.GetShadowOffset

```lua
offsetX, offsetY = GetShadowOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example**

```lua
local offsetX, offsetY = GetShadowOffset()
```

### SimpleEditBoxAPI.GetSpacing

```lua
fontHeight = GetSpacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontHeight` | uiUnit | no |  |

**Example**

```lua
local fontHeight = GetSpacing()
```

### SimpleEditBoxAPI.GetText

```lua
text = GetText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
local text = GetText()
```

### SimpleEditBoxAPI.GetTextColor

```lua
colorR, colorG, colorB, colorA = GetTextColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example**

```lua
local colorR, colorG, colorB, colorA = GetTextColor()
```

### SimpleEditBoxAPI.GetTextInsets

```lua
left, right, top, bottom = GetTextInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example**

```lua
local left, right, top, bottom = GetTextInsets()
```

### SimpleEditBoxAPI.GetUTF8CursorPosition

```lua
cursorPosition = GetUTF8CursorPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cursorPosition` | number | no |  |

**Example**

```lua
local cursorPosition = GetUTF8CursorPosition()
```

### SimpleEditBoxAPI.GetVisibleTextByteLimit

```lua
maxVisibleBytes = GetVisibleTextByteLimit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxVisibleBytes` | number | no |  |

**Example**

```lua
local maxVisibleBytes = GetVisibleTextByteLimit()
```

### SimpleEditBoxAPI.HasFocus

```lua
hasFocus = HasFocus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFocus` | bool | no |  |

**Example**

```lua
local hasFocus = HasFocus()
```

### SimpleEditBoxAPI.HasText

```lua
hasText = HasText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasText` | bool | no |  |

**Example**

```lua
local hasText = HasText()
```

### SimpleEditBoxAPI.HighlightText

```lua
HighlightText(start, stop)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | number | no | (default: 0) |
| `stop` | number | no | (default: -1) |

**Example**

```lua
HighlightText(0, 0)
```

### SimpleEditBoxAPI.Insert

```lua
Insert(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
Insert("")
```

### SimpleEditBoxAPI.IsAlphabeticOnly

```lua
enabled = IsAlphabeticOnly()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsAlphabeticOnly()
```

### SimpleEditBoxAPI.IsAutoFocus

```lua
autoFocus = IsAutoFocus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoFocus` | bool | no |  |

**Example**

```lua
local autoFocus = IsAutoFocus()
```

### SimpleEditBoxAPI.IsCountInvisibleLetters

```lua
countInvisibleLetters = IsCountInvisibleLetters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `countInvisibleLetters` | bool | no |  |

**Example**

```lua
local countInvisibleLetters = IsCountInvisibleLetters()
```

### SimpleEditBoxAPI.IsEnabled

```lua
isEnabled = IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example**

```lua
local isEnabled = IsEnabled()
```

### SimpleEditBoxAPI.IsInIMECompositionMode

```lua
isInIMECompositionMode = IsInIMECompositionMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInIMECompositionMode` | bool | no |  |

**Example**

```lua
local isInIMECompositionMode = IsInIMECompositionMode()
```

### SimpleEditBoxAPI.IsMultiLine

```lua
multiline = IsMultiLine()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `multiline` | bool | no |  |

**Example**

```lua
local multiline = IsMultiLine()
```

### SimpleEditBoxAPI.IsNumeric

```lua
isNumeric = IsNumeric()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNumeric` | bool | no |  |

**Example**

```lua
local isNumeric = IsNumeric()
```

### SimpleEditBoxAPI.IsNumericFullRange

```lua
isNumeric = IsNumericFullRange()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNumeric` | bool | no |  |

**Example**

```lua
local isNumeric = IsNumericFullRange()
```

### SimpleEditBoxAPI.IsPassword

```lua
isPassword = IsPassword()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPassword` | bool | no |  |

**Example**

```lua
local isPassword = IsPassword()
```

### SimpleEditBoxAPI.IsSecureText

```lua
isSecure = IsSecureText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSecure` | bool | no |  |

**Example**

```lua
local isSecure = IsSecureText()
```

### SimpleEditBoxAPI.ResetInputMode

```lua
ResetInputMode()
```

**Example**

```lua
ResetInputMode()
```

### SimpleEditBoxAPI.SetAlphabeticOnly

```lua
SetAlphabeticOnly(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example**

```lua
SetAlphabeticOnly(false)
```

### SimpleEditBoxAPI.SetAltArrowKeyMode

```lua
SetAltArrowKeyMode(altMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `altMode` | bool | no | (default: False) |

**Example**

```lua
SetAltArrowKeyMode(false)
```

### SimpleEditBoxAPI.SetAutoFocus

```lua
SetAutoFocus(autoFocus)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoFocus` | bool | no | (default: False) |

**Example**

```lua
SetAutoFocus(false)
```

### SimpleEditBoxAPI.SetBlinkSpeed

```lua
SetBlinkSpeed(cursorBlinkSpeedSec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cursorBlinkSpeedSec` | number | no |  |

**Example**

```lua
SetBlinkSpeed(0)
```

### SimpleEditBoxAPI.SetCountInvisibleLetters

```lua
SetCountInvisibleLetters(countInvisibleLetters)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `countInvisibleLetters` | bool | no | (default: False) |

**Example**

```lua
SetCountInvisibleLetters(false)
```

### SimpleEditBoxAPI.SetCursorPosition

```lua
SetCursorPosition(cursorPosition)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cursorPosition` | number | no |  |

**Example**

```lua
SetCursorPosition(0)
```

### SimpleEditBoxAPI.SetEnabled

```lua
SetEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example**

```lua
SetEnabled(false)
```

### SimpleEditBoxAPI.SetFocus

```lua
SetFocus()
```

**Example**

```lua
SetFocus()
```

### SimpleEditBoxAPI.SetFont

```lua
success = SetFont(fontFile, height, flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetFont("", height, flags)
```

### SimpleEditBoxAPI.SetFontObject

```lua
SetFontObject(font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example**

```lua
SetFontObject(font)
```

### SimpleEditBoxAPI.SetHighlightColor

```lua
SetHighlightColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example**

```lua
SetHighlightColor(0, 0, 0)
```

### SimpleEditBoxAPI.SetHistoryLines

```lua
SetHistoryLines(numHistoryLines)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numHistoryLines` | number | no |  |

**Example**

```lua
SetHistoryLines(0)
```

### SimpleEditBoxAPI.SetIndentedWordWrap

```lua
SetIndentedWordWrap(isIndented)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isIndented` | bool | no | (default: False) |

**Example**

```lua
SetIndentedWordWrap(false)
```

### SimpleEditBoxAPI.SetJustifyH

```lua
SetJustifyH(justifyH)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyH` | JustifyHorizontal | no |  |

**Example**

```lua
SetJustifyH(justifyH)
```

### SimpleEditBoxAPI.SetJustifyV

```lua
SetJustifyV(justifyV)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyV` | JustifyVertical | no |  |

**Example**

```lua
SetJustifyV(justifyV)
```

### SimpleEditBoxAPI.SetMaxBytes

```lua
SetMaxBytes(maxBytes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxBytes` | number | no |  |

**Example**

```lua
SetMaxBytes(0)
```

### SimpleEditBoxAPI.SetMaxLetters

```lua
SetMaxLetters(maxLetters)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLetters` | number | no |  |

**Example**

```lua
SetMaxLetters(0)
```

### SimpleEditBoxAPI.SetMultiLine

```lua
SetMultiLine(multiline)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `multiline` | bool | no | (default: False) |

**Example**

```lua
SetMultiLine(false)
```

### SimpleEditBoxAPI.SetNumber

```lua
SetNumber(number)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |

**Example**

```lua
SetNumber(0)
```

### SimpleEditBoxAPI.SetNumeric

```lua
SetNumeric(isNumeric)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNumeric` | bool | no | (default: False) |

**Example**

```lua
SetNumeric(false)
```

### SimpleEditBoxAPI.SetNumericFullRange

```lua
SetNumericFullRange(isNumeric)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isNumeric` | bool | no | (default: False) |

**Example**

```lua
SetNumericFullRange(false)
```

### SimpleEditBoxAPI.SetPassword

```lua
SetPassword(isPassword)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPassword` | bool | no | (default: False) |

**Example**

```lua
SetPassword(false)
```

### SimpleEditBoxAPI.SetSecureText

```lua
SetSecureText(isSecure)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSecure` | bool | no | (default: False) |

**Example**

```lua
SetSecureText(false)
```

### SimpleEditBoxAPI.SetSecurityDisablePaste

```lua
SetSecurityDisablePaste()
```

**Example**

```lua
SetSecurityDisablePaste()
```

### SimpleEditBoxAPI.SetSecurityDisableSetText

```lua
SetSecurityDisableSetText()
```

**Example**

```lua
SetSecurityDisableSetText()
```

### SimpleEditBoxAPI.SetShadowColor

```lua
SetShadowColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example**

```lua
SetShadowColor(0, 0, 0)
```

### SimpleEditBoxAPI.SetShadowOffset

```lua
SetShadowOffset(offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example**

```lua
SetShadowOffset(0, 0)
```

### SimpleEditBoxAPI.SetSpacing

```lua
SetSpacing(fontHeight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontHeight` | uiUnit | no |  |

**Example**

```lua
SetSpacing(fontHeight)
```

### SimpleEditBoxAPI.SetText

```lua
SetText(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
SetText("")
```

### SimpleEditBoxAPI.SetTextColor

```lua
SetTextColor(colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example**

```lua
SetTextColor(0, 0, 0)
```

### SimpleEditBoxAPI.SetTextInsets

```lua
SetTextInsets(left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example**

```lua
SetTextInsets(left, right, top, bottom)
```

### SimpleEditBoxAPI.SetVisibleTextByteLimit

```lua
SetVisibleTextByteLimit(maxVisibleBytes)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxVisibleBytes` | number | no |  |

**Example**

```lua
SetVisibleTextByteLimit(0)
```

### SimpleEditBoxAPI.ToggleInputLanguage

```lua
ToggleInputLanguage()
```

**Example**

```lua
ToggleInputLanguage()
```

