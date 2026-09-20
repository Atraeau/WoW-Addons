# C_PetJournal

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**25** functions · **15** events · **3** types

## Functions

### C_PetJournal.ClearHoveredBattlePet

```lua
C_PetJournal.ClearHoveredBattlePet()
```

**Example**

```lua
C_PetJournal.ClearHoveredBattlePet()
```

### C_PetJournal.ClearSearchFilter

```lua
C_PetJournal.ClearSearchFilter()
```

**Example**

```lua
C_PetJournal.ClearSearchFilter()
```

### C_PetJournal.DismissSummonedPet

```lua
C_PetJournal.DismissSummonedPet(petID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | no |  |

**Example**

```lua
C_PetJournal.DismissSummonedPet(petID)
```

### C_PetJournal.GetDisplayIDByIndex

```lua
displayID = C_PetJournal.GetDisplayIDByIndex(speciesID, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayID` | number | yes |  |

**Example**

```lua
local displayID = C_PetJournal.GetDisplayIDByIndex(0, 1)
```

### C_PetJournal.GetDisplayProbabilityByIndex

```lua
displayProbability = C_PetJournal.GetDisplayProbabilityByIndex(speciesID, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayProbability` | number | yes |  |

**Example**

```lua
local displayProbability = C_PetJournal.GetDisplayProbabilityByIndex(0, 1)
```

### C_PetJournal.GetNonBattlePetLinkByIndex

```lua
link = C_PetJournal.GetNonBattlePetLinkByIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_PetJournal.GetNonBattlePetLinkByIndex(1)
```

### C_PetJournal.GetNumDisplays

```lua
numDisplays = C_PetJournal.GetNumDisplays(speciesID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numDisplays` | number | yes |  |

**Example**

```lua
local numDisplays = C_PetJournal.GetNumDisplays(0)
```

### C_PetJournal.GetNumPetsInJournal

```lua
maxAllowed, numPets = C_PetJournal.GetNumPetsInJournal(creatureID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxAllowed` | number | no |  |
| `numPets` | number | no |  |

**Example**

```lua
local maxAllowed, numPets = C_PetJournal.GetNumPetsInJournal(0)
```

### C_PetJournal.GetOwnedPetIDs

```lua
ownedPetIDs = C_PetJournal.GetOwnedPetIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownedPetIDs` | WOWGUID[] | no |  |

**Example**

```lua
local ownedPetIDs = C_PetJournal.GetOwnedPetIDs()
```

### C_PetJournal.GetPetAbilityInfo

```lua
name, icon, petType = C_PetJournal.GetPetAbilityInfo(abilityID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `abilityID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `petType` | number | no |  |

**Example**

```lua
local name, icon, petType = C_PetJournal.GetPetAbilityInfo(0)
```

### C_PetJournal.GetPetAbilityListTable

```lua
info = C_PetJournal.GetPetAbilityListTable(speciesID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PetAbilityLevelInfo[] | no |  |

**Example**

```lua
local info = C_PetJournal.GetPetAbilityListTable(0)
```

### C_PetJournal.GetPetInfoTableByPetID

```lua
info = C_PetJournal.GetPetInfoTableByPetID(petID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PetJournalPetInfo | no |  |

**Example**

```lua
local info = C_PetJournal.GetPetInfoTableByPetID(petID)
```

### C_PetJournal.GetPetInfoTableBySpeciesID

```lua
petInfo = C_PetJournal.GetPetInfoTableBySpeciesID(speciesID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petInfo` | PetJournalPetInfo | no |  |

**Example**

```lua
local petInfo = C_PetJournal.GetPetInfoTableBySpeciesID(0)
```

### C_PetJournal.GetPetLoadOutInfo

```lua
petID, ability1ID, ability2ID, ability3ID, locked = C_PetJournal.GetPetLoadOutInfo(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | yes |  |
| `ability1ID` | number | no |  |
| `ability2ID` | number | no |  |
| `ability3ID` | number | no |  |
| `locked` | bool | no |  |

**Example**

```lua
local petID, ability1ID, ability2ID, ability3ID, locked = C_PetJournal.GetPetLoadOutInfo(1)
```

### C_PetJournal.GetPetSummonInfo

```lua
isSummonable, error, errorText = C_PetJournal.GetPetSummonInfo(battlePetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSummonable` | bool | no |  |
| `error` | PetJournalError | no |  |
| `errorText` | cstring | no |  |

**Example**

```lua
local isSummonable, error, errorText = C_PetJournal.GetPetSummonInfo("Creature-0-0000-0-0-0-0")
```

### C_PetJournal.GetSearchFilter

```lua
filterText = C_PetJournal.GetSearchFilter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterText` | cstring | no |  |

**Example**

```lua
local filterText = C_PetJournal.GetSearchFilter()
```

### C_PetJournal.HasFavoritePets

```lua
hasFavorites = C_PetJournal.HasFavoritePets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFavorites` | bool | no |  |

**Example**

```lua
local hasFavorites = C_PetJournal.HasFavoritePets()
```

### C_PetJournal.IsCurrentlySummoned

```lua
isSummoned = C_PetJournal.IsCurrentlySummoned(petID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSummoned` | bool | no |  |

**Example**

```lua
local isSummoned = C_PetJournal.IsCurrentlySummoned(petID)
```

### C_PetJournal.IsUsingDefaultFilters

```lua
isUsingDefaultFilters = C_PetJournal.IsUsingDefaultFilters()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingDefaultFilters` | bool | no |  |

**Example**

```lua
local isUsingDefaultFilters = C_PetJournal.IsUsingDefaultFilters()
```

### C_PetJournal.PetIsSummonable

```lua
isSummonable = C_PetJournal.PetIsSummonable(battlePetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSummonable` | bool | no |  |

**Example**

```lua
local isSummonable = C_PetJournal.PetIsSummonable("Creature-0-0000-0-0-0-0")
```

### C_PetJournal.PetUsesRandomDisplay

```lua
usesRandomDisplay = C_PetJournal.PetUsesRandomDisplay(speciesID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usesRandomDisplay` | bool | yes |  |

**Example**

```lua
local usesRandomDisplay = C_PetJournal.PetUsesRandomDisplay(0)
```

### C_PetJournal.SetDefaultFilters

```lua
C_PetJournal.SetDefaultFilters()
```

**Example**

```lua
C_PetJournal.SetDefaultFilters()
```

### C_PetJournal.SetHoveredBattlePet

```lua
C_PetJournal.SetHoveredBattlePet(battlePetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

**Example**

```lua
C_PetJournal.SetHoveredBattlePet("Creature-0-0000-0-0-0-0")
```

### C_PetJournal.SetSearchFilter

```lua
C_PetJournal.SetSearchFilter(filterText)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filterText` | cstring | no |  |

**Example**

```lua
C_PetJournal.SetSearchFilter("HELPFUL")
```

### C_PetJournal.SpellTargetBattlePet

```lua
C_PetJournal.SpellTargetBattlePet(battlePetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

**Example**

```lua
C_PetJournal.SpellTargetBattlePet("Creature-0-0000-0-0-0-0")
```

## Events

### BATTLEPET_FORCE_NAME_DECLENSION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `battlePetGUID` | WOWGUID | no |  |

### COMPANION_LEARNED

### COMPANION_UNLEARNED

### COMPANION_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionType` | cstring | yes |  |

### NEW_PET_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

### PET_JOURNAL_AUTO_SLOTTED_PET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotIndex` | number | no |  |
| `battlePetGUID` | WOWGUID | no |  |

### PET_JOURNAL_CAGE_FAILED

### PET_JOURNAL_LIST_UPDATE

### PET_JOURNAL_NEW_BATTLE_SLOT

### PET_JOURNAL_PET_DELETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

### PET_JOURNAL_PET_RESTORED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

### PET_JOURNAL_PET_REVOKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlePetGUID` | WOWGUID | no |  |

### PET_JOURNAL_PETS_HEALED

### PET_JOURNAL_TRAP_LEVEL_SET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trapLevel` | number | no |  |

### UPDATE_SUMMONPETS_ACTION

## Types

### PetAbilityLevelInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `abilityID` | number | no |  |
| `level` | number | no |  |

### PetJournalError (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | PetJournalError | no |  |
| `PetIsDead` | PetJournalError | no |  |
| `JournalIsLocked` | PetJournalError | no |  |
| `InvalidFaction` | PetJournalError | no |  |
| `NoFavoritesToSummon` | PetJournalError | no |  |
| `NoValidRandomSummon` | PetJournalError | no |  |

### PetJournalPetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speciesID` | number | no |  |
| `customName` | cstring | yes |  |
| `petLevel` | number | yes |  |
| `xp` | number | yes |  |
| `maxXP` | number | yes |  |
| `displayID` | number | yes |  |
| `isFavorite` | bool | yes |  |
| `icon` | fileID | no |  |
| `petType` | luaIndex | no |  |
| `creatureID` | number | no |  |
| `name` | cstring | yes |  |
| `sourceText` | cstring | no |  |
| `description` | cstring | no |  |
| `isWild` | bool | yes |  |
| `canBattle` | bool | no |  |
| `tradable` | bool | no |  |
| `unique` | bool | no |  |
| `obtainable` | bool | no |  |
| `canAttachToDecor` | bool | no |  |
| `creatureModelScale` | number | yes |  |

