# C_ColorUtil

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **0** events · **0** types

## Functions

### C_ColorUtil.ConvertHSLToHSV

Converts an unpacked HSL color to HSV.

```lua
hsvH, hsvS, hsvV = C_ColorUtil.ConvertHSLToHSV(hslH, hslS, hslL)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hslH` | number | no |  |
| `hslS` | number | no |  |
| `hslL` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hsvH` | number | no |  |
| `hsvS` | number | no |  |
| `hsvV` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hsvH, hsvS, hsvV = C_ColorUtil.ConvertHSLToHSV(0, 0, 0)
```

### C_ColorUtil.ConvertHSVToHSL

Converts an unpacked HSV color to HSL.

```lua
hslH, hslS, hslL = C_ColorUtil.ConvertHSVToHSL(hsvH, hsvS, hsvV)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hsvH` | number | no |  |
| `hsvS` | number | no |  |
| `hsvV` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hslH` | number | no |  |
| `hslS` | number | no |  |
| `hslL` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hslH, hslS, hslL = C_ColorUtil.ConvertHSVToHSL(0, 0, 0)
```

### C_ColorUtil.ConvertHSVToRGB

Converts an unpacked HSV color to RGB.

```lua
rgbR, rgbG, rgbB = C_ColorUtil.ConvertHSVToRGB(hsvH, hsvS, hsvV)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hsvH` | number | no |  |
| `hsvS` | number | no |  |
| `hsvV` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rgbR` | number | no |  |
| `rgbG` | number | no |  |
| `rgbB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rgbR, rgbG, rgbB = C_ColorUtil.ConvertHSVToRGB(0, 0, 0)
```

### C_ColorUtil.ConvertRGBToHSV

Converts an unpacked RGB color to HSV. For achromatic inputs, the returned hue will be -1.

```lua
hsvH, hsvS, hsvV = C_ColorUtil.ConvertRGBToHSV(rgbR, rgbG, rgbB)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rgbR` | number | no |  |
| `rgbG` | number | no |  |
| `rgbB` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hsvH` | number | no |  |
| `hsvS` | number | no |  |
| `hsvV` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hsvH, hsvS, hsvV = C_ColorUtil.ConvertRGBToHSV(0, 0, 0)
```

### C_ColorUtil.GenerateTextColorCode

Generates a hex color code suitable for use in text color code markup.

```lua
textColorCode = C_ColorUtil.GenerateTextColorCode(color)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no | Color to generate a hex color code from. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textColorCode` | string | no | Hex representation of the color formatted as an 8-byte ARGB string, with alpha forced to 255. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textColorCode = C_ColorUtil.GenerateTextColorCode(color)
```

### C_ColorUtil.WrapTextInColor

Wraps a given string with color code markup.

```lua
coloredText = C_ColorUtil.WrapTextInColor(text, color)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | Text to be wrapped in color markup. |
| `color` | colorRGB | no | Color to apply to the text. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coloredText` | string | no | The input text wrapped in '\|c' and '\|r' quoted code sequences for the supplied color. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local coloredText = C_ColorUtil.WrapTextInColor("", color)
```

### C_ColorUtil.WrapTextInColorCode

Wraps a given string with color code markup.

```lua
coloredText = C_ColorUtil.WrapTextInColorCode(text, textColorCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | Text to be wrapped in color markup. |
| `textColorCode` | cstring | no | Color to apply to the text, formatted as an 8-byte ARGB string as returned by GenerateTextColorCode. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coloredText` | string | no | The input text wrapped in '\|c' and '\|r' quoted code sequences for the supplied color. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local coloredText = C_ColorUtil.WrapTextInColorCode("", "")
```

