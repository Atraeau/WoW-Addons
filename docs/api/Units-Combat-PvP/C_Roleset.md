# C_Roleset

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local blockedRolesets = C_Roleset.GetActiveBlockedRolesets()
```

