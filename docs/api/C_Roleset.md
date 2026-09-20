# C_Roleset

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### C_Roleset.ApplyRolesetFilters

Sets or clears both blocklist and allowlist filters atomically with a single visibility reevaluation. Pass an empty table to clear the corresponding filter.

```lua
C_Roleset.ApplyRolesetFilters(blockedRolesets, allowedRolesets)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blockedRolesets` | string[] | no |  |
| `allowedRolesets` | string[] | no |  |

**Example**

```lua
C_Roleset.ApplyRolesetFilters(blockedRolesets, allowedRolesets)
```

### C_Roleset.GetActiveAllowedRolesets

Returns the rolesets in the currently active allowlist.

```lua
allowedRolesets = C_Roleset.GetActiveAllowedRolesets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowedRolesets` | string[] | no |  |

**Example**

```lua
local allowedRolesets = C_Roleset.GetActiveAllowedRolesets()
```

### C_Roleset.GetActiveBlockedRolesets

Returns the rolesets in the currently active blocklist.

```lua
blockedRolesets = C_Roleset.GetActiveBlockedRolesets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blockedRolesets` | string[] | no |  |

**Example**

```lua
local blockedRolesets = C_Roleset.GetActiveBlockedRolesets()
```

