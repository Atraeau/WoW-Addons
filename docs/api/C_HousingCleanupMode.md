# C_HousingCleanupMode

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **2** events · **1** types

## Functions

### C_HousingCleanupMode.GetHoveredDecorInfo

```lua
info = C_HousingCleanupMode.GetHoveredDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingCleanupMode.GetHoveredDecorInfo()
```

### C_HousingCleanupMode.IsHoveringDecor

```lua
isHoveringDecor = C_HousingCleanupMode.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingCleanupMode.IsHoveringDecor()
```

### C_HousingCleanupMode.RemoveSelectedDecor

```lua
C_HousingCleanupMode.RemoveSelectedDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingCleanupMode.RemoveSelectedDecor()
```

## Events

### HOUSING_CLEANUP_MODE_HOVERED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasHoveredTarget` | bool | no |  |
| `targetType` | HousingCleanupModeTargetType | no |  |

### HOUSING_CLEANUP_MODE_TARGET_SELECTED

## Types

### HousingCleanupModeTargetType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HousingCleanupModeTargetType | no |  |
| `Decor` | HousingCleanupModeTargetType | no |  |
| `HouseExterior` | HousingCleanupModeTargetType | no |  |

