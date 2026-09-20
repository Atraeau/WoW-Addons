# C_CombatText

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **1** events · **0** types

## Functions

### C_CombatText.GetActiveUnit

```lua
unitTarget = C_CombatText.GetActiveUnit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local unitTarget = C_CombatText.GetActiveUnit()
```

### C_CombatText.GetCurrentEventInfo

```lua
C_CombatText.GetCurrentEventInfo()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatText.GetCurrentEventInfo()
```

### C_CombatText.SetActiveUnit

```lua
C_CombatText.SetActiveUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CombatText.SetActiveUnit("player")
```

## Events

### COMBAT_TEXT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `combatTextType` | cstring | no |  |

