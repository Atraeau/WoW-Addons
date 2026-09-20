# C_SpecializationInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**31** functions · **10** events · **6** types

## Functions

### C_SpecializationInfo.CanPlayerUsePVPTalentUI

```lua
canUse, failureReason = C_SpecializationInfo.CanPlayerUsePVPTalentUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_SpecializationInfo.CanPlayerUsePVPTalentUI()
```

### C_SpecializationInfo.CanPlayerUseTalentSpecUI

```lua
canUse, failureReason = C_SpecializationInfo.CanPlayerUseTalentSpecUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_SpecializationInfo.CanPlayerUseTalentSpecUI()
```

### C_SpecializationInfo.CanPlayerUseTalentUI

```lua
canUse, failureReason = C_SpecializationInfo.CanPlayerUseTalentUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_SpecializationInfo.CanPlayerUseTalentUI()
```

### C_SpecializationInfo.GetActiveSpecGroup

```lua
groupIndex = C_SpecializationInfo.GetActiveSpecGroup([isInspect], [isPet])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInspect` | bool | yes |  |
| `isPet` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groupIndex = C_SpecializationInfo.GetActiveSpecGroup()
```

### C_SpecializationInfo.GetAllClassIDs

```lua
allClassIDs = C_SpecializationInfo.GetAllClassIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allClassIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allClassIDs = C_SpecializationInfo.GetAllClassIDs()
```

### C_SpecializationInfo.GetAllSelectedPvpTalentIDs

```lua
selectedPvpTalentIDs = C_SpecializationInfo.GetAllSelectedPvpTalentIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `selectedPvpTalentIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local selectedPvpTalentIDs = C_SpecializationInfo.GetAllSelectedPvpTalentIDs()
```

### C_SpecializationInfo.GetClassIDFromSpecID

```lua
classID = C_SpecializationInfo.GetClassIDFromSpecID(specID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local classID = C_SpecializationInfo.GetClassIDFromSpecID(0)
```

### C_SpecializationInfo.GetCombatConfigIDForSpecGroup

```lua
configID = C_SpecializationInfo.GetCombatConfigIDForSpecGroup(groupIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configID = C_SpecializationInfo.GetCombatConfigIDForSpecGroup(1)
```

### C_SpecializationInfo.GetInspectSelectedPvpTalent

```lua
selectedTalentID = C_SpecializationInfo.GetInspectSelectedPvpTalent(inspectedUnit, talentIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inspectedUnit` | UnitToken | no |  |
| `talentIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `selectedTalentID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local selectedTalentID = C_SpecializationInfo.GetInspectSelectedPvpTalent("player", 1)
```

### C_SpecializationInfo.GetInspectSpecialization

```lua
specializationID = C_SpecializationInfo.GetInspectSpecialization(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specializationID = C_SpecializationInfo.GetInspectSpecialization("player")
```

### C_SpecializationInfo.GetNumSpecializationsForClassID

```lua
specCount = C_SpecializationInfo.GetNumSpecializationsForClassID(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specCount` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specCount = C_SpecializationInfo.GetNumSpecializationsForClassID(0)
```

### C_SpecializationInfo.GetPvpTalentAlertStatus

```lua
hasUnspentSlot, hasNewTalent = C_SpecializationInfo.GetPvpTalentAlertStatus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasUnspentSlot` | bool | no |  |
| `hasNewTalent` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasUnspentSlot, hasNewTalent = C_SpecializationInfo.GetPvpTalentAlertStatus()
```

### C_SpecializationInfo.GetPvpTalentInfo

```lua
talentInfo = C_SpecializationInfo.GetPvpTalentInfo(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentInfo` | PvpTalentInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local talentInfo = C_SpecializationInfo.GetPvpTalentInfo(0)
```

### C_SpecializationInfo.GetPvpTalentSlotInfo

```lua
slotInfo = C_SpecializationInfo.GetPvpTalentSlotInfo(talentIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotInfo` | PvpTalentSlotInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local slotInfo = C_SpecializationInfo.GetPvpTalentSlotInfo(1)
```

### C_SpecializationInfo.GetPvpTalentSlotUnlockLevel

```lua
requiredLevel = C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(talentIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requiredLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requiredLevel = C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(1)
```

### C_SpecializationInfo.GetPvpTalentUnlockLevel

```lua
requiredLevel = C_SpecializationInfo.GetPvpTalentUnlockLevel(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requiredLevel` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requiredLevel = C_SpecializationInfo.GetPvpTalentUnlockLevel(0)
```

### C_SpecializationInfo.GetSpecialization

```lua
specializationIndex = C_SpecializationInfo.GetSpecialization([isInspect], [isPet], [specGroupIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInspect` | bool | yes |  |
| `isPet` | bool | yes |  |
| `specGroupIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specializationIndex = C_SpecializationInfo.GetSpecialization()
```

### C_SpecializationInfo.GetSpecializationInfo

```lua
specId, name, description, icon, role, primaryStat, pointsSpent, background, previewPointsSpent, isUnlocked = C_SpecializationInfo.GetSpecializationInfo(specializationIndex, isInspect, isPet, [inspectTarget], [sex], [groupIndex], [classID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationIndex` | luaIndex | no |  |
| `isInspect` | bool | no | (default: False) |
| `isPet` | bool | no | (default: False) |
| `inspectTarget` | string | yes |  |
| `sex` | number | yes |  |
| `groupIndex` | luaIndex | yes |  |
| `classID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specId` | number | no | (default: 0) |
| `name` | string | yes |  |
| `description` | string | yes |  |
| `icon` | fileID | yes |  |
| `role` | string | yes |  |
| `primaryStat` | luaIndex | yes |  |
| `pointsSpent` | number | no | (default: 0) |
| `background` | string | yes |  |
| `previewPointsSpent` | number | no | (default: 0) |
| `isUnlocked` | bool | no | (default: True) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specId, name, description, icon, role, primaryStat, pointsSpent, background, previewPointsSpent, isUnlocked = C_SpecializationInfo.GetSpecializationInfo(1, false, false)
```

### C_SpecializationInfo.GetSpecializationMasterySpells

```lua
spellIDs = C_SpecializationInfo.GetSpecializationMasterySpells(specializationIndex, [isInspect], [isPet])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationIndex` | luaIndex | no |  |
| `isInspect` | bool | yes |  |
| `isPet` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellIDs = C_SpecializationInfo.GetSpecializationMasterySpells(1)
```

### C_SpecializationInfo.GetSpecIDs

```lua
specIDs = C_SpecializationInfo.GetSpecIDs(specSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specIDs = C_SpecializationInfo.GetSpecIDs(0)
```

### C_SpecializationInfo.GetSpellsDisplay

```lua
spellID = C_SpecializationInfo.GetSpellsDisplay(specializationID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_SpecializationInfo.GetSpellsDisplay(0)
```

### C_SpecializationInfo.GetTalentInfo

```lua
result = C_SpecializationInfo.GetTalentInfo(query)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `query` | TalentInfoQuery | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | TalentInfoResult | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_SpecializationInfo.GetTalentInfo(query)
```

### C_SpecializationInfo.HasPlayerEarnedATalentPoint

```lua
hasEarned = C_SpecializationInfo.HasPlayerEarnedATalentPoint()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasEarned` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasEarned = C_SpecializationInfo.HasPlayerEarnedATalentPoint()
```

### C_SpecializationInfo.IsInitialized

```lua
isSpecializationDataInitialized = C_SpecializationInfo.IsInitialized()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpecializationDataInitialized` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSpecializationDataInitialized = C_SpecializationInfo.IsInitialized()
```

### C_SpecializationInfo.IsPvpTalentLocked

```lua
locked = C_SpecializationInfo.IsPvpTalentLocked(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local locked = C_SpecializationInfo.IsPvpTalentLocked(0)
```

### C_SpecializationInfo.IsSpecSelectionEnabled

```lua
enabled = C_SpecializationInfo.IsSpecSelectionEnabled(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_SpecializationInfo.IsSpecSelectionEnabled(0)
```

### C_SpecializationInfo.MatchesCurrentSpecSet

```lua
matches = C_SpecializationInfo.MatchesCurrentSpecSet(specSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matches` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matches = C_SpecializationInfo.MatchesCurrentSpecSet(0)
```

### C_SpecializationInfo.SetActiveSpecGroup

```lua
C_SpecializationInfo.SetActiveSpecGroup(groupIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpecializationInfo.SetActiveSpecGroup(1)
```

### C_SpecializationInfo.SetPetSpecialization

```lua
C_SpecializationInfo.SetPetSpecialization(specIndex, [petNumber])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | luaIndex | no |  |
| `petNumber` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpecializationInfo.SetPetSpecialization(1)
```

### C_SpecializationInfo.SetPvpTalentLocked

```lua
C_SpecializationInfo.SetPvpTalentLocked(talentID, locked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `locked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SpecializationInfo.SetPvpTalentLocked(0, false)
```

### C_SpecializationInfo.SetSpecialization

```lua
success = C_SpecializationInfo.SetSpecialization(specIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_SpecializationInfo.SetSpecialization(1)
```

## Events

### ACTIVE_TALENT_GROUP_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curr` | number | no |  |
| `prev` | number | no |  |

### CONFIRM_PET_UNLEARN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

### CONFIRM_TALENT_WIPE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |
| `respecType` | number | no |  |

### PET_SPECIALIZATION_CHANGED

### PLAYER_LEARN_PVP_TALENT_FAILED

### PLAYER_LEARN_TALENT_FAILED

### PLAYER_PVP_TALENT_UPDATE

### PLAYER_TALENT_UPDATE

### SPEC_INVOLUNTARILY_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPet` | bool | no |  |

### TALENTS_INVOLUNTARILY_RESET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPetTalents` | bool | no |  |

## Types

### PvpTalentInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |
| `name` | string | no |  |
| `icon` | number | no |  |
| `selected` | bool | no |  |
| `available` | bool | no |  |
| `spellID` | number | no |  |
| `unlocked` | bool | no |  |
| `known` | bool | no |  |
| `grantedByAura` | bool | no |  |
| `dependenciesUnmet` | bool | no |  |
| `dependenciesUnmetReason` | string | yes |  |

### PvpTalentSlotInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |
| `level` | number | no |  |
| `selectedTalentID` | number | yes |  |
| `availableTalentIDs` | number[] | no |  |

### SpecializationInfoOutput (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specId` | number | no | (default: 0) |
| `name` | string | yes |  |
| `description` | string | yes |  |
| `icon` | fileID | yes |  |
| `role` | string | yes |  |
| `primaryStat` | luaIndex | yes |  |
| `pointsSpent` | number | no | (default: 0) |
| `background` | string | yes |  |
| `previewPointsSpent` | number | no | (default: 0) |
| `isUnlocked` | bool | no | (default: True) |

### SpecializationInfoQuery (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationIndex` | luaIndex | no |  |
| `isInspect` | bool | no | (default: False) |
| `isPet` | bool | no | (default: False) |
| `inspectTarget` | string | yes |  |
| `sex` | number | yes |  |
| `groupIndex` | luaIndex | yes |  |
| `classID` | number | yes |  |

### TalentInfoQuery (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groupIndex` | luaIndex | yes |  |
| `isInspect` | bool | no | (default: False) |
| `tier` | luaIndex | yes |  |
| `column` | luaIndex | yes |  |
| `target` | UnitToken | yes |  |
| `specializationIndex` | luaIndex | yes |  |
| `talentIndex` | luaIndex | yes |  |
| `isPet` | bool | no | (default: False) |

### TalentInfoResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no | (default: 0) |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `tier` | luaIndex | no |  |
| `column` | luaIndex | no |  |
| `selected` | bool | no | (default: False) |
| `available` | bool | no | (default: False) |
| `spellID` | number | no | (default: 0) |
| `isPVPTalentUnlocked` | bool | no | (default: False) |
| `known` | bool | no | (default: False) |
| `grantedByAura` | bool | no | (default: False) |
| `rank` | luaIndex | no |  |
| `maxRank` | luaIndex | no |  |
| `meetsPrereq` | bool | no | (default: False) |
| `previewRank` | luaIndex | no |  |
| `meetsPreviewPrereq` | bool | no | (default: False) |
| `isExceptional` | bool | no | (default: False) |
| `hasGoldBorder` | bool | no | (default: False) |

