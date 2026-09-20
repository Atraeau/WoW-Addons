# string

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**6** functions · **0** events · **0** types

## Functions

### string.contains

Returns true if a string contains the specified literal substring.

```lua
contains = string.contains(str, substring)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to search. |
| `substring` | stringView | no | The literal substring for which to search. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contains` | bool | no | True if the string contains the specified substring; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contains = string.contains(str, substring)
```

### string.endswith

Returns true if a string ends with the specified suffix.

```lua
endsWith = string.endswith(str, suffix)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to inspect. |
| `suffix` | stringView | no | The suffix for which to search. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `endsWith` | bool | no | True if the string ends with the specified suffix; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local endsWith = string.endswith(str, suffix)
```

### string.ltrim

Returns a string with all bytes in the specified character set removed from the start.

```lua
trimmed = string.ltrim(str, characters)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to trim. |
| `characters` | stringView | no | The set of bytes to remove. (default:  \r\n\t) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trimmed` | stringView | no | The left-trimmed string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trimmed = string.ltrim(str, characters)
```

### string.rtrim

Returns a string with all bytes in the specified character set removed from the end.

```lua
trimmed = string.rtrim(str, characters)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to trim. |
| `characters` | stringView | no | The set of bytes to remove. (default:  \r\n\t) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trimmed` | stringView | no | The right-trimmed string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trimmed = string.rtrim(str, characters)
```

### string.startswith

Returns true if a string starts with the specified prefix.

```lua
startsWith = string.startswith(str, prefix)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to inspect. |
| `prefix` | stringView | no | The prefix for which to search. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startsWith` | bool | no | True if the string starts with the specified prefix; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local startsWith = string.startswith(str, prefix)
```

### string.trim

Returns a string with all bytes in the specified character set removed from both ends.

```lua
trimmed = string.trim(str, characters)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `str` | stringView | no | The string to trim. |
| `characters` | stringView | no | The set of bytes to remove. (default:  \r\n\t) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trimmed` | stringView | no | The trimmed string. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trimmed = string.trim(str, characters)
```

