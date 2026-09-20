# C_PetInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**13** functions · **11** events · **1** types

## Functions

### C_PetInfo.CanPetEatItem

```lua
canEat = C_PetInfo.CanPetEatItem(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEat` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canEat = C_PetInfo.CanPetEatItem(6948)
```

### C_PetInfo.GetPetFoodTypes

```lua
foodTypes = C_PetInfo.GetPetFoodTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `foodTypes` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local foodTypes = C_PetInfo.GetPetFoodTypes()
```

### C_PetInfo.GetPetHappiness

```lua
happiness, damagePercentage, loyaltyRate = C_PetInfo.GetPetHappiness()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `happiness` | number | no |  |
| `damagePercentage` | number | no |  |
| `loyaltyRate` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local happiness, damagePercentage, loyaltyRate = C_PetInfo.GetPetHappiness()
```

### C_PetInfo.GetPetLoyalty

```lua
loyaltyName = C_PetInfo.GetPetLoyalty()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loyaltyName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local loyaltyName = C_PetInfo.GetPetLoyalty()
```

### C_PetInfo.GetPetTalentTree

```lua
talentTreeName = C_PetInfo.GetPetTalentTree()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentTreeName` | stringView | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local talentTreeName = C_PetInfo.GetPetTalentTree()
```

### C_PetInfo.GetPetTamersForMap

```lua
petTamers = C_PetInfo.GetPetTamersForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petTamers` | PetTamerMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local petTamers = C_PetInfo.GetPetTamersForMap(0)
```

### C_PetInfo.GetPetTrainingPoints

```lua
totalPoints, usedPoints = C_PetInfo.GetPetTrainingPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalPoints` | number | no |  |
| `usedPoints` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalPoints, usedPoints = C_PetInfo.GetPetTrainingPoints()
```

### C_PetInfo.GetPetUIModelSceneID

```lua
modelSceneID = C_PetInfo.GetPetUIModelSceneID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modelSceneID = C_PetInfo.GetPetUIModelSceneID()
```

### C_PetInfo.GetSpellForPetAction

```lua
spellID = C_PetInfo.GetSpellForPetAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_PetInfo.GetSpellForPetAction(0)
```

### C_PetInfo.IsPetActionPassive

```lua
isPassive = C_PetInfo.IsPetActionPassive(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPassive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPassive = C_PetInfo.IsPetActionPassive(0)
```

### C_PetInfo.PetAbandon

```lua
C_PetInfo.PetAbandon([petNumber])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petNumber` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PetInfo.PetAbandon()
```

### C_PetInfo.PetAssistMode

```lua
C_PetInfo.PetAssistMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PetInfo.PetAssistMode()
```

### C_PetInfo.PetRename

```lua
C_PetInfo.PetRename(name, [petNumber], [declensions])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `petNumber` | number | yes |  |
| `declensions` | cstring[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PetInfo.PetRename("")
```

## Events

### PET_ATTACK_START

### PET_ATTACK_STOP

### PET_BAR_HIDEGRID

### PET_BAR_SHOWGRID

### PET_BAR_UPDATE_COOLDOWN

### PET_DISMISS_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delay` | number | no |  |

### PET_FORCE_NAME_DECLENSION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `petNumber` | number | yes |  |
| `declinedName1` | cstring | yes |  |
| `declinedName2` | cstring | yes |  |
| `declinedName3` | cstring | yes |  |
| `declinedName4` | cstring | yes |  |
| `declinedName5` | cstring | yes |  |

### PET_UI_CLOSE

### RAISED_AS_GHOUL

### UPDATE_POSSESS_BAR

### UPDATE_VEHICLE_ACTIONBAR

## Types

### PetTamerMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `atlasName` | string | yes |  |
| `textureIndex` | number | yes |  |

