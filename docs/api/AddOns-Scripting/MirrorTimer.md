# MirrorTimer

[← API index](../README.md) · group: [AddOns & Scripting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **0** events · **1** types

## Functions

### MirrorTimer.GetMirrorTimerInfo

```lua
name, startValue, maxValue, scale, paused, label, spellID = GetMirrorTimerInfo(timerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `startValue` | number | no |  |
| `maxValue` | number | no |  |
| `scale` | number | no |  |
| `paused` | number | no |  |
| `label` | cstring | no |  |
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, startValue, maxValue, scale, paused, label, spellID = GetMirrorTimerInfo(1)
```

### MirrorTimer.GetMirrorTimerProgress

```lua
progress = GetMirrorTimerProgress(timerName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `progress` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local progress = GetMirrorTimerProgress("")
```

## Types

### MirrorTimerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `startValue` | number | no |  |
| `maxValue` | number | no |  |
| `scale` | number | no |  |
| `paused` | number | no |  |
| `label` | cstring | no |  |
| `spellID` | number | no |  |

