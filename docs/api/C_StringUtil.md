# C_StringUtil

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**14** functions · **0** events · **1** types

## Functions

### C_StringUtil.CreateAbbreviatedNumberFormatter

Creates a numeric formatter that converts numbers to abbreviated strings, eg. 123456 -> '123k'.

```lua
formatter = C_StringUtil.CreateAbbreviatedNumberFormatter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | AbbreviatedNumberFormatter | no |  |

**Example**

```lua
local formatter = C_StringUtil.CreateAbbreviatedNumberFormatter()
```

### C_StringUtil.CreateNumericRuleFormatter

Creates a numeric formatter that converts numbers to strings with flexible rulesets.

```lua
formatter = C_StringUtil.CreateNumericRuleFormatter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | NumericRuleFormatter | no |  |

**Example**

```lua
local formatter = C_StringUtil.CreateNumericRuleFormatter()
```

### C_StringUtil.CreateSecondsFormatter

Creates a numeric formatter that converts numbers measuring durations in seconds to strings, eg. 93 -> '1m 33s'.

```lua
formatter = C_StringUtil.CreateSecondsFormatter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `formatter` | SecondsFormatter | no |  |

**Example**

```lua
local formatter = C_StringUtil.CreateSecondsFormatter()
```

### C_StringUtil.EscapeDecimalNonPrintables

Returns a string with ASCII control characters (except  , , and 	) and invalid UTF-8 bytes replaced by decimal escape sequences (e.g. \127).

```lua
escapedText = C_StringUtil.EscapeDecimalNonPrintables(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `escapedText` | string | no |  |

**Example**

```lua
local escapedText = C_StringUtil.EscapeDecimalNonPrintables(text)
```

### C_StringUtil.EscapeLuaFormatString

Returns a string with Lua format string tokens ('%') escaped.

```lua
escapedText = C_StringUtil.EscapeLuaFormatString(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `escapedText` | stringView | no |  |

**Example**

```lua
local escapedText = C_StringUtil.EscapeLuaFormatString("")
```

### C_StringUtil.EscapeLuaPatterns

Returns a string with all Lua pattern characters escaped.

```lua
escapedText = C_StringUtil.EscapeLuaPatterns(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | stringView | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `escapedText` | string | no |  |

**Example**

```lua
local escapedText = C_StringUtil.EscapeLuaPatterns(text)
```

### C_StringUtil.EscapeQuotedCodes

Returns a string with all quoted code sequences ('\|' characters) escaped.

```lua
escaped = C_StringUtil.EscapeQuotedCodes(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `escaped` | stringView | no |  |

**Example**

```lua
local escaped = C_StringUtil.EscapeQuotedCodes("")
```

### C_StringUtil.FloorToNearestString

```lua
text = C_StringUtil.FloorToNearestString(number)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_StringUtil.FloorToNearestString(0)
```

### C_StringUtil.RemoveContiguousSpaces

Returns a string with all contiguous occurrences of ASCII space characters truncated.

```lua
trimmedText = C_StringUtil.RemoveContiguousSpaces(text, maxAllowedSpaces)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | stringView | no |  |
| `maxAllowedSpaces` | number | no | Maximum number of permitted contiguous space characters; excessive spaces will be truncated to this count. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trimmedText` | string | no |  |

**Example**

```lua
local trimmedText = C_StringUtil.RemoveContiguousSpaces(text, 0)
```

### C_StringUtil.RoundToNearestString

```lua
text = C_StringUtil.RoundToNearestString(number)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_StringUtil.RoundToNearestString(0)
```

### C_StringUtil.StripHyperlinks

```lua
stripped = C_StringUtil.StripHyperlinks(text, maintainColor, maintainBrackets, stripNewlines, maintainAtlases, maintainTextures)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `maintainColor` | bool | no | If true, preserve all '\|c' and '\|r' quoted code sequences. (default: False) |
| `maintainBrackets` | bool | no | If true, preserve all '[' and ']' characters. (default: False) |
| `stripNewlines` | bool | no | If true, remove all '\|n' quoted code sequences. (default: False) |
| `maintainAtlases` | bool | no | If true, preserve all balanced '\|A' and '\|a' quoted code sequences. (default: False) |
| `maintainTextures` | bool | no | If true, preserve all balanced '\|T' and '\|t' quoted code sequences. (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stripped` | stringView | no |  |

**Example**

```lua
local stripped = C_StringUtil.StripHyperlinks("", false, false, false, false, false)
```

### C_StringUtil.StripTextureMarkupForLooseFiles

```lua
stripped = C_StringUtil.StripTextureMarkupForLooseFiles(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stripped` | stringView | no |  |

**Example**

```lua
local stripped = C_StringUtil.StripTextureMarkupForLooseFiles("")
```

### C_StringUtil.TruncateWhenZero

Formats the given number to a string as an integer (rounding down). If the integer is zero, returns an empty string.

```lua
text = C_StringUtil.TruncateWhenZero(number)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_StringUtil.TruncateWhenZero(0)
```

### C_StringUtil.WrapString

Returns a string with 'prefix' and 'suffix' joined to 'infix' iif 'infix' is not an empty string. Else, an empty string is returned.

```lua
text = C_StringUtil.WrapString(infix, [prefix], [suffix])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infix` | stringView | no |  |
| `prefix` | stringView | yes |  |
| `suffix` | stringView | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_StringUtil.WrapString(infix)
```

## Types

### StripHyperlinkOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maintainColor` | bool | no | If true, preserve all '\|c' and '\|r' quoted code sequences. (default: False) |
| `maintainBrackets` | bool | no | If true, preserve all '[' and ']' characters. (default: False) |
| `stripNewlines` | bool | no | If true, remove all '\|n' quoted code sequences. (default: False) |
| `maintainAtlases` | bool | no | If true, preserve all balanced '\|A' and '\|a' quoted code sequences. (default: False) |
| `maintainTextures` | bool | no | If true, preserve all balanced '\|T' and '\|t' quoted code sequences. (default: False) |

