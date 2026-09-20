# C_LFGInfo

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**23** functions · **31** events · **2** types

## Functions

### C_LFGInfo.AreCrossFactionGroupQueuesAllowed

```lua
areCrossFactionGroupQueuesAllowed = C_LFGInfo.AreCrossFactionGroupQueuesAllowed(lfgDungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areCrossFactionGroupQueuesAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areCrossFactionGroupQueuesAllowed = C_LFGInfo.AreCrossFactionGroupQueuesAllowed(0)
```

### C_LFGInfo.CanPlayerUseGroupFinder

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUseGroupFinder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUseGroupFinder()
```

### C_LFGInfo.CanPlayerUseLFD

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUseLFD()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUseLFD()
```

### C_LFGInfo.CanPlayerUseLFR

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUseLFR()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUseLFR()
```

### C_LFGInfo.CanPlayerUsePremadeGroup

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUsePremadeGroup()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUsePremadeGroup()
```

### C_LFGInfo.CanPlayerUsePVP

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUsePVP()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUsePVP()
```

### C_LFGInfo.CanPlayerUseScenarioFinder

```lua
canUse, failureReason = C_LFGInfo.CanPlayerUseScenarioFinder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_LFGInfo.CanPlayerUseScenarioFinder()
```

### C_LFGInfo.ConfirmLfgExpandSearch

```lua
C_LFGInfo.ConfirmLfgExpandSearch()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_LFGInfo.ConfirmLfgExpandSearch()
```

### C_LFGInfo.DoesActivePartyMeetPremadeLaunchCount

```lua
doesActivePartyMeetPremadeLaunchCount = C_LFGInfo.DoesActivePartyMeetPremadeLaunchCount(lfgDungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesActivePartyMeetPremadeLaunchCount` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doesActivePartyMeetPremadeLaunchCount = C_LFGInfo.DoesActivePartyMeetPremadeLaunchCount(0)
```

### C_LFGInfo.DoesCrossFactionQueueRequireFullPremade

```lua
doesCrossFactionQueueRequireFullPremade = C_LFGInfo.DoesCrossFactionQueueRequireFullPremade(lfgDungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesCrossFactionQueueRequireFullPremade` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doesCrossFactionQueueRequireFullPremade = C_LFGInfo.DoesCrossFactionQueueRequireFullPremade(0)
```

### C_LFGInfo.GetActiveLFGDungeonName

```lua
name = C_LFGInfo.GetActiveLFGDungeonName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_LFGInfo.GetActiveLFGDungeonName()
```

### C_LFGInfo.GetAllEntriesForCategory

```lua
lfgDungeonIDs = C_LFGInfo.GetAllEntriesForCategory(category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `category` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lfgDungeonIDs = C_LFGInfo.GetAllEntriesForCategory(1)
```

### C_LFGInfo.GetDungeonInfo

```lua
dungeonInfo = C_LFGInfo.GetDungeonInfo(lfgDungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonInfo` | LFGDungeonInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dungeonInfo = C_LFGInfo.GetDungeonInfo(0)
```

### C_LFGInfo.GetLevelUpInstances

```lua
instances = C_LFGInfo.GetLevelUpInstances(currPlayerLevel, isRaid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currPlayerLevel` | number | no |  |
| `isRaid` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `instances` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local instances = C_LFGInfo.GetLevelUpInstances(0, false)
```

### C_LFGInfo.GetLFDLockStates

```lua
lockInfo = C_LFGInfo.GetLFDLockStates()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lockInfo` | LFGLockInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local lockInfo = C_LFGInfo.GetLFDLockStates()
```

### C_LFGInfo.GetRoleCheckDifficultyDetails

```lua
maxLevel, isLevelReduced = C_LFGInfo.GetRoleCheckDifficultyDetails()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLevel` | number | yes |  |
| `isLevelReduced` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxLevel, isLevelReduced = C_LFGInfo.GetRoleCheckDifficultyDetails()
```

### C_LFGInfo.HideNameFromUI

```lua
shouldHide = C_LFGInfo.HideNameFromUI(dungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldHide` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local shouldHide = C_LFGInfo.HideNameFromUI(0)
```

### C_LFGInfo.IsGroupFinderEnabled

```lua
enabled = C_LFGInfo.IsGroupFinderEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_LFGInfo.IsGroupFinderEnabled()
```

### C_LFGInfo.IsInLFGFollowerDungeon

```lua
result = C_LFGInfo.IsInLFGFollowerDungeon()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_LFGInfo.IsInLFGFollowerDungeon()
```

### C_LFGInfo.IsInMatchmadeRaidWithoutRoleRequirements

```lua
result = C_LFGInfo.IsInMatchmadeRaidWithoutRoleRequirements()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_LFGInfo.IsInMatchmadeRaidWithoutRoleRequirements()
```

### C_LFGInfo.IsLFDEnabled

```lua
enabled = C_LFGInfo.IsLFDEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_LFGInfo.IsLFDEnabled()
```

### C_LFGInfo.IsLFGFollowerDungeon

```lua
result = C_LFGInfo.IsLFGFollowerDungeon(dungeonID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_LFGInfo.IsLFGFollowerDungeon(0)
```

### C_LFGInfo.IsLFREnabled

```lua
enabled = C_LFGInfo.IsLFREnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_LFGInfo.IsLFREnabled()
```

## Events

### ISLAND_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `winner` | number | no |  |

### LFG_BOOT_PROPOSAL_UPDATE

### LFG_COMPLETION_REWARD

### LFG_COOLDOWNS_UPDATED

### LFG_ENABLED_STATE_CHANGED

### LFG_INVALID_ERROR_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | number | no |  |
| `subReason1` | number | no |  |
| `subReason2` | number | no |  |

### LFG_LOCK_INFO_RECEIVED

### LFG_OFFER_CONTINUE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `lfgDungeonsID` | number | no |  |
| `typeID` | number | no |  |

### LFG_OPEN_FROM_GOSSIP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number | no |  |

### LFG_PROPOSAL_DONE

### LFG_PROPOSAL_FAILED

### LFG_PROPOSAL_SHOW

### LFG_PROPOSAL_SUCCEEDED

### LFG_PROPOSAL_UPDATE

### LFG_QUEUE_STATUS_UPDATE

### LFG_READY_CHECK_DECLINED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### LFG_READY_CHECK_HIDE

### LFG_READY_CHECK_PLAYER_IS_READY

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### LFG_READY_CHECK_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRequeue` | bool | no |  |

### LFG_READY_CHECK_UPDATE

### LFG_ROLE_CHECK_DECLINED

### LFG_ROLE_CHECK_HIDE

### LFG_ROLE_CHECK_ROLE_CHOSEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `isTank` | bool | no |  |
| `isHealer` | bool | no |  |
| `isDamage` | bool | no |  |

### LFG_ROLE_CHECK_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRequeue` | bool | no |  |

### LFG_ROLE_CHECK_UPDATE

### LFG_ROLE_UPDATE

### LFG_UPDATE

### LFG_UPDATE_RANDOM_INFO

### SHOW_LFG_EXPAND_SEARCH_PROMPT

### UPDATE_LFG_LIST

### WARFRONT_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `winner` | number | no |  |

## Types

### LFGDungeonInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `iconID` | fileID | no |  |
| `link` | string | yes |  |

### LFGLockInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgID` | number | no |  |
| `reason` | number | no |  |
| `hideEntry` | bool | no |  |

