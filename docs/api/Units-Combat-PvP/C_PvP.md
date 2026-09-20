# C_PvP

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**113** functions · **42** events · **28** types

## Functions

### C_PvP.ArePvpTalentsUnlocked

```lua
arePvpTalentsUnlocked = C_PvP.ArePvpTalentsUnlocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `arePvpTalentsUnlocked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local arePvpTalentsUnlocked = C_PvP.ArePvpTalentsUnlocked()
```

### C_PvP.AreTrainingGroundsEnabled

```lua
areTrainingGroundsEnabled = C_PvP.AreTrainingGroundsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areTrainingGroundsEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areTrainingGroundsEnabled = C_PvP.AreTrainingGroundsEnabled()
```

### C_PvP.CanDisplayDeaths

```lua
canDisplay = C_PvP.CanDisplayDeaths()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDisplay` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canDisplay = C_PvP.CanDisplayDeaths()
```

### C_PvP.CanDisplayHonorableKills

```lua
canDisplay = C_PvP.CanDisplayHonorableKills()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDisplay` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canDisplay = C_PvP.CanDisplayHonorableKills()
```

### C_PvP.CanPlayerUseRatedPVPUI

```lua
canUse, failureReason = C_PvP.CanPlayerUseRatedPVPUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUse` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUse, failureReason = C_PvP.CanPlayerUseRatedPVPUI()
```

### C_PvP.CanPlayerUseTrainingGroundsUI

```lua
canUseTrainingGroundsUI, failureReason = C_PvP.CanPlayerUseTrainingGroundsUI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseTrainingGroundsUI` | bool | no |  |
| `failureReason` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUseTrainingGroundsUI, failureReason = C_PvP.CanPlayerUseTrainingGroundsUI()
```

### C_PvP.CanSurrenderArena

```lua
CanSurrenderArena = C_PvP.CanSurrenderArena()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `CanSurrenderArena` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local CanSurrenderArena = C_PvP.CanSurrenderArena()
```

### C_PvP.CanToggleWarMode

```lua
canTogglePvP = C_PvP.CanToggleWarMode(toggle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `toggle` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canTogglePvP` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canTogglePvP = C_PvP.CanToggleWarMode(false)
```

### C_PvP.CanToggleWarModeInArea

```lua
canTogglePvPInArea = C_PvP.CanToggleWarModeInArea()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canTogglePvPInArea` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canTogglePvPInArea = C_PvP.CanToggleWarModeInArea()
```

### C_PvP.DoesMatchOutcomeAffectRating

```lua
doesAffect = C_PvP.DoesMatchOutcomeAffectRating()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doesAffect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local doesAffect = C_PvP.DoesMatchOutcomeAffectRating()
```

### C_PvP.GetActiveBrawlInfo

```lua
brawlInfo = C_PvP.GetActiveBrawlInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `brawlInfo` | PvpBrawlInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local brawlInfo = C_PvP.GetActiveBrawlInfo()
```

### C_PvP.GetActiveMatchBracket

```lua
bracket = C_PvP.GetActiveMatchBracket()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bracket` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bracket = C_PvP.GetActiveMatchBracket()
```

### C_PvP.GetActiveMatchDuration

```lua
seconds = C_PvP.GetActiveMatchDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local seconds = C_PvP.GetActiveMatchDuration()
```

### C_PvP.GetActiveMatchState

```lua
state = C_PvP.GetActiveMatchState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | PvPMatchState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_PvP.GetActiveMatchState()
```

### C_PvP.GetActiveMatchWinner

```lua
winner = C_PvP.GetActiveMatchWinner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `winner` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local winner = C_PvP.GetActiveMatchWinner()
```

### C_PvP.GetArenaCrowdControlDuration

```lua
duration = C_PvP.GetArenaCrowdControlDuration(playerToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local duration = C_PvP.GetArenaCrowdControlDuration(playerToken)
```

### C_PvP.GetArenaCrowdControlInfo

```lua
spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(playerToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(playerToken)
```

### C_PvP.GetArenaRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetArenaRewards(teamSize)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamSize` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetArenaRewards(0)
```

### C_PvP.GetArenaSkirmishRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetArenaSkirmishRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetArenaSkirmishRewards()
```

### C_PvP.GetAssignedSpecForBattlefieldQueue

```lua
specializationID = C_PvP.GetAssignedSpecForBattlefieldQueue(queueID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `queueID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specializationID = C_PvP.GetAssignedSpecForBattlefieldQueue(0)
```

### C_PvP.GetAvailableBrawlInfo

If nil is returned, PVP_BRAWL_INFO_UPDATED event will be sent when the data is ready.

```lua
brawlInfo = C_PvP.GetAvailableBrawlInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `brawlInfo` | PvpBrawlInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local brawlInfo = C_PvP.GetAvailableBrawlInfo()
```

### C_PvP.GetBattlefieldFlagPosition

```lua
uiPosx, uiPosy, flagTexture = C_PvP.GetBattlefieldFlagPosition(flagIndex, uiMapId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flagIndex` | luaIndex | no |  |
| `uiMapId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiPosx` | number | yes |  |
| `uiPosy` | number | yes |  |
| `flagTexture` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiPosx, uiPosy, flagTexture = C_PvP.GetBattlefieldFlagPosition(1, 0)
```

### C_PvP.GetBattlefieldVehicleInfo

```lua
info = C_PvP.GetBattlefieldVehicleInfo(vehicleIndex, uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicleIndex` | luaIndex | no |  |
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | BattlefieldVehicleInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetBattlefieldVehicleInfo(1, 0)
```

### C_PvP.GetBattlefieldVehicles

```lua
vehicles = C_PvP.GetBattlefieldVehicles(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicles` | BattlefieldVehicleInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vehicles = C_PvP.GetBattlefieldVehicles(0)
```

### C_PvP.GetBattlegroundInfo

```lua
battlegroundInfo = C_PvP.GetBattlegroundInfo(battlegroundIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlegroundIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlegroundInfo` | BattlegroundInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local battlegroundInfo = C_PvP.GetBattlegroundInfo(1)
```

### C_PvP.GetBrawlRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus, hasWon = C_PvP.GetBrawlRewards(brawlType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `brawlType` | BrawlType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |
| `hasWon` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus, hasWon = C_PvP.GetBrawlRewards(Enum.BrawlType.None)
```

### C_PvP.GetBrawlSoloRBGMinItemLevel

```lua
minItemLevel = C_PvP.GetBrawlSoloRBGMinItemLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minItemLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minItemLevel = C_PvP.GetBrawlSoloRBGMinItemLevel()
```

### C_PvP.GetCustomVictoryStatID

```lua
statID = C_PvP.GetCustomVictoryStatID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `statID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local statID = C_PvP.GetCustomVictoryStatID()
```

### C_PvP.GetGlobalPvpScalingInfoForSpecID

```lua
pvpScalingData = C_PvP.GetGlobalPvpScalingInfoForSpecID(specializationID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpScalingData` | PvpScalingData[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pvpScalingData = C_PvP.GetGlobalPvpScalingInfoForSpecID(0)
```

### C_PvP.GetHonorRewardInfo

```lua
info = C_PvP.GetHonorRewardInfo(honorLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honorLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | HonorRewardInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetHonorRewardInfo(0)
```

### C_PvP.GetLevelUpBattlegrounds

```lua
battlefields = C_PvP.GetLevelUpBattlegrounds(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlefields` | LevelUpBattlegroundInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local battlefields = C_PvP.GetLevelUpBattlegrounds(0)
```

### C_PvP.GetMatchPVPStatColumn

```lua
info = C_PvP.GetMatchPVPStatColumn(pvpStatID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpStatID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | MatchPVPStatColumn | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetMatchPVPStatColumn(0)
```

### C_PvP.GetMatchPVPStatColumns

```lua
columns = C_PvP.GetMatchPVPStatColumns()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `columns` | MatchPVPStatColumn[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local columns = C_PvP.GetMatchPVPStatColumns()
```

### C_PvP.GetNextHonorLevelForReward

```lua
nextHonorLevelWithReward = C_PvP.GetNextHonorLevelForReward(honorLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honorLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nextHonorLevelWithReward` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nextHonorLevelWithReward = C_PvP.GetNextHonorLevelForReward(0)
```

### C_PvP.GetOutdoorPvPWaitTime

```lua
pvpWaitTime = C_PvP.GetOutdoorPvPWaitTime(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpWaitTime` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pvpWaitTime = C_PvP.GetOutdoorPvPWaitTime(0)
```

### C_PvP.GetPersonalRatedBGBlitzSpecStats

```lua
specStats = C_PvP.GetPersonalRatedBGBlitzSpecStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specStats` | RatedBGBlitzSpecStats | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specStats = C_PvP.GetPersonalRatedBGBlitzSpecStats()
```

### C_PvP.GetPersonalRatedSoloShuffleSpecStats

```lua
specStats = C_PvP.GetPersonalRatedSoloShuffleSpecStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specStats` | RatedSoloShuffleSpecStats | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local specStats = C_PvP.GetPersonalRatedSoloShuffleSpecStats()
```

### C_PvP.GetPostMatchCurrencyRewards

```lua
rewards = C_PvP.GetPostMatchCurrencyRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewards` | PVPPostMatchCurrencyReward[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewards = C_PvP.GetPostMatchCurrencyRewards()
```

### C_PvP.GetPostMatchItemRewards

```lua
rewards = C_PvP.GetPostMatchItemRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewards` | PVPPostMatchItemReward[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewards = C_PvP.GetPostMatchItemRewards()
```

### C_PvP.GetPVPActiveMatchPersonalRatedInfo

```lua
info = C_PvP.GetPVPActiveMatchPersonalRatedInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PVPPersonalRatedInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetPVPActiveMatchPersonalRatedInfo()
```

### C_PvP.GetPVPActiveRatedMatchDeserterPenalty

```lua
deserterPenalty = C_PvP.GetPVPActiveRatedMatchDeserterPenalty()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deserterPenalty` | RatedMatchDeserterPenalty | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deserterPenalty = C_PvP.GetPVPActiveRatedMatchDeserterPenalty()
```

### C_PvP.GetPVPSeasonRewardAchievementID

```lua
achievementID = C_PvP.GetPVPSeasonRewardAchievementID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `achievementID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local achievementID = C_PvP.GetPVPSeasonRewardAchievementID()
```

### C_PvP.GetPvpTalentsUnlockedLevel

```lua
unlockLevel = C_PvP.GetPvpTalentsUnlockedLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unlockLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local unlockLevel = C_PvP.GetPvpTalentsUnlockedLevel()
```

### C_PvP.GetPvpTierID

```lua
id = C_PvP.GetPvpTierID(tierEnum, bracketEnum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierEnum` | number | no |  |
| `bracketEnum` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local id = C_PvP.GetPvpTierID(0, 1)
```

### C_PvP.GetPvpTierInfo

```lua
pvpTierInfo = C_PvP.GetPvpTierInfo(tierID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpTierInfo` | PvpTierInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pvpTierInfo = C_PvP.GetPvpTierInfo(0)
```

### C_PvP.GetRandomBGInfo

```lua
info = C_PvP.GetRandomBGInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RandomBGInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetRandomBGInfo()
```

### C_PvP.GetRandomBGRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomBGRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomBGRewards()
```

### C_PvP.GetRandomEpicBGInfo

```lua
info = C_PvP.GetRandomEpicBGInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RandomBGInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetRandomEpicBGInfo()
```

### C_PvP.GetRandomEpicBGRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomEpicBGRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomEpicBGRewards()
```

### C_PvP.GetRandomTrainingGroundArenaRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomTrainingGroundArenaRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomTrainingGroundArenaRewards()
```

### C_PvP.GetRandomTrainingGroundBGRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomTrainingGroundBGRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRandomTrainingGroundBGRewards()
```

### C_PvP.GetRatedBGRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedBGRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedBGRewards()
```

### C_PvP.GetRatedSoloRBGMinItemLevel

```lua
minItemLevel = C_PvP.GetRatedSoloRBGMinItemLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minItemLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minItemLevel = C_PvP.GetRatedSoloRBGMinItemLevel()
```

### C_PvP.GetRatedSoloRBGRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedSoloRBGRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedSoloRBGRewards()
```

### C_PvP.GetRatedSoloShuffleMinItemLevel

```lua
minItemLevel = C_PvP.GetRatedSoloShuffleMinItemLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minItemLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minItemLevel = C_PvP.GetRatedSoloShuffleMinItemLevel()
```

### C_PvP.GetRatedSoloShuffleRewards

```lua
honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedSoloShuffleRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local honor, experience, itemRewards, currencyRewards, roleShortageBonus = C_PvP.GetRatedSoloShuffleRewards()
```

### C_PvP.GetRewardItemLevelsByTierEnum

```lua
activityItemLevel, weeklyItemLevel = C_PvP.GetRewardItemLevelsByTierEnum(pvpTierEnum)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpTierEnum` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityItemLevel` | number | no |  |
| `weeklyItemLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activityItemLevel, weeklyItemLevel = C_PvP.GetRewardItemLevelsByTierEnum(0)
```

### C_PvP.GetScoreInfo

```lua
info = C_PvP.GetScoreInfo(offsetIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PVPScoreInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetScoreInfo(1)
```

### C_PvP.GetScoreInfoByPlayerGuid

```lua
info = C_PvP.GetScoreInfoByPlayerGuid(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PVPScoreInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetScoreInfoByPlayerGuid(UnitGUID("player"))
```

### C_PvP.GetSeasonBestInfo

```lua
tierID, nextTierID = C_PvP.GetSeasonBestInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tierID` | number | no |  |
| `nextTierID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tierID, nextTierID = C_PvP.GetSeasonBestInfo()
```

### C_PvP.GetSkirmishInfo

```lua
battlemasterListInfo = C_PvP.GetSkirmishInfo(pvpBracket)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpBracket` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlemasterListInfo` | BattlemasterListInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local battlemasterListInfo = C_PvP.GetSkirmishInfo(0)
```

### C_PvP.GetSpecialEventBrawlInfo

```lua
brawlInfo = C_PvP.GetSpecialEventBrawlInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `brawlInfo` | PvpBrawlInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local brawlInfo = C_PvP.GetSpecialEventBrawlInfo()
```

### C_PvP.GetTeamInfo

```lua
info = C_PvP.GetTeamInfo(factionIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PVPTeamInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PvP.GetTeamInfo(1)
```

### C_PvP.GetTrainingGrounds

```lua
trainingGrounds = C_PvP.GetTrainingGrounds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trainingGrounds` | BattlegroundInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local trainingGrounds = C_PvP.GetTrainingGrounds()
```

### C_PvP.GetUIDisplaySeason

```lua
uiDisplaySeason = C_PvP.GetUIDisplaySeason()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiDisplaySeason` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiDisplaySeason = C_PvP.GetUIDisplaySeason()
```

### C_PvP.GetWarModeRewardBonus

```lua
rewardBonus = C_PvP.GetWarModeRewardBonus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardBonus` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewardBonus = C_PvP.GetWarModeRewardBonus()
```

### C_PvP.GetWarModeRewardBonusDefault

```lua
defaultBonus = C_PvP.GetWarModeRewardBonusDefault()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultBonus` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local defaultBonus = C_PvP.GetWarModeRewardBonusDefault()
```

### C_PvP.GetWeeklyChestInfo

```lua
rewardAchieved, lastWeekRewardAchieved, lastWeekRewardClaimed, pvpTierMaxFromWins = C_PvP.GetWeeklyChestInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardAchieved` | bool | no |  |
| `lastWeekRewardAchieved` | bool | no |  |
| `lastWeekRewardClaimed` | bool | no |  |
| `pvpTierMaxFromWins` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rewardAchieved, lastWeekRewardAchieved, lastWeekRewardClaimed, pvpTierMaxFromWins = C_PvP.GetWeeklyChestInfo()
```

### C_PvP.GetZonePVPInfo

```lua
pvpType, isSubZonePvP, factionName = C_PvP.GetZonePVPInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpType` | cstring | no |  |
| `isSubZonePvP` | bool | no |  |
| `factionName` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pvpType, isSubZonePvP, factionName = C_PvP.GetZonePVPInfo()
```

### C_PvP.HasArenaSkirmishWinToday

```lua
hasArenaSkirmishWinToday = C_PvP.HasArenaSkirmishWinToday()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasArenaSkirmishWinToday` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasArenaSkirmishWinToday = C_PvP.HasArenaSkirmishWinToday()
```

### C_PvP.HasMatchStarted

Returns true if a match is either active or complete.

```lua
hasStarted = C_PvP.HasMatchStarted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasStarted` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasStarted = C_PvP.HasMatchStarted()
```

### C_PvP.HasRandomTrainingGroundArenaWinToday

```lua
hasRandomTrainingGroundArenaWinToday = C_PvP.HasRandomTrainingGroundArenaWinToday()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRandomTrainingGroundArenaWinToday` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasRandomTrainingGroundArenaWinToday = C_PvP.HasRandomTrainingGroundArenaWinToday()
```

### C_PvP.HasRandomTrainingGroundBGWinToday

```lua
hasRandomTrainingGroundBGWinToday = C_PvP.HasRandomTrainingGroundBGWinToday()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRandomTrainingGroundBGWinToday` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasRandomTrainingGroundBGWinToday = C_PvP.HasRandomTrainingGroundBGWinToday()
```

### C_PvP.IsActiveBattlefield

```lua
isActiveBattlefield = C_PvP.IsActiveBattlefield()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActiveBattlefield` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActiveBattlefield = C_PvP.IsActiveBattlefield()
```

### C_PvP.IsActiveMatchRegistered

```lua
registered = C_PvP.IsActiveMatchRegistered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = C_PvP.IsActiveMatchRegistered()
```

### C_PvP.IsArena

```lua
isArena = C_PvP.IsArena()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isArena` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isArena = C_PvP.IsArena()
```

### C_PvP.IsBattleground

```lua
isBattleground = C_PvP.IsBattleground()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBattleground` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBattleground = C_PvP.IsBattleground()
```

### C_PvP.IsBattlegroundEnlistmentBonusActive

```lua
battlegroundActive, brawlActive = C_PvP.IsBattlegroundEnlistmentBonusActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlegroundActive` | bool | no |  |
| `brawlActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local battlegroundActive, brawlActive = C_PvP.IsBattlegroundEnlistmentBonusActive()
```

### C_PvP.IsBrawlSoloRBG

```lua
isBrawlSoloRBG = C_PvP.IsBrawlSoloRBG()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBrawlSoloRBG` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBrawlSoloRBG = C_PvP.IsBrawlSoloRBG()
```

### C_PvP.IsBrawlSoloShuffle

```lua
isBrawlSoloShuffle = C_PvP.IsBrawlSoloShuffle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBrawlSoloShuffle` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBrawlSoloShuffle = C_PvP.IsBrawlSoloShuffle()
```

### C_PvP.IsInBrawl

```lua
isInBrawl = C_PvP.IsInBrawl()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInBrawl` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInBrawl = C_PvP.IsInBrawl()
```

### C_PvP.IsInRatedMatchWithDeserterPenalty

```lua
isInRatedMatchWithDeserterPenalty = C_PvP.IsInRatedMatchWithDeserterPenalty()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInRatedMatchWithDeserterPenalty` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInRatedMatchWithDeserterPenalty = C_PvP.IsInRatedMatchWithDeserterPenalty()
```

### C_PvP.IsMatchActive

```lua
isActive = C_PvP.IsMatchActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isActive = C_PvP.IsMatchActive()
```

### C_PvP.IsMatchComplete

```lua
isComplete = C_PvP.IsMatchComplete()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isComplete` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isComplete = C_PvP.IsMatchComplete()
```

### C_PvP.IsMatchConsideredArena

```lua
asArena = C_PvP.IsMatchConsideredArena()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asArena` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local asArena = C_PvP.IsMatchConsideredArena()
```

### C_PvP.IsMatchFactional

```lua
isFactional = C_PvP.IsMatchFactional()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFactional` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFactional = C_PvP.IsMatchFactional()
```

### C_PvP.IsPVPMap

```lua
isPVPMap = C_PvP.IsPVPMap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPVPMap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPVPMap = C_PvP.IsPVPMap()
```

### C_PvP.IsRatedArena

```lua
isRatedArena = C_PvP.IsRatedArena()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRatedArena` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRatedArena = C_PvP.IsRatedArena()
```

### C_PvP.IsRatedBattleground

```lua
isRatedBattleground = C_PvP.IsRatedBattleground()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRatedBattleground` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRatedBattleground = C_PvP.IsRatedBattleground()
```

### C_PvP.IsRatedMap

```lua
isRatedMap = C_PvP.IsRatedMap()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRatedMap` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRatedMap = C_PvP.IsRatedMap()
```

### C_PvP.IsRatedSoloRBG

```lua
isRatedSoloRBG = C_PvP.IsRatedSoloRBG()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRatedSoloRBG` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRatedSoloRBG = C_PvP.IsRatedSoloRBG()
```

### C_PvP.IsRatedSoloShuffle

```lua
isRatedSoloShuffle = C_PvP.IsRatedSoloShuffle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRatedSoloShuffle` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRatedSoloShuffle = C_PvP.IsRatedSoloShuffle()
```

### C_PvP.IsSoloRBG

```lua
isSoloRBG = C_PvP.IsSoloRBG()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSoloRBG` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSoloRBG = C_PvP.IsSoloRBG()
```

### C_PvP.IsSoloShuffle

```lua
isSoloShuffle = C_PvP.IsSoloShuffle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSoloShuffle` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSoloShuffle = C_PvP.IsSoloShuffle()
```

### C_PvP.IsSubZonePVPPOI

```lua
result = C_PvP.IsSubZonePVPPOI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_PvP.IsSubZonePVPPOI()
```

### C_PvP.IsTrainingGroundsArena

```lua
isTrainingGroundsArena = C_PvP.IsTrainingGroundsArena(lfgDungeonsID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonsID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrainingGroundsArena` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrainingGroundsArena = C_PvP.IsTrainingGroundsArena(0)
```

### C_PvP.IsTrainingGroundsBG

```lua
isTrainingGroundsBG = C_PvP.IsTrainingGroundsBG(lfgDungeonsID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lfgDungeonsID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrainingGroundsBG` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrainingGroundsBG = C_PvP.IsTrainingGroundsBG(0)
```

### C_PvP.IsWarModeActive

```lua
warModeActive = C_PvP.IsWarModeActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeActive` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warModeActive = C_PvP.IsWarModeActive()
```

### C_PvP.IsWarModeDesired

```lua
warModeDesired = C_PvP.IsWarModeDesired()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeDesired` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warModeDesired = C_PvP.IsWarModeDesired()
```

### C_PvP.IsWarModeFeatureEnabled

```lua
warModeEnabled = C_PvP.IsWarModeFeatureEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local warModeEnabled = C_PvP.IsWarModeFeatureEnabled()
```

### C_PvP.JoinBattlefield

```lua
C_PvP.JoinBattlefield(battlemasterListId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battlemasterListId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinBattlefield(0)
```

### C_PvP.JoinBrawl

```lua
C_PvP.JoinBrawl(isSpecialBrawl)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpecialBrawl` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinBrawl(false)
```

### C_PvP.JoinRandomTrainingGroundArena

```lua
C_PvP.JoinRandomTrainingGroundArena()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinRandomTrainingGroundArena()
```

### C_PvP.JoinRandomTrainingGroundBG

```lua
C_PvP.JoinRandomTrainingGroundBG()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinRandomTrainingGroundBG()
```

### C_PvP.JoinRatedBGBlitz

```lua
C_PvP.JoinRatedBGBlitz()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinRatedBGBlitz()
```

### C_PvP.JoinTrainingGround

```lua
C_PvP.JoinTrainingGround(trainingGroundID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trainingGroundID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.JoinTrainingGround(0)
```

### C_PvP.RequestCrowdControlSpell

```lua
C_PvP.RequestCrowdControlSpell(playerToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerToken` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.RequestCrowdControlSpell(playerToken)
```

### C_PvP.SetPVP

```lua
C_PvP.SetPVP(enablePVP)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enablePVP` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.SetPVP(false)
```

### C_PvP.SetWarModeDesired

```lua
C_PvP.SetWarModeDesired(warModeDesired)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeDesired` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.SetWarModeDesired(false)
```

### C_PvP.StartSoloRBGWarGameByName

```lua
success = C_PvP.StartSoloRBGWarGameByName(args)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `args` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_PvP.StartSoloRBGWarGameByName("")
```

### C_PvP.StartSpectatorSoloRBGWarGame

```lua
success = C_PvP.StartSpectatorSoloRBGWarGame(opaqueID1, opaqueID2, specifiedMap, tournamentRules)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `opaqueID1` | number | no |  |
| `opaqueID2` | number | no |  |
| `specifiedMap` | cstring | no |  |
| `tournamentRules` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_PvP.StartSpectatorSoloRBGWarGame(0, 0, "", false)
```

### C_PvP.TogglePVP

```lua
C_PvP.TogglePVP()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.TogglePVP()
```

### C_PvP.ToggleWarMode

```lua
C_PvP.ToggleWarMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PvP.ToggleWarMode()
```

## Events

### ARENA_OPPONENT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | cstring | no |  |
| `updateReason` | cstring | no |  |

### ARENA_PREP_OPPONENT_SPECIALIZATIONS

### ARENA_SEASON_WORLD_STATE

### BATTLEFIELD_AUTO_QUEUE

### BATTLEFIELD_AUTO_QUEUE_EJECT

### BATTLEFIELD_QUEUE_TIMEOUT

### BATTLEFIELDS_CLOSED

### BATTLEFIELDS_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isArena` | bool | yes |  |
| `battleMasterListID` | number | yes |  |

### BATTLEGROUND_OBJECTIVES_UPDATE

### BATTLEGROUND_POINTS_UPDATE

### GDF_SIM_COMPLETE

### HONOR_LEVEL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHigherLevel` | bool | no |  |

### NOTIFY_PVP_AFK_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offender` | cstring | no |  |
| `numBlackMarksOnOffender` | number | no |  |
| `numPlayersIHaveReported` | number | no |  |

### PLAYER_ENTERING_BATTLEGROUND

### PLAYER_JOINED_PVP_MATCH

### POST_MATCH_CURRENCY_REWARD_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reward` | PVPPostMatchCurrencyReward | no |  |

### POST_MATCH_ITEM_REWARD_UPDATE

### PVP_BRAWL_INFO_UPDATED

### PVP_MATCH_ACTIVE

### PVP_MATCH_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `winner` | number | no |  |
| `duration` | time_t | no |  |

### PVP_MATCH_INACTIVE

### PVP_MATCH_STATE_CHANGED

### PVPQUEUE_ANYWHERE_SHOW

### PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE

### PVP_RATED_STATS_UPDATE

### PVP_REWARDS_UPDATE

### PVP_ROLE_POPUP_HIDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `readyCheckInfo` | PvpReadyCheckInfo | yes |  |

### PVP_ROLE_POPUP_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `readyCheckInfo` | PvpReadyCheckInfo | no |  |

### PVP_ROLE_UPDATE

### PVP_SPECIAL_EVENT_INFO_UPDATED

### PVP_TYPES_ENABLED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wargameBattlegrounds` | bool | no |  |
| `ratedBattlegrounds` | bool | no |  |
| `ratedArenas` | bool | no |  |
| `ratedSoloShuffle` | bool | no |  |
| `ratedBGBlitz` | bool | no |  |

### PVP_VEHICLE_INFO_UPDATED

### PVP_WORLDSTATE_UPDATE

### TRAINING_GROUNDS_ENABLED_STATUS_UPDATED

### UPDATE_ACTIVE_BATTLEFIELD

### UPDATE_BATTLEFIELD_SCORE

### UPDATE_BATTLEFIELD_STATUS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `battleFieldIndex` | number | no |  |

### WARGAME_INVITE_SENT

### WARGAME_REQUESTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `opposingPartyMemberName` | cstring | no |  |
| `battlegroundName` | cstring | no |  |
| `timeoutSeconds` | time_t | no |  |
| `tournamentRules` | bool | no |  |

### WARGAME_REQUEST_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `responderGUID` | WOWGUID | no |  |
| `responderName` | cstring | yes |  |
| `accepted` | bool | no |  |

### WAR_MODE_STATUS_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `warModeEnabled` | bool | no |  |

### WORLD_PVP_QUEUE

## Types

### BattlefieldCurrencyReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `quantity` | number | no |  |

### BattlefieldItemReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `texture` | fileID | no |  |
| `quantity` | number | no |  |

### BattlefieldRewards (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honor` | number | no |  |
| `experience` | number | no |  |
| `itemRewards` | BattlefieldItemReward[] | yes |  |
| `currencyRewards` | BattlefieldCurrencyReward[] | yes |  |
| `roleShortageBonus` | RoleShortageReward | yes |  |

### BattlefieldVehicleInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |
| `name` | cstring | no |  |
| `isOccupied` | bool | no |  |
| `atlas` | textureAtlas | no |  |
| `textureWidth` | number | no |  |
| `textureHeight` | number | no |  |
| `facing` | number | no |  |
| `isPlayer` | bool | no |  |
| `isAlive` | bool | no |  |
| `shouldDrawBelowPlayerBlips` | bool | no |  |

### BattlegroundInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `icon` | fileID | yes |  |
| `gameType` | cstring | no |  |
| `shortDescription` | cstring | no |  |
| `longDescription` | cstring | no |  |
| `mapDescription` | cstring | no |  |
| `maxPlayers` | number | no |  |
| `battlegroundID` | number | yes |  |
| `lfgDungeonID` | number | yes |  |
| `mapID` | number | yes |  |
| `isHoliday` | bool | no |  |
| `isRandom` | bool | no |  |
| `canEnter` | bool | no |  |
| `isTrainingGround` | bool | no |  |

### BattlemasterListInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `matchmakingType` | PvPMatchmakingType | no |  |
| `minPlayers` | number | no |  |
| `maxPlayers` | number | no |  |
| `icon` | fileID | no |  |
| `longDescription` | string | no |  |
| `shortDescription` | string | no |  |

### BrawlType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | BrawlType | no |  |
| `Battleground` | BrawlType | no |  |
| `Arena` | BrawlType | no |  |
| `LFG` | BrawlType | no |  |
| `SoloShuffle` | BrawlType | no |  |
| `SoloRbg` | BrawlType | no |  |

### HonorRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honorLevelName` | string | no |  |
| `badgeFileDataID` | fileID | no |  |
| `achievementRewardedID` | number | no |  |

### LevelUpBattlegroundInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `icon` | fileID | no |  |
| `name` | string | no |  |
| `isEpic` | bool | no |  |

### MatchPVPStatColumn (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpStatID` | number | no |  |
| `columnHeaderID` | number | no |  |
| `orderIndex` | number | no |  |
| `name` | string | no |  |
| `tooltipTitle` | string | no |  |
| `tooltip` | string | no |  |

### PvpBrawlInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `brawlID` | number | no |  |
| `name` | string | no |  |
| `shortDescription` | string | no |  |
| `longDescription` | string | no |  |
| `canQueue` | bool | no |  |
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `groupsAllowed` | bool | no |  |
| `crossFactionAllowed` | bool | no | (default: False) |
| `timeLeftUntilNextChange` | number | yes |  |
| `brawlType` | BrawlType | no |  |
| `mapNames` | string[] | no |  |
| `includesAllArenas` | bool | no | (default: False) |
| `minItemLevel` | number | no | (default: 0) |
| `shouldHideRewardIcon` | bool | no | (default: False) |

### PvPMatchState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Inactive` | PvPMatchState | no |  |
| `Waiting` | PvPMatchState | no |  |
| `StartUp` | PvPMatchState | no |  |
| `Engaged` | PvPMatchState | no |  |
| `PostRound` | PvPMatchState | no |  |
| `Complete` | PvPMatchState | no |  |

### PVPPersonalRatedInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `personalRating` | number | no |  |
| `bestSeasonRating` | number | no |  |
| `bestWeeklyRating` | number | no |  |
| `seasonPlayed` | number | no |  |
| `seasonWon` | number | no |  |
| `weeklyPlayed` | number | no |  |
| `weeklyWon` | number | no |  |
| `lastWeeksBestRating` | number | no |  |
| `hasWonBracketToday` | bool | no |  |
| `tier` | number | no |  |
| `ranking` | number | yes |  |
| `roundsSeasonPlayed` | number | no |  |
| `roundsSeasonWon` | number | no |  |
| `roundsWeeklyPlayed` | number | no |  |
| `roundsWeeklyWon` | number | no |  |

### PVPPostMatchCurrencyReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyType` | number | no |  |
| `quantityChanged` | number | no |  |

### PVPPostMatchItemReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | string | no |  |
| `link` | string | no |  |
| `quantity` | number | no |  |
| `specID` | number | no |  |
| `sex` | number | no |  |
| `isUpgraded` | bool | no |  |

### PvpReadyCheckInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roles` | PvpRoleQueueInfo[] | no |  |
| `numPlayersAccepted` | number | no |  |
| `numPlayersDeclined` | number | no |  |
| `totalNumPlayers` | number | no |  |

### PvpRoleQueueInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `role` | cstring | no |  |
| `totalRole` | number | no |  |
| `totalAccepted` | number | no |  |
| `totalDeclined` | number | no |  |

### PvpScalingData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scalingDataID` | number | no |  |
| `specializationID` | number | no |  |
| `name` | cstring | no |  |
| `value` | number | no |  |

### PVPScoreInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `guid` | WOWGUID | no |  |
| `killingBlows` | number | no |  |
| `honorableKills` | number | no |  |
| `deaths` | number | no |  |
| `honorGained` | number | no |  |
| `faction` | number | no |  |
| `raceName` | string | no |  |
| `className` | string | no |  |
| `classToken` | string | no |  |
| `damageDone` | number | no |  |
| `healingDone` | number | no |  |
| `rating` | number | no |  |
| `ratingChange` | number | no |  |
| `prematchMMR` | number | no |  |
| `mmrChange` | number | no |  |
| `postmatchMMR` | number | no |  |
| `talentSpec` | string | no |  |
| `honorLevel` | number | no |  |
| `roleAssigned` | number | no |  |
| `stats` | PVPStatInfo[] | no |  |

### PVPStatInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pvpStatID` | number | no |  |
| `pvpStatValue` | number | no |  |
| `orderIndex` | number | no |  |
| `name` | string | no |  |
| `tooltip` | string | no |  |
| `iconName` | string | no |  |

### PVPTeamInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `size` | number | no |  |
| `rating` | number | no |  |
| `ratingNew` | number | no |  |
| `ratingMMR` | number | no |  |

### PvpTierInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `descendRating` | number | no |  |
| `ascendRating` | number | no |  |
| `descendTier` | number | no |  |
| `ascendTier` | number | no |  |
| `pvpTierEnum` | number | no |  |
| `tierIconID` | fileID | no |  |

### RandomBGInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canQueue` | bool | no |  |
| `bgID` | number | no |  |
| `bgIndex` | luaIndex | no |  |
| `hasRandomWinToday` | bool | no |  |
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `name` | string | no |  |

### RatedBGBlitzSpecStats (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weeklyMostPlayedSpecID` | number | no |  |
| `weeklyMostPlayedSpecGames` | number | no |  |
| `seasonMostPlayedSpecID` | number | no |  |
| `seasonMostPlayedSpecGames` | number | no |  |

### RatedMatchDeserterPenalty (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `personalRatingChange` | number | no |  |
| `queuePenaltySpellID` | number | no |  |
| `queuePenaltyDuration` | number | no |  |

### RatedSoloShuffleSpecStats (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weeklyMostPlayedSpecID` | number | no |  |
| `weeklyMostPlayedSpecRounds` | number | no |  |
| `seasonMostPlayedSpecID` | number | no |  |
| `seasonMostPlayedSpecRounds` | number | no |  |

### RoleShortageReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `validRoles` | cstring[] | no |  |
| `rewardSpellID` | number | no |  |
| `rewardItemID` | number | no |  |

### WorldPVPBattlegroundInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bgID` | number | no |  |
| `name` | string | no |  |
| `isActive` | bool | no |  |
| `canQueue` | bool | no |  |
| `canEnter` | bool | no |  |
| `startTime` | time_t | no |  |
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |

