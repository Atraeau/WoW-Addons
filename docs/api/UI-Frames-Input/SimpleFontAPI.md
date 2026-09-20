# SimpleFontAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**24** functions · **0** events · **0** types

## Functions

### SimpleFontAPI.CopyFontObject

```lua
CopyFontObject(sourceFont)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceFont` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
CopyFontObject(sourceFont)
```

### SimpleFontAPI.GetAlpha

```lua
alpha = GetAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local alpha = GetAlpha()
```

### SimpleFontAPI.GetFont

```lua
fontFile, height, flags = GetFont()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fontFile, height, flags = GetFont()
```

### SimpleFontAPI.GetFontHeight

Return is either in uiUnits or internal height due to fixedHeight.

```lua
height = GetFontHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local height = GetFontHeight()
```

### SimpleFontAPI.GetFontObject

```lua
font = GetFontObject()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetFontObject()
```

### SimpleFontAPI.GetFontObjectForAlphabet

```lua
font = GetFontObjectForAlphabet(alphabet)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alphabet` | FontAlphabet | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetFontObjectForAlphabet(alphabet)
```

### SimpleFontAPI.GetIndentedWordWrap

```lua
wordWrap = GetIndentedWordWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wordWrap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wordWrap = GetIndentedWordWrap()
```

### SimpleFontAPI.GetJustifyH

```lua
justifyH = GetJustifyH()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyH` | JustifyHorizontal | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local justifyH = GetJustifyH()
```

### SimpleFontAPI.GetJustifyV

```lua
justifyV = GetJustifyV()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyV` | JustifyVertical | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local justifyV = GetJustifyV()
```

### SimpleFontAPI.GetShadowColor

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetShadowColor()
```

### SimpleFontAPI.GetShadowOffset

```lua
offsetX, offsetY = GetShadowOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offsetX, offsetY = GetShadowOffset()
```

### SimpleFontAPI.GetSpacing

```lua
spacing = GetSpacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spacing` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spacing = GetSpacing()
```

### SimpleFontAPI.GetTextColor

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetTextColor()
```

### SimpleFontAPI.SetAlpha

```lua
SetAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlpha(alpha)
```

### SimpleFontAPI.SetFont

```lua
SetFont(fontFile, height, flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFont("", height, flags)
```

### SimpleFontAPI.SetFontHeight

Preserves all flags, does correct height conversion due to fixedHeight.

```lua
SetFontHeight(height)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFontHeight(0)
```

### SimpleFontAPI.SetFontObject

```lua
SetFontObject(font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFontObject(font)
```

### SimpleFontAPI.SetIndentedWordWrap

```lua
SetIndentedWordWrap(wordWrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wordWrap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIndentedWordWrap(false)
```

### SimpleFontAPI.SetJustifyH

```lua
SetJustifyH(justifyH)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyH` | JustifyHorizontal | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetJustifyH(justifyH)
```

### SimpleFontAPI.SetJustifyV

```lua
SetJustifyV(justifyV)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyV` | JustifyVertical | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetJustifyV(justifyV)
```

### SimpleFontAPI.SetShadowColor

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShadowColor(0, 0, 0)
```

### SimpleFontAPI.SetShadowOffset

```lua
SetShadowOffset(offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShadowOffset(1, 1)
```

### SimpleFontAPI.SetSpacing

```lua
SetSpacing(spacing)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spacing` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSpacing(spacing)
```

### SimpleFontAPI.SetTextColor

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTextColor(0, 0, 0)
```

