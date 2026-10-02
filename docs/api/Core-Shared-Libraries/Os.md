# Os

[← API index](../README.md) · group: [Core & Shared Libraries](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

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
