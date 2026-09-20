# SimpleButtonAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**42** functions · **0** events · **0** types

## Functions

### SimpleButtonAPI.ClearDisabledTexture

```lua
ClearDisabledTexture()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearDisabledTexture()
```

### SimpleButtonAPI.ClearHighlightTexture

```lua
ClearHighlightTexture()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearHighlightTexture()
```

### SimpleButtonAPI.ClearNormalTexture

```lua
ClearNormalTexture()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearNormalTexture()
```

### SimpleButtonAPI.ClearPushedTexture

```lua
ClearPushedTexture()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearPushedTexture()
```

### SimpleButtonAPI.Click

```lua
Click(button, isDown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no | (default: LeftButton) |
| `isDown` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
Click("", false)
```

### SimpleButtonAPI.Disable

```lua
Disable()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Disable()
```

### SimpleButtonAPI.Enable

```lua
Enable()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Enable()
```

### SimpleButtonAPI.GetButtonState

```lua
buttonState = GetButtonState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonState` | SimpleButtonStateToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buttonState = GetButtonState()
```

### SimpleButtonAPI.GetDisabledFontObject

```lua
font = GetDisabledFontObject()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetDisabledFontObject()
```

### SimpleButtonAPI.GetDisabledTexture

```lua
texture = GetDisabledTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = GetDisabledTexture()
```

### SimpleButtonAPI.GetFontString

```lua
fontString = GetFontString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fontString = GetFontString()
```

### SimpleButtonAPI.GetHighlightFontObject

```lua
font = GetHighlightFontObject()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetHighlightFontObject()
```

### SimpleButtonAPI.GetHighlightTexture

```lua
texture = GetHighlightTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = GetHighlightTexture()
```

### SimpleButtonAPI.GetMotionScriptsWhileDisabled

```lua
motionScriptsWhileDisabled = GetMotionScriptsWhileDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `motionScriptsWhileDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local motionScriptsWhileDisabled = GetMotionScriptsWhileDisabled()
```

### SimpleButtonAPI.GetNormalFontObject

```lua
font = GetNormalFontObject()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local font = GetNormalFontObject()
```

### SimpleButtonAPI.GetNormalTexture

```lua
texture = GetNormalTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = GetNormalTexture()
```

### SimpleButtonAPI.GetPushedTextOffset

```lua
offsetX, offsetY = GetPushedTextOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local offsetX, offsetY = GetPushedTextOffset()
```

### SimpleButtonAPI.GetPushedTexture

```lua
texture = GetPushedTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = GetPushedTexture()
```

### SimpleButtonAPI.GetText

```lua
text = GetText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local text = GetText()
```

### SimpleButtonAPI.GetTextHeight

```lua
height = GetTextHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local height = GetTextHeight()
```

### SimpleButtonAPI.GetTextWidth

```lua
width = GetTextWidth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local width = GetTextWidth()
```

### SimpleButtonAPI.IsEnabled

```lua
isEnabled = IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = IsEnabled()
```

### SimpleButtonAPI.RegisterForClicks

```lua
RegisterForClicks(buttons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttons` | ClickButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterForClicks(buttons)
```

### SimpleButtonAPI.RegisterForMouse

```lua
RegisterForMouse(buttons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttons` | ClickButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterForMouse(buttons)
```

### SimpleButtonAPI.SetButtonState

```lua
SetButtonState(buttonState, lock)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonState` | SimpleButtonStateToken | no |  |
| `lock` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetButtonState(buttonState, false)
```

### SimpleButtonAPI.SetDisabledAtlas

```lua
SetDisabledAtlas(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDisabledAtlas(atlas)
```

### SimpleButtonAPI.SetDisabledFontObject

```lua
SetDisabledFontObject(font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDisabledFontObject(font)
```

### SimpleButtonAPI.SetDisabledTexture

```lua
SetDisabledTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDisabledTexture(asset)
```

### SimpleButtonAPI.SetEnabled

```lua
SetEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEnabled(false)
```

### SimpleButtonAPI.SetFontString

```lua
SetFontString(fontString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFontString(fontString)
```

### SimpleButtonAPI.SetFormattedText

```lua
SetFormattedText(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFormattedText("")
```

### SimpleButtonAPI.SetHighlightAtlas

```lua
SetHighlightAtlas(atlas, [blendMode])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |
| `blendMode` | BlendMode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHighlightAtlas(atlas)
```

### SimpleButtonAPI.SetHighlightFontObject

```lua
SetHighlightFontObject(font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHighlightFontObject(font)
```

### SimpleButtonAPI.SetHighlightTexture

```lua
SetHighlightTexture(asset, [blendMode])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |
| `blendMode` | BlendMode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHighlightTexture(asset)
```

### SimpleButtonAPI.SetMotionScriptsWhileDisabled

```lua
SetMotionScriptsWhileDisabled(motionScriptsWhileDisabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `motionScriptsWhileDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMotionScriptsWhileDisabled(false)
```

### SimpleButtonAPI.SetNormalAtlas

```lua
SetNormalAtlas(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetNormalAtlas(atlas)
```

### SimpleButtonAPI.SetNormalFontObject

```lua
SetNormalFontObject(font)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `font` | SimpleFont | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetNormalFontObject(font)
```

### SimpleButtonAPI.SetNormalTexture

```lua
SetNormalTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetNormalTexture(asset)
```

### SimpleButtonAPI.SetPushedAtlas

```lua
SetPushedAtlas(atlas)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlas` | textureAtlas | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPushedAtlas(atlas)
```

### SimpleButtonAPI.SetPushedTextOffset

```lua
SetPushedTextOffset(offsetX, offsetY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetX` | uiUnit | no |  |
| `offsetY` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPushedTextOffset(1, 1)
```

### SimpleButtonAPI.SetPushedTexture

```lua
SetPushedTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPushedTexture(asset)
```

### SimpleButtonAPI.SetText

```lua
SetText(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetText("")
```

