# C_SystemVisibilityManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **1** events · **1** types

## Functions

### C_SystemVisibilityManager.IsSystemVisible

```lua
visible = C_SystemVisibilityManager.IsSystemVisible(system)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `system` | UISystemType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `visible` | bool | no |  |

**Example**

```lua
local visible = C_SystemVisibilityManager.IsSystemVisible(system)
```

## Events

### SYSTEM_VISIBILITY_CHANGED

## Types

### UISystemType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `InGameNavigation` | UISystemType | no |  |

