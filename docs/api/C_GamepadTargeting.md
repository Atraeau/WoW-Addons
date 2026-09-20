# C_GamepadTargeting

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **1** types

## Functions

### C_GamepadTargeting.Disable

```lua
targetAlreadySelected = C_GamepadTargeting.Disable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetAlreadySelected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local targetAlreadySelected = C_GamepadTargeting.Disable()
```

### C_GamepadTargeting.Enable

```lua
C_GamepadTargeting.Enable()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamepadTargeting.Enable()
```

### C_GamepadTargeting.HasReticleHoverTarget

```lua
hasReticleHoverTarget = C_GamepadTargeting.HasReticleHoverTarget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasReticleHoverTarget` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasReticleHoverTarget = C_GamepadTargeting.HasReticleHoverTarget()
```

### C_GamepadTargeting.SetFilter

```lua
C_GamepadTargeting.SetFilter(filter)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filter` | GamepadTargetingFilters | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamepadTargeting.SetFilter("HELPFUL")
```

## Types

### GamepadTargetingFilters (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hostile` | GamepadTargetingFilters | no |  |
| `Friendly` | GamepadTargetingFilters | no |  |
| `All` | GamepadTargetingFilters | no |  |

