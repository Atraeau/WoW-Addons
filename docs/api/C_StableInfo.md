# C_StableInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**17** functions · **5** events · **2** types

## Functions

### C_StableInfo.BuyStableSlot

```lua
C_StableInfo.BuyStableSlot()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StableInfo.BuyStableSlot()
```

### C_StableInfo.ClosePetStables

```lua
C_StableInfo.ClosePetStables()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StableInfo.ClosePetStables()
```

### C_StableInfo.GetActivePetList

```lua
activePets = C_StableInfo.GetActivePetList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activePets` | PetInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activePets = C_StableInfo.GetActivePetList()
```

### C_StableInfo.GetAvailablePetSpecInfos

```lua
petSpecInfos = C_StableInfo.GetAvailablePetSpecInfos()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petSpecInfos` | PetSpecInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local petSpecInfos = C_StableInfo.GetAvailablePetSpecInfos()
```

### C_StableInfo.GetNextStableSlotCost

```lua
cost = C_StableInfo.GetNextStableSlotCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cost = C_StableInfo.GetNextStableSlotCost()
```

### C_StableInfo.GetNumActivePets

```lua
numActivePets = C_StableInfo.GetNumActivePets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numActivePets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numActivePets = C_StableInfo.GetNumActivePets()
```

### C_StableInfo.GetNumStablePets

```lua
numStablePets = C_StableInfo.GetNumStablePets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numStablePets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numStablePets = C_StableInfo.GetNumStablePets()
```

### C_StableInfo.GetNumStableSlots

```lua
numSlots = C_StableInfo.GetNumStableSlots()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSlots` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSlots = C_StableInfo.GetNumStableSlots()
```

### C_StableInfo.GetStabledPetList

```lua
stabledPets = C_StableInfo.GetStabledPetList()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stabledPets` | PetInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local stabledPets = C_StableInfo.GetStabledPetList()
```

### C_StableInfo.GetStablePetFoodTypes

```lua
foodTypes = C_StableInfo.GetStablePetFoodTypes(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `foodTypes` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local foodTypes = C_StableInfo.GetStablePetFoodTypes(1)
```

### C_StableInfo.GetStablePetInfo

```lua
petInfo = C_StableInfo.GetStablePetInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petInfo` | PetInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local petInfo = C_StableInfo.GetStablePetInfo(1)
```

### C_StableInfo.IsAtStableMaster

```lua
isAtStableMaster = C_StableInfo.IsAtStableMaster()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtStableMaster` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAtStableMaster = C_StableInfo.IsAtStableMaster()
```

### C_StableInfo.IsBonusPetSlotAvailable

```lua
isAvailable = C_StableInfo.IsBonusPetSlotAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAvailable = C_StableInfo.IsBonusPetSlotAvailable()
```

### C_StableInfo.IsPetFavorite

```lua
isFavorite = C_StableInfo.IsPetFavorite(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFavorite = C_StableInfo.IsPetFavorite(1)
```

### C_StableInfo.PickupStablePet

```lua
C_StableInfo.PickupStablePet(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StableInfo.PickupStablePet(1)
```

### C_StableInfo.SetPetFavorite

```lua
C_StableInfo.SetPetFavorite(slot, isFavorite)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |
| `isFavorite` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StableInfo.SetPetFavorite(1, false)
```

### C_StableInfo.SetPetSlot

```lua
C_StableInfo.SetPetSlot(index, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `slot` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_StableInfo.SetPetSlot(1, 1)
```

## Events

### PET_INFO_UPDATE

### PET_STABLE_CLOSED

### PET_STABLE_FAVORITES_UPDATED

### PET_STABLE_SHOW

### PET_STABLE_UPDATE

## Types

### PetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | number | no |  |
| `icon` | fileID | no |  |
| `name` | string | no |  |
| `level` | number | no |  |
| `familyName` | string | no |  |
| `specialization` | string | no |  |
| `type` | string | no |  |
| `petAbilities` | number[] | no |  |
| `specAbilities` | number[] | no |  |
| `displayID` | number | no |  |
| `isFavorite` | bool | no |  |
| `isExotic` | bool | no |  |
| `uiModelSceneID` | number | no | (default: 718) |
| `petNumber` | number | no |  |
| `creatureID` | number | no |  |
| `specID` | number | no |  |
| `loyaltyLevel` | number | no |  |
| `loyaltyName` | string | no |  |
| `happinessLevel` | number | no |  |
| `experience` | number | no |  |
| `experienceNeeded` | number | no |  |

### PetSpecInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `specIndex` | luaIndex | no |  |
| `specializationName` | string | no |  |

