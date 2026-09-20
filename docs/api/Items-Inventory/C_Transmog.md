# C_Transmog

[← API index](../README.md) · group: [Items & Inventory](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **15** events · **5** types

## Functions

### C_Transmog.CanHaveSecondaryAppearanceForSlotID

```lua
canHaveSecondaryAppearance = C_Transmog.CanHaveSecondaryAppearanceForSlotID(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canHaveSecondaryAppearance` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canHaveSecondaryAppearance = C_Transmog.CanHaveSecondaryAppearanceForSlotID(1)
```

### C_Transmog.ExtractTransmogIDList

```lua
transmogIDList = C_Transmog.ExtractTransmogIDList(input)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `input` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogIDList` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local transmogIDList = C_Transmog.ExtractTransmogIDList("")
```

### C_Transmog.GetAllSetAppearancesByID

```lua
setItems = C_Transmog.GetAllSetAppearancesByID(setID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setItems` | TransmogSetItemInfo[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local setItems = C_Transmog.GetAllSetAppearancesByID(0)
```

### C_Transmog.GetItemIDForSource

```lua
itemID = C_Transmog.GetItemIDForSource(itemModifiedAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID = C_Transmog.GetItemIDForSource(6948)
```

### C_Transmog.GetSlotForInventoryType

```lua
slot = C_Transmog.GetSlotForInventoryType(inventoryType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryType` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slot = C_Transmog.GetSlotForInventoryType(1)
```

### C_Transmog.GetSlotVisualInfo

```lua
slotVisualInfo = C_Transmog.GetSlotVisualInfo(transmogLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogLocation` | TransmogLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotVisualInfo` | TransmogSlotVisualInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotVisualInfo = C_Transmog.GetSlotVisualInfo(transmogLocation)
```

### C_Transmog.IsAtTransmogNPC

```lua
isAtNPC = C_Transmog.IsAtTransmogNPC()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtNPC` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAtNPC = C_Transmog.IsAtTransmogNPC()
```

## Events

### TRANSMOG_COLLECTION_CAMERA_UPDATE

### TRANSMOG_COLLECTION_ITEM_FAVORITE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemAppearanceID` | number | no |  |
| `isFavorite` | bool | no |  |

### TRANSMOG_COLLECTION_ITEM_UPDATE

### TRANSMOG_COLLECTION_SOURCE_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

### TRANSMOG_COLLECTION_SOURCE_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

### TRANSMOG_COLLECTION_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collectionIndex` | luaIndex | yes |  |
| `modID` | number | yes |  |
| `itemAppearanceID` | number | yes |  |
| `reason` | cstring | yes |  |

### TRANSMOG_COSMETIC_COLLECTION_SOURCE_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |

### TRANSMOGRIFY_CLOSE

### TRANSMOGRIFY_ITEM_UPDATE

### TRANSMOGRIFY_OPEN

### TRANSMOGRIFY_SUCCESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogLocation` | TransmogLocation | no |  |

### TRANSMOGRIFY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `transmogLocation` | TransmogLocation | yes |  |
| `action` | cstring | yes |  |

### TRANSMOG_SEARCH_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchType` | TransmogSearchType | no |  |
| `collectionType` | TransmogCollectionType | yes |  |

### TRANSMOG_SETS_UPDATE_FAVORITE

### TRANSMOG_SOURCE_COLLECTABILITY_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemModifiedAppearanceID` | number | no |  |
| `collectable` | bool | no |  |

## Types

### TransmogApplyWarningInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLink` | string | no |  |
| `text` | string | no |  |

### TransmogPendingType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Apply` | TransmogPendingType | no |  |
| `Revert` | TransmogPendingType | no |  |
| `ToggleOn` | TransmogPendingType | no |  |
| `ToggleOff` | TransmogPendingType | no |  |

### TransmogSetItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `itemModifiedAppearanceID` | number | no |  |
| `invSlot` | number | no |  |
| `invType` | string | no |  |

### TransmogSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTransmogrified` | bool | no |  |
| `hasPending` | bool | no |  |
| `isPendingCollected` | bool | no |  |
| `canTransmogrify` | bool | no |  |
| `cannotTransmogrifyReason` | number | no |  |
| `hasUndo` | bool | no |  |
| `isHideVisual` | bool | no |  |
| `texture` | fileID | yes |  |

### TransmogSlotVisualInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseSourceID` | number | no |  |
| `baseVisualID` | number | no |  |
| `appliedSourceID` | number | no |  |
| `appliedVisualID` | number | no |  |
| `pendingSourceID` | number | no |  |
| `pendingVisualID` | number | no |  |
| `hasUndo` | bool | no |  |
| `isHideVisual` | bool | no |  |
| `itemSubclass` | number | no |  |

