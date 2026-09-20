# C_GossipInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**20** functions · **7** events · **10** types

## Functions

### C_GossipInfo.CloseGossip

```lua
C_GossipInfo.CloseGossip()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.CloseGossip()
```

### C_GossipInfo.ForceGossip

```lua
forceGossip = C_GossipInfo.ForceGossip()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forceGossip` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local forceGossip = C_GossipInfo.ForceGossip()
```

### C_GossipInfo.GetActiveQuests

```lua
info = C_GossipInfo.GetActiveQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GossipQuestUIInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_GossipInfo.GetActiveQuests()
```

### C_GossipInfo.GetAvailableQuests

```lua
info = C_GossipInfo.GetAvailableQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GossipQuestUIInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_GossipInfo.GetAvailableQuests()
```

### C_GossipInfo.GetCompletedOptionDescriptionString

```lua
description = C_GossipInfo.GetCompletedOptionDescriptionString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_GossipInfo.GetCompletedOptionDescriptionString()
```

### C_GossipInfo.GetCustomGossipDescriptionString

```lua
description = C_GossipInfo.GetCustomGossipDescriptionString()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_GossipInfo.GetCustomGossipDescriptionString()
```

### C_GossipInfo.GetFriendshipReputation

```lua
reputationInfo = C_GossipInfo.GetFriendshipReputation(friendshipFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendshipFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reputationInfo` | FriendshipReputationInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reputationInfo = C_GossipInfo.GetFriendshipReputation(0)
```

### C_GossipInfo.GetFriendshipReputationRanks

```lua
rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendshipFactionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rankInfo` | FriendshipReputationRankInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(0)
```

### C_GossipInfo.GetNumActiveQuests

```lua
numQuests = C_GossipInfo.GetNumActiveQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numQuests` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numQuests = C_GossipInfo.GetNumActiveQuests()
```

### C_GossipInfo.GetNumAvailableQuests

```lua
numQuests = C_GossipInfo.GetNumAvailableQuests()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numQuests` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numQuests = C_GossipInfo.GetNumAvailableQuests()
```

### C_GossipInfo.GetOptions

```lua
info = C_GossipInfo.GetOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GossipOptionUIInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_GossipInfo.GetOptions()
```

### C_GossipInfo.GetOptionUIWidgetSetsAndTypesByOptionID

```lua
gossipOptionUIWidgetSetsAndTypes = C_GossipInfo.GetOptionUIWidgetSetsAndTypesByOptionID(gossipOptionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipOptionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipOptionUIWidgetSetsAndTypes` | GossipOptionUIWidgetSetAndType[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gossipOptionUIWidgetSetsAndTypes = C_GossipInfo.GetOptionUIWidgetSetsAndTypesByOptionID(0)
```

### C_GossipInfo.GetPoiForUiMapID

```lua
gossipPoiID = C_GossipInfo.GetPoiForUiMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipPoiID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gossipPoiID = C_GossipInfo.GetPoiForUiMapID(0)
```

### C_GossipInfo.GetPoiInfo

```lua
gossipPoiInfo = C_GossipInfo.GetPoiInfo(uiMapID, gossipPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |
| `gossipPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipPoiInfo` | GossipPoiInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gossipPoiInfo = C_GossipInfo.GetPoiInfo(0, 0)
```

### C_GossipInfo.GetText

```lua
gossipText = C_GossipInfo.GetText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipText` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local gossipText = C_GossipInfo.GetText()
```

### C_GossipInfo.RefreshOptions

```lua
C_GossipInfo.RefreshOptions()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.RefreshOptions()
```

### C_GossipInfo.SelectActiveQuest

```lua
C_GossipInfo.SelectActiveQuest(optionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.SelectActiveQuest(0)
```

### C_GossipInfo.SelectAvailableQuest

```lua
C_GossipInfo.SelectAvailableQuest(optionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.SelectAvailableQuest(0)
```

### C_GossipInfo.SelectOption

```lua
C_GossipInfo.SelectOption(optionID, [text], [confirmed])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |
| `text` | cstring | yes |  |
| `confirmed` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.SelectOption(0)
```

### C_GossipInfo.SelectOptionByIndex

```lua
C_GossipInfo.SelectOptionByIndex(optionID, [text], [confirmed])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `optionID` | number | no |  |
| `text` | cstring | yes |  |
| `confirmed` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GossipInfo.SelectOptionByIndex(0)
```

## Events

### DYNAMIC_GOSSIP_POI_UPDATED

### GOSSIP_CLOSED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interactionIsContinuing` | bool | no |  |

### GOSSIP_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipID` | number | no |  |
| `text` | string | no |  |
| `cost` | WOWMONEY | no |  |

### GOSSIP_CONFIRM_CANCEL

### GOSSIP_ENTER_CODE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipID` | number | no |  |

### GOSSIP_OPTIONS_REFRESHED

### GOSSIP_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiTextureKit` | textureKit | yes |  |

## Types

### FriendshipReputationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `friendshipFactionID` | number | no |  |
| `standing` | number | no |  |
| `maxRep` | number | no |  |
| `name` | string | yes |  |
| `text` | string | no |  |
| `texture` | number | no |  |
| `reaction` | string | no |  |
| `reactionThreshold` | number | no |  |
| `nextThreshold` | number | yes |  |
| `reversedColor` | bool | no |  |
| `overrideColor` | number | yes |  |

### FriendshipReputationRankInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentLevel` | number | no |  |
| `maxLevel` | number | no |  |

### GossipOptionRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `quantity` | number | no |  |
| `rewardType` | GossipOptionRewardType | no |  |
| `context` | ItemCreationContext | no |  |

### GossipOptionRewardType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Item` | GossipOptionRewardType | no |  |
| `Currency` | GossipOptionRewardType | no |  |

### GossipOptionStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Available` | GossipOptionStatus | no |  |
| `Unavailable` | GossipOptionStatus | no |  |
| `Locked` | GossipOptionStatus | no |  |
| `AlreadyComplete` | GossipOptionStatus | no |  |

### GossipOptionUIInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gossipOptionID` | number | yes |  |
| `name` | string | no |  |
| `icon` | fileID | no |  |
| `rewards` | GossipOptionRewardInfo[] | no |  |
| `status` | GossipOptionStatus | no |  |
| `spellID` | number | yes |  |
| `flags` | number | no |  |
| `overrideIconID` | fileID | yes |  |
| `selectOptionWhenOnlyOption` | bool | no |  |
| `orderIndex` | number | no |  |
| `failureDescription` | string | yes |  |

### GossipOptionUIWidgetSetAndType (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetType` | number | no |  |
| `uiWidgetSetID` | number | no |  |

### GossipOptionUIWidgetSetTypes (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Modifiers` | GossipOptionUIWidgetSetTypes | no |  |
| `Background` | GossipOptionUIWidgetSetTypes | no |  |

### GossipPoiInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `textureIndex` | number | no |  |
| `position` | vector2 | no |  |
| `inBattleMap` | bool | no |  |

### GossipQuestUIInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `questLevel` | number | no |  |
| `isTrivial` | bool | no |  |
| `frequency` | number | yes |  |
| `repeatable` | bool | yes |  |
| `isComplete` | bool | yes |  |
| `isLegendary` | bool | no |  |
| `isIgnored` | bool | no |  |
| `questID` | number | no |  |
| `isImportant` | bool | no |  |
| `isMeta` | bool | no |  |
| `questInfoID` | number | no |  |

