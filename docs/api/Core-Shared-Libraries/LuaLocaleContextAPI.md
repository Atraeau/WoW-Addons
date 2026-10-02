# LuaLocaleContextAPI

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**22** functions · **0** events · **0** types

## Functions

### LuaLocaleContextAPI.CompareStrings

Compares two UTF-8 strings using the options specified on a collator.

```lua
result = CompareStrings(left, right, strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | cstring | no | The first UTF-8 string passed to collation comparison. |
| `right` | cstring | no | The second UTF-8 string passed to collation comparison. |
| `strength` | CollationStrength | no | The comparison level used by the collator for ordering and equality. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no | The comparison result: less than, equal to, or greater than zero. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CompareStrings("", "", strength)
```

### LuaLocaleContextAPI.FindBreaks

Opens a break iterator for locating text boundaries in the context locale.

```lua
byteOffsets = FindBreaks(text, breakType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text whose boundary offsets are requested. |
| `breakType` | BreakType | no | The break iterator kind to use for boundary analysis. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `byteOffsets` | luaIndex[] | no | The native UTF-8 string indices for the text boundaries (returned with 1-based indexes for lua convenience). |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local byteOffsets = FindBreaks("", breakType)
```

### LuaLocaleContextAPI.FindStringMatches

Creates a string search iterator using a collator and returns every match position.

```lua
byteOffsets = FindStringMatches(text, pattern, strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text scanned by the string search iterator. |
| `pattern` | cstring | no | The UTF-8 pattern whose collation-aware matches are returned. |
| `strength` | CollationStrength | no | The comparison level used by the collator while searching for matches. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `byteOffsets` | luaIndex[] | no | The UTF-8 byte offsets of matches in the text (returned with 1-based indexes for lua convenience). |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local byteOffsets = FindStringMatches("", "", strength)
```

### LuaLocaleContextAPI.FoldCase

Case-folds the characters in a string; case-folding is locale-independent and not context-sensitive.

```lua
result = FoldCase(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text converted with locale-independent case folding. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The case-folded string, which may be longer or shorter than the original. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FoldCase("")
```

### LuaLocaleContextAPI.FormatCurrency

Formats a double as a localized currency value using the provided ISO 4217 currency code.

```lua
result = FormatCurrency(number, currencyCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no | The double value formatted by the locale currency formatter. |
| `currencyCode` | cstring | no | The 3-letter null-terminated ISO 4217 currency code for currency formatting. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The localized currency text produced by the formatter. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FormatCurrency(0, "")
```

### LuaLocaleContextAPI.FormatDate

Formats Unix time as localized date text using locale date patterns, symbols, style, and optional time zone.

```lua
result = FormatDate(unixTimeSeconds, style, timeZone)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unixTimeSeconds` | number | no | The date as seconds since the Unix epoch; this API converts it to milliseconds. |
| `style` | DateTimeStyle | no | The date format length; None omits the date portion. |
| `timeZone` | cstring | no | The time zone ID applied to the formatter; empty strings keep the formatter default. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The formatted date string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FormatDate(0, style, "")
```

### LuaLocaleContextAPI.FormatDateTime

Formats Unix time as localized date and time text using locale patterns, symbols, styles, and optional time zone.

```lua
result = FormatDateTime(unixTimeSeconds, dateStyle, timeStyle, timeZone)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unixTimeSeconds` | number | no | The date and time as seconds since the Unix epoch; this API converts it to milliseconds. |
| `dateStyle` | DateTimeStyle | no | The date format length; None omits the date portion. |
| `timeStyle` | DateTimeStyle | no | The time format length; None omits the time portion. |
| `timeZone` | cstring | no | The time zone ID applied to the formatter; empty strings keep the formatter default. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The formatted date and time string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FormatDateTime(0, dateStyle, timeStyle, "")
```

### LuaLocaleContextAPI.FormatNumber

Formats a double with locale number formatting using locale symbols, grouping, and the selected non-currency style.

```lua
result = FormatNumber(number, style)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no | The double value formatted according to the selected number formatter. |
| `style` | NumberStyle | no | The number style to format with; Currency is not accepted here, use FormatCurrency instead. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The localized number text produced by the formatter. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FormatNumber(0, style)
```

### LuaLocaleContextAPI.FormatTime

Formats Unix time as localized time text using locale time patterns, symbols, style, and optional time zone.

```lua
result = FormatTime(unixTimeSeconds, style, timeZone)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unixTimeSeconds` | number | no | The time as seconds since the Unix epoch; this API converts it to milliseconds. |
| `style` | DateTimeStyle | no | The time format length; None omits the time portion. |
| `timeZone` | cstring | no | The time zone ID applied to the formatter; empty strings keep the formatter default. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The formatted time string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = FormatTime(0, style, "")
```

### LuaLocaleContextAPI.GetCurrencyName

Returns the display name for a currency in the context locale.

```lua
result = GetCurrencyName(currencyCode, style)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyCode` | cstring | no | The null-terminated 3-letter ISO 4217 currency code. |
| `style` | CurrencyNameStyle | no | The selector for which kind of currency name to return. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The display string for the currency, or the currency code itself if no localized name is available. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetCurrencyName("", style)
```

### LuaLocaleContextAPI.GetDisplayName

Gets a display name suitable for the specified locale.

```lua
result = GetDisplayName(displayLocale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayLocale` | cstring | no | The locale whose language conventions are used for the display name |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The displayable name for the locale. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetDisplayName("")
```

### LuaLocaleContextAPI.GetLocale

Gets the locale used by this locale context.

```lua
result = GetLocale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The locale ID of this locale context. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetLocale()
```

### LuaLocaleContextAPI.GetSortKey

Transforms a string into a collation sort key.

```lua
result = GetSortKey(text, strength)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text converted into collation sort-key bytes. |
| `strength` | CollationStrength | no | The comparison level used by the collator; lower strengths ignore later-level differences. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The sort key bytes excluding the terminating zero byte. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetSortKey("", strength)
```

### LuaLocaleContextAPI.Length

Counts character break boundaries in UTF-8 text.

```lua
result = Length(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text counted by character break iteration. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no | The number of character boundaries minus the initial boundary. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = Length("")
```

### LuaLocaleContextAPI.ParseCurrency

Parses an entire localized currency string into a double amount and ISO 4217 currency code.

```lua
result = ParseCurrency(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The localized currency text to parse for both amount and ISO 4217 code. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | CurrencyParseResult | no | The numeric amount and ISO 4217 currency code parsed from the localized currency text. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ParseCurrency("")
```

### LuaLocaleContextAPI.ParseNumber

Parses an entire localized number string into a double using the selected non-currency number formatter.

```lua
result = ParseNumber(text, style)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The localized numeric text to parse with the selected style. |
| `style` | NumberStyle | no | The number style to parse with; Currency is not accepted here, use ParseCurrency instead. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no | The numeric value parsed from the localized number text. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ParseNumber("", style)
```

### LuaLocaleContextAPI.SelectPlural

Returns the keyword of the first plural rule that applies to a number.

```lua
result = SelectPlural(number, pluralType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no | The number for which the plural rule has to be determined. |
| `pluralType` | PluralType | no | The plural rule type, cardinal or ordinal. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The plural keyword for the rule that applies to the number. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = SelectPlural(0, pluralType)
```

### LuaLocaleContextAPI.SetLocale

Sets the locale used by this locale context.

```lua
success = SetLocale(locale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locale` | cstring | no | The locale ID used by subsequent locale context calls. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no | True if the locale was updated. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = SetLocale("")
```

### LuaLocaleContextAPI.ToLower

Lowercases the characters in a string; casing is locale-dependent and context-sensitive.

```lua
result = ToLower(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text whose characters are lowercased. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The lowercased string, which may be longer or shorter than the original. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ToLower("")
```

### LuaLocaleContextAPI.ToTitle

Titlecases a string using titlecase positions determined by the default Unicode algorithm.

```lua
result = ToTitle(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text whose titlecase positions are mapped. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The titlecased string, which may be longer or shorter than the original. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ToTitle("")
```

### LuaLocaleContextAPI.ToUpper

Uppercases the characters in a string; casing is locale-dependent and context-sensitive.

```lua
result = ToUpper(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text whose characters are uppercased. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The uppercased string, which may be longer or shorter than the original. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = ToUpper("")
```

### LuaLocaleContextAPI.TransformLocale

Applies a locale transform to the context locale and returns the transformed locale string.

```lua
result = TransformLocale(transform)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transform` | LocaleTransform | no | The locale transform to apply. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The transformed locale string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = TransformLocale(transform)
```

