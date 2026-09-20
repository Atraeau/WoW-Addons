# C_AccountInfo

[← API index](../README.md) · group: [Store, Account & Services](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local battleNetAccountID = C_AccountInfo.GetIDFromBattleNetAccountGUID(UnitGUID("player"))
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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBNet = C_AccountInfo.IsGUIDBattleNetAccountType(UnitGUID("player"))
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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLocalUser = C_AccountInfo.IsGUIDRelatedToLocalAccount(UnitGUID("player"))
```

