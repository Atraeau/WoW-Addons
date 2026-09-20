# C_Garrison

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**40** functions · **65** events · **20** types

## Functions

### C_Garrison.AddFollowerToMission

```lua
followerAdded = C_Garrison.AddFollowerToMission(missionID, followerID, [boardIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `followerID` | GarrisonFollower | no |  |
| `boardIndex` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerAdded` | bool | no |  |

**Example**

```lua
local followerAdded = C_Garrison.AddFollowerToMission(0, followerID)
```

### C_Garrison.GetAutoCombatDamageClassValues

```lua
damageClassStrings = C_Garrison.GetAutoCombatDamageClassValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `damageClassStrings` | AutoCombatDamageClassString[] | no |  |

**Example**

```lua
local damageClassStrings = C_Garrison.GetAutoCombatDamageClassValues()
```

### C_Garrison.GetAutoMissionBoardState

```lua
targetInfo = C_Garrison.GetAutoMissionBoardState(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetInfo` | AutoMissionTargetingInfo[] | no |  |

**Example**

```lua
local targetInfo = C_Garrison.GetAutoMissionBoardState(0)
```

### C_Garrison.GetAutoMissionEnvironmentEffect

```lua
autoMissionEnvEffect = C_Garrison.GetAutoMissionEnvironmentEffect(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoMissionEnvEffect` | AutoMissionEnvironmentEffect | yes |  |

**Example**

```lua
local autoMissionEnvEffect = C_Garrison.GetAutoMissionEnvironmentEffect(0)
```

### C_Garrison.GetAutoMissionTargetingInfo

```lua
targetInfo = C_Garrison.GetAutoMissionTargetingInfo(missionID, followerID, casterBoardIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `followerID` | GarrisonFollower | no |  |
| `casterBoardIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetInfo` | AutoMissionTargetingInfo[] | no |  |

**Example**

```lua
local targetInfo = C_Garrison.GetAutoMissionTargetingInfo(0, followerID, 1)
```

### C_Garrison.GetAutoMissionTargetingInfoForSpell

```lua
targetInfo = C_Garrison.GetAutoMissionTargetingInfoForSpell(missionID, autoCombatSpellID, casterBoardIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `autoCombatSpellID` | number | no |  |
| `casterBoardIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetInfo` | AutoMissionTargetingInfo[] | no |  |

**Example**

```lua
local targetInfo = C_Garrison.GetAutoMissionTargetingInfoForSpell(0, 12345, 1)
```

### C_Garrison.GetAutoTroops

```lua
autoTroopInfo = C_Garrison.GetAutoTroops(followerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerType` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoTroopInfo` | AutoCombatTroopInfo[] | no |  |

**Example**

```lua
local autoTroopInfo = C_Garrison.GetAutoTroops(0)
```

### C_Garrison.GetCombatLogSpellInfo

```lua
spellInfo = C_Garrison.GetCombatLogSpellInfo(autoCombatSpellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCombatSpellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellInfo` | AutoCombatSpellInfo | yes |  |

**Example**

```lua
local spellInfo = C_Garrison.GetCombatLogSpellInfo(12345)
```

### C_Garrison.GetCurrentCypherEquipmentLevel

```lua
equipmentLevel = C_Garrison.GetCurrentCypherEquipmentLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `equipmentLevel` | number | no |  |

**Example**

```lua
local equipmentLevel = C_Garrison.GetCurrentCypherEquipmentLevel()
```

### C_Garrison.GetCurrentGarrTalentTreeFriendshipFactionID

```lua
currentGarrTalentTreeFriendshipFactionID = C_Garrison.GetCurrentGarrTalentTreeFriendshipFactionID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentGarrTalentTreeFriendshipFactionID` | number | yes |  |

**Example**

```lua
local currentGarrTalentTreeFriendshipFactionID = C_Garrison.GetCurrentGarrTalentTreeFriendshipFactionID()
```

### C_Garrison.GetCurrentGarrTalentTreeID

```lua
currentGarrTalentTreeID = C_Garrison.GetCurrentGarrTalentTreeID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentGarrTalentTreeID` | number | yes |  |

**Example**

```lua
local currentGarrTalentTreeID = C_Garrison.GetCurrentGarrTalentTreeID()
```

### C_Garrison.GetCyphersToNextEquipmentLevel

```lua
cyphersToNext = C_Garrison.GetCyphersToNextEquipmentLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cyphersToNext` | number | yes |  |

**Example**

```lua
local cyphersToNext = C_Garrison.GetCyphersToNextEquipmentLevel()
```

### C_Garrison.GetFollowerAutoCombatSpells

```lua
autoCombatSpells, autoCombatAutoAttack = C_Garrison.GetFollowerAutoCombatSpells(garrFollowerID, followerLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerID` | GarrisonFollower | no |  |
| `followerLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCombatSpells` | AutoCombatSpellInfo[] | no |  |
| `autoCombatAutoAttack` | AutoCombatSpellInfo | yes |  |

**Example**

```lua
local autoCombatSpells, autoCombatAutoAttack = C_Garrison.GetFollowerAutoCombatSpells(garrFollowerID, 0)
```

### C_Garrison.GetFollowerAutoCombatStats

```lua
autoCombatInfo = C_Garrison.GetFollowerAutoCombatStats(garrFollowerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerID` | GarrisonFollower | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCombatInfo` | FollowerAutoCombatStatsInfo | yes |  |

**Example**

```lua
local autoCombatInfo = C_Garrison.GetFollowerAutoCombatStats(garrFollowerID)
```

### C_Garrison.GetFollowerMissionCompleteInfo

```lua
followerMissionCompleteInfo = C_Garrison.GetFollowerMissionCompleteInfo(followerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerID` | GarrisonFollower | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerMissionCompleteInfo` | FollowerMissionCompleteInfo | no |  |

**Example**

```lua
local followerMissionCompleteInfo = C_Garrison.GetFollowerMissionCompleteInfo(followerID)
```

### C_Garrison.GetGarrisonPlotsInstancesForMap

```lua
garrisonPlotInstances = C_Garrison.GetGarrisonPlotsInstancesForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonPlotInstances` | GarrisonPlotInstanceMapInfo[] | no |  |

**Example**

```lua
local garrisonPlotInstances = C_Garrison.GetGarrisonPlotsInstancesForMap(0)
```

### C_Garrison.GetGarrisonTalentTreeCurrencyTypes

```lua
garrTalentTreeCurrencyType = C_Garrison.GetGarrisonTalentTreeCurrencyTypes(garrTalentTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeCurrencyType` | number | yes |  |

**Example**

```lua
local garrTalentTreeCurrencyType = C_Garrison.GetGarrisonTalentTreeCurrencyTypes(0)
```

### C_Garrison.GetGarrisonTalentTreeType

```lua
garrTalentTreeType = C_Garrison.GetGarrisonTalentTreeType(garrTalentTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeType` | number | no |  |

**Example**

```lua
local garrTalentTreeType = C_Garrison.GetGarrisonTalentTreeType(0)
```

### C_Garrison.GetMaxCypherEquipmentLevel

```lua
maxEquipmentLevel = C_Garrison.GetMaxCypherEquipmentLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxEquipmentLevel` | number | no |  |

**Example**

```lua
local maxEquipmentLevel = C_Garrison.GetMaxCypherEquipmentLevel()
```

### C_Garrison.GetMissionCompleteEncounters

```lua
encounters = C_Garrison.GetMissionCompleteEncounters(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `encounters` | GarrisonEnemyEncounterInfo[] | no |  |

**Example**

```lua
local encounters = C_Garrison.GetMissionCompleteEncounters(0)
```

### C_Garrison.GetMissionDeploymentInfo

```lua
missionDeploymentInfo = C_Garrison.GetMissionDeploymentInfo(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionDeploymentInfo` | MissionDeploymentInfo | no |  |

**Example**

```lua
local missionDeploymentInfo = C_Garrison.GetMissionDeploymentInfo(0)
```

### C_Garrison.GetMissionEncounterIconInfo

```lua
missionEncounterIconInfo = C_Garrison.GetMissionEncounterIconInfo(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionEncounterIconInfo` | MissionEncounterIconInfo | no |  |

**Example**

```lua
local missionEncounterIconInfo = C_Garrison.GetMissionEncounterIconInfo(0)
```

### C_Garrison.GetTalentInfo

```lua
info = C_Garrison.GetTalentInfo(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GarrisonTalentInfo | no |  |

**Example**

```lua
local info = C_Garrison.GetTalentInfo(0)
```

### C_Garrison.GetTalentPointsSpentInTalentTree

```lua
talentPoints = C_Garrison.GetTalentPointsSpentInTalentTree(garrTalentTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentPoints` | number | no |  |

**Example**

```lua
local talentPoints = C_Garrison.GetTalentPointsSpentInTalentTree(0)
```

### C_Garrison.GetTalentTreeIDsByClassID

```lua
treeIDs = C_Garrison.GetTalentTreeIDsByClassID(garrType, classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrType` | number | no |  |
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeIDs` | number[] | no |  |

**Example**

```lua
local treeIDs = C_Garrison.GetTalentTreeIDsByClassID(0, 0)
```

### C_Garrison.GetTalentTreeInfo

```lua
info = C_Garrison.GetTalentTreeInfo(treeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GarrisonTalentTreeInfo | no |  |

**Example**

```lua
local info = C_Garrison.GetTalentTreeInfo(0)
```

### C_Garrison.GetTalentTreeResetInfo

```lua
goldCost, currencyCosts = C_Garrison.GetTalentTreeResetInfo(garrTalentTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `goldCost` | number | no |  |
| `currencyCosts` | GarrisonTalentCurrencyCostInfo[] | no |  |

**Example**

```lua
local goldCost, currencyCosts = C_Garrison.GetTalentTreeResetInfo(0)
```

### C_Garrison.GetTalentTreeTalentPointResearchInfo

```lua
goldCost, currencyCosts, durationSecs = C_Garrison.GetTalentTreeTalentPointResearchInfo(garrTalentID, researchRank, garrTalentTreeID, talentPointIndex, isRespec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentID` | number | no |  |
| `researchRank` | number | no |  |
| `garrTalentTreeID` | number | no |  |
| `talentPointIndex` | number | no |  |
| `isRespec` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `goldCost` | number | no |  |
| `currencyCosts` | GarrisonTalentCurrencyCostInfo[] | no |  |
| `durationSecs` | number | no |  |

**Example**

```lua
local goldCost, currencyCosts, durationSecs = C_Garrison.GetTalentTreeTalentPointResearchInfo(0, 1, 0, 1, false)
```

### C_Garrison.GetTalentUnlockWorldQuest

```lua
worldQuestID = C_Garrison.GetTalentUnlockWorldQuest(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `worldQuestID` | number | no |  |

**Example**

```lua
local worldQuestID = C_Garrison.GetTalentUnlockWorldQuest(0)
```

### C_Garrison.HasAdventures

```lua
hasAdventures = C_Garrison.HasAdventures()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAdventures` | bool | no |  |

**Example**

```lua
local hasAdventures = C_Garrison.HasAdventures()
```

### C_Garrison.IsAtGarrisonMissionNPC

```lua
atGarrisonMissionNPC = C_Garrison.IsAtGarrisonMissionNPC()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atGarrisonMissionNPC` | bool | no |  |

**Example**

```lua
local atGarrisonMissionNPC = C_Garrison.IsAtGarrisonMissionNPC()
```

### C_Garrison.IsEnvironmentCountered

```lua
environmentCountered = C_Garrison.IsEnvironmentCountered(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `environmentCountered` | bool | no |  |

**Example**

```lua
local environmentCountered = C_Garrison.IsEnvironmentCountered(0)
```

### C_Garrison.IsFollowerOnCompletedMission

```lua
followerOnCompletedMission = C_Garrison.IsFollowerOnCompletedMission(followerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerID` | GarrisonFollower | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerOnCompletedMission` | bool | no |  |

**Example**

```lua
local followerOnCompletedMission = C_Garrison.IsFollowerOnCompletedMission(followerID)
```

### C_Garrison.IsLandingPageMinimapButtonVisible

```lua
isLandingPageMinimapButtonVisible = C_Garrison.IsLandingPageMinimapButtonVisible(garrType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrType` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLandingPageMinimapButtonVisible` | bool | no |  |

**Example**

```lua
local isLandingPageMinimapButtonVisible = C_Garrison.IsLandingPageMinimapButtonVisible(0)
```

### C_Garrison.IsTalentConditionMet

```lua
isMet, failureString = C_Garrison.IsTalentConditionMet(talentID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `talentID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMet` | bool | no |  |
| `failureString` | cstring | yes |  |

**Example**

```lua
local isMet, failureString = C_Garrison.IsTalentConditionMet(0)
```

### C_Garrison.RegenerateCombatLog

```lua
success = C_Garrison.RegenerateCombatLog(missionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_Garrison.RegenerateCombatLog(0)
```

### C_Garrison.RemoveFollowerFromMission

```lua
C_Garrison.RemoveFollowerFromMission(missionID, followerID, [boardIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `followerID` | GarrisonFollower | no |  |
| `boardIndex` | number | yes |  |

**Example**

```lua
C_Garrison.RemoveFollowerFromMission(0, followerID)
```

### C_Garrison.RushHealAllFollowers

```lua
C_Garrison.RushHealAllFollowers(followerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerType` | number | no |  |

**Example**

```lua
C_Garrison.RushHealAllFollowers(0)
```

### C_Garrison.RushHealFollower

```lua
C_Garrison.RushHealFollower(garrFollowerID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerID` | GarrisonFollower | no |  |

**Example**

```lua
C_Garrison.RushHealFollower(garrFollowerID)
```

### C_Garrison.SetAutoCombatSpellFastForward

```lua
C_Garrison.SetAutoCombatSpellFastForward(state)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | bool | no |  |

**Example**

```lua
C_Garrison.SetAutoCombatSpellFastForward(false)
```

## Events

### GARRISON_ARCHITECT_CLOSED

### GARRISON_ARCHITECT_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_BUILDING_ACTIVATABLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buildingName` | cstring | no |  |
| `garrisonType` | number | no |  |

### GARRISON_BUILDING_ACTIVATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonPlotInstanceID` | number | no |  |
| `garrisonBuildingID` | number | no |  |

### GARRISON_BUILDING_ERROR

### GARRISON_BUILDING_LIST_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `categoryID` | number | no |  |

### GARRISON_BUILDING_PLACED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonPlotInstanceID` | number | no |  |
| `newPlacement` | bool | no |  |

### GARRISON_BUILDING_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrPlotInstanceID` | number | no |  |
| `garrBuildingID` | number | no |  |

### GARRISON_BUILDING_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonBuildingID` | number | no |  |
| `garrPlotInstanceID` | number | yes |  |

### GARRISON_FOLLOWER_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerDbID` | GarrisonFollower | no |  |
| `followerName` | cstring | no |  |
| `followerClassName` | cstring | no |  |
| `followerLevel` | number | no |  |
| `followerQuality` | number | no |  |
| `isUpgraded` | bool | no |  |
| `textureKit` | textureKit | no |  |
| `followerTypeID` | number | no |  |

### GARRISON_FOLLOWER_CATEGORIES_UPDATED

### GARRISON_FOLLOWER_DURABILITY_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerTypeID` | number | no |  |
| `followerDbID` | GarrisonFollower | no |  |
| `followerDurability` | number | no |  |

### GARRISON_FOLLOWER_HEALED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerID` | GarrisonFollower | no |  |

### GARRISON_FOLLOWER_LIST_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_FOLLOWER_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_FOLLOWER_UPGRADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerDbID` | GarrisonFollower | no |  |

### GARRISON_FOLLOWER_XP_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerTypeID` | number | no |  |
| `followerDbID` | GarrisonFollower | no |  |
| `xpChange` | number | no |  |
| `oldFollowerXp` | number | no |  |
| `oldFollowerLevel` | number | no |  |
| `oldFollowerQuality` | number | no |  |

### GARRISON_HIDE_LANDING_PAGE

### GARRISON_INVASION_AVAILABLE

### GARRISON_INVASION_UNAVAILABLE

### GARRISON_LANDINGPAGE_SHIPMENTS

### GARRISON_MISSION_AREA_BONUS_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonMissonBonusAbilityID` | number | no |  |

### GARRISON_MISSION_BONUS_ROLL_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `success` | bool | no |  |

### GARRISON_MISSION_COMPLETE_RESPONSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `canComplete` | bool | no |  |
| `success` | bool | no |  |
| `bonusRollSuccess` | bool | no |  |
| `followerDeaths` | GarrisonFollowerDeathInfo[] | no |  |
| `autoCombatResult` | AutoCombatResult | yes |  |

### GARRISON_MISSION_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |
| `missionID` | number | no |  |

### GARRISON_MISSION_LIST_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerTypeID` | number | no |  |

### GARRISON_MISSION_NPC_CLOSED

### GARRISON_MISSION_NPC_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_MISSION_REWARD_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missionID` | number | no |  |
| `followerDbID` | GarrisonFollower | no |  |

### GARRISON_MISSION_STARTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrFollowerTypeID` | number | no |  |
| `missionID` | number | no |  |

### GARRISON_MONUMENT_CLOSE_UI

### GARRISON_MONUMENT_LIST_LOADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### GARRISON_MONUMENT_REPLACED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### GARRISON_MONUMENT_SELECTED_TROPHY_ID_LOADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### GARRISON_MONUMENT_SHOW_UI

### GARRISON_RANDOM_MISSION_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |
| `missionID` | number | no |  |

### GARRISON_RECALL_PORTAL_LAST_USED_TIME

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `recallPortalLastUsedTime` | number | no |  |

### GARRISON_RECALL_PORTAL_USED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### GARRISON_RECRUIT_FOLLOWER_RESULT

### GARRISON_RECRUITMENT_FOLLOWERS_GENERATED

### GARRISON_RECRUITMENT_NPC_CLOSED

### GARRISON_RECRUITMENT_NPC_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_RECRUITMENT_READY

### GARRISON_SHIPMENT_RECEIVED

### GARRISON_SHIPYARD_NPC_CLOSED

### GARRISON_SHIPYARD_NPC_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### GARRISON_SHOW_LANDING_PAGE

### GARRISON_SPEC_GROUPS_CLEARED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTypeID` | number | no |  |

### GARRISON_SPEC_GROUP_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTypeID` | number | no |  |
| `specID` | number | no |  |

### GARRISON_TALENT_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTypeID` | number | no |  |
| `doAlert` | bool | no |  |

### GARRISON_TALENT_EVENT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventType` | number | no |  |
| `eventID` | number | no |  |

### GARRISON_TALENT_NPC_CLOSED

### GARRISON_TALENT_NPC_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonTypeID` | number | no |  |
| `garrisonTalentTreeID` | number | no |  |

### GARRISON_TALENT_RESEARCH_STARTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTypeID` | number | no |  |
| `garrisonTalentTreeID` | number | no |  |
| `garrTalentID` | number | no |  |

### GARRISON_TALENT_UNLOCKS_RESULT

### GARRISON_TALENT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTypeID` | number | no |  |

### GARRISON_TRADESKILL_NPC_CLOSED

### GARRISON_UPDATE

### GARRISON_UPGRADEABLE_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrisonUpgradeable` | bool | no |  |

### GARRISON_USE_PARTY_GARRISON_CHANGED

### SHIPMENT_CRAFTER_CLOSED

### SHIPMENT_CRAFTER_INFO

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | number | no |  |
| `shipmentCount` | number | no |  |
| `maxShipments` | number | no |  |
| `ownedShipments` | number | no |  |
| `plotInstanceID` | number | no |  |

### SHIPMENT_CRAFTER_OPENED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `charShipmentContainerID` | number | no |  |

### SHIPMENT_CRAFTER_REAGENT_UPDATE

### SHIPMENT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shipmentStarted` | bool | yes |  |
| `hasAttachedFollower` | bool | yes |  |

## Types

### AutoCombatDamageClassString (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `damageClassValue` | number | no |  |
| `locString` | cstring | no |  |

### AutoCombatResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `winner` | bool | no |  |
| `combatLog` | AutoMissionRound[] | no |  |

### AutoCombatSpellInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autoCombatSpellID` | number | no |  |
| `name` | cstring | no |  |
| `description` | string | no |  |
| `cooldown` | number | no |  |
| `duration` | number | no |  |
| `schoolMask` | number | no |  |
| `previewMask` | number | no |  |
| `icon` | fileID | no |  |
| `spellTutorialFlag` | number | no |  |
| `hasThornsEffect` | bool | no |  |

### AutoCombatTroopInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `followerID` | GarrisonFollower | no |  |
| `garrFollowerID` | GarrisonFollower | no |  |
| `followerTypeID` | number | no |  |
| `displayIDs` | FollowerDisplayID[] | no |  |
| `level` | number | no |  |
| `quality` | number | no |  |
| `levelXP` | number | no |  |
| `maxXP` | number | no |  |
| `height` | number | no |  |
| `scale` | number | no |  |
| `displayScale` | number | yes |  |
| `displayHeight` | number | yes |  |
| `classSpec` | number | yes |  |
| `className` | string | yes |  |
| `flavorText` | string | yes |  |
| `classAtlas` | textureAtlas | no |  |
| `portraitIconID` | fileID | no |  |
| `textureKit` | textureKit | no |  |
| `isTroop` | bool | no |  |
| `raceID` | number | no |  |
| `health` | number | no |  |
| `maxHealth` | number | no |  |
| `role` | number | no |  |
| `isAutoTroop` | bool | no |  |
| `isSoulbind` | bool | no |  |
| `isCollected` | bool | no |  |
| `autoCombatStats` | FollowerAutoCombatStatsInfo | no |  |

### AutoMissionCombatEventInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `boardIndex` | number | no |  |
| `oldHealth` | number | no |  |
| `newHealth` | number | no |  |
| `maxHealth` | number | no |  |
| `points` | number | yes |  |

### AutoMissionEnvironmentEffect (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `autoCombatSpellInfo` | AutoCombatSpellInfo | no |  |

### AutoMissionEvent (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | number | no |  |
| `spellID` | number | no |  |
| `schoolMask` | number | no |  |
| `effectIndex` | number | no |  |
| `casterBoardIndex` | number | no |  |
| `auraType` | number | no |  |
| `targetInfo` | AutoMissionCombatEventInfo[] | no |  |

### AutoMissionRound (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `events` | AutoMissionEvent[] | no |  |

### AutoMissionTargetingInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetIndex` | number | no |  |
| `previewType` | number | no |  |
| `spellID` | number | no |  |
| `effectIndex` | number | no |  |

### FollowerAutoCombatStatsInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentHealth` | number | no |  |
| `maxHealth` | number | no |  |
| `attack` | number | no |  |
| `healingTimestamp` | time_t | no |  |
| `healCost` | number | no |  |
| `minutesHealingRemaining` | number | no |  |

### FollowerDisplayID (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `followerPageScale` | number | no |  |
| `showWeapon` | bool | no |  |

### FollowerMissionCompleteInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayIDs` | FollowerDisplayID[] | no |  |
| `level` | number | no |  |
| `quality` | number | no |  |
| `currentXP` | number | no |  |
| `maxXP` | number | no |  |
| `height` | number | no |  |
| `scale` | number | no |  |
| `movementType` | number | yes |  |
| `impactDelay` | number | yes |  |
| `castID` | number | yes |  |
| `castSoundID` | number | yes |  |
| `impactID` | number | yes |  |
| `impactSoundID` | number | yes |  |
| `targetImpactID` | number | yes |  |
| `targetImpactSoundID` | number | yes |  |
| `className` | string | yes |  |
| `classAtlas` | textureAtlas | no |  |
| `portraitIconID` | fileID | no |  |
| `textureKit` | textureKit | no |  |
| `isTroop` | bool | no |  |
| `boardIndex` | number | no |  |
| `health` | number | no |  |
| `maxHealth` | number | no |  |
| `role` | number | no |  |

### GarrisonAbilityCounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `icon` | fileID | no |  |
| `name` | cstring | no |  |
| `factor` | number | no |  |
| `description` | cstring | no |  |

### GarrisonAbilityInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `description` | string | no |  |
| `icon` | fileID | no |  |
| `isTrait` | bool | no |  |
| `isSpecialization` | bool | no |  |
| `temporary` | bool | no |  |
| `category` | string | yes |  |
| `counters` | GarrisonAbilityCounterInfo[] | no |  |
| `isEmptySlot` | bool | no |  |

### GarrisonEnemyEncounterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayID` | fileID | no |  |
| `portraitFileDataID` | fileID | no |  |
| `textureKit` | textureKit | no |  |
| `scale` | number | no |  |
| `height` | number | no |  |
| `mechanics` | GarrisonMechanicInfo[] | no |  |
| `autoCombatSpells` | AutoCombatSpellInfo[] | no |  |
| `autoCombatAutoAttack` | AutoCombatSpellInfo | yes |  |
| `role` | number | no |  |
| `health` | number | no |  |
| `maxHealth` | number | no |  |
| `attack` | number | no |  |
| `boardIndex` | number | no |  |
| `isElite` | bool | no |  |

### GarrisonFollowerDeathInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerID` | GarrisonFollower | no |  |
| `state` | luaIndex | no |  |

### GarrisonMechanicInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mechanicTypeID` | number | no |  |
| `icon` | fileID | no |  |
| `name` | cstring | no |  |
| `factor` | number | no |  |
| `description` | cstring | no |  |
| `ability` | GarrisonAbilityInfo | yes |  |

### GarrisonPlotInstanceMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buildingPlotInstanceID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `atlasName` | textureAtlas | no |  |

### MissionDeploymentInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `location` | cstring | no |  |
| `xp` | number | no |  |
| `environment` | string | yes |  |
| `environmentDesc` | string | yes |  |
| `environmentTexture` | fileID | no |  |
| `locTextureKit` | textureKit | no |  |
| `isExhausting` | bool | no |  |
| `enemies` | GarrisonEnemyEncounterInfo[] | no |  |

### MissionEncounterIconInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `portraitFileDataID` | fileID | no |  |
| `missionScalar` | number | no |  |
| `isElite` | bool | no |  |
| `isRare` | bool | no |  |

