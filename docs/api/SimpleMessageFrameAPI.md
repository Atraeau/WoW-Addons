# SimpleMessageFrameAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**33** functions · **0** events · **0** types

## Functions

### SimpleMessageFrameAPI.AddMessage

```lua
AddMessage(text, colorR, colorG, colorB, [a], [messageID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `a` | SingleColorValue | yes |  |
| `messageID` | number | yes |  |

**Example**

```lua
AddMessage("", 0, 0, 0)
```

### SimpleMessageFrameAPI.Clear

```lua
Clear()
```

**Example**

```lua
Clear()
```

### SimpleMessageFrameAPI.GetFadeDuration

```lua
fadeDurationSeconds = GetFadeDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fadeDurationSeconds` | number | no |  |

**Example**

```lua
local fadeDurationSeconds = GetFadeDuration()
```

### SimpleMessageFrameAPI.GetFadePower

```lua
fadePower = GetFadePower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fadePower` | number | no |  |

**Example**

```lua
local fadePower = GetFadePower()
```

### SimpleMessageFrameAPI.GetFading

```lua
isFading = GetFading()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFading` | bool | no |  |

**Example**

```lua
local isFading = GetFading()
```

### SimpleMessageFrameAPI.GetFont

```lua
fontFile, height, flags = GetFont()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example**

```lua
local fontFile, height, flags = GetFont()
```

### SimpleMessageFrameAPI.GetFontObject

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

### SimpleMessageFrameAPI.GetFontStringByID

```lua
fontString = GetFontStringByID(messageID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontString` | SimpleFontString | no |  |

**Example**

```lua
local fontString = GetFontStringByID(0)
```

### SimpleMessageFrameAPI.GetIndentedWordWrap

```lua
wordWrap = GetIndentedWordWrap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wordWrap` | bool | no |  |

**Example**

```lua
local wordWrap = GetIndentedWordWrap()
```

### SimpleMessageFrameAPI.GetInsertMode

```lua
mode = GetInsertMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mode` | InsertMode | no |  |

**Example**

```lua
local mode = GetInsertMode()
```

### SimpleMessageFrameAPI.GetJustifyH

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

### SimpleMessageFrameAPI.GetJustifyV

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

### SimpleMessageFrameAPI.GetShadowColor

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

### SimpleMessageFrameAPI.GetShadowOffset

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

### SimpleMessageFrameAPI.GetSpacing

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

### SimpleMessageFrameAPI.GetTextColor

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

### SimpleMessageFrameAPI.GetTimeVisible

```lua
timeVisibleSeconds = GetTimeVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeVisibleSeconds` | number | no |  |

**Example**

```lua
local timeVisibleSeconds = GetTimeVisible()
```

### SimpleMessageFrameAPI.HasMessageByID

```lua
hasMessage = HasMessageByID(messageID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMessage` | bool | no |  |

**Example**

```lua
local hasMessage = HasMessageByID(0)
```

### SimpleMessageFrameAPI.ResetMessageFadeByID

```lua
ResetMessageFadeByID(messageID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `messageID` | number | no |  |

**Example**

```lua
ResetMessageFadeByID(0)
```

### SimpleMessageFrameAPI.SetFadeDuration

```lua
SetFadeDuration(fadeDurationSeconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fadeDurationSeconds` | number | no |  |

**Example**

```lua
SetFadeDuration(0)
```

### SimpleMessageFrameAPI.SetFadePower

```lua
SetFadePower(fadePower)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fadePower` | number | no |  |

**Example**

```lua
SetFadePower(0)
```

### SimpleMessageFrameAPI.SetFading

```lua
SetFading(fading)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fading` | bool | no |  |

**Example**

```lua
SetFading(false)
```

### SimpleMessageFrameAPI.SetFont

```lua
SetFont(fontFile, height, flags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFile` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

**Example**

```lua
SetFont("", height, flags)
```

### SimpleMessageFrameAPI.SetFontObject

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

### SimpleMessageFrameAPI.SetIndentedWordWrap

```lua
SetIndentedWordWrap(wordWrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wordWrap` | bool | no |  |

**Example**

```lua
SetIndentedWordWrap(false)
```

### SimpleMessageFrameAPI.SetInsertMode

```lua
SetInsertMode(mode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mode` | InsertMode | no |  |

**Example**

```lua
SetInsertMode(mode)
```

### SimpleMessageFrameAPI.SetJustifyH

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

### SimpleMessageFrameAPI.SetJustifyV

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

### SimpleMessageFrameAPI.SetShadowColor

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

### SimpleMessageFrameAPI.SetShadowOffset

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

### SimpleMessageFrameAPI.SetSpacing

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

### SimpleMessageFrameAPI.SetTextColor

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

### SimpleMessageFrameAPI.SetTimeVisible

```lua
SetTimeVisible(timeVisibleSeconds)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeVisibleSeconds` | number | no |  |

**Example**

```lua
SetTimeVisible(0)
```

