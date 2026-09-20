# Totem

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **0** events · **1** types

## Functions

### Totem.DestroyTotem

```lua
DestroyTotem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
DestroyTotem(1)
```

### Totem.GetNumTotemSlots

```lua
numSlots = GetNumTotemSlots()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSlots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSlots = GetNumTotemSlots()
```

### Totem.GetTotemCannotDismiss

```lua
cannotDismiss = GetTotemCannotDismiss(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cannotDismiss` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cannotDismiss = GetTotemCannotDismiss(1)
```

### Totem.GetTotemDuration

```lua
duration = GetTotemDuration(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = GetTotemDuration(1)
```

### Totem.GetTotemInfo

```lua
haveTotem, totemName, startTime, duration, icon, modRate, spellID = GetTotemInfo(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `haveTotem` | bool | no |  |
| `totemName` | cstring | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `icon` | fileID | no |  |
| `modRate` | number | no |  |
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local haveTotem, totemName, startTime, duration, icon, modRate, spellID = GetTotemInfo(1)
```

### Totem.GetTotemTimeLeft

```lua
timeLeft = GetTotemTimeLeft(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeft` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeLeft = GetTotemTimeLeft(1)
```

### Totem.TargetTotem

```lua
TargetTotem(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
TargetTotem(1)
```

## Types

### TotemInfoScript (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `haveTotem` | bool | no |  |
| `totemName` | cstring | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `icon` | fileID | no |  |
| `modRate` | number | no |  |
| `spellID` | number | no |  |

