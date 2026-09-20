# UnitRole

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**6** functions · **2** events · **0** types

## Functions

### UnitRole.AreClassRolesSoftSuggestions

If true, UnitGetAvailableRoles results should be treated as suggested role, not hard limits on what role the current player can display as.

```lua
result = AreClassRolesSoftSuggestions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = AreClassRolesSoftSuggestions()
```

### UnitRole.CanShowSetRoleButton

```lua
result = CanShowSetRoleButton()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CanShowSetRoleButton()
```

### UnitRole.InitiateRolePoll

```lua
result = InitiateRolePoll()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = InitiateRolePoll()
```

### UnitRole.UnitGetAvailableRoles

```lua
tank, healer, dps = UnitGetAvailableRoles(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tank` | bool | no |  |
| `healer` | bool | no |  |
| `dps` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tank, healer, dps = UnitGetAvailableRoles("player")
```

### UnitRole.UnitSetRole

```lua
result = UnitSetRole(unit, [roleStr])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `roleStr` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = UnitSetRole("player")
```

### UnitRole.UnitSetRoleEnum

```lua
result = UnitSetRoleEnum(unit, [role])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `role` | LFGRole | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = UnitSetRoleEnum("player")
```

## Events

### ROLE_CHANGED_INFORM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `changedName` | cstring | no |  |
| `fromName` | cstring | no |  |
| `oldRole` | cstring | no |  |
| `newRole` | cstring | no |  |

### ROLE_POLL_BEGIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fromName` | cstring | no |  |

