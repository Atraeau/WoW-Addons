# C_LFGListRoles

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **1** events · **0** types

## Functions

### C_LFGListRoles.GetRoles

```lua
roles = C_LFGListRoles.GetRoles()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roles` | LFGRoles | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roles = C_LFGListRoles.GetRoles()
```

### C_LFGListRoles.GetSavedRoles

```lua
roles = C_LFGListRoles.GetSavedRoles()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roles` | LFGRoles | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roles = C_LFGListRoles.GetSavedRoles()
```

### C_LFGListRoles.SetRoles

```lua
success = C_LFGListRoles.SetRoles(roles, limitToClassRoles)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roles` | LFGRoles | no |  |
| `limitToClassRoles` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_LFGListRoles.SetRoles(roles, false)
```

## Events

### LFG_LIST_ROLE_UPDATE

