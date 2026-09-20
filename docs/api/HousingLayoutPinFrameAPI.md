# HousingLayoutPinFrameAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**17** functions · **0** events · **0** types

## Functions

### HousingLayoutPinFrameAPI.CanMove

```lua
moveRestriction = CanMove()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `moveRestriction` | HousingLayoutRestriction | no |  |

**Example**

```lua
local moveRestriction = CanMove()
```

### HousingLayoutPinFrameAPI.CanRemove

```lua
removalRestriction = CanRemove()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removalRestriction` | HousingLayoutRestriction | no |  |

**Example**

```lua
local removalRestriction = CanRemove()
```

### HousingLayoutPinFrameAPI.CanRotate

```lua
rotateRestriction = CanRotate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rotateRestriction` | HousingLayoutRestriction | no |  |

**Example**

```lua
local rotateRestriction = CanRotate()
```

### HousingLayoutPinFrameAPI.Drag

```lua
Drag(isAccessible)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccessible` | bool | no |  |

**Example**

```lua
Drag(false)
```

### HousingLayoutPinFrameAPI.GetDoorConnectionInfo

```lua
connectionInfo = GetDoorConnectionInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `connectionInfo` | DoorConnectionInfo | yes |  |

**Example**

```lua
local connectionInfo = GetDoorConnectionInfo()
```

### HousingLayoutPinFrameAPI.GetPinType

```lua
type = GetPinType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingLayoutPinType | no |  |

**Example**

```lua
local type = GetPinType()
```

### HousingLayoutPinFrameAPI.GetRoomGUID

```lua
roomGUID = GetRoomGUID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Example**

```lua
local roomGUID = GetRoomGUID()
```

### HousingLayoutPinFrameAPI.GetRoomName

```lua
name = GetRoomName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |

**Example**

```lua
local name = GetRoomName()
```

### HousingLayoutPinFrameAPI.IsAnyPartOfRoomSelected

Returns true if this pin's associated room, or anything attached to it, is selected. Ex: If pin is for a door, returns true if its room, or any other doors on that room, are selected

```lua
isSelected = IsAnyPartOfRoomSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSelected` | bool | no |  |

**Example**

```lua
local isSelected = IsAnyPartOfRoomSelected()
```

### HousingLayoutPinFrameAPI.IsConnectedToDraggingRoom

```lua
isConnectedToDraggingRoom = IsConnectedToDraggingRoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConnectedToDraggingRoom` | bool | no |  |

**Example**

```lua
local isConnectedToDraggingRoom = IsConnectedToDraggingRoom()
```

### HousingLayoutPinFrameAPI.IsOccupiedDoor

Will be nil if pin is not a Door

```lua
isOccupied = IsOccupiedDoor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOccupied` | bool | yes |  |

**Example**

```lua
local isOccupied = IsOccupiedDoor()
```

### HousingLayoutPinFrameAPI.IsPartOfDraggingRoom

```lua
isPartOfDraggingRoom = IsPartOfDraggingRoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPartOfDraggingRoom` | bool | no |  |

**Example**

```lua
local isPartOfDraggingRoom = IsPartOfDraggingRoom()
```

### HousingLayoutPinFrameAPI.IsSelected

Returns true if this pin's object is itself selected; See IsAnyPartOfRoomSelected for a broader Selected check

```lua
isSelected = IsSelected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSelected` | bool | no |  |

**Example**

```lua
local isSelected = IsSelected()
```

### HousingLayoutPinFrameAPI.IsValid

```lua
isValid = IsValid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = IsValid()
```

### HousingLayoutPinFrameAPI.IsValidForSelectedFloorplan

```lua
isValid = IsValidForSelectedFloorplan()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = IsValidForSelectedFloorplan()
```

### HousingLayoutPinFrameAPI.Select

```lua
Select()
```

**Example**

```lua
Select()
```

### HousingLayoutPinFrameAPI.SetUpdateCallback

```lua
SetUpdateCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PinUpdatedCallback | no |  |

**Example**

```lua
SetUpdateCallback(cb)
```

