# C_HousingExpertMode

[← API index](../README.md) · group: [Housing](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**18** functions · **6** events · **4** types

## Functions

### C_HousingExpertMode.CancelActiveEditing

Cancels all in-progress editing of the selected target, which will reset any unsaved changes and deselect the active target; Will not reset any already-applied changes

```lua
C_HousingExpertMode.CancelActiveEditing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.CancelActiveEditing()
```

### C_HousingExpertMode.CommitDecorMovement

Attempt to save the changes made to the currently selected decor instance

```lua
C_HousingExpertMode.CommitDecorMovement()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.CommitDecorMovement()
```

### C_HousingExpertMode.CommitHouseExteriorPosition

Attempt to save the changes made to the House Exterior's position within the plot

```lua
C_HousingExpertMode.CommitHouseExteriorPosition()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.CommitHouseExteriorPosition()
```

### C_HousingExpertMode.GetHoveredDecorInfo

Returns info for the placed decor instance currently being hovered, if there is one

```lua
info = C_HousingExpertMode.GetHoveredDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingExpertMode.GetHoveredDecorInfo()
```

### C_HousingExpertMode.GetPrecisionSubmode

Returns the currently active Expert submode, if there is one

```lua
activeSubMode = C_HousingExpertMode.GetPrecisionSubmode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeSubMode` | HousingPrecisionSubmode | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activeSubMode = C_HousingExpertMode.GetPrecisionSubmode()
```

### C_HousingExpertMode.GetPrecisionSubmodeRestriction

Returns the type of restriction currently active on the submode; Will return HousingExpertSubmodeRestriction:None if submode is not currently restricted

```lua
restriction = C_HousingExpertMode.GetPrecisionSubmodeRestriction(subMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subMode` | HousingPrecisionSubmode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restriction` | HousingExpertSubmodeRestriction | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restriction = C_HousingExpertMode.GetPrecisionSubmodeRestriction(Enum.HousingPrecisionSubmode.Translate)
```

### C_HousingExpertMode.GetSelectedDecorInfo

Returns info for the placed decor instance that's currently selected, if there is one

```lua
info = C_HousingExpertMode.GetSelectedDecorInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HousingDecorInstanceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_HousingExpertMode.GetSelectedDecorInfo()
```

### C_HousingExpertMode.IsDecorSelected

Returns true if a placed decor instance is currently selected

```lua
hasSelectedDecor = C_HousingExpertMode.IsDecorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedDecor = C_HousingExpertMode.IsDecorSelected()
```

### C_HousingExpertMode.IsGridVisible

```lua
gridVisible = C_HousingExpertMode.IsGridVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gridVisible = C_HousingExpertMode.IsGridVisible()
```

### C_HousingExpertMode.IsHouseExteriorHovered

Returns true if the house's exterior is currently being hovered

```lua
isHouseExteriorHovered = C_HousingExpertMode.IsHouseExteriorHovered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorHovered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorHovered = C_HousingExpertMode.IsHouseExteriorHovered()
```

### C_HousingExpertMode.IsHouseExteriorSelected

Returns true if the house's exterior is currently selected

```lua
isHouseExteriorSelected = C_HousingExpertMode.IsHouseExteriorSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHouseExteriorSelected` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHouseExteriorSelected = C_HousingExpertMode.IsHouseExteriorSelected()
```

### C_HousingExpertMode.IsHoveringDecor

Returns true if a placed decor instance is currently being hovered

```lua
isHoveringDecor = C_HousingExpertMode.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingExpertMode.IsHoveringDecor()
```

### C_HousingExpertMode.RemoveSelectedDecor

Attempt to return the currently selected decor instance back to the house chest

```lua
C_HousingExpertMode.RemoveSelectedDecor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.RemoveSelectedDecor()
```

### C_HousingExpertMode.ResetPrecisionChanges

Reset the selected target's transform back to default values; This is NOT an undo, meaning it will completely reset the transform value to default, NOT just recently-made changes

```lua
C_HousingExpertMode.ResetPrecisionChanges(activeSubmodeOnly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeSubmodeOnly` | bool | no | If true, only transform values associated with the currently active submode with be reset (ex: in Scale submode, only target's scale will be reset); If false, all transform values will be reset |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.ResetPrecisionChanges(false)
```

### C_HousingExpertMode.SelectNextRotationAxis

In the rotation submode, swaps the selected axis to the next available one, in order of X -> Y -> Z (wrapping back around to X again, etc); If no axis is selected, selects the first available one, also in that order

```lua
C_HousingExpertMode.SelectNextRotationAxis()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.SelectNextRotationAxis()
```

### C_HousingExpertMode.SetGridVisible

```lua
C_HousingExpertMode.SetGridVisible(gridVisible)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gridVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.SetGridVisible(false)
```

### C_HousingExpertMode.SetPrecisionIncrementingActive

Sets a specific type of incremental change active or inactive; Whilever that type is active and target stays selected, incremental changes of that type will continue to be made every frame

```lua
C_HousingExpertMode.SetPrecisionIncrementingActive(incrementType, active)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `incrementType` | HousingIncrementType | no |  |
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.SetPrecisionIncrementingActive(Enum.HousingIncrementType.Left, false)
```

### C_HousingExpertMode.SetPrecisionSubmode

Activate a specific Expert submode

```lua
C_HousingExpertMode.SetPrecisionSubmode(subMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subMode` | HousingPrecisionSubmode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingExpertMode.SetPrecisionSubmode(Enum.HousingPrecisionSubmode.Translate)
```

## Events

### HOUSING_DECOR_PRECISION_MANIPULATION_EVENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `event` | TransformManipulatorEvent | no |  |

### HOUSING_DECOR_PRECISION_MANIPULATION_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isManipulatingSelection` | bool | no |  |

### HOUSING_DECOR_PRECISION_SUBMODE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeSubmode` | HousingPrecisionSubmode | yes |  |

### HOUSING_EXPERT_MODE_HOVERED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasHoveredTarget` | bool | no |  |
| `targetType` | HousingExpertModeTargetType | no |  |

### HOUSING_EXPERT_MODE_PLACEMENT_FLAGS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetType` | HousingExpertModeTargetType | no |  |
| `activeFlags` | HousingDecorPlacementRestriction | no |  |

### HOUSING_EXPERT_MODE_SELECTED_TARGET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedTarget` | bool | no |  |
| `targetType` | HousingExpertModeTargetType | no |  |

## Types

### HousingExpertModeTargetType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HousingExpertModeTargetType | no |  |
| `Decor` | HousingExpertModeTargetType | no |  |
| `House` | HousingExpertModeTargetType | no |  |

### HousingExpertSubmodeRestriction (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HousingExpertSubmodeRestriction | no |  |
| `NotInExpertMode` | HousingExpertSubmodeRestriction | no |  |
| `NoHouseExteriorScale` | HousingExpertSubmodeRestriction | no |  |
| `NoWMOScale` | HousingExpertSubmodeRestriction | no |  |

### HousingIncrementType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Left` | HousingIncrementType | no |  |
| `Right` | HousingIncrementType | no |  |
| `Forward` | HousingIncrementType | no |  |
| `Back` | HousingIncrementType | no |  |
| `Up` | HousingIncrementType | no |  |
| `Down` | HousingIncrementType | no |  |
| `RotateLeft` | HousingIncrementType | no |  |
| `RotateRight` | HousingIncrementType | no |  |
| `ScaleUp` | HousingIncrementType | no |  |
| `ScaleDown` | HousingIncrementType | no |  |

### HousingPrecisionSubmode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Translate` | HousingPrecisionSubmode | no |  |
| `Rotate` | HousingPrecisionSubmode | no |  |
| `Scale` | HousingPrecisionSubmode | no |  |

