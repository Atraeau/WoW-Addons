# C_QuestItemUse

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **0** events · **0** types

## Functions

### C_QuestItemUse.CanUseQuestItemOnObject

```lua
canUse = C_QuestItemUse.CanUseQuestItemOnObject(item, unit, [checkRange])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `item` | ItemLocation | no |  |
| `unit` | UnitToken | no |  |
| `checkRange` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse = C_QuestItemUse.CanUseQuestItemOnObject(6948, "player")
```

