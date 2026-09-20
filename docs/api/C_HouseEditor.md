# C_HouseEditor

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **3** events · **1** types

## Functions

### C_HouseEditor.ActivateHouseEditorMode

Attempts switch the House Editor to a specific House Editor mode

```lua
result = C_HouseEditor.ActivateHouseEditorMode(editMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editMode` | HouseEditorMode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no | The initial result of the attempt to activate the mode; If Success, mode is either already active, or we've succesfully started making required requests to server; Listen for MODE_CHANGED or MODE_CHANGE_FAILURE events for ultimate end result after server calls |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_HouseEditor.ActivateHouseEditorMode(editMode)
```

### C_HouseEditor.EnterHouseEditor

Attempts to open the House Editor to the default House Editor mode

```lua
result = C_HouseEditor.EnterHouseEditor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no | The initial result of the attempt to open the Editor; If Success, Editor is either already active, or we've succesfully started making required requests to server; Listen for MODE_CHANGED or MODE_CHANGE_FAILURE events for ultimate end result after server calls |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_HouseEditor.EnterHouseEditor()
```

### C_HouseEditor.GetActiveHouseEditorMode

```lua
editMode = C_HouseEditor.GetActiveHouseEditorMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editMode` | HouseEditorMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local editMode = C_HouseEditor.GetActiveHouseEditorMode()
```

### C_HouseEditor.GetHouseEditorAvailability

Returns the availability state of the House Editor overall

```lua
result = C_HouseEditor.GetHouseEditorAvailability()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_HouseEditor.GetHouseEditorAvailability()
```

### C_HouseEditor.GetHouseEditorModeAvailability

Returns the availability of a specific House Editor mode

```lua
result = C_HouseEditor.GetHouseEditorModeAvailability(editMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editMode` | HouseEditorMode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_HouseEditor.GetHouseEditorModeAvailability(editMode)
```

### C_HouseEditor.GetHouseEditorPlayerType

```lua
playerType = C_HouseEditor.GetHouseEditorPlayerType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerType` | HouseEditorPlayerType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local playerType = C_HouseEditor.GetHouseEditorPlayerType()
```

### C_HouseEditor.IsHouseEditorActive

Returns whether the House Editor is active, in any mode

```lua
isEditorActive = C_HouseEditor.IsHouseEditorActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEditorActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEditorActive = C_HouseEditor.IsHouseEditorActive()
```

### C_HouseEditor.IsHouseEditorModeActive

Returns whether the specific House Editor mode is active

```lua
isModeActive = C_HouseEditor.IsHouseEditorModeActive(editMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editMode` | HouseEditorMode | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isModeActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isModeActive = C_HouseEditor.IsHouseEditorModeActive(editMode)
```

### C_HouseEditor.IsHouseEditorStatusAvailable

Returns true if the HouseEditor currently able process mode availability and switching; May be false if not in a house or plot, or while waiting to get house settings back from the server

```lua
editorStatusAvailable = C_HouseEditor.IsHouseEditorStatusAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `editorStatusAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local editorStatusAvailable = C_HouseEditor.IsHouseEditorStatusAvailable()
```

### C_HouseEditor.LeaveHouseEditor

```lua
C_HouseEditor.LeaveHouseEditor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HouseEditor.LeaveHouseEditor()
```

## Events

### HOUSE_EDITOR_AVAILABILITY_CHANGED

### HOUSE_EDITOR_MODE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentEditMode` | HouseEditorMode | no |  |

### HOUSE_EDITOR_MODE_CHANGE_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

## Types

### HouseEditorPlayerType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | HouseEditorPlayerType | no | Not in a house or plot, or at one without even sufficient visiting permissions |
| `Owner` | HouseEditorPlayerType | no | Owner of the current house or plot |
| `Visitor` | HouseEditorPlayerType | no | A visitor of the current house or plot |

