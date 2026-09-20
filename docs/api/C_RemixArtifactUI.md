# C_RemixArtifactUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **2** events · **3** types

## Functions

### C_RemixArtifactUI.ClearRemixArtifactItem

```lua
C_RemixArtifactUI.ClearRemixArtifactItem()
```

**Example**

```lua
C_RemixArtifactUI.ClearRemixArtifactItem()
```

### C_RemixArtifactUI.GetAppearanceInfoByID

```lua
uiCameraID, altHandUICameraID = C_RemixArtifactUI.GetAppearanceInfoByID(artifactAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiCameraID` | number | no |  |
| `altHandUICameraID` | number | yes |  |

**Example**

```lua
local uiCameraID, altHandUICameraID = C_RemixArtifactUI.GetAppearanceInfoByID(0)
```

### C_RemixArtifactUI.GetArtifactArtInfo

```lua
artifactArtInfo = C_RemixArtifactUI.GetArtifactArtInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactArtInfo` | RemixArtifactArtInfo | no |  |

**Example**

```lua
local artifactArtInfo = C_RemixArtifactUI.GetArtifactArtInfo()
```

### C_RemixArtifactUI.GetArtifactItemInfo

```lua
itemID, altItemID, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop = C_RemixArtifactUI.GetArtifactItemInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |

**Example**

```lua
local itemID, altItemID, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop = C_RemixArtifactUI.GetArtifactItemInfo()
```

### C_RemixArtifactUI.GetCurrArtifactItemID

```lua
reqitemID = C_RemixArtifactUI.GetCurrArtifactItemID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reqitemID` | number | yes |  |

**Example**

```lua
local reqitemID = C_RemixArtifactUI.GetCurrArtifactItemID()
```

### C_RemixArtifactUI.GetCurrItemSpecIndex

```lua
specIndex = C_RemixArtifactUI.GetCurrItemSpecIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | luaIndex | yes |  |

**Example**

```lua
local specIndex = C_RemixArtifactUI.GetCurrItemSpecIndex()
```

### C_RemixArtifactUI.GetCurrTraitTreeID

```lua
traitTreeID = C_RemixArtifactUI.GetCurrTraitTreeID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitTreeID` | number | yes |  |

**Example**

```lua
local traitTreeID = C_RemixArtifactUI.GetCurrTraitTreeID()
```

### C_RemixArtifactUI.ItemInSlotIsRemixArtifact

```lua
isRemixArtifact = C_RemixArtifactUI.ItemInSlotIsRemixArtifact(invSlot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invSlot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRemixArtifact` | bool | no |  |

**Example**

```lua
local isRemixArtifact = C_RemixArtifactUI.ItemInSlotIsRemixArtifact(1)
```

## Events

### REMIX_ARTIFACT_ITEM_SPECS_LOADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### REMIX_ARTIFACT_UPDATE

## Types

### RemixArtifactAppearanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiCameraID` | number | no |  |
| `altHandUICameraID` | number | yes |  |

### RemixArtifactArtInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `titleName` | string | no |  |
| `uiModelSceneID` | number | no |  |
| `spellVisualKitID` | number | no |  |

### RemixArtifactInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |

