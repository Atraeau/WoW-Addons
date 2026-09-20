# Os

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **0** events · **0** types

## Functions

### Os.CopyToClipboard

```lua
length = CopyToClipboard(text, removeMarkup)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `removeMarkup` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `length` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local length = CopyToClipboard("", false)
```

### Os.GetTimePreciseSec

```lua
time = GetTimePreciseSec()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `time` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local time = GetTimePreciseSec()
```

