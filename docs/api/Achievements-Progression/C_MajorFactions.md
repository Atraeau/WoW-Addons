# C_MajorFactions

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**14** functions · **4** events · **6** types

## Functions

### C_MajorFactions.GetCurrentRenownLevel

```lua
level = C_MajorFactions.GetCurrentRenownLevel(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local level = C_MajorFactions.GetCurrentRenownLevel(0)
```

### C_MajorFactions.GetMajorFactionData

```lua
data = C_MajorFactions.GetMajorFactionData(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | MajorFactionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_MajorFactions.GetMajorFactionData(0)
```

### C_MajorFactions.GetMajorFactionIDs

```lua
majorFactionIDs = C_MajorFactions.GetMajorFactionIDs([expansionID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local majorFactionIDs = C_MajorFactions.GetMajorFactionIDs()
```

### C_MajorFactions.GetMajorFactionProgressionInfo

```lua
data = C_MajorFactions.GetMajorFactionProgressionInfo(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | MajorFactionProgressionInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_MajorFactions.GetMajorFactionProgressionInfo(0)
```

### C_MajorFactions.GetMajorFactionRenownInfo

```lua
data = C_MajorFactions.GetMajorFactionRenownInfo(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | MajorFactionRenownInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local data = C_MajorFactions.GetMajorFactionRenownInfo(0)
```

### C_MajorFactions.GetRenownLevels

```lua
levels = C_MajorFactions.GetRenownLevels(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levels` | MajorFactionRenownLevelInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local levels = C_MajorFactions.GetRenownLevels(0)
```

### C_MajorFactions.GetRenownNPCFactionID

```lua
renownNPCFactionID = C_MajorFactions.GetRenownNPCFactionID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renownNPCFactionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local renownNPCFactionID = C_MajorFactions.GetRenownNPCFactionID()
```

### C_MajorFactions.GetRenownRewardsForLevel

```lua
rewards = C_MajorFactions.GetRenownRewardsForLevel(majorFactionID, renownLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |
| `renownLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewards` | MajorFactionRenownRewardInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewards = C_MajorFactions.GetRenownRewardsForLevel(0, 0)
```

### C_MajorFactions.GetTotalReputationForRenownLevel

```lua
totalReputation = C_MajorFactions.GetTotalReputationForRenownLevel(majorFactionID, renownLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |
| `renownLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalReputation` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalReputation = C_MajorFactions.GetTotalReputationForRenownLevel(0, 0)
```

### C_MajorFactions.HasMaximumRenown

```lua
hasMaxRenown = C_MajorFactions.HasMaximumRenown(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxRenown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasMaxRenown = C_MajorFactions.HasMaximumRenown(0)
```

### C_MajorFactions.IsMajorFactionHiddenFromExpansionPage

```lua
isHidden = C_MajorFactions.IsMajorFactionHiddenFromExpansionPage(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHidden` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHidden = C_MajorFactions.IsMajorFactionHiddenFromExpansionPage(0)
```

### C_MajorFactions.IsWeeklyRenownCapped

```lua
isWeeklyCapped = C_MajorFactions.IsWeeklyRenownCapped(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWeeklyCapped` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWeeklyCapped = C_MajorFactions.IsWeeklyRenownCapped(0)
```

### C_MajorFactions.ShouldDisplayMajorFactionAsJourney

```lua
shouldDisplayMajorFactionAsJourney = C_MajorFactions.ShouldDisplayMajorFactionAsJourney(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldDisplayMajorFactionAsJourney` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldDisplayMajorFactionAsJourney = C_MajorFactions.ShouldDisplayMajorFactionAsJourney(0)
```

### C_MajorFactions.ShouldUseJourneyRewardTrack

```lua
shouldUseJourneyRewardTrack = C_MajorFactions.ShouldUseJourneyRewardTrack(majorFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldUseJourneyRewardTrack` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldUseJourneyRewardTrack = C_MajorFactions.ShouldUseJourneyRewardTrack(0)
```

## Events

### MAJOR_FACTION_INTERACTION_ENDED

### MAJOR_FACTION_INTERACTION_STARTED

### MAJOR_FACTION_RENOWN_LEVEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |
| `newRenownLevel` | number | no |  |
| `oldRenownLevel` | number | no |  |

### MAJOR_FACTION_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorFactionID` | number | no |  |

## Types

### MajorFactionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `highlights` | RenownHighlightInfo[] | no |  |
| `factionID` | number | no |  |
| `expansionID` | number | no |  |
| `bountySetID` | number | no |  |
| `isUnlocked` | bool | no |  |
| `useJourneyUnlockToast` | bool | no |  |
| `hideRenownLevelUpToast` | bool | no |  |
| `unlockDescription` | cstring | yes |  |
| `uiPriority` | number | no |  |
| `renownLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `renownReputationEarned` | number | no |  |
| `renownLevelThreshold` | number | no |  |
| `textureKit` | textureKit | no |  |
| `celebrationSoundKit` | number | no |  |
| `renownFanfareSoundKitID` | number | no |  |
| `factionFontColor` | DBColorExport | yes |  |
| `renownTrackLevelEffectID` | number | yes |  |
| `playerCompanionID` | number | yes |  |

### MajorFactionProgressionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renownLevel` | number | no |  |
| `previousWeekProgressiveMaxLevel` | number | no |  |
| `currentWeekProgressiveMaxLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `renownReputationEarned` | number | no |  |
| `renownLevelThreshold` | number | no |  |
| `weekNumber` | number | no |  |

### MajorFactionRenownInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renownLevel` | number | no |  |
| `renownReputationEarned` | number | no |  |
| `renownLevelThreshold` | number | no |  |

### MajorFactionRenownLevelInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |
| `level` | number | no |  |
| `locked` | bool | no |  |
| `isMilestone` | bool | no |  |
| `isCapstone` | bool | no |  |

### MajorFactionRenownRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `renownRewardID` | number | no |  |
| `uiOrder` | number | no |  |
| `isAccountUnlock` | bool | no |  |
| `itemID` | number | yes |  |
| `spellID` | number | yes |  |
| `mountID` | number | yes |  |
| `transmogID` | number | yes |  |
| `transmogSetID` | number | yes |  |
| `titleMaskID` | number | yes |  |
| `transmogIllusionSourceID` | number | yes |  |
| `icon` | fileID | yes |  |
| `name` | cstring | yes |  |
| `description` | cstring | yes |  |
| `toastDescription` | cstring | yes |  |
| `rewardType` | number | yes |  |
| `isCollected` | bool | yes |  |

### RenownHighlightInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | no |  |
| `description` | cstring | no |  |
| `level` | number | no |  |

