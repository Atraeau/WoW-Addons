# C_DelvesUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**40** functions · **6** events · **5** types

## Functions

### C_DelvesUI.GetActiveDelveTier

Returns the entrance tier information for the active Delve (via party data). Assumes only Delves use this type for now.

```lua
tierInfo = C_DelvesUI.GetActiveDelveTier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierInfo` | TieredEntranceTierInfo | no |  |

**Example**

```lua
local tierInfo = C_DelvesUI.GetActiveDelveTier()
```

### C_DelvesUI.GetCompanionInfoForActivePlayer

```lua
playerCompanionInfoID = C_DelvesUI.GetCompanionInfoForActivePlayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerCompanionInfoID` | number | no |  |

**Example**

```lua
local playerCompanionInfoID = C_DelvesUI.GetCompanionInfoForActivePlayer()
```

### C_DelvesUI.GetCreatureDisplayInfoForCompanion

```lua
creatureDisplayInfoID = C_DelvesUI.GetCreatureDisplayInfoForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | no |  |

**Example**

```lua
local creatureDisplayInfoID = C_DelvesUI.GetCreatureDisplayInfoForCompanion()
```

### C_DelvesUI.GetCurioLink

Given the spell ID for an owned curio and its rarity, return a spell link style hyperlink for the curio spell, since they aren't items when learned

```lua
curioLink = C_DelvesUI.GetCurioLink(spellID, rarity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |
| `rarity` | CurioRarity | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curioLink` | cstring | no |  |

**Example**

```lua
local curioLink = C_DelvesUI.GetCurioLink(12345, rarity)
```

### C_DelvesUI.GetCurioNodeForCompanion

```lua
nodeID = C_DelvesUI.GetCurioNodeForCompanion(curioType, [companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curioType` | CurioType | no |  |
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example**

```lua
local nodeID = C_DelvesUI.GetCurioNodeForCompanion(curioType)
```

### C_DelvesUI.GetCurioRarityByTraitCondAccountElementID

```lua
rarity = C_DelvesUI.GetCurioRarityByTraitCondAccountElementID(traitCondAccountElementID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitCondAccountElementID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rarity` | CurioRarity | no |  |

**Example**

```lua
local rarity = C_DelvesUI.GetCurioRarityByTraitCondAccountElementID(0)
```

### C_DelvesUI.GetCurrentDelvesSeasonNumber

```lua
seasonNumber = C_DelvesUI.GetCurrentDelvesSeasonNumber()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seasonNumber` | number | no |  |

**Example**

```lua
local seasonNumber = C_DelvesUI.GetCurrentDelvesSeasonNumber()
```

### C_DelvesUI.GetDelveEntranceBackgroundWidgetSetID

```lua
backgroundWidgetSetID = C_DelvesUI.GetDelveEntranceBackgroundWidgetSetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `backgroundWidgetSetID` | number | no |  |

**Example**

```lua
local backgroundWidgetSetID = C_DelvesUI.GetDelveEntranceBackgroundWidgetSetID()
```

### C_DelvesUI.GetDelveEntranceDescriptionString

```lua
description = C_DelvesUI.GetDelveEntranceDescriptionString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | yes |  |

**Example**

```lua
local description = C_DelvesUI.GetDelveEntranceDescriptionString()
```

### C_DelvesUI.GetDelveEntranceHeaderString

```lua
header = C_DelvesUI.GetDelveEntranceHeaderString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `header` | string | yes |  |

**Example**

```lua
local header = C_DelvesUI.GetDelveEntranceHeaderString()
```

### C_DelvesUI.GetDelveEntranceMapID

```lua
mapID = C_DelvesUI.GetDelveEntranceMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Example**

```lua
local mapID = C_DelvesUI.GetDelveEntranceMapID()
```

### C_DelvesUI.GetDelveEntranceTiers

```lua
levelInfo = C_DelvesUI.GetDelveEntranceTiers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelInfo` | TieredEntranceTierInfo[] | no |  |

**Example**

```lua
local levelInfo = C_DelvesUI.GetDelveEntranceTiers()
```

### C_DelvesUI.GetDelveEntranceTitleString

```lua
title = C_DelvesUI.GetDelveEntranceTitleString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | yes |  |

**Example**

```lua
local title = C_DelvesUI.GetDelveEntranceTitleString()
```

### C_DelvesUI.GetDelvesAffixSpellsForSeason

```lua
affixSpellIDs = C_DelvesUI.GetDelvesAffixSpellsForSeason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `affixSpellIDs` | number[] | no |  |

**Example**

```lua
local affixSpellIDs = C_DelvesUI.GetDelvesAffixSpellsForSeason()
```

### C_DelvesUI.GetDelvesFactionForSeason

```lua
factionID = C_DelvesUI.GetDelvesFactionForSeason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Example**

```lua
local factionID = C_DelvesUI.GetDelvesFactionForSeason()
```

### C_DelvesUI.GetDelvesMinRequiredLevel

Players must be at or above the min level + offset to enter Delves. This function returns that min level.

```lua
minRequiredLevel = C_DelvesUI.GetDelvesMinRequiredLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minRequiredLevel` | number | yes |  |

**Example**

```lua
local minRequiredLevel = C_DelvesUI.GetDelvesMinRequiredLevel()
```

### C_DelvesUI.GetFactionForCompanion

```lua
factionID = C_DelvesUI.GetFactionForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Example**

```lua
local factionID = C_DelvesUI.GetFactionForCompanion()
```

### C_DelvesUI.GetFlavorNodeForCompanion

```lua
nodeID = C_DelvesUI.GetFlavorNodeForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example**

```lua
local nodeID = C_DelvesUI.GetFlavorNodeForCompanion()
```

### C_DelvesUI.GetFlavorNodeNameForCompanion

```lua
name = C_DelvesUI.GetFlavorNodeNameForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example**

```lua
local name = C_DelvesUI.GetFlavorNodeNameForCompanion()
```

### C_DelvesUI.GetLockedTextForCompanion

```lua
text = C_DelvesUI.GetLockedTextForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example**

```lua
local text = C_DelvesUI.GetLockedTextForCompanion()
```

### C_DelvesUI.GetModelSceneForCompanion

```lua
modelSceneID = C_DelvesUI.GetModelSceneForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneID` | number | no |  |

**Example**

```lua
local modelSceneID = C_DelvesUI.GetModelSceneForCompanion()
```

### C_DelvesUI.GetPlayerCompanionPDEID

```lua
pdeID = C_DelvesUI.GetPlayerCompanionPDEID([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pdeID` | number | no |  |

**Example**

```lua
local pdeID = C_DelvesUI.GetPlayerCompanionPDEID()
```

### C_DelvesUI.GetRoleNodeForCompanion

```lua
nodeID = C_DelvesUI.GetRoleNodeForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nodeID` | number | no |  |

**Example**

```lua
local nodeID = C_DelvesUI.GetRoleNodeForCompanion()
```

### C_DelvesUI.GetRoleSubtreeForCompanion

```lua
subTreeID = C_DelvesUI.GetRoleSubtreeForCompanion(roleType, [companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roleType` | CompanionRoleType | no |  |
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subTreeID` | number | no |  |

**Example**

```lua
local subTreeID = C_DelvesUI.GetRoleSubtreeForCompanion(roleType)
```

### C_DelvesUI.GetTieredEntranceOptionalAffixTraitTreeID

```lua
treeID = C_DelvesUI.GetTieredEntranceOptionalAffixTraitTreeID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | yes |  |

**Example**

```lua
local treeID = C_DelvesUI.GetTieredEntranceOptionalAffixTraitTreeID()
```

### C_DelvesUI.GetTieredEntrancePDEID

```lua
pdeID = C_DelvesUI.GetTieredEntrancePDEID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pdeID` | number | no |  |

**Example**

```lua
local pdeID = C_DelvesUI.GetTieredEntrancePDEID()
```

### C_DelvesUI.GetTieredEntranceType

```lua
entranceType = C_DelvesUI.GetTieredEntranceType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entranceType` | TieredEntranceType | no |  |

**Example**

```lua
local entranceType = C_DelvesUI.GetTieredEntranceType()
```

### C_DelvesUI.GetTraitTreeForCompanion

```lua
treeID = C_DelvesUI.GetTraitTreeForCompanion([companionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `companionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Example**

```lua
local treeID = C_DelvesUI.GetTraitTreeForCompanion()
```

### C_DelvesUI.GetUnseenCuriosBySlotType

```lua
unseenCurioNodeIDs = C_DelvesUI.GetUnseenCuriosBySlotType(slotType, ownedCurioNodeIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotType` | CompanionConfigSlotTypes | no |  |
| `ownedCurioNodeIDs` | number[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unseenCurioNodeIDs` | number[] | no |  |

**Example**

```lua
local unseenCurioNodeIDs = C_DelvesUI.GetUnseenCuriosBySlotType(1, ownedCurioNodeIDs)
```

### C_DelvesUI.GetWorldTierDifficultyForActivePlayer

```lua
difficulty = C_DelvesUI.GetWorldTierDifficultyForActivePlayer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficulty` | WorldTierDifficulty | no |  |

**Example**

```lua
local difficulty = C_DelvesUI.GetWorldTierDifficultyForActivePlayer()
```

### C_DelvesUI.HasActiveDelve

```lua
result = C_DelvesUI.HasActiveDelve()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_DelvesUI.HasActiveDelve()
```

### C_DelvesUI.HasActiveLair

```lua
result = C_DelvesUI.HasActiveLair()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_DelvesUI.HasActiveLair()
```

### C_DelvesUI.HasActiveLFGLair

```lua
result = C_DelvesUI.HasActiveLFGLair()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_DelvesUI.HasActiveLFGLair()
```

### C_DelvesUI.IsDelveEntranceTierEnabled

```lua
isEnabled, failureReason = C_DelvesUI.IsDelveEntranceTierEnabled(tier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tier` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |
| `failureReason` | string | yes |  |

**Example**

```lua
local isEnabled, failureReason = C_DelvesUI.IsDelveEntranceTierEnabled(0)
```

### C_DelvesUI.IsEligibleForActiveDelveRewards

```lua
result = C_DelvesUI.IsEligibleForActiveDelveRewards(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_DelvesUI.IsEligibleForActiveDelveRewards("player")
```

### C_DelvesUI.IsInLair

```lua
result = C_DelvesUI.IsInLair()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_DelvesUI.IsInLair()
```

### C_DelvesUI.IsTraitTreeForCompanion

```lua
isForCompanion = C_DelvesUI.IsTraitTreeForCompanion(traitTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `traitTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isForCompanion` | bool | no |  |

**Example**

```lua
local isForCompanion = C_DelvesUI.IsTraitTreeForCompanion(0)
```

### C_DelvesUI.RequestPartyEligibilityForDelveTiers

Queries private party members to see what level they have unlocked for the Delve. Ineligible members are added to the tooltip of dropdown entries.

```lua
C_DelvesUI.RequestPartyEligibilityForDelveTiers(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Example**

```lua
C_DelvesUI.RequestPartyEligibilityForDelveTiers(0)
```

### C_DelvesUI.SaveSeenCuriosBySlotType

```lua
C_DelvesUI.SaveSeenCuriosBySlotType(slotType, ownedCurioNodeIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotType` | CompanionConfigSlotTypes | no |  |
| `ownedCurioNodeIDs` | number[] | no |  |

**Example**

```lua
C_DelvesUI.SaveSeenCuriosBySlotType(1, ownedCurioNodeIDs)
```

### C_DelvesUI.SelectDelveEntranceTier

```lua
C_DelvesUI.SelectDelveEntranceTier(tier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tier` | number | no |  |

**Example**

```lua
C_DelvesUI.SelectDelveEntranceTier(0)
```

## Events

### ACTIVE_DELVE_DATA_UPDATE

Signaled when SpellScript calls change the data for players/parties owning a delve or when the delve is shut down.

### DELVE_ASSIST_ACTION

Signaled when an assist action occurs in a delve.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | DelveAssistActionData | no |  |

### DELVES_ACCOUNT_DATA_ELEMENT_CHANGED

Signaled when player account data element(s) have changed. This drives curio ranks, and the UI should update when this is sent.

### PARTY_ELIGIBILITY_FOR_DELVE_TIERS_CHANGED

Signaled when responses come in from RequestPartyEligibilityForDelveTiers.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string | no |  |
| `maxEligibleLevel` | number | no |  |

### SHOW_DELVES_COMPANION_CONFIGURATION_UI

Signaled when SpellScript indicates that a curio has been learned or upgraded. Will show the companion config UI.

### WALK_IN_DATA_UPDATE

Signaled when the player or a private party member join a new walk-in instance or when the instance is shut down.

## Types

### CompanionRoleType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Dps` | CompanionRoleType | no |  |
| `Heal` | CompanionRoleType | no |  |
| `Tank` | CompanionRoleType | no |  |

### CurioType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Combat` | CurioType | no |  |
| `Utility` | CurioType | no |  |

### TieredEntranceRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `quantity` | number | no |  |
| `rewardType` | TieredEntranceRewardType | no |  |
| `context` | ItemCreationContext | no |  |

### TieredEntranceRewardType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Item` | TieredEntranceRewardType | no |  |
| `Currency` | TieredEntranceRewardType | no |  |

### TieredEntranceTierInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tier` | number | no |  |
| `suggestedILvl` | number | no |  |
| `overrideTooltipSpellID` | number | no |  |
| `unlocked` | bool | no |  |
| `tierDescription` | string | no |  |
| `rewards` | TieredEntranceRewardInfo[] | no |  |
| `modifierUIWidgetSetID` | number | no |  |
| `lockedReason` | string | yes |  |
| `queueAsLFG` | bool | no |  |
| `difficultyID` | number | no |  |

