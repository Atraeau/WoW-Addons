# C_EquipmentSet

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**23** functions · **4** events · **0** types

## Functions

### C_EquipmentSet.AssignSpecToEquipmentSet

```lua
C_EquipmentSet.AssignSpecToEquipmentSet(equipmentSetID, specIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |
| `specIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.AssignSpecToEquipmentSet(0, 1)
```

### C_EquipmentSet.CanUseEquipmentSets

```lua
canUseEquipmentSets = C_EquipmentSet.CanUseEquipmentSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseEquipmentSets` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUseEquipmentSets = C_EquipmentSet.CanUseEquipmentSets()
```

### C_EquipmentSet.ClearIgnoredSlotsForSave

```lua
C_EquipmentSet.ClearIgnoredSlotsForSave()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.ClearIgnoredSlotsForSave()
```

### C_EquipmentSet.CreateEquipmentSet

```lua
C_EquipmentSet.CreateEquipmentSet(equipmentSetName, [icon])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetName` | cstring | no |  |
| `icon` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.CreateEquipmentSet("")
```

### C_EquipmentSet.DeleteEquipmentSet

```lua
C_EquipmentSet.DeleteEquipmentSet(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.DeleteEquipmentSet(0)
```

### C_EquipmentSet.EquipmentSetContainsLockedItems

```lua
hasLockedItems = C_EquipmentSet.EquipmentSetContainsLockedItems(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasLockedItems` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasLockedItems = C_EquipmentSet.EquipmentSetContainsLockedItems(0)
```

### C_EquipmentSet.GetEquipmentSetAssignedSpec

```lua
specIndex = C_EquipmentSet.GetEquipmentSetAssignedSpec(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specIndex = C_EquipmentSet.GetEquipmentSetAssignedSpec(0)
```

### C_EquipmentSet.GetEquipmentSetForSpec

```lua
equipmentSetID = C_EquipmentSet.GetEquipmentSetForSpec(specIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local equipmentSetID = C_EquipmentSet.GetEquipmentSetForSpec(1)
```

### C_EquipmentSet.GetEquipmentSetID

```lua
equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local equipmentSetID = C_EquipmentSet.GetEquipmentSetID("")
```

### C_EquipmentSet.GetEquipmentSetIDs

```lua
equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
```

### C_EquipmentSet.GetEquipmentSetInfo

```lua
name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `iconFileID` | number | no |  |
| `setID` | number | no |  |
| `isEquipped` | bool | no |  |
| `numItems` | number | no |  |
| `numEquipped` | number | no |  |
| `numInInventory` | number | no |  |
| `numLost` | number | no |  |
| `numIgnored` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(0)
```

### C_EquipmentSet.GetIgnoredSlots

```lua
slotIgnored = C_EquipmentSet.GetIgnoredSlots(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotIgnored` | bool[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotIgnored = C_EquipmentSet.GetIgnoredSlots(0)
```

### C_EquipmentSet.GetItemIDs

```lua
itemIDs = C_EquipmentSet.GetItemIDs(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemIDs = C_EquipmentSet.GetItemIDs(0)
```

### C_EquipmentSet.GetItemLocations

```lua
locations = C_EquipmentSet.GetItemLocations(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locations` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local locations = C_EquipmentSet.GetItemLocations(0)
```

### C_EquipmentSet.GetNumEquipmentSets

```lua
numEquipmentSets = C_EquipmentSet.GetNumEquipmentSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numEquipmentSets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numEquipmentSets = C_EquipmentSet.GetNumEquipmentSets()
```

### C_EquipmentSet.IgnoreSlotForSave

```lua
C_EquipmentSet.IgnoreSlotForSave(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.IgnoreSlotForSave(1)
```

### C_EquipmentSet.IsSlotIgnoredForSave

```lua
isSlotIgnored = C_EquipmentSet.IsSlotIgnoredForSave(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSlotIgnored` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSlotIgnored = C_EquipmentSet.IsSlotIgnoredForSave(1)
```

### C_EquipmentSet.ModifyEquipmentSet

```lua
C_EquipmentSet.ModifyEquipmentSet(equipmentSetID, newName, [newIcon])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |
| `newName` | cstring | no |  |
| `newIcon` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.ModifyEquipmentSet(0, "")
```

### C_EquipmentSet.PickupEquipmentSet

```lua
C_EquipmentSet.PickupEquipmentSet(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.PickupEquipmentSet(0)
```

### C_EquipmentSet.SaveEquipmentSet

```lua
C_EquipmentSet.SaveEquipmentSet(equipmentSetID, [icon])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |
| `icon` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.SaveEquipmentSet(0)
```

### C_EquipmentSet.UnassignEquipmentSetSpec

```lua
C_EquipmentSet.UnassignEquipmentSetSpec(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.UnassignEquipmentSetSpec(0)
```

### C_EquipmentSet.UnignoreSlotForSave

```lua
C_EquipmentSet.UnignoreSlotForSave(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EquipmentSet.UnignoreSlotForSave(1)
```

### C_EquipmentSet.UseEquipmentSet

```lua
setWasEquipped = C_EquipmentSet.UseEquipmentSet(equipmentSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setWasEquipped` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local setWasEquipped = C_EquipmentSet.UseEquipmentSet(0)
```

## Events

### EQUIPMENT_SETS_CHANGED

### EQUIPMENT_SWAP_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |
| `setID` | number | yes |  |

### EQUIPMENT_SWAP_PENDING

### TRANSMOG_CUSTOM_SETS_CHANGED

