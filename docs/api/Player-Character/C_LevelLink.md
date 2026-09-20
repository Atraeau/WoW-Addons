# C_LevelLink

[← API index](../README.md) · group: [Player & Character](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **0** events · **0** types

## Functions

### C_LevelLink.IsActionLocked

```lua
isLocked = C_LevelLink.IsActionLocked(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLocked = C_LevelLink.IsActionLocked(1)
```

### C_LevelLink.IsSpellLocked

```lua
isLocked = C_LevelLink.IsSpellLocked(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLocked = C_LevelLink.IsSpellLocked(2050)
```

