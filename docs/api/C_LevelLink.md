# C_LevelLink

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

```lua
local isLocked = C_LevelLink.IsActionLocked(actionID)
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

**Example**

```lua
local isLocked = C_LevelLink.IsSpellLocked(12345)
```

