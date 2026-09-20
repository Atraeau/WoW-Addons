# C_Reputation

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**27** functions · **1** events · **2** types

## Functions

### C_Reputation.AreLegacyReputationsShown

```lua
areLegacyReputationsShown = C_Reputation.AreLegacyReputationsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areLegacyReputationsShown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areLegacyReputationsShown = C_Reputation.AreLegacyReputationsShown()
```

### C_Reputation.CollapseAllFactionHeaders

```lua
C_Reputation.CollapseAllFactionHeaders()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.CollapseAllFactionHeaders()
```

### C_Reputation.CollapseFactionHeader

```lua
C_Reputation.CollapseFactionHeader(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.CollapseFactionHeader(1)
```

### C_Reputation.ExpandAllFactionHeaders

```lua
C_Reputation.ExpandAllFactionHeaders()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.ExpandAllFactionHeaders()
```

### C_Reputation.ExpandFactionHeader

```lua
C_Reputation.ExpandFactionHeader(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.ExpandFactionHeader(1)
```

### C_Reputation.GetFactionDataByID

```lua
factionData = C_Reputation.GetFactionDataByID(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionData` | FactionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local factionData = C_Reputation.GetFactionDataByID(0)
```

### C_Reputation.GetFactionDataByIndex

```lua
factionData = C_Reputation.GetFactionDataByIndex(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionData` | FactionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local factionData = C_Reputation.GetFactionDataByIndex(1)
```

### C_Reputation.GetFactionParagonInfo

```lua
currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon, paragonStorageLevel = C_Reputation.GetFactionParagonInfo(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentValue` | number | no |  |
| `threshold` | number | no |  |
| `rewardQuestID` | number | no |  |
| `hasRewardPending` | bool | no |  |
| `tooLowLevelForParagon` | bool | no |  |
| `paragonStorageLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon, paragonStorageLevel = C_Reputation.GetFactionParagonInfo(0)
```

### C_Reputation.GetGuildFactionData

```lua
guildFactionData = C_Reputation.GetGuildFactionData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guildFactionData` | FactionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local guildFactionData = C_Reputation.GetGuildFactionData()
```

### C_Reputation.GetGuildRepExpirationTime

```lua
expirationTime = C_Reputation.GetGuildRepExpirationTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expirationTime` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expirationTime = C_Reputation.GetGuildRepExpirationTime()
```

### C_Reputation.GetNumFactions

```lua
numFactions = C_Reputation.GetNumFactions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numFactions` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numFactions = C_Reputation.GetNumFactions()
```

### C_Reputation.GetReputationSortType

```lua
sortType = C_Reputation.GetReputationSortType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortType` | ReputationSortType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sortType = C_Reputation.GetReputationSortType()
```

### C_Reputation.GetSelectedFaction

```lua
selectedFactionSortIndex = C_Reputation.GetSelectedFaction()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `selectedFactionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local selectedFactionSortIndex = C_Reputation.GetSelectedFaction()
```

### C_Reputation.GetWatchedFactionData

```lua
watchedFactionData = C_Reputation.GetWatchedFactionData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `watchedFactionData` | FactionData | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local watchedFactionData = C_Reputation.GetWatchedFactionData()
```

### C_Reputation.IsAccountWideReputation

```lua
isAccountWide = C_Reputation.IsAccountWideReputation(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccountWide` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAccountWide = C_Reputation.IsAccountWideReputation(0)
```

### C_Reputation.IsFactionActive

```lua
isActive = C_Reputation.IsFactionActive(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = C_Reputation.IsFactionActive(1)
```

### C_Reputation.IsFactionParagon

```lua
factionIsParagon = C_Reputation.IsFactionParagon(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionIsParagon` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local factionIsParagon = C_Reputation.IsFactionParagon(0)
```

### C_Reputation.IsFactionParagonForCurrentPlayer

```lua
currentPlayerHasParagon = C_Reputation.IsFactionParagonForCurrentPlayer(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentPlayerHasParagon` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentPlayerHasParagon = C_Reputation.IsFactionParagonForCurrentPlayer(0)
```

### C_Reputation.IsMajorFaction

```lua
isMajorFaction = C_Reputation.IsMajorFaction(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMajorFaction` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMajorFaction = C_Reputation.IsMajorFaction(0)
```

### C_Reputation.RequestFactionParagonPreloadRewardData

```lua
C_Reputation.RequestFactionParagonPreloadRewardData(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.RequestFactionParagonPreloadRewardData(0)
```

### C_Reputation.SetFactionActive

```lua
C_Reputation.SetFactionActive(factionSortIndex, setActive)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |
| `setActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetFactionActive(1, false)
```

### C_Reputation.SetLegacyReputationsShown

```lua
C_Reputation.SetLegacyReputationsShown(showLegacyReputations)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showLegacyReputations` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetLegacyReputationsShown(false)
```

### C_Reputation.SetReputationSortType

```lua
C_Reputation.SetReputationSortType(sortType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortType` | ReputationSortType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetReputationSortType(Enum.ReputationSortType.None)
```

### C_Reputation.SetSelectedFaction

```lua
C_Reputation.SetSelectedFaction(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetSelectedFaction(1)
```

### C_Reputation.SetWatchedFactionByID

```lua
C_Reputation.SetWatchedFactionByID(factionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetWatchedFactionByID(0)
```

### C_Reputation.SetWatchedFactionByIndex

```lua
C_Reputation.SetWatchedFactionByIndex(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.SetWatchedFactionByIndex(1)
```

### C_Reputation.ToggleFactionAtWar

```lua
C_Reputation.ToggleFactionAtWar(factionSortIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionSortIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Reputation.ToggleFactionAtWar(1)
```

## Events

### FACTION_STANDING_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |
| `updatedStanding` | number | no |  |

## Types

### FactionData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionID` | number | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `reaction` | luaIndex | no |  |
| `currentReactionThreshold` | number | no |  |
| `nextReactionThreshold` | number | no |  |
| `currentStanding` | number | no |  |
| `atWarWith` | bool | no |  |
| `canToggleAtWar` | bool | no |  |
| `isChild` | bool | no |  |
| `isHeader` | bool | no |  |
| `isHeaderWithRep` | bool | no |  |
| `isCollapsed` | bool | no |  |
| `isWatched` | bool | no |  |
| `hasBonusRepGain` | bool | no |  |
| `canSetInactive` | bool | no |  |
| `isAccountWide` | bool | no |  |

### ReputationSortType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ReputationSortType | no |  |
| `Account` | ReputationSortType | no |  |
| `Character` | ReputationSortType | no |  |

