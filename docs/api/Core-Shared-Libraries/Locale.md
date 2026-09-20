# Locale

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **0** events · **1** types

## Functions

### Locale.GetAvailableLocaleInfo

```lua
localeInfos = GetAvailableLocaleInfo(ignoreLocaleRestrictions)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreLocaleRestrictions` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeInfos` | LocaleInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local localeInfos = GetAvailableLocaleInfo(false)
```

### Locale.GetAvailableLocales

```lua
localeName = GetAvailableLocales(ignoreLocaleRestrictions)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreLocaleRestrictions` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local localeName = GetAvailableLocales(false)
```

### Locale.GetCurrentRegion

```lua
region = GetCurrentRegion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `region` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local region = GetCurrentRegion()
```

### Locale.GetLocale

```lua
localeName = GetLocale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local localeName = GetLocale()
```

### Locale.GetOSLocale

```lua
localeName = GetOSLocale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local localeName = GetOSLocale()
```

## Types

### LocaleInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localeId` | number | no |  |
| `localeName` | cstring | no |  |

