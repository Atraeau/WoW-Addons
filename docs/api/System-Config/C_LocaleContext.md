# C_LocaleContext

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**22** functions · **0** events · **0** types

## Functions

### C_LocaleContext.CompareStrings

Compares two UTF-8 strings using the options specified on a collator.

```lua
result = C_LocaleContext.CompareStrings(left, right, strength)
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
local result = C_LocaleContext.CompareStrings("", "", strength)
```

### C_LocaleContext.FindBreaks

Opens a break iterator for locating text boundaries in the context locale.

```lua
byteOffsets = C_LocaleContext.FindBreaks(text, breakType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no | The UTF-8 text whose boundary offsets are requested. |
| `breakType` | BreakType | no | The break iterator kind to use for boundary analysis. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `byteOffsets` | number[] | no | The native UTF-8 string indices for the text boundaries. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local byteOffsets = C_LocaleContext.FindBreaks("", breakType)
```

### C_LocaleContext.FindStringMatches

Creates a string search iterator using a collator and returns every match position.

```lua
byteOffsets = C_LocaleContext.FindStringMatches(text, pattern, strength)
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
| `byteOffsets` | number[] | no | The UTF-8 byte offsets of matches in the text. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local byteOffsets = C_LocaleContext.FindStringMatches("", "", strength)
```

### C_LocaleContext.FoldCase

Case-folds the characters in a string; case-folding is locale-independent and not context-sensitive.

```lua
result = C_LocaleContext.FoldCase(text)
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
local result = C_LocaleContext.FoldCase("")
```

### C_LocaleContext.FormatCurrency

Formats a double as a localized currency value using the provided ISO 4217 currency code.

```lua
result = C_LocaleContext.FormatCurrency(number, currencyCode)
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
local result = C_LocaleContext.FormatCurrency(0, "")
```

### C_LocaleContext.FormatDate

Formats Unix time as localized date text using locale date patterns, symbols, style, and optional time zone.

```lua
result = C_LocaleContext.FormatDate(unixTimeSeconds, style, timeZone)
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
local result = C_LocaleContext.FormatDate(0, style, "")
```

### C_LocaleContext.FormatDateTime

Formats Unix time as localized date and time text using locale patterns, symbols, styles, and optional time zone.

```lua
result = C_LocaleContext.FormatDateTime(unixTimeSeconds, dateStyle, timeStyle, timeZone)
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
local result = C_LocaleContext.FormatDateTime(0, dateStyle, timeStyle, "")
```

### C_LocaleContext.FormatNumber

Formats a double with locale number formatting using locale symbols, grouping, and the selected non-currency style.

```lua
result = C_LocaleContext.FormatNumber(number, style)
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
local result = C_LocaleContext.FormatNumber(0, style)
```

### C_LocaleContext.FormatTime

Formats Unix time as localized time text using locale time patterns, symbols, style, and optional time zone.

```lua
result = C_LocaleContext.FormatTime(unixTimeSeconds, style, timeZone)
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
local result = C_LocaleContext.FormatTime(0, style, "")
```

### C_LocaleContext.GetCurrencyName

Returns the display name for a currency in the context locale.

```lua
result = C_LocaleContext.GetCurrencyName(currencyCode, style)
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
local result = C_LocaleContext.GetCurrencyName("", style)
```

### C_LocaleContext.GetDisplayName

Gets a display name suitable for the specified locale.

```lua
result = C_LocaleContext.GetDisplayName(displayLocale)
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
local result = C_LocaleContext.GetDisplayName("")
```

### C_LocaleContext.GetLocale

Gets the locale used by this locale context.

```lua
result = C_LocaleContext.GetLocale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no | The locale ID of this locale context. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_LocaleContext.GetLocale()
```

### C_LocaleContext.GetSortKey

Transforms a string into a collation sort key.

```lua
result = C_LocaleContext.GetSortKey(text, strength)
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
local result = C_LocaleContext.GetSortKey("", strength)
```

### C_LocaleContext.Length

Counts character break boundaries in UTF-8 text.

```lua
result = C_LocaleContext.Length(text)
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
local result = C_LocaleContext.Length("")
```

### C_LocaleContext.ParseCurrency

Parses an entire localized currency string into a double amount and ISO 4217 currency code.

```lua
result = C_LocaleContext.ParseCurrency(text)
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
local result = C_LocaleContext.ParseCurrency("")
```

### C_LocaleContext.ParseNumber

Parses an entire localized number string into a double using the selected non-currency number formatter.

```lua
result = C_LocaleContext.ParseNumber(text, style)
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
local result = C_LocaleContext.ParseNumber("", style)
```

### C_LocaleContext.SelectPlural

Returns the keyword of the first plural rule that applies to a number.

```lua
result = C_LocaleContext.SelectPlural(number, pluralType)
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
local result = C_LocaleContext.SelectPlural(0, pluralType)
```

### C_LocaleContext.SetLocale

Sets the locale used by this locale context.

```lua
success = C_LocaleContext.SetLocale(locale)
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
local success = C_LocaleContext.SetLocale("")
```

### C_LocaleContext.ToLower

Lowercases the characters in a string; casing is locale-dependent and context-sensitive.

```lua
result = C_LocaleContext.ToLower(text)
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
local result = C_LocaleContext.ToLower("")
```

### C_LocaleContext.ToTitle

Titlecases a string using titlecase positions determined by the default Unicode algorithm.

```lua
result = C_LocaleContext.ToTitle(text)
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
local result = C_LocaleContext.ToTitle("")
```

### C_LocaleContext.ToUpper

Uppercases the characters in a string; casing is locale-dependent and context-sensitive.

```lua
result = C_LocaleContext.ToUpper(text)
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
local result = C_LocaleContext.ToUpper("")
```

### C_LocaleContext.TransformLocale

Applies a locale transform to the context locale and returns the transformed locale string.

```lua
result = C_LocaleContext.TransformLocale(transform)
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
local result = C_LocaleContext.TransformLocale(transform)
```

