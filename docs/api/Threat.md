# Threat

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

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

**Example**

```lua
local result = IsThreatWarningEnabled()
```

