# C_IncomingSummon

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **1** types

## Functions

### C_IncomingSummon.HasIncomingSummon

```lua
summon = C_IncomingSummon.HasIncomingSummon(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `summon` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local summon = C_IncomingSummon.HasIncomingSummon("player")
```

### C_IncomingSummon.IncomingSummonStatus

```lua
status = C_IncomingSummon.IncomingSummonStatus(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `status` | SummonStatus | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local status = C_IncomingSummon.IncomingSummonStatus("player")
```

## Types

### SummonStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | SummonStatus | no |  |
| `Pending` | SummonStatus | no |  |
| `Accepted` | SummonStatus | no |  |
| `Declined` | SummonStatus | no |  |

