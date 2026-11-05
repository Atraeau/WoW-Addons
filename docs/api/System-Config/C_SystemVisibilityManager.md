# C_SystemVisibilityManager

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 70790, interface 16001) on 2026-11-05 13:35:56.

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local visible = C_SystemVisibilityManager.IsSystemVisible(Enum.UISystemType.InGameNavigation)
```

## Events

### SYSTEM_VISIBILITY_CHANGED

## Types

### UISystemType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `InGameNavigation` | UISystemType | no |  |
