# C_CovenantPreview

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **2** events · **4** types

## Functions

### C_CovenantPreview.CloseFromUI

```lua
C_CovenantPreview.CloseFromUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_CovenantPreview.CloseFromUI()
```

### C_CovenantPreview.GetCovenantInfoForPlayerChoiceResponseID

```lua
previewInfo = C_CovenantPreview.GetCovenantInfoForPlayerChoiceResponseID(playerChoiceResponseID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerChoiceResponseID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previewInfo` | CovenantPreviewInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local previewInfo = C_CovenantPreview.GetCovenantInfoForPlayerChoiceResponseID(0)
```

## Events

### COVENANT_PREVIEW_CLOSE

### COVENANT_PREVIEW_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `previewInfo` | CovenantPreviewInfo | no |  |

## Types

### CovenantAbilityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `type` | CovenantAbilityType | no |  |

### CovenantFeatureInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `texture` | number | no |  |

### CovenantPreviewInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `transmogSetID` | number | no |  |
| `mountID` | number | no |  |
| `covenantName` | string | no |  |
| `covenantZone` | string | no |  |
| `description` | string | no |  |
| `covenantCrest` | textureAtlas | no |  |
| `covenantAbilities` | CovenantAbilityInfo[] | no |  |
| `fromPlayerChoice` | bool | no |  |
| `covenantSoulbinds` | CovenantSoulbindInfo[] | no |  |
| `featureInfo` | CovenantFeatureInfo | no |  |

### CovenantSoulbindInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `uiTextureKit` | textureKit | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `sortOrder` | number | no |  |

