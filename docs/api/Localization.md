# Localization

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **0** events · **1** types

## Functions

### Localization.AbbreviateLargeNumbers

```lua
result = AbbreviateLargeNumbers(number, [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |
| `options` | NumberAbbrevOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = AbbreviateLargeNumbers(0)
```

### Localization.AbbreviateNumbers

```lua
result = AbbreviateNumbers(number, [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `number` | number | no |  |
| `options` | NumberAbbrevOptions | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = AbbreviateNumbers(0)
```

### Localization.BreakUpLargeNumbers

```lua
result = BreakUpLargeNumbers(largeNumber, natural)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `largeNumber` | number | no |  |
| `natural` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = BreakUpLargeNumbers(0, false)
```

### Localization.CaseAccentInsensitiveParse

```lua
result = CaseAccentInsensitiveParse(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CaseAccentInsensitiveParse("")
```

### Localization.CreateAbbreviateConfig

```lua
config = CreateAbbreviateConfig(data)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | NumberAbbreviationBreakpoint[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `config` | AbbreviateConfig | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local config = CreateAbbreviateConfig(data)
```

### Localization.DeclineName

```lua
declinedNames = DeclineName(name, [gender], declensionSet, [namePartType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `gender` | UnitSex | yes |  |
| `declensionSet` | luaIndex | no |  |
| `namePartType` | NamePartType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `declinedNames` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local declinedNames = DeclineName("", 1)
```

### Localization.GetDefaultAbbreviationBreakpoints

```lua
breakpoints = GetDefaultAbbreviationBreakpoints([locale])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locale` | WowLocale | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpoints` | NumberAbbreviationBreakpoint[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local breakpoints = GetDefaultAbbreviationBreakpoints()
```

### Localization.GetNumDeclensionSets

```lua
numDeclensionSets = GetNumDeclensionSets(name, [gender], [namePartType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `gender` | UnitSex | yes |  |
| `namePartType` | NamePartType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDeclensionSets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numDeclensionSets = GetNumDeclensionSets("")
```

### Localization.IsEuropeanNumbers

```lua
enabled = IsEuropeanNumbers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = IsEuropeanNumbers()
```

### Localization.LocalizedClassList

```lua
result = LocalizedClassList(isFemale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFemale` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaValueVariant | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = LocalizedClassList(false)
```

### Localization.SetEuropeanNumbers

```lua
SetEuropeanNumbers(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetEuropeanNumbers(false)
```

## Types

### NumberAbbrevOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `breakpointData` | NumberAbbreviationBreakpoint[] | yes | Order these from largest to smallest. |
| `locale` | cstring | yes | Locale controls whether standard asian abbreviation data will be used along with a small change in behavior for large number abbreviation when fractionDivisor is greater than zero. |
| `config` | AbbreviateConfig | yes | Provides a cached config object for optimal performance when calling abbreviation functions multiple times with the same options. |

