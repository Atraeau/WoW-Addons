# Threat

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**2** functions · **0** events · **0** types

## Functions

### Threat.GetThreatStatusColor

```lua
colorR, colorG, colorB = GetThreatStatusColor(gameErrorIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameErrorIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local colorR, colorG, colorB = GetThreatStatusColor(1)
```

### Threat.IsThreatWarningEnabled

```lua
result = IsThreatWarningEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = IsThreatWarningEnabled()
```
