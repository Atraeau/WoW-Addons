# FrameAPITooltip

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**9** functions · **0** events · **0** types

## Functions

### FrameAPITooltip.AddFontStrings

```lua
AddFontStrings(leftFontString, rightFontString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `leftFontString` | SimpleFontString | no |  |
| `rightFontString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddFontStrings(leftFontString, rightFontString)
```

### FrameAPITooltip.ClearPadding

Set all padding values to 0.0 and remove the Padding SecretAspect.

```lua
ClearPadding()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearPadding()
```

### FrameAPITooltip.GetLeftLine

```lua
leftFontString = GetLeftLine(line)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `line` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `leftFontString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local leftFontString = GetLeftLine(1)
```

### FrameAPITooltip.GetMinimumWidth

```lua
width, forced = GetMinimumWidth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | number | no |  |
| `forced` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local width, forced = GetMinimumWidth()
```

### FrameAPITooltip.GetPadding

```lua
right, bottom, left, top = GetPadding()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `right` | number | no |  |
| `bottom` | number | no |  |
| `left` | number | no |  |
| `top` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local right, bottom, left, top = GetPadding()
```

### FrameAPITooltip.GetRightLine

```lua
rightFontString = GetRightLine(line)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `line` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rightFontString` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rightFontString = GetRightLine(1)
```

### FrameAPITooltip.SetMinimumWidth

```lua
SetMinimumWidth(width, force)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | number | no |  |
| `force` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMinimumWidth(0, false)
```

### FrameAPITooltip.SetPadding

```lua
SetPadding(right, bottom, [left], [top])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `right` | number | no |  |
| `bottom` | number | no |  |
| `left` | number | yes |  |
| `top` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPadding(0, 0)
```

### FrameAPITooltip.SetText

```lua
SetText(text, colorR, colorG, colorB, alpha, wrap)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `alpha` | number | no | (default: 1) |
| `wrap` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetText("", 0, 0, 0, 0, false)
```

