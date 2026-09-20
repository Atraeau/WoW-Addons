# C_HouseExterior

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**20** functions · **12** events · **0** types

## Functions

### C_HouseExterior.CancelActiveExteriorEditing

Cancels all in-progress editing of house exterior fixtures, which will deselect any active targets

```lua
C_HouseExterior.CancelActiveExteriorEditing()
```

**Example**

```lua
C_HouseExterior.CancelActiveExteriorEditing()
```

### C_HouseExterior.GetCoreFixtureOptionsInfo

```lua
coreFixtureOptionsInfo = C_HouseExterior.GetCoreFixtureOptionsInfo(coreFixtureType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coreFixtureType` | HousingFixtureType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coreFixtureOptionsInfo` | HousingCoreFixtureInfo | yes |  |

**Example**

```lua
local coreFixtureOptionsInfo = C_HouseExterior.GetCoreFixtureOptionsInfo(coreFixtureType)
```

### C_HouseExterior.GetCurrentHouseExteriorSize

```lua
houseExteriorSize = C_HouseExterior.GetCurrentHouseExteriorSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseExteriorSize` | HousingFixtureSize | yes |  |

**Example**

```lua
local houseExteriorSize = C_HouseExterior.GetCurrentHouseExteriorSize()
```

### C_HouseExterior.GetCurrentHouseExteriorType

```lua
houseExteriorTypeID, houseExteriorTypeName = C_HouseExterior.GetCurrentHouseExteriorType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseExteriorTypeID` | number | yes |  |
| `houseExteriorTypeName` | cstring | yes |  |

**Example**

```lua
local houseExteriorTypeID, houseExteriorTypeName = C_HouseExterior.GetCurrentHouseExteriorType()
```

### C_HouseExterior.GetHouseExteriorSizeOptions

```lua
options = C_HouseExterior.GetHouseExteriorSizeOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | HouseExteriorSizeOptionsInfo | yes |  |

**Example**

```lua
local options = C_HouseExterior.GetHouseExteriorSizeOptions()
```

### C_HouseExterior.GetHouseExteriorTypeOptions

```lua
options = C_HouseExterior.GetHouseExteriorTypeOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | HouseExteriorTypeOptionsInfo | yes |  |

**Example**

```lua
local options = C_HouseExterior.GetHouseExteriorTypeOptions()
```

### C_HouseExterior.GetSelectedFixturePointInfo

```lua
fixturePointInfo = C_HouseExterior.GetSelectedFixturePointInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixturePointInfo` | HousingFixturePointInfo | yes |  |

**Example**

```lua
local fixturePointInfo = C_HouseExterior.GetSelectedFixturePointInfo()
```

### C_HouseExterior.HasHoveredFixture

```lua
anyHoveredFixture = C_HouseExterior.HasHoveredFixture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyHoveredFixture` | bool | no |  |

**Example**

```lua
local anyHoveredFixture = C_HouseExterior.HasHoveredFixture()
```

### C_HouseExterior.HasSelectedFixturePoint

```lua
anySelectedFixturePoint = C_HouseExterior.HasSelectedFixturePoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anySelectedFixturePoint` | bool | no |  |

**Example**

```lua
local anySelectedFixturePoint = C_HouseExterior.HasSelectedFixturePoint()
```

### C_HouseExterior.IsAnyDecorAttachedToCoreFixture

Returns true if any decor is attached to the specified core fixture type, OR any child fixtures attached to it; Will also return false if the type provided is not a core fixture type, or if not in Exterior Customization mode on an owned plot

```lua
anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToCoreFixture(coreFixtureType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coreFixtureType` | HousingFixtureType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyAttachedDecor` | bool | no |  |

**Example**

```lua
local anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToCoreFixture(coreFixtureType)
```

### C_HouseExterior.IsAnyDecorAttachedToDoor

Returns true if any decor is attached to the current House Exterior's door; Will also return false if not in Exterior Customization mode on an owned plot

```lua
anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToDoor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyAttachedDecor` | bool | no |  |

**Example**

```lua
local anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToDoor()
```

### C_HouseExterior.IsAnyDecorAttachedToHouseExterior

Returns true if any decor is attached to any component of the current House Exterior; Will also return false if not in House Exterior Customization mode on an owned Plot

```lua
anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToHouseExterior()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyAttachedDecor` | bool | no |  |

**Example**

```lua
local anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToHouseExterior()
```

### C_HouseExterior.IsAnyDecorAttachedToSelectedFixturePoint

Returns true if any decor is attached to the Fixture occupying the currently selected fixture point; Will also return false if no point is currently selected, or if there is currently no Fixture there

```lua
anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToSelectedFixturePoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyAttachedDecor` | bool | no |  |

**Example**

```lua
local anyAttachedDecor = C_HouseExterior.IsAnyDecorAttachedToSelectedFixturePoint()
```

### C_HouseExterior.IsExteriorDecorHidden

```lua
decorHidden = C_HouseExterior.IsExteriorDecorHidden()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorHidden` | bool | no |  |

**Example**

```lua
local decorHidden = C_HouseExterior.IsExteriorDecorHidden()
```

### C_HouseExterior.RemoveFixtureFromSelectedPoint

```lua
C_HouseExterior.RemoveFixtureFromSelectedPoint(attachedDecorAction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attachedDecorAction` | HousingFixtureDecorAction | no | What to do with any decor currently attached to the fixture (default: Store) |

**Example**

```lua
C_HouseExterior.RemoveFixtureFromSelectedPoint(attachedDecorAction)
```

### C_HouseExterior.SelectCoreFixtureOption

```lua
C_HouseExterior.SelectCoreFixtureOption(fixtureID, attachedDecorAction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixtureID` | number | no |  |
| `attachedDecorAction` | HousingFixtureDecorAction | no | What to do with any decor attached to the old core fixture; If the fixture being swapped is a variant (ie recolor) of the existing one, attached decor will always be reparented directly to the new one (default: Store) |

**Example**

```lua
C_HouseExterior.SelectCoreFixtureOption(0, attachedDecorAction)
```

### C_HouseExterior.SelectFixtureOption

```lua
C_HouseExterior.SelectFixtureOption(fixtureID, attachedDecorAction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixtureID` | number | no |  |
| `attachedDecorAction` | HousingFixtureDecorAction | no | If this fixture choice is replacing an existing one that has decor attached, what to do with any decor attached to the old one (default: Store) |

**Example**

```lua
C_HouseExterior.SelectFixtureOption(0, attachedDecorAction)
```

### C_HouseExterior.SetExteriorDecorHidden

```lua
C_HouseExterior.SetExteriorDecorHidden(decorHidden)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorHidden` | bool | no |  |

**Example**

```lua
C_HouseExterior.SetExteriorDecorHidden(false)
```

### C_HouseExterior.SetHouseExteriorSize

```lua
C_HouseExterior.SetHouseExteriorSize(size, attachedDecorAction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `size` | HousingFixtureSize | no |  |
| `attachedDecorAction` | HousingFixtureDecorAction | no | What to do with decor attached to any of the house's existing exterior components (default: Store) |

**Example**

```lua
C_HouseExterior.SetHouseExteriorSize(size, attachedDecorAction)
```

### C_HouseExterior.SetHouseExteriorType

```lua
C_HouseExterior.SetHouseExteriorType(houseExteriorTypeID, attachedDecorAction)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `houseExteriorTypeID` | number | no |  |
| `attachedDecorAction` | HousingFixtureDecorAction | no | What to do with decor attached to any of the house's existing exterior components (default: Store) |

**Example**

```lua
C_HouseExterior.SetHouseExteriorType(0, attachedDecorAction)
```

## Events

### HOUSE_EXTERIOR_DECOR_HIDDEN_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDecorHidden` | bool | no |  |

### HOUSE_EXTERIOR_TYPE_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixtureID` | number | no |  |

### HOUSING_CORE_FIXTURE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `coreFixtureType` | HousingFixtureType | no |  |

### HOUSING_FIXTURE_HOVER_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyHovered` | bool | no |  |

### HOUSING_FIXTURE_POINT_FRAME_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointFrame` | HousingFixturePointFrame | no |  |

### HOUSING_FIXTURE_POINT_FRAME_RELEASED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointFrame` | HousingFixturePointFrame | no |  |

### HOUSING_FIXTURE_POINT_FRAMES_RELEASED

### HOUSING_FIXTURE_POINT_SELECTION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelection` | bool | no |  |

### HOUSING_FIXTURE_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fixtureID` | number | no |  |

### HOUSING_SET_EXTERIOR_HOUSE_SIZE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_SET_EXTERIOR_HOUSE_TYPE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_SET_FIXTURE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

