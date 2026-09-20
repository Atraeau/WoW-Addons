# C_ArtifactUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**62** functions · **10** events · **7** types

## Functions

### C_ArtifactUI.AddPower

```lua
success = C_ArtifactUI.AddPower(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_ArtifactUI.AddPower(0)
```

### C_ArtifactUI.ApplyCursorRelicToSlot

```lua
C_ArtifactUI.ApplyCursorRelicToSlot(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Example**

```lua
C_ArtifactUI.ApplyCursorRelicToSlot(1)
```

### C_ArtifactUI.CanApplyArtifactRelic

```lua
canApply = C_ArtifactUI.CanApplyArtifactRelic(relicItemID, onlyUnlocked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicItemID` | number | no |  |
| `onlyUnlocked` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canApply` | bool | no |  |

**Example**

```lua
local canApply = C_ArtifactUI.CanApplyArtifactRelic(6948, false)
```

### C_ArtifactUI.CanApplyCursorRelicToSlot

```lua
canApply = C_ArtifactUI.CanApplyCursorRelicToSlot(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canApply` | bool | no |  |

**Example**

```lua
local canApply = C_ArtifactUI.CanApplyCursorRelicToSlot(1)
```

### C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot

```lua
canApply = C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(relicItemID, relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicItemID` | number | no |  |
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canApply` | bool | no |  |

**Example**

```lua
local canApply = C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(6948, 1)
```

### C_ArtifactUI.CanApplyRelicItemIDToSlot

```lua
canApply = C_ArtifactUI.CanApplyRelicItemIDToSlot(relicItemID, relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicItemID` | number | no |  |
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canApply` | bool | no |  |

**Example**

```lua
local canApply = C_ArtifactUI.CanApplyRelicItemIDToSlot(6948, 1)
```

### C_ArtifactUI.CheckRespecNPC

```lua
canRespec = C_ArtifactUI.CheckRespecNPC()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRespec` | bool | no |  |

**Example**

```lua
local canRespec = C_ArtifactUI.CheckRespecNPC()
```

### C_ArtifactUI.Clear

```lua
C_ArtifactUI.Clear()
```

**Example**

```lua
C_ArtifactUI.Clear()
```

### C_ArtifactUI.ClearForgeCamera

```lua
C_ArtifactUI.ClearForgeCamera()
```

**Example**

```lua
C_ArtifactUI.ClearForgeCamera()
```

### C_ArtifactUI.ConfirmRespec

```lua
C_ArtifactUI.ConfirmRespec()
```

**Example**

```lua
C_ArtifactUI.ConfirmRespec()
```

### C_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted

```lua
hasAnyRelicsSlotted = C_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyRelicsSlotted` | bool | no |  |

**Example**

```lua
local hasAnyRelicsSlotted = C_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted()
```

### C_ArtifactUI.GetAppearanceInfo

```lua
artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfo(appearanceSetIndex, appearanceIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceSetIndex` | number | no |  |
| `appearanceIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no |  |
| `appearanceName` | string | no |  |
| `displayIndex` | number | no |  |
| `unlocked` | bool | no |  |
| `failureDescription` | string | yes |  |
| `uiCameraID` | number | no |  |
| `altHandCameraID` | number | yes |  |
| `swatchColorR` | number | no |  |
| `swatchColorG` | number | no |  |
| `swatchColorB` | number | no |  |
| `modelOpacity` | number | no |  |
| `modelSaturation` | number | no |  |
| `obtainable` | bool | no |  |

**Example**

```lua
local artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfo(1, 1)
```

### C_ArtifactUI.GetAppearanceInfoByID

```lua
artifactAppearanceSetID, artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfoByID(artifactAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceSetID` | number | no |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceName` | string | no |  |
| `displayIndex` | number | no |  |
| `unlocked` | bool | no |  |
| `failureDescription` | string | yes |  |
| `uiCameraID` | number | no |  |
| `altHandCameraID` | number | yes |  |
| `swatchColorR` | number | no |  |
| `swatchColorG` | number | no |  |
| `swatchColorB` | number | no |  |
| `modelOpacity` | number | no |  |
| `modelSaturation` | number | no |  |
| `obtainable` | bool | no |  |

**Example**

```lua
local artifactAppearanceSetID, artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfoByID(0)
```

### C_ArtifactUI.GetAppearanceSetInfo

```lua
artifactAppearanceSetID, appearanceSetName, appearanceSetDescription, numAppearances = C_ArtifactUI.GetAppearanceSetInfo(appearanceSetIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceSetIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceSetID` | number | no |  |
| `appearanceSetName` | string | no |  |
| `appearanceSetDescription` | string | no |  |
| `numAppearances` | number | no |  |

**Example**

```lua
local artifactAppearanceSetID, appearanceSetName, appearanceSetDescription, numAppearances = C_ArtifactUI.GetAppearanceSetInfo(1)
```

### C_ArtifactUI.GetArtifactArtInfo

```lua
artifactArtInfo = C_ArtifactUI.GetArtifactArtInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactArtInfo` | ArtifactArtInfo | no |  |

**Example**

```lua
local artifactArtInfo = C_ArtifactUI.GetArtifactArtInfo()
```

### C_ArtifactUI.GetArtifactInfo

```lua
itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetArtifactInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `xp` | number | no |  |
| `pointsSpent` | number | no |  |
| `quality` | number | no |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |
| `tier` | ArtifactTiers | no |  |

**Example**

```lua
local itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetArtifactInfo()
```

### C_ArtifactUI.GetArtifactItemID

```lua
itemID = C_ArtifactUI.GetArtifactItemID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example**

```lua
local itemID = C_ArtifactUI.GetArtifactItemID()
```

### C_ArtifactUI.GetArtifactTier

```lua
tier = C_ArtifactUI.GetArtifactTier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tier` | ArtifactTiers | yes |  |

**Example**

```lua
local tier = C_ArtifactUI.GetArtifactTier()
```

### C_ArtifactUI.GetArtifactXPRewardTargetInfo

```lua
name, icon = C_ArtifactUI.GetArtifactXPRewardTargetInfo(artifactCategoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactCategoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |

**Example**

```lua
local name, icon = C_ArtifactUI.GetArtifactXPRewardTargetInfo(0)
```

### C_ArtifactUI.GetCostForPointAtRank

```lua
cost = C_ArtifactUI.GetCostForPointAtRank(rank, tier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rank` | number | no |  |
| `tier` | ArtifactTiers | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example**

```lua
local cost = C_ArtifactUI.GetCostForPointAtRank(1, tier)
```

### C_ArtifactUI.GetEquippedArtifactArtInfo

```lua
artifactArtInfo = C_ArtifactUI.GetEquippedArtifactArtInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactArtInfo` | ArtifactArtInfo | no |  |

**Example**

```lua
local artifactArtInfo = C_ArtifactUI.GetEquippedArtifactArtInfo()
```

### C_ArtifactUI.GetEquippedArtifactInfo

```lua
itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetEquippedArtifactInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `xp` | number | no |  |
| `pointsSpent` | number | no |  |
| `quality` | number | no |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |
| `tier` | ArtifactTiers | no |  |

**Example**

```lua
local itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetEquippedArtifactInfo()
```

### C_ArtifactUI.GetEquippedArtifactItemID

```lua
itemID = C_ArtifactUI.GetEquippedArtifactItemID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Example**

```lua
local itemID = C_ArtifactUI.GetEquippedArtifactItemID()
```

### C_ArtifactUI.GetEquippedArtifactNumRelicSlots

```lua
numRelicSlots = C_ArtifactUI.GetEquippedArtifactNumRelicSlots(onlyUnlocked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onlyUnlocked` | bool | no | If true then only the relic slots that are unlocked will be considered. (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRelicSlots` | number | no |  |

**Example**

```lua
local numRelicSlots = C_ArtifactUI.GetEquippedArtifactNumRelicSlots(false)
```

### C_ArtifactUI.GetEquippedArtifactRelicInfo

```lua
name, icon, slotTypeName, link = C_ArtifactUI.GetEquippedArtifactRelicInfo(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `slotTypeName` | cstring | no | Matches the socket identifiers used in the socketing system. |
| `link` | string | no |  |

**Example**

```lua
local name, icon, slotTypeName, link = C_ArtifactUI.GetEquippedArtifactRelicInfo(1)
```

### C_ArtifactUI.GetEquippedRelicLockedReason

```lua
lockedReason = C_ArtifactUI.GetEquippedRelicLockedReason(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lockedReason` | string | yes |  |

**Example**

```lua
local lockedReason = C_ArtifactUI.GetEquippedRelicLockedReason(1)
```

### C_ArtifactUI.GetForgeRotation

```lua
forgeRotationX, forgeRotationY, forgeRotationZ = C_ArtifactUI.GetForgeRotation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forgeRotationX` | number | no |  |
| `forgeRotationY` | number | no |  |
| `forgeRotationZ` | number | no |  |

**Example**

```lua
local forgeRotationX, forgeRotationY, forgeRotationZ = C_ArtifactUI.GetForgeRotation()
```

### C_ArtifactUI.GetItemLevelIncreaseProvidedByRelic

```lua
itemIevelIncrease = C_ArtifactUI.GetItemLevelIncreaseProvidedByRelic(itemLinkOrID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLinkOrID` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIevelIncrease` | number | no |  |

**Example**

```lua
local itemIevelIncrease = C_ArtifactUI.GetItemLevelIncreaseProvidedByRelic(6948)
```

### C_ArtifactUI.GetMetaPowerInfo

```lua
spellID, powerCost, currentRank = C_ArtifactUI.GetMetaPowerInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `powerCost` | number | no |  |
| `currentRank` | number | no |  |

**Example**

```lua
local spellID, powerCost, currentRank = C_ArtifactUI.GetMetaPowerInfo()
```

### C_ArtifactUI.GetNumAppearanceSets

```lua
numAppearanceSets = C_ArtifactUI.GetNumAppearanceSets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numAppearanceSets` | number | no |  |

**Example**

```lua
local numAppearanceSets = C_ArtifactUI.GetNumAppearanceSets()
```

### C_ArtifactUI.GetNumObtainedArtifacts

```lua
numObtainedArtifacts = C_ArtifactUI.GetNumObtainedArtifacts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numObtainedArtifacts` | number | no |  |

**Example**

```lua
local numObtainedArtifacts = C_ArtifactUI.GetNumObtainedArtifacts()
```

### C_ArtifactUI.GetNumRelicSlots

```lua
numRelicSlots = C_ArtifactUI.GetNumRelicSlots(onlyUnlocked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onlyUnlocked` | bool | no | If true then only the relic slots that are unlocked will be considered. (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRelicSlots` | number | no |  |

**Example**

```lua
local numRelicSlots = C_ArtifactUI.GetNumRelicSlots(false)
```

### C_ArtifactUI.GetPointsRemaining

```lua
pointsRemaining = C_ArtifactUI.GetPointsRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointsRemaining` | number | no |  |

**Example**

```lua
local pointsRemaining = C_ArtifactUI.GetPointsRemaining()
```

### C_ArtifactUI.GetPowerHyperlink

```lua
link = C_ArtifactUI.GetPowerHyperlink(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | cstring | no |  |

**Example**

```lua
local link = C_ArtifactUI.GetPowerHyperlink(0)
```

### C_ArtifactUI.GetPowerInfo

```lua
powerInfo = C_ArtifactUI.GetPowerInfo(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerInfo` | ArtifactPowerInfo | no |  |

**Example**

```lua
local powerInfo = C_ArtifactUI.GetPowerInfo(0)
```

### C_ArtifactUI.GetPowerLinks

```lua
linkingPowerID = C_ArtifactUI.GetPowerLinks(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `linkingPowerID` | number[] | no |  |

**Example**

```lua
local linkingPowerID = C_ArtifactUI.GetPowerLinks(0)
```

### C_ArtifactUI.GetPowers

```lua
powerID = C_ArtifactUI.GetPowers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number[] | no |  |

**Example**

```lua
local powerID = C_ArtifactUI.GetPowers()
```

### C_ArtifactUI.GetPowersAffectedByRelic

```lua
powerIDs = C_ArtifactUI.GetPowersAffectedByRelic(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerIDs` | number | no |  |

**Example**

```lua
local powerIDs = C_ArtifactUI.GetPowersAffectedByRelic(1)
```

### C_ArtifactUI.GetPowersAffectedByRelicItemLink

```lua
powerIDs = C_ArtifactUI.GetPowersAffectedByRelicItemLink(relicItemInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicItemInfo` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerIDs` | number | no |  |

**Example**

```lua
local powerIDs = C_ArtifactUI.GetPowersAffectedByRelicItemLink(6948)
```

### C_ArtifactUI.GetPreviewAppearance

```lua
artifactAppearanceID = C_ArtifactUI.GetPreviewAppearance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | yes |  |

**Example**

```lua
local artifactAppearanceID = C_ArtifactUI.GetPreviewAppearance()
```

### C_ArtifactUI.GetRelicInfo

```lua
name, icon, slotTypeName, link = C_ArtifactUI.GetRelicInfo(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `slotTypeName` | cstring | no | Matches the socket identifiers used in the socketing system. |
| `link` | string | no |  |

**Example**

```lua
local name, icon, slotTypeName, link = C_ArtifactUI.GetRelicInfo(1)
```

### C_ArtifactUI.GetRelicInfoByItemID

```lua
name, icon, slotTypeName, link = C_ArtifactUI.GetRelicInfoByItemID(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `slotTypeName` | cstring | no | Matches the socket identifiers used in the socketing system. |
| `link` | string | no |  |

**Example**

```lua
local name, icon, slotTypeName, link = C_ArtifactUI.GetRelicInfoByItemID(6948)
```

### C_ArtifactUI.GetRelicLockedReason

```lua
lockedReason = C_ArtifactUI.GetRelicLockedReason(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lockedReason` | string | yes |  |

**Example**

```lua
local lockedReason = C_ArtifactUI.GetRelicLockedReason(1)
```

### C_ArtifactUI.GetRelicSlotType

```lua
slotTypeName = C_ArtifactUI.GetRelicSlotType(relicSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `relicSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotTypeName` | cstring | no |  |

**Example**

```lua
local slotTypeName = C_ArtifactUI.GetRelicSlotType(1)
```

### C_ArtifactUI.GetRespecArtifactArtInfo

```lua
artifactArtInfo = C_ArtifactUI.GetRespecArtifactArtInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactArtInfo` | ArtifactArtInfo | no |  |

**Example**

```lua
local artifactArtInfo = C_ArtifactUI.GetRespecArtifactArtInfo()
```

### C_ArtifactUI.GetRespecArtifactInfo

```lua
itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetRespecArtifactInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `xp` | number | no |  |
| `pointsSpent` | number | no |  |
| `quality` | number | no |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |
| `tier` | ArtifactTiers | no |  |

**Example**

```lua
local itemID, altItemID, name, icon, xp, pointsSpent, quality, artifactAppearanceID, appearanceModID, itemAppearanceID, altItemAppearanceID, altOnTop, tier = C_ArtifactUI.GetRespecArtifactInfo()
```

### C_ArtifactUI.GetRespecCost

```lua
cost = C_ArtifactUI.GetRespecCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example**

```lua
local cost = C_ArtifactUI.GetRespecCost()
```

### C_ArtifactUI.GetTotalPowerCost

```lua
totalArtifactPowerCost = C_ArtifactUI.GetTotalPowerCost(startingTrait, numTraits, artifactTier)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startingTrait` | luaIndex | no |  |
| `numTraits` | number | no |  |
| `artifactTier` | ArtifactTiers | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalArtifactPowerCost` | number | no |  |

**Example**

```lua
local totalArtifactPowerCost = C_ArtifactUI.GetTotalPowerCost(startingTrait, 0, artifactTier)
```

### C_ArtifactUI.GetTotalPurchasedRanks

```lua
totalPurchasedRanks = C_ArtifactUI.GetTotalPurchasedRanks()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalPurchasedRanks` | number | no |  |

**Example**

```lua
local totalPurchasedRanks = C_ArtifactUI.GetTotalPurchasedRanks()
```

### C_ArtifactUI.IsArtifactDisabled

```lua
artifactDisabled = C_ArtifactUI.IsArtifactDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactDisabled` | bool | no |  |

**Example**

```lua
local artifactDisabled = C_ArtifactUI.IsArtifactDisabled()
```

### C_ArtifactUI.IsArtifactItem

```lua
isArtifact = C_ArtifactUI.IsArtifactItem(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isArtifact` | bool | no |  |

**Example**

```lua
local isArtifact = C_ArtifactUI.IsArtifactItem(6948)
```

### C_ArtifactUI.IsAtForge

```lua
isAtForge = C_ArtifactUI.IsAtForge()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtForge` | bool | no |  |

**Example**

```lua
local isAtForge = C_ArtifactUI.IsAtForge()
```

### C_ArtifactUI.IsEquippedArtifactDisabled

```lua
artifactDisabled = C_ArtifactUI.IsEquippedArtifactDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactDisabled` | bool | no |  |

**Example**

```lua
local artifactDisabled = C_ArtifactUI.IsEquippedArtifactDisabled()
```

### C_ArtifactUI.IsEquippedArtifactMaxed

```lua
artifactMaxed = C_ArtifactUI.IsEquippedArtifactMaxed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactMaxed` | bool | no |  |

**Example**

```lua
local artifactMaxed = C_ArtifactUI.IsEquippedArtifactMaxed()
```

### C_ArtifactUI.IsMaxedByRulesOrEffect

```lua
isEffectivelyMaxed = C_ArtifactUI.IsMaxedByRulesOrEffect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEffectivelyMaxed` | bool | no |  |

**Example**

```lua
local isEffectivelyMaxed = C_ArtifactUI.IsMaxedByRulesOrEffect()
```

### C_ArtifactUI.IsPowerKnown

```lua
known = C_ArtifactUI.IsPowerKnown(powerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `known` | bool | no |  |

**Example**

```lua
local known = C_ArtifactUI.IsPowerKnown(0)
```

### C_ArtifactUI.IsViewedArtifactEquipped

```lua
isViewedArtifactEquipped = C_ArtifactUI.IsViewedArtifactEquipped()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isViewedArtifactEquipped` | bool | no |  |

**Example**

```lua
local isViewedArtifactEquipped = C_ArtifactUI.IsViewedArtifactEquipped()
```

### C_ArtifactUI.SetAppearance

```lua
C_ArtifactUI.SetAppearance(artifactAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no |  |

**Example**

```lua
C_ArtifactUI.SetAppearance(0)
```

### C_ArtifactUI.SetForgeCamera

```lua
C_ArtifactUI.SetForgeCamera()
```

**Example**

```lua
C_ArtifactUI.SetForgeCamera()
```

### C_ArtifactUI.SetForgeRotation

```lua
C_ArtifactUI.SetForgeRotation(forgeRotationX, forgeRotationY, forgeRotationZ)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forgeRotationX` | number | no |  |
| `forgeRotationY` | number | no |  |
| `forgeRotationZ` | number | no |  |

**Example**

```lua
C_ArtifactUI.SetForgeRotation(0, 0, 0)
```

### C_ArtifactUI.SetPreviewAppearance

Call without an argument to clear the preview.

```lua
C_ArtifactUI.SetPreviewAppearance(artifactAppearanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no | (default: 0) |

**Example**

```lua
C_ArtifactUI.SetPreviewAppearance(0)
```

### C_ArtifactUI.ShouldSuppressForgeRotation

```lua
shouldSuppressForgeRotation = C_ArtifactUI.ShouldSuppressForgeRotation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldSuppressForgeRotation` | bool | no |  |

**Example**

```lua
local shouldSuppressForgeRotation = C_ArtifactUI.ShouldSuppressForgeRotation()
```

## Events

### ARTIFACT_CLOSE

### ARTIFACT_ENDGAME_REFUND

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRefundedPowers` | number | no |  |
| `refundedTier` | ArtifactTiers | no |  |
| `bagOrSlotIndex` | luaIndex | no |  |
| `slotIndex` | luaIndex | yes |  |

### ARTIFACT_RELIC_FORGE_CLOSE

### ARTIFACT_RELIC_FORGE_PREVIEW_RELIC_CHANGED

### ARTIFACT_RELIC_FORGE_UPDATE

### ARTIFACT_RELIC_INFO_RECEIVED

### ARTIFACT_RESPEC_PROMPT

### ARTIFACT_TIER_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newTier` | luaIndex | no |  |
| `bagOrSlotIndex` | luaIndex | no |  |
| `slotIndex` | luaIndex | yes |  |

### ARTIFACT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newItem` | bool | no |  |

### ARTIFACT_XP_UPDATE

## Types

### ArtifactAppearanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceID` | number | no |  |
| `appearanceName` | string | no |  |
| `displayIndex` | number | no |  |
| `unlocked` | bool | no |  |
| `failureDescription` | string | yes |  |
| `uiCameraID` | number | no |  |
| `altHandCameraID` | number | yes |  |
| `swatchColor` | colorRGB | no |  |
| `modelOpacity` | number | no |  |
| `modelSaturation` | number | no |  |
| `obtainable` | bool | no |  |

### ArtifactAppearanceSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `artifactAppearanceSetID` | number | no |  |
| `appearanceSetName` | string | no |  |
| `appearanceSetDescription` | string | no |  |
| `numAppearances` | number | no |  |

### ArtifactArtInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `titleName` | string | no |  |
| `titleColor` | colorRGB | no |  |
| `barConnectedColor` | colorRGB | no |  |
| `barDisconnectedColor` | colorRGB | no |  |
| `uiModelSceneID` | number | no |  |
| `spellVisualKitID` | number | no |  |

### ArtifactInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `altItemID` | number | yes |  |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `xp` | number | no |  |
| `pointsSpent` | number | no |  |
| `quality` | number | no |  |
| `artifactAppearanceID` | number | no |  |
| `appearanceModID` | number | no |  |
| `itemAppearanceID` | number | yes |  |
| `altItemAppearanceID` | number | yes |  |
| `altOnTop` | bool | no |  |
| `tier` | ArtifactTiers | no |  |

### ArtifactMetaPowerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `powerCost` | number | no |  |
| `currentRank` | number | no |  |

### ArtifactPowerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `cost` | number | no |  |
| `currentRank` | number | no |  |
| `maxRank` | number | no |  |
| `bonusRanks` | number | no |  |
| `numMaxRankBonusFromTier` | number | no |  |
| `prereqsMet` | bool | no |  |
| `isStart` | bool | no |  |
| `isGoldMedal` | bool | no |  |
| `isFinal` | bool | no |  |
| `tier` | luaIndex | no |  |
| `position` | vector2 | no |  |
| `offset` | vector2 | yes |  |
| `linearIndex` | luaIndex | yes |  |

### ArtifactRelicInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `slotTypeName` | cstring | no | Matches the socket identifiers used in the socketing system. |
| `link` | string | no |  |

