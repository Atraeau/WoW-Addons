# C_Commentator

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**144** functions · **10** events · **12** types

## Functions

### C_Commentator.AddPlayerOverrideName

```lua
C_Commentator.AddPlayerOverrideName(playerName, overrideName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string | no |  |
| `overrideName` | string | no |  |

**Example**

```lua
C_Commentator.AddPlayerOverrideName("", "")
```

### C_Commentator.AddTrackedDefensiveAuras

```lua
C_Commentator.AddTrackedDefensiveAuras(spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.AddTrackedDefensiveAuras(12345)
```

### C_Commentator.AddTrackedOffensiveAuras

```lua
C_Commentator.AddTrackedOffensiveAuras(spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.AddTrackedOffensiveAuras(12345)
```

### C_Commentator.AreTeamsSwapped

```lua
teamsAreSwapped = C_Commentator.AreTeamsSwapped()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamsAreSwapped` | bool | no |  |

**Example**

```lua
local teamsAreSwapped = C_Commentator.AreTeamsSwapped()
```

### C_Commentator.AssignPlayersToTeam

```lua
C_Commentator.AssignPlayersToTeam(playerName, teamName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string[] | no |  |
| `teamName` | string | no |  |

**Example**

```lua
C_Commentator.AssignPlayersToTeam(playerName, "")
```

### C_Commentator.AssignPlayersToTeamInCurrentInstance

```lua
C_Commentator.AssignPlayersToTeamInCurrentInstance(teamIndex, teamName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `teamName` | string | no |  |

**Example**

```lua
C_Commentator.AssignPlayersToTeamInCurrentInstance(1, "")
```

### C_Commentator.AssignPlayerToTeam

```lua
C_Commentator.AssignPlayerToTeam(playerName, teamName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string | no |  |
| `teamName` | string | no |  |

**Example**

```lua
C_Commentator.AssignPlayerToTeam("", "")
```

### C_Commentator.CanUseCommentatorCheats

```lua
canUseCommentatorCheats = C_Commentator.CanUseCommentatorCheats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseCommentatorCheats` | bool | no |  |

**Example**

```lua
local canUseCommentatorCheats = C_Commentator.CanUseCommentatorCheats()
```

### C_Commentator.ClearCameraTarget

```lua
C_Commentator.ClearCameraTarget()
```

**Example**

```lua
C_Commentator.ClearCameraTarget()
```

### C_Commentator.ClearFollowTarget

```lua
C_Commentator.ClearFollowTarget()
```

**Example**

```lua
C_Commentator.ClearFollowTarget()
```

### C_Commentator.ClearLookAtTarget

```lua
C_Commentator.ClearLookAtTarget([lookAtIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lookAtIndex` | luaIndex | yes |  |

**Example**

```lua
C_Commentator.ClearLookAtTarget()
```

### C_Commentator.EnterInstance

```lua
C_Commentator.EnterInstance()
```

**Example**

```lua
C_Commentator.EnterInstance()
```

### C_Commentator.ExitInstance

```lua
C_Commentator.ExitInstance()
```

**Example**

```lua
C_Commentator.ExitInstance()
```

### C_Commentator.FindSpectatedUnit

```lua
playerIndex, teamIndex, isPet = C_Commentator.FindSpectatedUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerIndex` | luaIndex | no |  |
| `teamIndex` | luaIndex | no |  |
| `isPet` | bool | no |  |

**Example**

```lua
local playerIndex, teamIndex, isPet = C_Commentator.FindSpectatedUnit("player")
```

### C_Commentator.FindTeamNameInCurrentInstance

```lua
teamName = C_Commentator.FindTeamNameInCurrentInstance(teamIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName` | string | yes |  |

**Example**

```lua
local teamName = C_Commentator.FindTeamNameInCurrentInstance(1)
```

### C_Commentator.FindTeamNameInDirectory

```lua
teamName = C_Commentator.FindTeamNameInDirectory(playerNames)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerNames` | string[] | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName` | string | yes |  |

**Example**

```lua
local teamName = C_Commentator.FindTeamNameInDirectory(playerNames)
```

### C_Commentator.FlushCommentatorHistory

```lua
C_Commentator.FlushCommentatorHistory()
```

**Example**

```lua
C_Commentator.FlushCommentatorHistory()
```

### C_Commentator.FollowPlayer

```lua
C_Commentator.FollowPlayer(factionIndex, playerIndex, [forceInstantTransition])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `forceInstantTransition` | bool | yes |  |

**Example**

```lua
C_Commentator.FollowPlayer(1, 1)
```

### C_Commentator.FollowUnit

```lua
C_Commentator.FollowUnit(token)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | string | no |  |

**Example**

```lua
C_Commentator.FollowUnit("")
```

### C_Commentator.ForceFollowTransition

```lua
C_Commentator.ForceFollowTransition()
```

**Example**

```lua
C_Commentator.ForceFollowTransition()
```

### C_Commentator.GetAdditionalCameraWeight

```lua
teamIndex, playerIndex = C_Commentator.GetAdditionalCameraWeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |

**Example**

```lua
local teamIndex, playerIndex = C_Commentator.GetAdditionalCameraWeight()
```

### C_Commentator.GetAdditionalCameraWeightByToken

```lua
weight = C_Commentator.GetAdditionalCameraWeightByToken(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weight` | number | no |  |

**Example**

```lua
local weight = C_Commentator.GetAdditionalCameraWeightByToken("player")
```

### C_Commentator.GetAllPlayerOverrideNames

```lua
nameEntries = C_Commentator.GetAllPlayerOverrideNames()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nameEntries` | NameOverrideEntry[] | no |  |

**Example**

```lua
local nameEntries = C_Commentator.GetAllPlayerOverrideNames()
```

### C_Commentator.GetCamera

```lua
xPos, yPos, zPos, yaw, pitch, roll, fov = C_Commentator.GetCamera()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `zPos` | number | no |  |
| `yaw` | number | no |  |
| `pitch` | number | no |  |
| `roll` | number | no |  |
| `fov` | number | no |  |

**Example**

```lua
local xPos, yPos, zPos, yaw, pitch, roll, fov = C_Commentator.GetCamera()
```

### C_Commentator.GetCameraCollision

```lua
isColliding = C_Commentator.GetCameraCollision()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isColliding` | bool | no |  |

**Example**

```lua
local isColliding = C_Commentator.GetCameraCollision()
```

### C_Commentator.GetCameraPosition

```lua
xPos, yPos, zPos = C_Commentator.GetCameraPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `zPos` | number | no |  |

**Example**

```lua
local xPos, yPos, zPos = C_Commentator.GetCameraPosition()
```

### C_Commentator.GetCombatEventInfo

```lua
C_Commentator.GetCombatEventInfo()
```

**Example**

```lua
C_Commentator.GetCombatEventInfo()
```

### C_Commentator.GetCommentatorHistory

```lua
history = C_Commentator.GetCommentatorHistory()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `history` | CommentatorHistory | no |  |

**Example**

```lua
local history = C_Commentator.GetCommentatorHistory()
```

### C_Commentator.GetCommentatorMatchDataState

```lua
state = C_Commentator.GetCommentatorMatchDataState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | CommentatorMatchDataState | no |  |

**Example**

```lua
local state = C_Commentator.GetCommentatorMatchDataState()
```

### C_Commentator.GetCurrentMapID

```lua
mapID = C_Commentator.GetCurrentMapID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | yes |  |

**Example**

```lua
local mapID = C_Commentator.GetCurrentMapID()
```

### C_Commentator.GetDampeningPercent

```lua
percentage = C_Commentator.GetDampeningPercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `percentage` | number | no |  |

**Example**

```lua
local percentage = C_Commentator.GetDampeningPercent()
```

### C_Commentator.GetDistanceBeforeForcedHorizontalConvergence

```lua
distance = C_Commentator.GetDistanceBeforeForcedHorizontalConvergence()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example**

```lua
local distance = C_Commentator.GetDistanceBeforeForcedHorizontalConvergence()
```

### C_Commentator.GetDurationToForceHorizontalConvergence

```lua
ms = C_Commentator.GetDurationToForceHorizontalConvergence()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
local ms = C_Commentator.GetDurationToForceHorizontalConvergence()
```

### C_Commentator.GetExcludeDistance

```lua
excludeDistance = C_Commentator.GetExcludeDistance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `excludeDistance` | number | no |  |

**Example**

```lua
local excludeDistance = C_Commentator.GetExcludeDistance()
```

### C_Commentator.GetHardlockWeight

```lua
weight = C_Commentator.GetHardlockWeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weight` | number | no |  |

**Example**

```lua
local weight = C_Commentator.GetHardlockWeight()
```

### C_Commentator.GetHorizontalAngleThresholdToSmooth

```lua
angle = C_Commentator.GetHorizontalAngleThresholdToSmooth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
local angle = C_Commentator.GetHorizontalAngleThresholdToSmooth()
```

### C_Commentator.GetIndirectSpellID

```lua
indirectSpellID = C_Commentator.GetIndirectSpellID(trackedSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `indirectSpellID` | number | no |  |

**Example**

```lua
local indirectSpellID = C_Commentator.GetIndirectSpellID(12345)
```

### C_Commentator.GetInstanceInfo

```lua
mapID, mapName, status, instanceIDLow, instanceIDHigh = C_Commentator.GetInstanceInfo(mapIndex, instanceIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapIndex` | luaIndex | no |  |
| `instanceIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `mapName` | string | yes |  |
| `status` | number | no |  |
| `instanceIDLow` | number | no |  |
| `instanceIDHigh` | number | no |  |

**Example**

```lua
local mapID, mapName, status, instanceIDLow, instanceIDHigh = C_Commentator.GetInstanceInfo(1, 1)
```

### C_Commentator.GetLookAtLerpAmount

```lua
amount = C_Commentator.GetLookAtLerpAmount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
local amount = C_Commentator.GetLookAtLerpAmount()
```

### C_Commentator.GetMapInfo

```lua
teamSize, minLevel, maxLevel, numInstances = C_Commentator.GetMapInfo(mapIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamSize` | number | no |  |
| `minLevel` | number | no |  |
| `maxLevel` | number | no |  |
| `numInstances` | number | no |  |

**Example**

```lua
local teamSize, minLevel, maxLevel, numInstances = C_Commentator.GetMapInfo(1)
```

### C_Commentator.GetMatchDuration

```lua
seconds = C_Commentator.GetMatchDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `seconds` | time_t | no |  |

**Example**

```lua
local seconds = C_Commentator.GetMatchDuration()
```

### C_Commentator.GetMaxNumPlayersPerTeam

```lua
maxNumPlayersPerTeam = C_Commentator.GetMaxNumPlayersPerTeam()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxNumPlayersPerTeam` | number | no |  |

**Example**

```lua
local maxNumPlayersPerTeam = C_Commentator.GetMaxNumPlayersPerTeam()
```

### C_Commentator.GetMaxNumTeams

```lua
maxNumTeams = C_Commentator.GetMaxNumTeams()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxNumTeams` | number | no |  |

**Example**

```lua
local maxNumTeams = C_Commentator.GetMaxNumTeams()
```

### C_Commentator.GetMode

```lua
commentatorMode = C_Commentator.GetMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `commentatorMode` | number | no |  |

**Example**

```lua
local commentatorMode = C_Commentator.GetMode()
```

### C_Commentator.GetMsToHoldForHorizontalMovement

```lua
ms = C_Commentator.GetMsToHoldForHorizontalMovement()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
local ms = C_Commentator.GetMsToHoldForHorizontalMovement()
```

### C_Commentator.GetMsToHoldForVerticalMovement

```lua
ms = C_Commentator.GetMsToHoldForVerticalMovement()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
local ms = C_Commentator.GetMsToHoldForVerticalMovement()
```

### C_Commentator.GetMsToSmoothHorizontalChange

```lua
ms = C_Commentator.GetMsToSmoothHorizontalChange()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
local ms = C_Commentator.GetMsToSmoothHorizontalChange()
```

### C_Commentator.GetMsToSmoothVerticalChange

```lua
ms = C_Commentator.GetMsToSmoothVerticalChange()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
local ms = C_Commentator.GetMsToSmoothVerticalChange()
```

### C_Commentator.GetNumMaps

```lua
numMaps = C_Commentator.GetNumMaps()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numMaps` | number | no |  |

**Example**

```lua
local numMaps = C_Commentator.GetNumMaps()
```

### C_Commentator.GetNumPlayers

```lua
numPlayers = C_Commentator.GetNumPlayers(factionIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numPlayers` | number | no |  |

**Example**

```lua
local numPlayers = C_Commentator.GetNumPlayers(1)
```

### C_Commentator.GetOrCreateSeries

```lua
data = C_Commentator.GetOrCreateSeries(teamName1, teamName2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName1` | string | no |  |
| `teamName2` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | CommentatorSeries | no |  |

**Example**

```lua
local data = C_Commentator.GetOrCreateSeries("", "")
```

### C_Commentator.GetPlayerAuraInfo

```lua
startTime, duration, enable = C_Commentator.GetPlayerAuraInfo(teamIndex, playerIndex, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerAuraInfo(1, 1, 12345)
```

### C_Commentator.GetPlayerAuraInfoByUnit

```lua
startTime, duration, enable = C_Commentator.GetPlayerAuraInfoByUnit(token, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | UnitToken | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerAuraInfoByUnit(token, 12345)
```

### C_Commentator.GetPlayerCooldownInfo

```lua
startTime, duration, enable = C_Commentator.GetPlayerCooldownInfo(teamIndex, playerIndex, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerCooldownInfo(1, 1, 12345)
```

### C_Commentator.GetPlayerCooldownInfoByUnit

```lua
startTime, duration, enable = C_Commentator.GetPlayerCooldownInfoByUnit(unitToken, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerCooldownInfoByUnit("player", 12345)
```

### C_Commentator.GetPlayerCrowdControlInfo

```lua
spellID, expiration, duration = C_Commentator.GetPlayerCrowdControlInfo(teamIndex, playerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `expiration` | number | no |  |
| `duration` | number | no |  |

**Example**

```lua
local spellID, expiration, duration = C_Commentator.GetPlayerCrowdControlInfo(1, 1)
```

### C_Commentator.GetPlayerCrowdControlInfoByUnit

```lua
spellID, expiration, duration = C_Commentator.GetPlayerCrowdControlInfoByUnit(token)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `expiration` | number | no |  |
| `duration` | number | no |  |

**Example**

```lua
local spellID, expiration, duration = C_Commentator.GetPlayerCrowdControlInfoByUnit(token)
```

### C_Commentator.GetPlayerData

```lua
info = C_Commentator.GetPlayerData(teamIndex, playerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CommentatorPlayerData | yes |  |

**Example**

```lua
local info = C_Commentator.GetPlayerData(1, 1)
```

### C_Commentator.GetPlayerFlagInfo

```lua
hasFlag = C_Commentator.GetPlayerFlagInfo(teamIndex, playerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFlag` | bool | no |  |

**Example**

```lua
local hasFlag = C_Commentator.GetPlayerFlagInfo(1, 1)
```

### C_Commentator.GetPlayerFlagInfoByUnit

```lua
hasFlag = C_Commentator.GetPlayerFlagInfoByUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFlag` | bool | no |  |

**Example**

```lua
local hasFlag = C_Commentator.GetPlayerFlagInfoByUnit("player")
```

### C_Commentator.GetPlayerItemCooldownInfo

```lua
startTime, duration, enable = C_Commentator.GetPlayerItemCooldownInfo(teamIndex, playerIndex, itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerItemCooldownInfo(1, 1, 6948)
```

### C_Commentator.GetPlayerItemCooldownInfoByUnit

```lua
startTime, duration, enable = C_Commentator.GetPlayerItemCooldownInfoByUnit(unitToken, itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `enable` | bool | no |  |

**Example**

```lua
local startTime, duration, enable = C_Commentator.GetPlayerItemCooldownInfoByUnit("player", 6948)
```

### C_Commentator.GetPlayerOverrideName

```lua
overrideName = C_Commentator.GetPlayerOverrideName(originalName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `originalName` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideName` | string | no |  |

**Example**

```lua
local overrideName = C_Commentator.GetPlayerOverrideName("")
```

### C_Commentator.GetPlayerSpellCharges

```lua
charges, maxCharges, startTime, duration = C_Commentator.GetPlayerSpellCharges(teamIndex, playerIndex, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `charges` | number | no |  |
| `maxCharges` | number | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |

**Example**

```lua
local charges, maxCharges, startTime, duration = C_Commentator.GetPlayerSpellCharges(1, 1, 12345)
```

### C_Commentator.GetPlayerSpellChargesByUnit

```lua
charges, maxCharges, startTime, duration = C_Commentator.GetPlayerSpellChargesByUnit(unitToken, spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `charges` | number | no |  |
| `maxCharges` | number | no |  |
| `startTime` | number | no |  |
| `duration` | number | no |  |

**Example**

```lua
local charges, maxCharges, startTime, duration = C_Commentator.GetPlayerSpellChargesByUnit("player", 12345)
```

### C_Commentator.GetPositionLerpAmount

```lua
amount = C_Commentator.GetPositionLerpAmount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
local amount = C_Commentator.GetPositionLerpAmount()
```

### C_Commentator.GetSmoothFollowTransitioning

```lua
enabled = C_Commentator.GetSmoothFollowTransitioning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_Commentator.GetSmoothFollowTransitioning()
```

### C_Commentator.GetSoftlockWeight

```lua
weight = C_Commentator.GetSoftlockWeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weight` | number | no |  |

**Example**

```lua
local weight = C_Commentator.GetSoftlockWeight()
```

### C_Commentator.GetSpeedFactor

```lua
factor = C_Commentator.GetSpeedFactor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factor` | number | no |  |

**Example**

```lua
local factor = C_Commentator.GetSpeedFactor()
```

### C_Commentator.GetStartLocation

```lua
pos = C_Commentator.GetStartLocation(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pos` | vector3 | no |  |

**Example**

```lua
local pos = C_Commentator.GetStartLocation(0)
```

### C_Commentator.GetTeamColor

```lua
color = C_Commentator.GetTeamColor(teamIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no |  |

**Example**

```lua
local color = C_Commentator.GetTeamColor(1)
```

### C_Commentator.GetTeamColorByUnit

```lua
color = C_Commentator.GetTeamColorByUnit(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no |  |

**Example**

```lua
local color = C_Commentator.GetTeamColorByUnit("player")
```

### C_Commentator.GetTimeLeftInMatch

```lua
timeLeft = C_Commentator.GetTimeLeftInMatch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeft` | number | yes |  |

**Example**

```lua
local timeLeft = C_Commentator.GetTimeLeftInMatch()
```

### C_Commentator.GetTrackedSpellID

```lua
trackedSpellID = C_Commentator.GetTrackedSpellID(indirectSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `indirectSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `trackedSpellID` | number | no |  |

**Example**

```lua
local trackedSpellID = C_Commentator.GetTrackedSpellID(12345)
```

### C_Commentator.GetTrackedSpells

```lua
spells, result = C_Commentator.GetTrackedSpells(teamIndex, playerIndex, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `category` | TrackedSpellCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spells` | number[] | yes |  |
| `result` | TrackedSpellsResult | no |  |

**Example**

```lua
local spells, result = C_Commentator.GetTrackedSpells(1, 1, category)
```

### C_Commentator.GetTrackedSpellsByUnit

```lua
spells, result = C_Commentator.GetTrackedSpellsByUnit(unitToken, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `category` | TrackedSpellCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spells` | number[] | yes |  |
| `result` | TrackedSpellsResult | no |  |

**Example**

```lua
local spells, result = C_Commentator.GetTrackedSpellsByUnit("player", category)
```

### C_Commentator.GetUnitData

```lua
data = C_Commentator.GetUnitData(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `data` | CommentatorUnitData | no |  |

**Example**

```lua
local data = C_Commentator.GetUnitData("player")
```

### C_Commentator.GetWargameInfo

```lua
name, minPlayers, maxPlayers, isArena = C_Commentator.GetWargameInfo(listID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `minPlayers` | number | no |  |
| `maxPlayers` | number | no |  |
| `isArena` | bool | no |  |

**Example**

```lua
local name, minPlayers, maxPlayers, isArena = C_Commentator.GetWargameInfo(0)
```

### C_Commentator.HasTrackedAuras

```lua
hasOffensiveAura, hasDefensiveAura = C_Commentator.HasTrackedAuras(token)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `token` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasOffensiveAura` | bool | no |  |
| `hasDefensiveAura` | bool | no |  |

**Example**

```lua
local hasOffensiveAura, hasDefensiveAura = C_Commentator.HasTrackedAuras(token)
```

### C_Commentator.IsSmartCameraLocked

```lua
isSmartCameraLocked = C_Commentator.IsSmartCameraLocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSmartCameraLocked` | bool | no |  |

**Example**

```lua
local isSmartCameraLocked = C_Commentator.IsSmartCameraLocked()
```

### C_Commentator.IsSpectating

```lua
isSpectating = C_Commentator.IsSpectating()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSpectating` | bool | no |  |

**Example**

```lua
local isSpectating = C_Commentator.IsSpectating()
```

### C_Commentator.IsTrackedDefensiveAura

```lua
isDefensiveTrigger = C_Commentator.IsTrackedDefensiveAura(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDefensiveTrigger` | bool | no |  |

**Example**

```lua
local isDefensiveTrigger = C_Commentator.IsTrackedDefensiveAura(12345)
```

### C_Commentator.IsTrackedOffensiveAura

```lua
isOffensiveTrigger = C_Commentator.IsTrackedOffensiveAura(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOffensiveTrigger` | bool | no |  |

**Example**

```lua
local isOffensiveTrigger = C_Commentator.IsTrackedOffensiveAura(12345)
```

### C_Commentator.IsTrackedSpell

```lua
isTracked = C_Commentator.IsTrackedSpell(teamIndex, playerIndex, spellID, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `spellID` | number | no |  |
| `category` | TrackedSpellCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTracked` | bool | no |  |

**Example**

```lua
local isTracked = C_Commentator.IsTrackedSpell(1, 1, 12345, category)
```

### C_Commentator.IsTrackedSpellByUnit

```lua
isTracked = C_Commentator.IsTrackedSpellByUnit(unitToken, spellID, category)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `spellID` | number | no |  |
| `category` | TrackedSpellCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTracked` | bool | no |  |

**Example**

```lua
local isTracked = C_Commentator.IsTrackedSpellByUnit("player", 12345, category)
```

### C_Commentator.IsUsingSmartCamera

```lua
isUsingSmartCamera = C_Commentator.IsUsingSmartCamera()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsingSmartCamera` | bool | no |  |

**Example**

```lua
local isUsingSmartCamera = C_Commentator.IsUsingSmartCamera()
```

### C_Commentator.LookAtPlayer

```lua
C_Commentator.LookAtPlayer(factionIndex, playerIndex, [lookAtIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `lookAtIndex` | luaIndex | yes |  |

**Example**

```lua
C_Commentator.LookAtPlayer(1, 1)
```

### C_Commentator.RemoveAllOverrideNames

```lua
C_Commentator.RemoveAllOverrideNames()
```

**Example**

```lua
C_Commentator.RemoveAllOverrideNames()
```

### C_Commentator.RemovePlayerOverrideName

```lua
C_Commentator.RemovePlayerOverrideName(originalPlayerName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `originalPlayerName` | string | no |  |

**Example**

```lua
C_Commentator.RemovePlayerOverrideName("")
```

### C_Commentator.RequestPlayerCooldownInfo

```lua
C_Commentator.RequestPlayerCooldownInfo(teamIndex, playerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |

**Example**

```lua
C_Commentator.RequestPlayerCooldownInfo(1, 1)
```

### C_Commentator.ResetFoVTarget

```lua
C_Commentator.ResetFoVTarget()
```

**Example**

```lua
C_Commentator.ResetFoVTarget()
```

### C_Commentator.ResetSeriesScores

```lua
C_Commentator.ResetSeriesScores(teamName1, teamName2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName1` | string | no |  |
| `teamName2` | string | no |  |

**Example**

```lua
C_Commentator.ResetSeriesScores("", "")
```

### C_Commentator.ResetSettings

```lua
C_Commentator.ResetSettings()
```

**Example**

```lua
C_Commentator.ResetSettings()
```

### C_Commentator.ResetTrackedAuras

```lua
C_Commentator.ResetTrackedAuras()
```

**Example**

```lua
C_Commentator.ResetTrackedAuras()
```

### C_Commentator.SendAddonMessage

Works the same as C_ChatInfo.SendAddonMessage but accepts secrets and is only allowed when outgoing addon comms are allowed (i.e. on tournament realms)

```lua
result = C_Commentator.SendAddonMessage(prefix, message, [chatType], [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `message` | cstring | no |  |
| `chatType` | cstring | yes | ChatType, defaults to SLASH_CMD_PARTY. |
| `target` | cstring | yes | Only applies for targeted channels |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendAddonMessageResult | no |  |

**Example**

```lua
local result = C_Commentator.SendAddonMessage("", "")
```

### C_Commentator.SendAddonMessageLogged

Works the same as C_ChatInfo.SendAddonMessageLogged but accepts secrets and is only allowed when outgoing addon comms are allowed (i.e. on tournament realms)

```lua
result = C_Commentator.SendAddonMessageLogged(prefix, message, [chatType], [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `prefix` | cstring | no |  |
| `message` | cstring | no |  |
| `chatType` | cstring | yes | ChatType, defaults to SLASH_CMD_PARTY. |
| `target` | cstring | yes | Only applies for targeted channels |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendAddonMessageResult | yes |  |

**Example**

```lua
local result = C_Commentator.SendAddonMessageLogged("", "")
```

### C_Commentator.SetAdditionalCameraWeight

```lua
C_Commentator.SetAdditionalCameraWeight(teamIndex, playerIndex, weight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | luaIndex | no |  |
| `playerIndex` | luaIndex | no |  |
| `weight` | number | no |  |

**Example**

```lua
C_Commentator.SetAdditionalCameraWeight(1, 1, 0)
```

### C_Commentator.SetAdditionalCameraWeightByToken

```lua
C_Commentator.SetAdditionalCameraWeightByToken(unitToken, weight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `weight` | number | no |  |

**Example**

```lua
C_Commentator.SetAdditionalCameraWeightByToken("player", 0)
```

### C_Commentator.SetBlocklistedAuras

```lua
C_Commentator.SetBlocklistedAuras(spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetBlocklistedAuras(12345)
```

### C_Commentator.SetBlocklistedCooldowns

```lua
C_Commentator.SetBlocklistedCooldowns(specID, spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetBlocklistedCooldowns(0, 12345)
```

### C_Commentator.SetBlocklistedItemCooldowns

```lua
C_Commentator.SetBlocklistedItemCooldowns(itemIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetBlocklistedItemCooldowns(6948)
```

### C_Commentator.SetCamera

```lua
C_Commentator.SetCamera(xPos, yPos, zPos, yaw, pitch, roll, fov)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `zPos` | number | no |  |
| `yaw` | number | no |  |
| `pitch` | number | no |  |
| `roll` | number | no |  |
| `fov` | number | no |  |

**Example**

```lua
C_Commentator.SetCamera(0, 0, 0, 0, 0, 0, 0)
```

### C_Commentator.SetCameraCollision

```lua
C_Commentator.SetCameraCollision(collide)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collide` | bool | no |  |

**Example**

```lua
C_Commentator.SetCameraCollision(false)
```

### C_Commentator.SetCameraPosition

```lua
C_Commentator.SetCameraPosition(xPos, yPos, zPos, snapToLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `zPos` | number | no |  |
| `snapToLocation` | bool | no |  |

**Example**

```lua
C_Commentator.SetCameraPosition(0, 0, 0, false)
```

### C_Commentator.SetCheatsEnabled

```lua
C_Commentator.SetCheatsEnabled(enableCheats)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enableCheats` | bool | no |  |

**Example**

```lua
C_Commentator.SetCheatsEnabled(false)
```

### C_Commentator.SetCommentatorHistory

```lua
C_Commentator.SetCommentatorHistory(history)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `history` | CommentatorHistory | no |  |

**Example**

```lua
C_Commentator.SetCommentatorHistory(history)
```

### C_Commentator.SetDistanceBeforeForcedHorizontalConvergence

```lua
C_Commentator.SetDistanceBeforeForcedHorizontalConvergence(distance)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example**

```lua
C_Commentator.SetDistanceBeforeForcedHorizontalConvergence(0)
```

### C_Commentator.SetDurationToForceHorizontalConvergence

```lua
C_Commentator.SetDurationToForceHorizontalConvergence(ms)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
C_Commentator.SetDurationToForceHorizontalConvergence(0)
```

### C_Commentator.SetExcludeDistance

```lua
C_Commentator.SetExcludeDistance(excludeDistance)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `excludeDistance` | number | no |  |

**Example**

```lua
C_Commentator.SetExcludeDistance(0)
```

### C_Commentator.SetFollowCameraSpeeds

```lua
C_Commentator.SetFollowCameraSpeeds(elasticSpeed, minSpeed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elasticSpeed` | number | no |  |
| `minSpeed` | number | no |  |

**Example**

```lua
C_Commentator.SetFollowCameraSpeeds(0, 0)
```

### C_Commentator.SetHardlockWeight

```lua
C_Commentator.SetHardlockWeight(weight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weight` | number | no |  |

**Example**

```lua
C_Commentator.SetHardlockWeight(0)
```

### C_Commentator.SetHorizontalAngleThresholdToSmooth

```lua
C_Commentator.SetHorizontalAngleThresholdToSmooth(angle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `angle` | number | no |  |

**Example**

```lua
C_Commentator.SetHorizontalAngleThresholdToSmooth(0)
```

### C_Commentator.SetLookAtLerpAmount

```lua
C_Commentator.SetLookAtLerpAmount(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
C_Commentator.SetLookAtLerpAmount(0)
```

### C_Commentator.SetMapAndInstanceIndex

```lua
C_Commentator.SetMapAndInstanceIndex(mapIndex, instanceIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapIndex` | luaIndex | no |  |
| `instanceIndex` | luaIndex | no |  |

**Example**

```lua
C_Commentator.SetMapAndInstanceIndex(1, 1)
```

### C_Commentator.SetMouseDisabled

```lua
C_Commentator.SetMouseDisabled(disabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disabled` | bool | no |  |

**Example**

```lua
C_Commentator.SetMouseDisabled(false)
```

### C_Commentator.SetMoveSpeed

```lua
C_Commentator.SetMoveSpeed(newSpeed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newSpeed` | number | no |  |

**Example**

```lua
C_Commentator.SetMoveSpeed(0)
```

### C_Commentator.SetMsToHoldForHorizontalMovement

```lua
C_Commentator.SetMsToHoldForHorizontalMovement(ms)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
C_Commentator.SetMsToHoldForHorizontalMovement(0)
```

### C_Commentator.SetMsToHoldForVerticalMovement

```lua
C_Commentator.SetMsToHoldForVerticalMovement(ms)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
C_Commentator.SetMsToHoldForVerticalMovement(0)
```

### C_Commentator.SetMsToSmoothHorizontalChange

```lua
C_Commentator.SetMsToSmoothHorizontalChange(ms)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
C_Commentator.SetMsToSmoothHorizontalChange(0)
```

### C_Commentator.SetMsToSmoothVerticalChange

```lua
C_Commentator.SetMsToSmoothVerticalChange(ms)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ms` | number | no |  |

**Example**

```lua
C_Commentator.SetMsToSmoothVerticalChange(0)
```

### C_Commentator.SetPositionLerpAmount

```lua
C_Commentator.SetPositionLerpAmount(amount)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
C_Commentator.SetPositionLerpAmount(0)
```

### C_Commentator.SetRequestedDebuffCooldowns

```lua
C_Commentator.SetRequestedDebuffCooldowns(specID, spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetRequestedDebuffCooldowns(0, 12345)
```

### C_Commentator.SetRequestedDefensiveCooldowns

```lua
C_Commentator.SetRequestedDefensiveCooldowns(specID, spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetRequestedDefensiveCooldowns(0, 12345)
```

### C_Commentator.SetRequestedItemCooldowns

```lua
C_Commentator.SetRequestedItemCooldowns(itemIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetRequestedItemCooldowns(6948)
```

### C_Commentator.SetRequestedOffensiveCooldowns

```lua
C_Commentator.SetRequestedOffensiveCooldowns(specID, spellIDs)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `spellIDs` | number[] | no |  |

**Example**

```lua
C_Commentator.SetRequestedOffensiveCooldowns(0, 12345)
```

### C_Commentator.SetSeriesScore

```lua
C_Commentator.SetSeriesScore(teamName1, teamName2, scoringTeamName, score)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName1` | string | no |  |
| `teamName2` | string | no |  |
| `scoringTeamName` | string | no |  |
| `score` | number | no |  |

**Example**

```lua
C_Commentator.SetSeriesScore("", "", "", 0)
```

### C_Commentator.SetSeriesScores

```lua
C_Commentator.SetSeriesScores(teamName1, teamName2, score1, score2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName1` | string | no |  |
| `teamName2` | string | no |  |
| `score1` | number | no |  |
| `score2` | number | no |  |

**Example**

```lua
C_Commentator.SetSeriesScores("", "", 0, 0)
```

### C_Commentator.SetSmartCameraLocked

```lua
C_Commentator.SetSmartCameraLocked(locked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locked` | bool | no |  |

**Example**

```lua
C_Commentator.SetSmartCameraLocked(false)
```

### C_Commentator.SetSmoothFollowTransitioning

```lua
C_Commentator.SetSmoothFollowTransitioning(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
C_Commentator.SetSmoothFollowTransitioning(false)
```

### C_Commentator.SetSoftlockWeight

```lua
C_Commentator.SetSoftlockWeight(weight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `weight` | number | no |  |

**Example**

```lua
C_Commentator.SetSoftlockWeight(0)
```

### C_Commentator.SetSpeedFactor

```lua
C_Commentator.SetSpeedFactor(factor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factor` | number | no |  |

**Example**

```lua
C_Commentator.SetSpeedFactor(0)
```

### C_Commentator.SetTargetHeightOffset

```lua
C_Commentator.SetTargetHeightOffset(offset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offset` | number | no |  |

**Example**

```lua
C_Commentator.SetTargetHeightOffset(0)
```

### C_Commentator.SetUseSmartCamera

```lua
C_Commentator.SetUseSmartCamera(useSmartCamera)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `useSmartCamera` | bool | no |  |

**Example**

```lua
C_Commentator.SetUseSmartCamera(false)
```

### C_Commentator.SnapCameraLookAtPoint

```lua
C_Commentator.SnapCameraLookAtPoint()
```

**Example**

```lua
C_Commentator.SnapCameraLookAtPoint()
```

### C_Commentator.SpellUsesItemCharges

```lua
spellUsesItemCharges = C_Commentator.SpellUsesItemCharges(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellUsesItemCharges` | bool | no |  |

**Example**

```lua
local spellUsesItemCharges = C_Commentator.SpellUsesItemCharges(12345)
```

### C_Commentator.StartWargame

```lua
C_Commentator.StartWargame(listID, teamSize, tournamentRules, teamOneCaptain, teamTwoCaptain)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `listID` | number | no |  |
| `teamSize` | number | no |  |
| `tournamentRules` | bool | no |  |
| `teamOneCaptain` | string | no |  |
| `teamTwoCaptain` | string | no |  |

**Example**

```lua
C_Commentator.StartWargame(0, 0, false, "", "")
```

### C_Commentator.SwapTeamSides

```lua
C_Commentator.SwapTeamSides()
```

**Example**

```lua
C_Commentator.SwapTeamSides()
```

### C_Commentator.ToggleCheats

```lua
C_Commentator.ToggleCheats()
```

**Example**

```lua
C_Commentator.ToggleCheats()
```

### C_Commentator.UpdateMapInfo

```lua
C_Commentator.UpdateMapInfo([targetPlayer])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetPlayer` | string | yes |  |

**Example**

```lua
C_Commentator.UpdateMapInfo()
```

### C_Commentator.UpdatePlayerInfo

```lua
C_Commentator.UpdatePlayerInfo()
```

**Example**

```lua
C_Commentator.UpdatePlayerInfo()
```

### C_Commentator.ZoomIn

```lua
C_Commentator.ZoomIn()
```

**Example**

```lua
C_Commentator.ZoomIn()
```

### C_Commentator.ZoomIn_Position

```lua
C_Commentator.ZoomIn_Position([zoomAmount])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomAmount` | number | yes |  |

**Example**

```lua
C_Commentator.ZoomIn_Position()
```

### C_Commentator.ZoomOut

```lua
C_Commentator.ZoomOut()
```

**Example**

```lua
C_Commentator.ZoomOut()
```

### C_Commentator.ZoomOut_Position

```lua
C_Commentator.ZoomOut_Position([zoomAmount])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `zoomAmount` | number | yes |  |

**Example**

```lua
C_Commentator.ZoomOut_Position()
```

## Events

### COMMENTATOR_COMBAT_EVENT

### COMMENTATOR_ENTER_WORLD

### COMMENTATOR_HISTORY_FLUSHED

### COMMENTATOR_IMMEDIATE_FOV_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fov` | number | no |  |

### COMMENTATOR_MAP_UPDATE

### COMMENTATOR_PLAYER_NAME_OVERRIDE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nameToOverride` | cstring | no |  |
| `overrideName` | cstring | yes |  |

### COMMENTATOR_PLAYER_UPDATE

### COMMENTATOR_RESET_SETTINGS

### COMMENTATOR_TEAM_NAME_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamName` | string | no |  |

### COMMENTATOR_TEAMS_SWAPPED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `swapped` | bool | no |  |

## Types

### CommentatorHistory (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `series` | CommentatorSeries[] | no |  |
| `teamDirectory` | CommentatorTeamDirectoryEntry[] | no |  |
| `overrideNameDirectory` | CommentatorOverrideNameEntry[] | no |  |

### CommentatorMatchDataState (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `receivedPlayerInfo` | bool | no |  |
| `setInstancePlayers` | bool | no |  |
| `requestedCooldownInfo` | bool | no |  |
| `requestedPlayerCooldowns` | TeamPlayerRequestedCooldownInfo[] | no |  |

### CommentatorOverrideNameEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `originalName` | string | no |  |
| `newName` | string | no |  |

### CommentatorPlayerData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | string | no |  |
| `name` | string | no |  |
| `faction` | number | no |  |
| `specialization` | number | no |  |
| `damageDone` | number | no |  |
| `damageTaken` | number | no |  |
| `healingDone` | number | no |  |
| `healingTaken` | number | no |  |
| `kills` | number | no |  |
| `deaths` | number | no |  |
| `soloShuffleRoundWins` | number | no |  |
| `soloShuffleRoundLosses` | number | no |  |

### CommentatorSeries (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teams` | CommentatorSeriesTeam[] | no |  |

### CommentatorSeriesTeam (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `score` | number | no |  |

### CommentatorTeamDirectoryEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerName` | string | no |  |
| `teamName` | string | no |  |

### CommentatorTrackedItemCooldown (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `category` | TrackedSpellCategory | no |  |

### CommentatorUnitData (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healthMax` | number | no |  |
| `health` | number | no |  |
| `absorbTotal` | number | no |  |
| `isDeadOrGhost` | bool | no |  |
| `isFeignDeath` | bool | no |  |
| `powerTypeToken` | string | no |  |
| `power` | number | no |  |
| `powerMax` | number | no |  |

### NameOverrideEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `originalName` | string | no |  |
| `overrideName` | string | no |  |

### TeamPlayerRequestedCooldownInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `teamIndex` | number | no |  |
| `playerIndex` | number | no |  |
| `cooldownsRequested` | number | no |  |

### TrackedSpellsResult (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Success` | TrackedSpellsResult | no |  |
| `PlayerNotFound` | TrackedSpellsResult | no |  |
| `NoCooldownInfo` | TrackedSpellsResult | no |  |
| `MismatchedCooldownInfo` | TrackedSpellsResult | no |  |

