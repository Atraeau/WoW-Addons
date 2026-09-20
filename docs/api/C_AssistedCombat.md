# C_AssistedCombat

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **1** events · **0** types

## Functions

### C_AssistedCombat.GetActionSpell

```lua
spellID = C_AssistedCombat.GetActionSpell()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |

**Example**

```lua
local spellID = C_AssistedCombat.GetActionSpell()
```

### C_AssistedCombat.GetNextCastSpell

```lua
spellID = C_AssistedCombat.GetNextCastSpell(checkForVisibleButton)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checkForVisibleButton` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |

**Example**

```lua
local spellID = C_AssistedCombat.GetNextCastSpell(false)
```

### C_AssistedCombat.GetRotationSpells

```lua
spellIDs = C_AssistedCombat.GetRotationSpells()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example**

```lua
local spellIDs = C_AssistedCombat.GetRotationSpells()
```

### C_AssistedCombat.IsAvailable

```lua
isAvailable, failureReason = C_AssistedCombat.IsAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |
| `failureReason` | string | no |  |

**Example**

```lua
local isAvailable, failureReason = C_AssistedCombat.IsAvailable()
```

## Events

### ASSISTED_COMBAT_ACTION_SPELL_CAST

