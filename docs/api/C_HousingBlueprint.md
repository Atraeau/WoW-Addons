# C_HousingBlueprint

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**19** functions · **14** events · **0** types

## Functions

### C_HousingBlueprint.CanExportRoom

Returns true if the specific room is allowed to be exported

```lua
canExport = C_HousingBlueprint.CanExportRoom(roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roomGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canExport` | bool | no |  |

**Example**

```lua
local canExport = C_HousingBlueprint.CanExportRoom("Creature-0-0000-0-0-0-0")
```

### C_HousingBlueprint.CanExportTypeFromCurrentLocation

Returns true if the player's current location is a valid place to attempt to export a specific kind of blueprint

```lua
locationValid = C_HousingBlueprint.CanExportTypeFromCurrentLocation(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingBlueprintType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationValid` | bool | no |  |

**Example**

```lua
local locationValid = C_HousingBlueprint.CanExportTypeFromCurrentLocation(type)
```

### C_HousingBlueprint.CanImportTypeFromCurrentLocation

Returns true if the player's current location is a valid place to attempt to import a specific kind of blueprint

```lua
locationValid = C_HousingBlueprint.CanImportTypeFromCurrentLocation(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingBlueprintType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locationValid` | bool | no |  |

**Example**

```lua
local locationValid = C_HousingBlueprint.CanImportTypeFromCurrentLocation(type)
```

### C_HousingBlueprint.DeleteBlueprint

Delete the specified owned blueprint; Listen for HousingBlueprintDeleteSuccess and HousingBlueprintDeleteFailure for results

```lua
C_HousingBlueprint.DeleteBlueprint(blueprintID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |

**Example**

```lua
C_HousingBlueprint.DeleteBlueprint(blueprintID)
```

### C_HousingBlueprint.ExportBlueprint

Saves out a new Blueprint of the specified type, using the specified name, if available, based on where the player is currently standing (see GetExportAvailability); Listen for HousingBlueprintExportSuccess and HousingBlueprintExportFailure for results

```lua
C_HousingBlueprint.ExportBlueprint(type, name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingBlueprintType | no |  |
| `name` | cstring | no |  |

**Example**

```lua
C_HousingBlueprint.ExportBlueprint(type, "")
```

### C_HousingBlueprint.ExportRoomBlueprint

Saves out a new Blueprint of the specified room, using the specified name, if available (see GetExportAvailability); Listen for HousingBlueprintExportSuccess and HousingBlueprintExportFailure for results

```lua
C_HousingBlueprint.ExportRoomBlueprint(name, roomGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `roomGUID` | WOWGUID | no |  |

**Example**

```lua
C_HousingBlueprint.ExportRoomBlueprint("", "Creature-0-0000-0-0-0-0")
```

### C_HousingBlueprint.GetBlueprintHyperlink

```lua
hyperLink = C_HousingBlueprint.GetBlueprintHyperlink(blueprintShareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintShareCode` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hyperLink` | string | no |  |

**Example**

```lua
local hyperLink = C_HousingBlueprint.GetBlueprintHyperlink("")
```

### C_HousingBlueprint.GetBlueprintTypeForCode

Returns what type of Blueprint the specified code is for; Will return HousingBlueprintType.None if code is invalid; Does NOT check whether the shareCode actually matches up to a real valid Blueprint

```lua
type = C_HousingBlueprint.GetBlueprintTypeForCode(shareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | HousingBlueprintType | no |  |

**Example**

```lua
local type = C_HousingBlueprint.GetBlueprintTypeForCode("")
```

### C_HousingBlueprint.GetExportAvailability

Returns success if the player can currently export Blueprints, or a specific error type (ex: invalid location or permissions)

```lua
availability = C_HousingBlueprint.GetExportAvailability()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `availability` | HousingResult | no |  |

**Example**

```lua
local availability = C_HousingBlueprint.GetExportAvailability()
```

### C_HousingBlueprint.GetFeatureAvailability

Returns success if Blueprints as a feature is currently enabled and available

```lua
blueprintsAvailability = C_HousingBlueprint.GetFeatureAvailability()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintsAvailability` | HousingResult | no |  |

**Example**

```lua
local blueprintsAvailability = C_HousingBlueprint.GetFeatureAvailability()
```

### C_HousingBlueprint.GetImportAvailability

Returns success if the player can currently import Blueprints, or a specific error type (ex: invalid location or permissions)

```lua
availability = C_HousingBlueprint.GetImportAvailability()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `availability` | HousingResult | no |  |

**Example**

```lua
local availability = C_HousingBlueprint.GetImportAvailability()
```

### C_HousingBlueprint.ImportBlueprint

Imports the specified blueprint, if available (see GetImportAvailability and CanImportTypeFromCurrentLocation); Listen for HousingBlueprintImportSuccess and HousingBlueprintImportFailure for results

```lua
C_HousingBlueprint.ImportBlueprint(shareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |

**Example**

```lua
C_HousingBlueprint.ImportBlueprint("")
```

### C_HousingBlueprint.IsShareCodeValid

Returns true if the string matches the valid expected format for a Blueprint Share Code; Does NOT check whether the shareCode actually matches up to a real valid Blueprint

```lua
isValid = C_HousingBlueprint.IsShareCodeValid(shareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = C_HousingBlueprint.IsShareCodeValid("")
```

### C_HousingBlueprint.RenameBlueprint

Rename the specified owned blueprint to the specified name; Listen for HousingBlueprintRenameSuccess and HousingBlueprintRenameFailure for results

```lua
C_HousingBlueprint.RenameBlueprint(blueprintID, newName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |
| `newName` | cstring | no |  |

**Example**

```lua
C_HousingBlueprint.RenameBlueprint(blueprintID, "")
```

### C_HousingBlueprint.RequestBlueprintCollection

Request the full list of all of the player's Blueprints; This is async, either the HOUSING_BLUEPRINT_COLLECTION_RECEIVED or HOUSING_BLUEPRINT_COLLECTION_FAILURE event will eventually be fired as a result

```lua
C_HousingBlueprint.RequestBlueprintCollection()
```

**Example**

```lua
C_HousingBlueprint.RequestBlueprintCollection()
```

### C_HousingBlueprint.RequestBlueprintContents

Request the full contents of a specific Blueprint, in context of the current owned plot or house (if any); This is async as content info includes dynamic data from the server, either the HOUSING_BLUEPRINT_CONTENTS_RECEIVED or HOUSING_BLUEPRINT_CONTENTS_FAILURE event will eventually be fired as a result; Calling this again before a prior request has finished will cancel the prior request

```lua
C_HousingBlueprint.RequestBlueprintContents(shareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |

**Example**

```lua
C_HousingBlueprint.RequestBlueprintContents("")
```

### C_HousingBlueprint.RequestBlueprintContentsForContext

Request the full contents of a specific Blueprint, either in context of a specific owned House or plot, or explicitly outside of any specific context; Typically used to update missing requirement info from previously-retrieved contents; See RequestBlueprintContents for other notes

```lua
C_HousingBlueprint.RequestBlueprintContentsForContext(shareCode, [optionalHouseGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |
| `optionalHouseGUID` | WOWGUID | yes |  |

**Example**

```lua
C_HousingBlueprint.RequestBlueprintContentsForContext("")
```

### C_HousingBlueprint.StartImportRoomBlueprint

Start the process of importing a Room Blueprint. This will lead to Layout Mode being opened, so the player can then select an available door to attach the room to

```lua
C_HousingBlueprint.StartImportRoomBlueprint(shareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shareCode` | cstring | no |  |

**Example**

```lua
C_HousingBlueprint.StartImportRoomBlueprint("")
```

### C_HousingBlueprint.UpdateBlueprintStringFromInput

```lua
updatedShareCode = C_HousingBlueprint.UpdateBlueprintStringFromInput(inputShareCode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inputShareCode` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `updatedShareCode` | string | no |  |

**Example**

```lua
local updatedShareCode = C_HousingBlueprint.UpdateBlueprintStringFromInput("")
```

## Events

### HOUSING_BLUEPRINT_COLLECTION_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_COLLECTION_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collection` | HousingBlueprintCollection | no |  |

### HOUSING_BLUEPRINT_CONTENTS_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintShareCode` | string | no |  |
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_CONTENTS_RECEIVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contentInfo` | HousingBlueprintContentInfo | no |  |

### HOUSING_BLUEPRINT_DELETE_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_DELETE_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |

### HOUSING_BLUEPRINT_EXPORT_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_EXPORT_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintShareCode` | string | no |  |

### HOUSING_BLUEPRINT_IMPORT_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_IMPORT_STARTED

### HOUSING_BLUEPRINT_IMPORT_SUCCESS

### HOUSING_BLUEPRINT_RENAME_FAILURE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |
| `result` | HousingResult | no |  |

### HOUSING_BLUEPRINT_RENAME_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `blueprintID` | BigUInteger | no |  |
| `name` | string | no |  |

### HOUSING_BLUEPRINTS_AVAILABILITY_CHANGED

