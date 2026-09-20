# C_NamePlateManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **7** events · **0** types

## Functions

### C_NamePlateManager.GetNamePlateHitTestInsets

Returns the values used to adjust the hit testing area for nameplates.

```lua
left, right, top, bottom = C_NamePlateManager.GetNamePlateHitTestInsets(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | NamePlateType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = C_NamePlateManager.GetNamePlateHitTestInsets(type)
```

### C_NamePlateManager.IsNamePlateUnitBehindCamera

Returns whether the unit to which the nameplate is attached is behind the player's camera.

```lua
isBehindCamera = C_NamePlateManager.IsNamePlateUnitBehindCamera(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenNamePlate | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBehindCamera` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBehindCamera = C_NamePlateManager.IsNamePlateUnitBehindCamera("player")
```

### C_NamePlateManager.SetNamePlateHitTestInsets

Provide values to adjust the hit testing area for nameplates. Positive values will decrease the hit test area, negative values will increase it. Note that all hit testing is clamped to the bounds of the nameplate and can not be moved outside it.

```lua
C_NamePlateManager.SetNamePlateHitTestInsets(type, left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | NamePlateType | no |  |
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_NamePlateManager.SetNamePlateHitTestInsets(type, left, right, top, bottom)
```

### C_NamePlateManager.SetNamePlateSimplified

Set whether the nameplate attached to a unit is considered simplified, which can change the way it's displayed.

```lua
C_NamePlateManager.SetNamePlateSimplified(unitToken, isSimplified)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenNamePlate | no |  |
| `isSimplified` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_NamePlateManager.SetNamePlateSimplified("player", false)
```

## Events

### FORBIDDEN_NAME_PLATE_CREATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `namePlateFrame` | NamePlateFrame | no |  |

### FORBIDDEN_NAME_PLATE_UNIT_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenType | no |  |

### FORBIDDEN_NAME_PLATE_UNIT_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenType | no |  |

### NAME_PLATE_CREATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `namePlateFrame` | NamePlateFrame | no |  |

### NAME_PLATE_UNIT_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenType | no |  |

### NAME_PLATE_UNIT_BEHIND_CAMERA_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `isBehindCamera` | bool | no |  |

### NAME_PLATE_UNIT_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenType | no |  |

