# C_AccountInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_AccountInfo.GetIDFromBattleNetAccountGUID

```lua
battleNetAccountID = C_AccountInfo.GetIDFromBattleNetAccountGUID(battleNetAccountGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battleNetAccountGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battleNetAccountID` | number | no |  |

**Example**

```lua
local battleNetAccountID = C_AccountInfo.GetIDFromBattleNetAccountGUID("Creature-0-0000-0-0-0-0")
```

### C_AccountInfo.IsGUIDBattleNetAccountType

```lua
isBNet = C_AccountInfo.IsGUIDBattleNetAccountType(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBNet` | bool | no |  |

**Example**

```lua
local isBNet = C_AccountInfo.IsGUIDBattleNetAccountType("Creature-0-0000-0-0-0-0")
```

### C_AccountInfo.IsGUIDRelatedToLocalAccount

```lua
isLocalUser = C_AccountInfo.IsGUIDRelatedToLocalAccount(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocalUser` | bool | no |  |

**Example**

```lua
local isLocalUser = C_AccountInfo.IsGUIDRelatedToLocalAccount("Creature-0-0000-0-0-0-0")
```

