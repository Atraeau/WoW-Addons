# C_PlayerInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**40** functions · **0** events · **2** types

## Functions

### C_PlayerInfo.CanPlayerEnterChromieTime

```lua
canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canEnter` | bool | no |  |

**Example**

```lua
local canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
```

### C_PlayerInfo.CanPlayerUseAreaLoot

```lua
canUseAreaLoot = C_PlayerInfo.CanPlayerUseAreaLoot()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseAreaLoot` | bool | no |  |

**Example**

```lua
local canUseAreaLoot = C_PlayerInfo.CanPlayerUseAreaLoot()
```

### C_PlayerInfo.CanPlayerUseMountEquipment

```lua
canUseMountEquipment, failureReason = C_PlayerInfo.CanPlayerUseMountEquipment()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUseMountEquipment` | bool | no |  |
| `failureReason` | string | no |  |

**Example**

```lua
local canUseMountEquipment, failureReason = C_PlayerInfo.CanPlayerUseMountEquipment()
```

### C_PlayerInfo.CanUseItem

```lua
isUseable = C_PlayerInfo.CanUseItem(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUseable` | bool | no |  |

**Example**

```lua
local isUseable = C_PlayerInfo.CanUseItem(6948)
```

### C_PlayerInfo.GetAlternateFormInfo

```lua
hasAlternateForm, inAlternateForm = C_PlayerInfo.GetAlternateFormInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAlternateForm` | bool | no |  |
| `inAlternateForm` | bool | no |  |

**Example**

```lua
local hasAlternateForm, inAlternateForm = C_PlayerInfo.GetAlternateFormInfo()
```

### C_PlayerInfo.GetClass

```lua
className, classFilename, classID = C_PlayerInfo.GetClass(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `className` | cstring | yes |  |
| `classFilename` | cstring | yes |  |
| `classID` | number | yes |  |

**Example**

```lua
local className, classFilename, classID = C_PlayerInfo.GetClass(playerLocation)
```

### C_PlayerInfo.GetContentDifficultyCreatureForPlayer

```lua
difficulty = C_PlayerInfo.GetContentDifficultyCreatureForPlayer(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficulty` | RelativeContentDifficulty | no |  |

**Example**

```lua
local difficulty = C_PlayerInfo.GetContentDifficultyCreatureForPlayer("player")
```

### C_PlayerInfo.GetContentDifficultyQuestForPlayer

```lua
difficulty = C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `difficulty` | RelativeContentDifficulty | no |  |

**Example**

```lua
local difficulty = C_PlayerInfo.GetContentDifficultyQuestForPlayer(0)
```

### C_PlayerInfo.GetDisplayID

```lua
displayID = C_PlayerInfo.GetDisplayID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayID` | number | no |  |

**Example**

```lua
local displayID = C_PlayerInfo.GetDisplayID()
```

### C_PlayerInfo.GetGlidingInfo

```lua
isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGliding` | bool | no |  |
| `canGlide` | bool | no |  |
| `forwardSpeed` | number | no |  |

**Example**

```lua
local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
```

### C_PlayerInfo.GetInstancesUnlockedAtLevel

```lua
dungeonID = C_PlayerInfo.GetInstancesUnlockedAtLevel(level, isRaid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |
| `isRaid` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dungeonID` | number[] | no |  |

**Example**

```lua
local dungeonID = C_PlayerInfo.GetInstancesUnlockedAtLevel(0, false)
```

### C_PlayerInfo.GetName

```lua
name = C_PlayerInfo.GetName(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |

**Example**

```lua
local name = C_PlayerInfo.GetName(playerLocation)
```

### C_PlayerInfo.GetNativeDisplayID

```lua
nativeDisplayID = C_PlayerInfo.GetNativeDisplayID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nativeDisplayID` | number | no |  |

**Example**

```lua
local nativeDisplayID = C_PlayerInfo.GetNativeDisplayID()
```

### C_PlayerInfo.GetPetStableCreatureDisplayInfoID

```lua
creatureDisplayInfoID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureDisplayInfoID` | number | no |  |

**Example**

```lua
local creatureDisplayInfoID = C_PlayerInfo.GetPetStableCreatureDisplayInfoID(1)
```

### C_PlayerInfo.GetPlayerCharacterData

```lua
characterData = C_PlayerInfo.GetPlayerCharacterData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `characterData` | PlayerInfoCharacterData | no |  |

**Example**

```lua
local characterData = C_PlayerInfo.GetPlayerCharacterData()
```

### C_PlayerInfo.GetPlayerMythicPlusRatingSummary

Returns the players mythic+ rating summary which includes the runs they've completed as well as their current season m+ rating

```lua
ratingSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(playerToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratingSummary` | MythicPlusRatingSummary | no |  |

**Example**

```lua
local ratingSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(playerToken)
```

### C_PlayerInfo.GetRace

```lua
raceID = C_PlayerInfo.GetRace(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | yes |  |

**Example**

```lua
local raceID = C_PlayerInfo.GetRace(playerLocation)
```

### C_PlayerInfo.GetSex

```lua
sex = C_PlayerInfo.GetSex(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sex` | UnitSex | yes |  |

**Example**

```lua
local sex = C_PlayerInfo.GetSex(playerLocation)
```

### C_PlayerInfo.GUIDIsPlayer

```lua
isPlayer = C_PlayerInfo.GUIDIsPlayer(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlayer` | bool | no |  |

**Example**

```lua
local isPlayer = C_PlayerInfo.GUIDIsPlayer("Creature-0-0000-0-0-0-0")
```

### C_PlayerInfo.HasAccountInventoryLock

```lua
hasAccountInventoryLock = C_PlayerInfo.HasAccountInventoryLock()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAccountInventoryLock` | bool | no |  |

**Example**

```lua
local hasAccountInventoryLock = C_PlayerInfo.HasAccountInventoryLock()
```

### C_PlayerInfo.HasVisibleInvSlot

```lua
isVisible = C_PlayerInfo.HasVisibleInvSlot(slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example**

```lua
local isVisible = C_PlayerInfo.HasVisibleInvSlot(1)
```

### C_PlayerInfo.IsAccountBankEnabled

```lua
isAccountBankEnabled = C_PlayerInfo.IsAccountBankEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAccountBankEnabled` | bool | no |  |

**Example**

```lua
local isAccountBankEnabled = C_PlayerInfo.IsAccountBankEnabled()
```

### C_PlayerInfo.IsCharacterBankEnabled

```lua
isCharacterBankEnabled = C_PlayerInfo.IsCharacterBankEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCharacterBankEnabled` | bool | no |  |

**Example**

```lua
local isCharacterBankEnabled = C_PlayerInfo.IsCharacterBankEnabled()
```

### C_PlayerInfo.IsConnected

```lua
isConnected = C_PlayerInfo.IsConnected([playerLocation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConnected` | bool | yes |  |

**Example**

```lua
local isConnected = C_PlayerInfo.IsConnected()
```

### C_PlayerInfo.IsDisplayRaceNative

```lua
isDisplayRaceNative = C_PlayerInfo.IsDisplayRaceNative()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDisplayRaceNative` | bool | no |  |

**Example**

```lua
local isDisplayRaceNative = C_PlayerInfo.IsDisplayRaceNative()
```

### C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer

```lua
isUnlocked = C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(expansionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUnlocked` | bool | no |  |

**Example**

```lua
local isUnlocked = C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(0)
```

### C_PlayerInfo.IsMirrorImage

```lua
isMirrorImage = C_PlayerInfo.IsMirrorImage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMirrorImage` | bool | no |  |

**Example**

```lua
local isMirrorImage = C_PlayerInfo.IsMirrorImage()
```

### C_PlayerInfo.IsPlayerEligibleForNPE

```lua
isEligible, failureReason = C_PlayerInfo.IsPlayerEligibleForNPE()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEligible` | bool | no |  |
| `failureReason` | string | no |  |

**Example**

```lua
local isEligible, failureReason = C_PlayerInfo.IsPlayerEligibleForNPE()
```

### C_PlayerInfo.IsPlayerEligibleForNPEv2

```lua
isEligible, failureReason = C_PlayerInfo.IsPlayerEligibleForNPEv2()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEligible` | bool | no |  |
| `failureReason` | string | no |  |

**Example**

```lua
local isEligible, failureReason = C_PlayerInfo.IsPlayerEligibleForNPEv2()
```

### C_PlayerInfo.IsPlayerInChromieTime

```lua
inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inChromieTime` | bool | no |  |

**Example**

```lua
local inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
```

### C_PlayerInfo.IsPlayerInRPE

```lua
isInRPE = C_PlayerInfo.IsPlayerInRPE()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInRPE` | bool | no |  |

**Example**

```lua
local isInRPE = C_PlayerInfo.IsPlayerInRPE()
```

### C_PlayerInfo.IsPlayerInTimerunningHeroicWorldTier

```lua
inTimerunningHeroicWorldTier = C_PlayerInfo.IsPlayerInTimerunningHeroicWorldTier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inTimerunningHeroicWorldTier` | bool | no |  |

**Example**

```lua
local inTimerunningHeroicWorldTier = C_PlayerInfo.IsPlayerInTimerunningHeroicWorldTier()
```

### C_PlayerInfo.IsPlayerNPERestricted

```lua
isRestricted = C_PlayerInfo.IsPlayerNPERestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRestricted` | bool | no |  |

**Example**

```lua
local isRestricted = C_PlayerInfo.IsPlayerNPERestricted()
```

### C_PlayerInfo.IsReturningCharacter

```lua
isReturning = C_PlayerInfo.IsReturningCharacter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReturning` | bool | no |  |

**Example**

```lua
local isReturning = C_PlayerInfo.IsReturningCharacter()
```

### C_PlayerInfo.IsSelfFoundActive

```lua
active = C_PlayerInfo.IsSelfFoundActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example**

```lua
local active = C_PlayerInfo.IsSelfFoundActive()
```

### C_PlayerInfo.IsTradingPostAvailable

```lua
isAvailable = C_PlayerInfo.IsTradingPostAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example**

```lua
local isAvailable = C_PlayerInfo.IsTradingPostAvailable()
```

### C_PlayerInfo.IsTravelersLogAvailable

```lua
isAvailable = C_PlayerInfo.IsTravelersLogAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example**

```lua
local isAvailable = C_PlayerInfo.IsTravelersLogAvailable()
```

### C_PlayerInfo.IsTutorialsTabAvailable

```lua
isAvailable = C_PlayerInfo.IsTutorialsTabAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAvailable` | bool | no |  |

**Example**

```lua
local isAvailable = C_PlayerInfo.IsTutorialsTabAvailable()
```

### C_PlayerInfo.ShouldDisplaySurname

```lua
display = C_PlayerInfo.ShouldDisplaySurname()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `display` | bool | no |  |

**Example**

```lua
local display = C_PlayerInfo.ShouldDisplaySurname()
```

### C_PlayerInfo.UnitIsSameServer

```lua
unitIsSameServer = C_PlayerInfo.UnitIsSameServer(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitIsSameServer` | bool | no |  |

**Example**

```lua
local unitIsSameServer = C_PlayerInfo.UnitIsSameServer(playerLocation)
```

## Types

### MythicPlusRatingMapSummary (Structure)

Specific information about a completed mythic plus run.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `challengeModeID` | number | no |  |
| `mapScore` | number | no |  |
| `bestRunLevel` | number | no |  |
| `bestRunDurationMS` | number | no |  |
| `finishedSuccess` | bool | no |  |

### MythicPlusRatingSummary (Structure)

The current season rating and well as a list of completed mythic plus runs.

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentSeasonScore` | number | no |  |
| `runs` | MythicPlusRatingMapSummary[] | no |  |

