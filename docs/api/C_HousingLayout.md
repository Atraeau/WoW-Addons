# C_HousingLayout

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**41** functions · **18** events · **0** types

## Functions

### C_HousingLayout.AnyRoomsOnFloor

```lua
anyRooms = C_HousingLayout.AnyRoomsOnFloor(floor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `anyRooms` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local anyRooms = C_HousingLayout.AnyRoomsOnFloor(0)
```

### C_HousingLayout.CancelActiveLayoutEditing

```lua
C_HousingLayout.CancelActiveLayoutEditing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.CancelActiveLayoutEditing()
```

### C_HousingLayout.CanSetViewedFloor

```lua
canSet = C_HousingLayout.CanSetViewedFloor(floor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSet` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canSet = C_HousingLayout.CanSetViewedFloor(0)
```

### C_HousingLayout.ConfirmStairChoice

```lua
C_HousingLayout.ConfirmStairChoice([choice])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `choice` | HousingLayoutStairDirection | yes | If not set, the pending stair operation will be cancelled |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.ConfirmStairChoice()
```

### C_HousingLayout.DeselectFloorplan

```lua
C_HousingLayout.DeselectFloorplan()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.DeselectFloorplan()
```

### C_HousingLayout.DeselectRoomOrDoor

```lua
C_HousingLayout.DeselectRoomOrDoor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.DeselectRoomOrDoor()
```

### C_HousingLayout.GetBaseRoomFloor

```lua
floor = C_HousingLayout.GetBaseRoomFloor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local floor = C_HousingLayout.GetBaseRoomFloor()
```

### C_HousingLayout.GetHighestOccupiedFloorIndex

```lua
highestFloorIndex = C_HousingLayout.GetHighestOccupiedFloorIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `highestFloorIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local highestFloorIndex = C_HousingLayout.GetHighestOccupiedFloorIndex()
```

### C_HousingLayout.GetLowestOccupiedFloorIndex

```lua
lowestFloorIndex = C_HousingLayout.GetLowestOccupiedFloorIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lowestFloorIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lowestFloorIndex = C_HousingLayout.GetLowestOccupiedFloorIndex()
```

### C_HousingLayout.GetNumActiveRooms

```lua
numRooms = C_HousingLayout.GetNumActiveRooms()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRooms` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numRooms = C_HousingLayout.GetNumActiveRooms()
```

### C_HousingLayout.GetRoomPlacementBudget

Returns the max room placement budget for the current owned house's interior; Can be increased via house level

```lua
placementBudget = C_HousingLayout.GetRoomPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `placementBudget` | number | yes | Will be nil if not in an owned House or Plot |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local placementBudget = C_HousingLayout.GetRoomPlacementBudget()
```

### C_HousingLayout.GetRoomPlayerIsIn

Returns the guid of the interior room the player is standing in, or nil if not currently standing in one

```lua
roomGUID = C_HousingLayout.GetRoomPlayerIsIn()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roomGUID = C_HousingLayout.GetRoomPlayerIsIn()
```

### C_HousingLayout.GetSelectedBlueprintFloorplan

```lua
roomID, shareCode = C_HousingLayout.GetSelectedBlueprintFloorplan()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomID` | number | no |  |
| `shareCode` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roomID, shareCode = C_HousingLayout.GetSelectedBlueprintFloorplan()
```

### C_HousingLayout.GetSelectedDoor

If a door is selected, returns its component id and the guid of the room it belongs to; Otherwise returns nothing

```lua
selectedDoorComponentID, roomGUID = C_HousingLayout.GetSelectedDoor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `selectedDoorComponentID` | number | no |  |
| `roomGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local selectedDoorComponentID, roomGUID = C_HousingLayout.GetSelectedDoor()
```

### C_HousingLayout.GetSelectedFloorplan

```lua
roomID = C_HousingLayout.GetSelectedFloorplan()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roomID = C_HousingLayout.GetSelectedFloorplan()
```

### C_HousingLayout.GetSelectedRoom

If a Room is selected, returns the room's guid; Otherwise returns nothing

```lua
roomGUID = C_HousingLayout.GetSelectedRoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local roomGUID = C_HousingLayout.GetSelectedRoom()
```

### C_HousingLayout.GetSelectedStairwellRoomCount

```lua
stairwellRoomCount = C_HousingLayout.GetSelectedStairwellRoomCount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stairwellRoomCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local stairwellRoomCount = C_HousingLayout.GetSelectedStairwellRoomCount()
```

### C_HousingLayout.GetSpentPlacementBudget

Returns how much of the current owned house's room placement budget has been spent; Different kinds of rooms take up different budget amounts, so this value isn't an individual room count, see GetNumActiveRooms for that

```lua
spentPlacementBudget = C_HousingLayout.GetSpentPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spentPlacementBudget` | number | yes | Will be nil if not in an owned House |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spentPlacementBudget = C_HousingLayout.GetSpentPlacementBudget()
```

### C_HousingLayout.GetViewedFloor

```lua
floor = C_HousingLayout.GetViewedFloor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local floor = C_HousingLayout.GetViewedFloor()
```

### C_HousingLayout.HasAnySelections

Returns true if any room, door, or floorplan is currently selected or being dragged

```lua
hasAnySelections = C_HousingLayout.HasAnySelections()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnySelections` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnySelections = C_HousingLayout.HasAnySelections()
```

### C_HousingLayout.HasRoomPlacementBudget

Returns whether there's a max room placement budget available and active for the current player, in the current house's interior

```lua
hasBudget = C_HousingLayout.HasRoomPlacementBudget()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBudget` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasBudget = C_HousingLayout.HasRoomPlacementBudget()
```

### C_HousingLayout.HasSelectedBlueprintFloorplan

```lua
hasSelectedBlueprintFloorplan = C_HousingLayout.HasSelectedBlueprintFloorplan()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedBlueprintFloorplan` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedBlueprintFloorplan = C_HousingLayout.HasSelectedBlueprintFloorplan()
```

### C_HousingLayout.HasSelectedDoor

Returns true if a door component is currently selected

```lua
hasSelectedDoor = C_HousingLayout.HasSelectedDoor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedDoor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedDoor = C_HousingLayout.HasSelectedDoor()
```

### C_HousingLayout.HasSelectedFloorplan

```lua
hasSelectedFloorplan = C_HousingLayout.HasSelectedFloorplan()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedFloorplan` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedFloorplan = C_HousingLayout.HasSelectedFloorplan()
```

### C_HousingLayout.HasSelectedRoom

Returns true if a room is selected, will NOT return true if a door is selected

```lua
hasSelectedRoom = C_HousingLayout.HasSelectedRoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelectedRoom` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSelectedRoom = C_HousingLayout.HasSelectedRoom()
```

### C_HousingLayout.HasStairs

```lua
hasStairs = C_HousingLayout.HasStairs(roomRecordID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomRecordID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasStairs` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasStairs = C_HousingLayout.HasStairs(0)
```

### C_HousingLayout.HasValidConnection

```lua
canPlace = C_HousingLayout.HasValidConnection(roomGUID, componentID, roomId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `roomId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPlace` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canPlace = C_HousingLayout.HasValidConnection(UnitGUID("player"), 0, 0)
```

### C_HousingLayout.IsBaseRoom

```lua
isBaseRoom = C_HousingLayout.IsBaseRoom(roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBaseRoom` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBaseRoom = C_HousingLayout.IsBaseRoom(UnitGUID("player"))
```

### C_HousingLayout.IsDraggingRoom

```lua
isDragging, isAccessibleDrag = C_HousingLayout.IsDraggingRoom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDragging` | bool | no |  |
| `isAccessibleDrag` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDragging, isAccessibleDrag = C_HousingLayout.IsDraggingRoom()
```

### C_HousingLayout.MoveDraggedRoom

Attempt to move the room currently being dragged to a specific connection point on a specific other room

```lua
C_HousingLayout.MoveDraggedRoom(sourceDoorIndex, destRoom, destDoorIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceDoorIndex` | number | no |  |
| `destRoom` | WOWGUID | no |  |
| `destDoorIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.MoveDraggedRoom(1, UnitGUID("player"), 1)
```

### C_HousingLayout.MoveLayoutCamera

```lua
C_HousingLayout.MoveLayoutCamera(direction, isPressed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `direction` | HousingLayoutCameraDirection | no |  |
| `isPressed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.MoveLayoutCamera(direction, false)
```

### C_HousingLayout.RemoveRoom

Attempt to return a previously placed room to the House Chest

```lua
C_HousingLayout.RemoveRoom(roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.RemoveRoom(UnitGUID("player"))
```

### C_HousingLayout.RoomHasStairs

Returns true of the provided roomGUID is a stairwell. Returns false if roomGUID is invalid

```lua
hasStairs = C_HousingLayout.RoomHasStairs(roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasStairs` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasStairs = C_HousingLayout.RoomHasStairs(UnitGUID("player"))
```

### C_HousingLayout.RotateFocusedRoom

Rotates either the currently dragged or currently selected room, if either exist

```lua
C_HousingLayout.RotateFocusedRoom(isLeft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLeft` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.RotateFocusedRoom(false)
```

### C_HousingLayout.RotateRoom

Attempt to rotate an already placed room

```lua
C_HousingLayout.RotateRoom(roomGUID, isLeft)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `isLeft` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.RotateRoom(UnitGUID("player"), false)
```

### C_HousingLayout.SelectFloorplan

```lua
C_HousingLayout.SelectFloorplan(roomID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.SelectFloorplan(0)
```

### C_HousingLayout.SetViewedFloor

```lua
C_HousingLayout.SetViewedFloor(floor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.SetViewedFloor(0)
```

### C_HousingLayout.StartDrag

```lua
C_HousingLayout.StartDrag()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.StartDrag()
```

### C_HousingLayout.StopDrag

```lua
C_HousingLayout.StopDrag()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.StopDrag()
```

### C_HousingLayout.StopDraggingRoom

```lua
C_HousingLayout.StopDraggingRoom()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingLayout.StopDraggingRoom()
```

### C_HousingLayout.ZoomLayoutCamera

```lua
zoomChanged = C_HousingLayout.ZoomLayoutCamera(zoomIn)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomIn` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomChanged` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local zoomChanged = C_HousingLayout.ZoomLayoutCamera(false)
```

## Events

### HOUSING_LAYOUT_DOOR_SELECTED

Fired when one of the door nodes of an already placed room has been selected

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |

### HOUSING_LAYOUT_DOOR_SELECTION_CHANGED

Fired when one of the door nodes of an already placed room has been selected or deselected

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelection` | bool | no |  |

### HOUSING_LAYOUT_DRAG_TARGET_CHANGED

Fired when an already placed room has either started or stopped being dragged

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDraggingRoom` | bool | no |  |

### HOUSING_LAYOUT_FLOORPLAN_SELECTION_CHANGED

Fired when a room option in the House Chest has been selected or deselected

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelection` | bool | no |  |
| `roomID` | number | no |  |
| `blueprintShareCode` | cstring | yes |  |

### HOUSING_LAYOUT_OCCUPIED_FLOOR_RANGE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lowestFloor` | number | no |  |
| `highestFloor` | number | no |  |

### HOUSING_LAYOUT_PIN_FRAME_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pinFrame` | HousingLayoutPinFrame | no |  |

### HOUSING_LAYOUT_PIN_FRAME_RELEASED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pinFrame` | HousingLayoutPinFrame | no |  |

### HOUSING_LAYOUT_PIN_FRAMES_RELEASED

### HOUSING_LAYOUT_ROOM_COMPONENT_THEME_SET_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |
| `componentID` | number | no |  |
| `newThemeSet` | number | no |  |
| `result` | HousingResult | no |  |

### HOUSING_LAYOUT_ROOM_MOVED

Fired when a previously placed room has been moved to a different position or rotation

### HOUSING_LAYOUT_ROOM_MOVE_INVALID

### HOUSING_LAYOUT_ROOM_RECEIVED

Fired when info for a newly placed room has been recieved while in Layout Mode

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playAddedSound` | bool | no |  |

### HOUSING_LAYOUT_ROOM_REMOVED

Fired when a previously placed room has been removed while in Layout Mode

### HOUSING_LAYOUT_ROOM_RETURNED

Fired when a room that was being dragged is let go of without being placed, and is returned to the House Chest

### HOUSING_LAYOUT_ROOM_SELECTION_CHANGED

Fired when an already placed room has been selected or deselected

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSelection` | bool | no |  |

### HOUSING_LAYOUT_ROOM_SNAPPED

Fired when a room being dragged has been snapped to a particular door connection

### HOUSING_LAYOUT_VIEWED_FLOOR_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `floor` | number | no |  |

### SHOW_STAIR_DIRECTION_CONFIRMATION

