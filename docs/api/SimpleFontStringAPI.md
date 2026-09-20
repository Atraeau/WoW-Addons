# SimpleFontStringAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**57** functions · **0** events · **0** types

## Functions

### SimpleFontStringAPI.CalculateScreenAreaFromCharacterSpan

```lua
areas = CalculateScreenAreaFromCharacterSpan(leftIndex, rightIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `leftIndex` | luaIndex | no |  |
| `rightIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areas` | uiBoundsRect[] | yes |  |

**Example**

```lua
local areas = CalculateScreenAreaFromCharacterSpan(1, 1)
```

### SimpleFontStringAPI.CanNonSpaceWrap

```lua
wrap = CanNonSpaceWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
local wrap = CanNonSpaceWrap()
```

### SimpleFontStringAPI.CanWordWrap

```lua
wrap = CanWordWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
local wrap = CanWordWrap()
```

### SimpleFontStringAPI.ClearAlphaGradient

```lua
ClearAlphaGradient()
```

**Example**

```lua
ClearAlphaGradient()
```

### SimpleFontStringAPI.ClearText

Sets text to an empty string and removes the Text secret aspect.

```lua
ClearText()
```

**Example**

```lua
ClearText()
```

### SimpleFontStringAPI.FindCharacterIndexAtCoordinate

```lua
characterIndex, inside = FindCharacterIndexAtCoordinate(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterIndex` | luaIndex | no |  |
| `inside` | bool | no |  |

**Example**

```lua
local characterIndex, inside = FindCharacterIndexAtCoordinate(x, y)
```

### SimpleFontStringAPI.GetAlphaGradient

```lua
start, length = GetAlphaGradient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | number | no |  |
| `length` | number | no |  |

**Example**

```lua
local start, length = GetAlphaGradient()
```

### SimpleFontStringAPI.GetFieldSize

```lua
fieldSize = GetFieldSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fieldSize` | number | no |  |

**Example**

```lua
local fieldSize = GetFieldSize()
```

### SimpleFontStringAPI.GetFont

```lua
fontFile, fontHeight, flags = GetFont()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | FontAsset | yes |  |
| `fontHeight` | uiUnit | no |  |
| `flags` | TBFFlags | no |  |

**Example**

```lua
local fontFile, fontHeight, flags = GetFont()
```

### SimpleFontStringAPI.GetFontHeight

```lua
height = GetFontHeight(calculated)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `calculated` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
local height = GetFontHeight(false)
```

### SimpleFontStringAPI.GetFontObject

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

### SimpleFontStringAPI.GetIndentedWordWrap

```lua
wrap = GetIndentedWordWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
local wrap = GetIndentedWordWrap()
```

### SimpleFontStringAPI.GetJustifyH

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

### SimpleFontStringAPI.GetJustifyV

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

### SimpleFontStringAPI.GetLineHeight

```lua
lineHeight = GetLineHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lineHeight` | uiUnit | no |  |

**Example**

```lua
local lineHeight = GetLineHeight()
```

### SimpleFontStringAPI.GetMaxLines

```lua
maxLines = GetMaxLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLines` | number | no |  |

**Example**

```lua
local maxLines = GetMaxLines()
```

### SimpleFontStringAPI.GetNumLines

```lua
numLines = GetNumLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numLines` | number | no |  |

**Example**

```lua
local numLines = GetNumLines()
```

### SimpleFontStringAPI.GetRotation

```lua
radians = GetRotation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example**

```lua
local radians = GetRotation()
```

### SimpleFontStringAPI.GetScaleAnimationMode

```lua
scaleAnimationMode = GetScaleAnimationMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaleAnimationMode` | FontStringScaleAnimationMode | no |  |

**Example**

```lua
local scaleAnimationMode = GetScaleAnimationMode()
```

### SimpleFontStringAPI.GetShadowColor

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

### SimpleFontStringAPI.GetShadowOffset

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

### SimpleFontStringAPI.GetSmoothScaling

```lua
smoothScaling = GetSmoothScaling()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `smoothScaling` | bool | no |  |

**Example**

```lua
local smoothScaling = GetSmoothScaling()
```

### SimpleFontStringAPI.GetSpacing

```lua
spacing = GetSpacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spacing` | uiUnit | no |  |

**Example**

```lua
local spacing = GetSpacing()
```

### SimpleFontStringAPI.GetStringHeight

```lua
height = GetStringHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
local height = GetStringHeight()
```

### SimpleFontStringAPI.GetStringWidth

```lua
width = GetStringWidth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
local width = GetStringWidth()
```

### SimpleFontStringAPI.GetText

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

### SimpleFontStringAPI.GetTextColor

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

### SimpleFontStringAPI.GetTextScale

```lua
textScale = GetTextScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textScale` | number | no |  |

**Example**

```lua
local textScale = GetTextScale()
```

### SimpleFontStringAPI.GetUnboundedStringWidth

```lua
width = GetUnboundedStringWidth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
local width = GetUnboundedStringWidth()
```

### SimpleFontStringAPI.GetUnboundedStringWidthForText

```lua
width = GetUnboundedStringWidthForText(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
local width = GetUnboundedStringWidthForText("")
```

### SimpleFontStringAPI.GetWrappedWidth

```lua
width = GetWrappedWidth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
local width = GetWrappedWidth()
```

### SimpleFontStringAPI.IsTruncated

```lua
isTruncated = IsTruncated()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTruncated` | bool | no |  |

**Example**

```lua
local isTruncated = IsTruncated()
```

### SimpleFontStringAPI.OnColorsUpdated

```lua
OnColorsUpdated()
```

**Example**

```lua
OnColorsUpdated()
```

### SimpleFontStringAPI.SetAlphaGradient

```lua
isWithinText = SetAlphaGradient(start, length)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `start` | number | no |  |
| `length` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWithinText` | bool | no |  |

**Example**

```lua
local isWithinText = SetAlphaGradient(0, 0)
```

### SimpleFontStringAPI.SetDesaturateEmbeddedTextures

```lua
SetDesaturateEmbeddedTextures(desaturate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturate` | bool | no |  |

**Example**

```lua
SetDesaturateEmbeddedTextures(false)
```

### SimpleFontStringAPI.SetFixedColor

```lua
SetFixedColor(fixedColor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixedColor` | bool | no |  |

**Example**

```lua
SetFixedColor(false)
```

### SimpleFontStringAPI.SetFont

```lua
success = SetFont(fontFile, fontHeight, [flags])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | FontAsset | no |  |
| `fontHeight` | uiFontHeight | no |  |
| `flags` | TBFFlags | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = SetFont(fontFile, fontHeight)
```

### SimpleFontStringAPI.SetFontHeight

```lua
SetFontHeight(height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
SetFontHeight(height)
```

### SimpleFontStringAPI.SetFontObject

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

### SimpleFontStringAPI.SetFormattedText

```lua
SetFormattedText(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
SetFormattedText("")
```

### SimpleFontStringAPI.SetIndentedWordWrap

```lua
SetIndentedWordWrap(wrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
SetIndentedWordWrap(false)
```

### SimpleFontStringAPI.SetJustifyH

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

### SimpleFontStringAPI.SetJustifyV

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

### SimpleFontStringAPI.SetMaxLines

```lua
SetMaxLines(maxLines)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLines` | number | no |  |

**Example**

```lua
SetMaxLines(0)
```

### SimpleFontStringAPI.SetNonSpaceWrap

```lua
SetNonSpaceWrap(wrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
SetNonSpaceWrap(false)
```

### SimpleFontStringAPI.SetRotation

```lua
SetRotation(radians)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |

**Example**

```lua
SetRotation(0)
```

### SimpleFontStringAPI.SetScaleAnimationMode

```lua
SetScaleAnimationMode(scaleAnimationMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaleAnimationMode` | FontStringScaleAnimationMode | no |  |

**Example**

```lua
SetScaleAnimationMode(scaleAnimationMode)
```

### SimpleFontStringAPI.SetShadowColor

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

### SimpleFontStringAPI.SetShadowOffset

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

### SimpleFontStringAPI.SetSmoothScaling

```lua
SetSmoothScaling(smoothScaling)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `smoothScaling` | bool | no | If true, text height will not snap to nearest whole numbers for scaled font strings. |

**Example**

```lua
SetSmoothScaling(false)
```

### SimpleFontStringAPI.SetSpacing

```lua
SetSpacing(spacing)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spacing` | uiUnit | no |  |

**Example**

```lua
SetSpacing(spacing)
```

### SimpleFontStringAPI.SetText

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

### SimpleFontStringAPI.SetTextColor

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

### SimpleFontStringAPI.SetTextHeight

```lua
SetTextHeight(height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
SetTextHeight(height)
```

### SimpleFontStringAPI.SetTextScale

```lua
SetTextScale(textScale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textScale` | number | no |  |

**Example**

```lua
SetTextScale(0)
```

### SimpleFontStringAPI.SetTextToFit

```lua
SetTextToFit(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
SetTextToFit("")
```

### SimpleFontStringAPI.SetWordWrap

```lua
SetWordWrap(wrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrap` | bool | no |  |

**Example**

```lua
SetWordWrap(false)
```

