# SimpleHTMLAPI

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**23** functions · **0** events · **0** types

## Functions

### SimpleHTMLAPI.GetContentHeight

```lua
height = GetContentHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local height = GetContentHeight()
```

### SimpleHTMLAPI.GetFont

```lua
fontFile, height, flags = GetFont(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fontFile, height, flags = GetFont(textType)
```

### SimpleHTMLAPI.GetFontObject

```lua
font = GetFontObject(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetFontObject(textType)
```

### SimpleHTMLAPI.GetHyperlinkFormat

```lua
format = GetHyperlinkFormat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `format` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local format = GetHyperlinkFormat()
```

### SimpleHTMLAPI.GetIndentedWordWrap

```lua
wordWrap = GetIndentedWordWrap(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wordWrap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wordWrap = GetIndentedWordWrap(textType)
```

### SimpleHTMLAPI.GetJustifyH

```lua
justifyH = GetJustifyH(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyH` | JustifyHorizontal | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local justifyH = GetJustifyH(textType)
```

### SimpleHTMLAPI.GetJustifyV

```lua
justifyV = GetJustifyV(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `justifyV` | JustifyVertical | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local justifyV = GetJustifyV(textType)
```

### SimpleHTMLAPI.GetShadowColor

```lua
colorR, colorG, colorB, colorA = GetShadowColor(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetShadowColor(textType)
```

### SimpleHTMLAPI.GetShadowOffset

```lua
offsetX, offsetY = GetShadowOffset(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offsetX, offsetY = GetShadowOffset(textType)
```

### SimpleHTMLAPI.GetSpacing

```lua
spacing = GetSpacing(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spacing` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spacing = GetSpacing(textType)
```

### SimpleHTMLAPI.GetTextColor

```lua
colorR, colorG, colorB, colorA = GetTextColor(textType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB, colorA = GetTextColor(textType)
```

### SimpleHTMLAPI.GetTextData

```lua
content = GetTextData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `content` | HTMLContentNode[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local content = GetTextData()
```

### SimpleHTMLAPI.SetFont

```lua
SetFont(textType, fontFile, height, flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFont(textType, "", height, flags)
```

### SimpleHTMLAPI.SetFontObject

```lua
SetFontObject(textType, font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFontObject(textType, font)
```

### SimpleHTMLAPI.SetHyperlinkFormat

```lua
SetHyperlinkFormat(format)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `format` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHyperlinkFormat("")
```

### SimpleHTMLAPI.SetIndentedWordWrap

```lua
SetIndentedWordWrap(textType, wordWrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `wordWrap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIndentedWordWrap(textType, false)
```

### SimpleHTMLAPI.SetJustifyH

```lua
SetJustifyH(textType, justifyH)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `justifyH` | JustifyHorizontal | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetJustifyH(textType, justifyH)
```

### SimpleHTMLAPI.SetJustifyV

```lua
SetJustifyV(textType, justifyV)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `justifyV` | JustifyVertical | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetJustifyV(textType, justifyV)
```

### SimpleHTMLAPI.SetShadowColor

```lua
SetShadowColor(textType, colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShadowColor(textType, 0, 0, 0)
```

### SimpleHTMLAPI.SetShadowOffset

```lua
SetShadowOffset(textType, offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShadowOffset(textType, 1, 1)
```

### SimpleHTMLAPI.SetSpacing

```lua
SetSpacing(textType, spacing)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `spacing` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetSpacing(textType, spacing)
```

### SimpleHTMLAPI.SetText

```lua
SetText(text, ignoreMarkup)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `ignoreMarkup` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetText("", false)
```

### SimpleHTMLAPI.SetTextColor

```lua
SetTextColor(textType, colorR, colorG, colorB, [a])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textType` | HTMLTextType | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetTextColor(textType, 0, 0, 0)
```

