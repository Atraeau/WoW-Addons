# Font

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **3** types

## Functions

### Font.CreateFontFamily

```lua
fontFamily = CreateFontFamily(name, members)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `members` | CreateFontFamilyMemberInfo[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontFamily` | SimpleFont | no |  |

**Example**

```lua
local fontFamily = CreateFontFamily("", members)
```

### Font.GetFontInfo

```lua
info = GetFontInfo(fontObject)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontObject` | SimpleFont | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | FontScriptInfo | yes |  |

**Example**

```lua
local info = GetFontInfo(fontObject)
```

### Font.GetFonts

```lua
fontNames = GetFonts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fontNames` | cstring[] | no |  |

**Example**

```lua
local fontNames = GetFonts()
```

## Types

### CreateFontFamilyMemberInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alphabet` | FontAlphabet | no |  |
| `file` | cstring | no |  |
| `height` | uiFontHeight | no |  |
| `flags` | TBFFlags | no |  |

### FontScriptInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |
| `height` | number | no |  |
| `outline` | string | no |  |
| `shadow` | FontScriptShadowInfo | yes |  |
| `fontObject` | SimpleFont | no |  |
| `canBeUserScaled` | bool | no |  |

### FontScriptShadowInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGBA | no |  |
| `x` | number | no |  |
| `y` | number | no |  |

