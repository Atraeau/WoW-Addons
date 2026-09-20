# C_ClassTalents

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**31** functions · **8** events · **2** types

## Functions

### C_ClassTalents.CanChangeTalents

Returns true only if the player has staged changes and can commit their talents in their current state.

```lua
canChange, canAdd, changeError = C_ClassTalents.CanChangeTalents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChange` | bool | no |  |
| `canAdd` | bool | no |  |
| `changeError` | string | yes |  |

**Example**

```lua
local canChange, canAdd, changeError = C_ClassTalents.CanChangeTalents()
```

### C_ClassTalents.CanCreateNewConfig

```lua
canCreate = C_ClassTalents.CanCreateNewConfig()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canCreate` | bool | no |  |

**Example**

```lua
local canCreate = C_ClassTalents.CanCreateNewConfig()
```

### C_ClassTalents.CanEditTalents

Returns true if the player could switch talents if they staged a proper loadout.

```lua
canEdit, changeError = C_ClassTalents.CanEditTalents()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEdit` | bool | no |  |
| `changeError` | cstring | no |  |

**Example**

```lua
local canEdit, changeError = C_ClassTalents.CanEditTalents()
```

### C_ClassTalents.CommitConfig

```lua
success = C_ClassTalents.CommitConfig([savedConfigID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `savedConfigID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.CommitConfig()
```

### C_ClassTalents.DeleteConfig

```lua
success = C_ClassTalents.DeleteConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.DeleteConfig(0)
```

### C_ClassTalents.GetActiveConfigID

```lua
activeConfigID = C_ClassTalents.GetActiveConfigID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeConfigID` | number | yes |  |

**Example**

```lua
local activeConfigID = C_ClassTalents.GetActiveConfigID()
```

### C_ClassTalents.GetActiveHeroTalentSpec

Returns the SubTreeID of the player's active Hero Talent Specialization SubTree.

```lua
heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `heroSpecID` | number | yes | SubTreeID of the player's active Hero Talent Specialization or nil if no Specialization is active. |

**Example**

```lua
local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
```

### C_ClassTalents.GetConfigIDsBySpecID

```lua
configIDs = C_ClassTalents.GetConfigIDsBySpecID([specID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configIDs` | number[] | no |  |

**Example**

```lua
local configIDs = C_ClassTalents.GetConfigIDsBySpecID()
```

### C_ClassTalents.GetHasStarterBuild

```lua
hasStarterBuild = C_ClassTalents.GetHasStarterBuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasStarterBuild` | bool | no |  |

**Example**

```lua
local hasStarterBuild = C_ClassTalents.GetHasStarterBuild()
```

### C_ClassTalents.GetHeroTalentSpecsForClassSpec

Returns the SubTreeIDs of the Hero Talent Specializations available to a Class Specialization and config; Returns nothing if none available

```lua
subTreeIDs, requiredPlayerLevel = C_ClassTalents.GetHeroTalentSpecsForClassSpec([configID], [classSpecID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | yes | If not supplied, defaults to the player's active config |
| `classSpecID` | number | yes | If not supplied, defaults to the player's active spec |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subTreeIDs` | number[] | yes | SubTreeIDs of each Hero Talent Specialization |
| `requiredPlayerLevel` | number | yes | The player level at which one of the Hero Talent Specializations can be activated |

**Example**

```lua
local subTreeIDs, requiredPlayerLevel = C_ClassTalents.GetHeroTalentSpecsForClassSpec()
```

### C_ClassTalents.GetLastSelectedSavedConfigID

```lua
configID = C_ClassTalents.GetLastSelectedSavedConfigID(specID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | yes |  |

**Example**

```lua
local configID = C_ClassTalents.GetLastSelectedSavedConfigID(0)
```

### C_ClassTalents.GetNextStarterBuildPurchase

```lua
nodeID, entryID = C_ClassTalents.GetNextStarterBuildPurchase()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | yes |  |
| `entryID` | number | yes |  |

**Example**

```lua
local nodeID, entryID = C_ClassTalents.GetNextStarterBuildPurchase()
```

### C_ClassTalents.GetStarterBuildActive

```lua
isActive = C_ClassTalents.GetStarterBuildActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example**

```lua
local isActive = C_ClassTalents.GetStarterBuildActive()
```

### C_ClassTalents.GetTraitTreeForSpec

```lua
treeID = C_ClassTalents.GetTraitTreeForSpec(specID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | yes |  |

**Example**

```lua
local treeID = C_ClassTalents.GetTraitTreeForSpec(0)
```

### C_ClassTalents.HasUnspentHeroTalentPoints

Returns whether the player has any unspent talent points in their active hero talent tree. If hasUnspentPoints is true, numHeroPoints will be greater than zero.

```lua
hasUnspentPoints, numHeroPoints = C_ClassTalents.HasUnspentHeroTalentPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUnspentPoints` | bool | no |  |
| `numHeroPoints` | number | no |  |

**Example**

```lua
local hasUnspentPoints, numHeroPoints = C_ClassTalents.HasUnspentHeroTalentPoints()
```

### C_ClassTalents.HasUnspentTalentPoints

Returns whether the player has any unspent talent points in their class or spec talent trees. If hasUnspentPoints is true, the number of unspent points for at least one of the trees will be greater than zero. Hero talent points are not included by this function.

```lua
hasUnspentPoints, numClassPoints, numSpecPoints = C_ClassTalents.HasUnspentTalentPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUnspentPoints` | bool | no |  |
| `numClassPoints` | number | no |  |
| `numSpecPoints` | number | no |  |

**Example**

```lua
local hasUnspentPoints, numClassPoints, numSpecPoints = C_ClassTalents.HasUnspentTalentPoints()
```

### C_ClassTalents.ImportLoadout

```lua
success, importError = C_ClassTalents.ImportLoadout(configID, entries, name, [importString])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `entries` | ImportLoadoutEntryInfo[] | no |  |
| `name` | string | no |  |
| `importString` | string | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `importError` | cstring | no |  |

**Example**

```lua
local success, importError = C_ClassTalents.ImportLoadout(0, entries, "")
```

### C_ClassTalents.InitializeViewLoadout

```lua
C_ClassTalents.InitializeViewLoadout(specID, level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `level` | number | no |  |

**Example**

```lua
C_ClassTalents.InitializeViewLoadout(0, 0)
```

### C_ClassTalents.IsConfigPopulated

New configs may or may not be populated and ready to load immediately after creation. Avoid calling for configs intentionally created empty.

```lua
isPopulated = C_ClassTalents.IsConfigPopulated(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPopulated` | bool | no |  |

**Example**

```lua
local isPopulated = C_ClassTalents.IsConfigPopulated(0)
```

### C_ClassTalents.LoadConfig

```lua
result, changeError, newLearnedNodeIDs = C_ClassTalents.LoadConfig(configID, autoApply)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `autoApply` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LoadConfigResult | no |  |
| `changeError` | string | yes |  |
| `newLearnedNodeIDs` | number[] | no |  |

**Example**

```lua
local result, changeError, newLearnedNodeIDs = C_ClassTalents.LoadConfig(0, false)
```

### C_ClassTalents.RenameConfig

```lua
success = C_ClassTalents.RenameConfig(configID, name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `name` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.RenameConfig(0, "")
```

### C_ClassTalents.RequestNewConfig

```lua
success = C_ClassTalents.RequestNewConfig(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.RequestNewConfig("")
```

### C_ClassTalents.SaveConfig

```lua
success = C_ClassTalents.SaveConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.SaveConfig(0)
```

### C_ClassTalents.SetStarterBuildActive

```lua
result = C_ClassTalents.SetStarterBuildActive(active)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LoadConfigResult | no |  |

**Example**

```lua
local result = C_ClassTalents.SetStarterBuildActive(false)
```

### C_ClassTalents.SetUsesSharedActionBars

```lua
C_ClassTalents.SetUsesSharedActionBars(configID, usesShared)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |
| `usesShared` | bool | no |  |

**Example**

```lua
C_ClassTalents.SetUsesSharedActionBars(0, false)
```

### C_ClassTalents.SwitchToLoadoutByIndex

Loads loadout for the current specialization by dropdown index. Indices start at 1.

```lua
C_ClassTalents.SwitchToLoadoutByIndex(loadoutIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadoutIndex` | number | no |  |

**Example**

```lua
C_ClassTalents.SwitchToLoadoutByIndex(1)
```

### C_ClassTalents.SwitchToLoadoutByName

Loads loadout for the current specialization by name. Loads the first one found in the case of duplicate names.

```lua
C_ClassTalents.SwitchToLoadoutByName(loadoutName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadoutName` | cstring | no |  |

**Example**

```lua
C_ClassTalents.SwitchToLoadoutByName("")
```

### C_ClassTalents.SwitchToSpecializationByIndex

Activates specialization for the current class by index in the order within the Specializations tab. Indices start at 1.

```lua
C_ClassTalents.SwitchToSpecializationByIndex(specIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | number | no |  |

**Example**

```lua
C_ClassTalents.SwitchToSpecializationByIndex(1)
```

### C_ClassTalents.SwitchToSpecializationByName

Activates specialization for the current class by spec name.

```lua
C_ClassTalents.SwitchToSpecializationByName(specName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specName` | cstring | no |  |

**Example**

```lua
C_ClassTalents.SwitchToSpecializationByName("")
```

### C_ClassTalents.UpdateLastSelectedSavedConfigID

```lua
C_ClassTalents.UpdateLastSelectedSavedConfigID(specID, [configID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `configID` | number | yes |  |

**Example**

```lua
C_ClassTalents.UpdateLastSelectedSavedConfigID(0)
```

### C_ClassTalents.ViewLoadout

```lua
success = C_ClassTalents.ViewLoadout(entries, [importString])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entries` | ImportLoadoutEntryInfo[] | no |  |
| `importString` | string | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ClassTalents.ViewLoadout(entries)
```

## Events

### ACTIVE_COMBAT_CONFIG_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

### CLASS_TALENTS_SWITCH_TO_LOADOUT_BY_INDEX

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadoutIndex` | number | no |  |

### CLASS_TALENTS_SWITCH_TO_LOADOUT_BY_NAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadoutName` | cstring | no |  |

### CLASS_TALENTS_SWITCH_TO_SPECIALIZATION_BY_INDEX

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | number | no |  |

### CLASS_TALENTS_SWITCH_TO_SPECIALIZATION_BY_NAME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specName` | cstring | no |  |

### SELECTED_LOADOUT_CHANGED

### SPECIALIZATION_CHANGE_CAST_FAILED

### STARTER_BUILD_ACTIVATION_FAILED

## Types

### ImportLoadoutEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |
| `ranksGranted` | number | no |  |
| `ranksPurchased` | number | no |  |
| `selectionEntryID` | number | no |  |

### LoadConfigResult (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Error` | LoadConfigResult | no |  |
| `NoChangesNecessary` | LoadConfigResult | no |  |
| `LoadInProgress` | LoadConfigResult | no |  |
| `Ready` | LoadConfigResult | no |  |

