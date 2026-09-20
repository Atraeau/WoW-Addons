# Unit

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**217** functions · **142** events · **8** types

## Functions

### Unit.CanEjectPassengerFromSeat

```lua
result = CanEjectPassengerFromSeat(virtualSeatIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `virtualSeatIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CanEjectPassengerFromSeat(1)
```

### Unit.CanSwitchVehicleSeat

```lua
result = CanSwitchVehicleSeat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CanSwitchVehicleSeat()
```

### Unit.ClosestGameObjectPosition

```lua
xPos, yPos, distance = ClosestGameObjectPosition(gameObjectID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameObjectID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `distance` | number | no |  |

**Example**

```lua
local xPos, yPos, distance = ClosestGameObjectPosition(0)
```

### Unit.ClosestUnitPosition

```lua
xPos, yPos, distance = ClosestUnitPosition(creatureID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPos` | number | no |  |
| `yPos` | number | no |  |
| `distance` | number | no |  |

**Example**

```lua
local xPos, yPos, distance = ClosestUnitPosition(0)
```

### Unit.CreateUnitHealPredictionCalculator

```lua
healPredictionCalculator = CreateUnitHealPredictionCalculator()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healPredictionCalculator` | UnitHealPredictionCalculator | no |  |

**Example**

```lua
local healPredictionCalculator = CreateUnitHealPredictionCalculator()
```

### Unit.EjectPassengerFromSeat

```lua
EjectPassengerFromSeat(virtualSeatIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `virtualSeatIndex` | luaIndex | no |  |

**Example**

```lua
EjectPassengerFromSeat(1)
```

### Unit.GetComboPoints

```lua
result = GetComboPoints(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `target` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetComboPoints("player", target)
```

### Unit.GetNegativeCorruptionEffectInfo

```lua
corruptionEffects = GetNegativeCorruptionEffectInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `corruptionEffects` | CorruptionEffectInfo[] | no |  |

**Example**

```lua
local corruptionEffects = GetNegativeCorruptionEffectInfo()
```

### Unit.GetUnitChargedPowerPoints

```lua
pointIndices = GetUnitChargedPowerPoints(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pointIndices` | number[] | no |  |

**Example**

```lua
local pointIndices = GetUnitChargedPowerPoints("player")
```

### Unit.GetUnitEmpowerHoldAtMaxTime

```lua
holdAtMaxTime = GetUnitEmpowerHoldAtMaxTime(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `holdAtMaxTime` | number | no |  |

**Example**

```lua
local holdAtMaxTime = GetUnitEmpowerHoldAtMaxTime("player")
```

### Unit.GetUnitEmpowerMinHoldTime

```lua
minHoldTime = GetUnitEmpowerMinHoldTime(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minHoldTime` | number | no |  |

**Example**

```lua
local minHoldTime = GetUnitEmpowerMinHoldTime("player")
```

### Unit.GetUnitEmpowerStageDuration

```lua
duration = GetUnitEmpowerStageDuration(unit, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `index` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | no |  |

**Example**

```lua
local duration = GetUnitEmpowerStageDuration("player", 1)
```

### Unit.GetUnitHealthModifier

```lua
result = GetUnitHealthModifier(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetUnitHealthModifier("player")
```

### Unit.GetUnitMaxHealthModifier

```lua
result = GetUnitMaxHealthModifier(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetUnitMaxHealthModifier("player")
```

### Unit.GetUnitPowerBarInfo

```lua
info = GetUnitPowerBarInfo(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UnitPowerBarInfo | no |  |

**Example**

```lua
local info = GetUnitPowerBarInfo("player")
```

### Unit.GetUnitPowerBarInfoByID

```lua
info = GetUnitPowerBarInfoByID(barID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `barID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | UnitPowerBarInfo | no |  |

**Example**

```lua
local info = GetUnitPowerBarInfoByID(0)
```

### Unit.GetUnitPowerBarStrings

```lua
name, tooltip, cost = GetUnitPowerBarStrings(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `tooltip` | cstring | yes |  |
| `cost` | cstring | yes |  |

**Example**

```lua
local name, tooltip, cost = GetUnitPowerBarStrings("player")
```

### Unit.GetUnitPowerBarStringsByID

```lua
name, tooltip, cost = GetUnitPowerBarStringsByID(barID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `barID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `tooltip` | cstring | yes |  |
| `cost` | cstring | yes |  |

**Example**

```lua
local name, tooltip, cost = GetUnitPowerBarStringsByID(0)
```

### Unit.GetUnitPowerBarTextureInfo

```lua
texture, colorR, colorG, colorB, colorA = GetUnitPowerBarTextureInfo(unitToken, textureIndex, [timerIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `textureIndex` | luaIndex | no |  |
| `timerIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | fileID | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example**

```lua
local texture, colorR, colorG, colorB, colorA = GetUnitPowerBarTextureInfo("player", 1)
```

### Unit.GetUnitPowerBarTextureInfoByID

```lua
texture, colorR, colorG, colorB, colorA = GetUnitPowerBarTextureInfoByID(barID, textureIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `barID` | number | no |  |
| `textureIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | fileID | no |  |
| `colorR` | number | no |  |
| `colorG` | number | no |  |
| `colorB` | number | no |  |
| `colorA` | number | no |  |

**Example**

```lua
local texture, colorR, colorG, colorB, colorA = GetUnitPowerBarTextureInfoByID(0, 1)
```

### Unit.GetUnitPowerModifier

```lua
result = GetUnitPowerModifier(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetUnitPowerModifier("player")
```

### Unit.GetUnitSpeed

```lua
currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentSpeed` | number | no |  |
| `runSpeed` | number | no |  |
| `flightSpeed` | number | no |  |
| `swimSpeed` | number | no |  |

**Example**

```lua
local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")
```

### Unit.GetUnitTotalModifiedMaxHealthPercent

```lua
result = GetUnitTotalModifiedMaxHealthPercent(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetUnitTotalModifiedMaxHealthPercent("player")
```

### Unit.GetVehicleUIIndicator

```lua
backgroundTextureID, numSeatIndicators = GetVehicleUIIndicator(vehicleIndicatorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicleIndicatorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `backgroundTextureID` | fileID | no |  |
| `numSeatIndicators` | number | no |  |

**Example**

```lua
local backgroundTextureID, numSeatIndicators = GetVehicleUIIndicator(0)
```

### Unit.GetVehicleUIIndicatorSeat

```lua
virtualSeatIndex, xPos, yPos = GetVehicleUIIndicatorSeat(vehicleIndicatorID, indicatorSeatIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicleIndicatorID` | number | no |  |
| `indicatorSeatIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `virtualSeatIndex` | number | no |  |
| `xPos` | number | no |  |
| `yPos` | number | no |  |

**Example**

```lua
local virtualSeatIndex, xPos, yPos = GetVehicleUIIndicatorSeat(0, 1)
```

### Unit.IsFalling

```lua
result = IsFalling([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsFalling()
```

### Unit.IsFlying

```lua
result = IsFlying([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsFlying()
```

### Unit.IsPlayerInGuildFromGUID

```lua
IsInGuild = IsPlayerInGuildFromGUID(playerGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `IsInGuild` | bool | no |  |

**Example**

```lua
local IsInGuild = IsPlayerInGuildFromGUID("Creature-0-0000-0-0-0-0")
```

### Unit.IsSubmerged

```lua
result = IsSubmerged([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsSubmerged()
```

### Unit.IsSwimming

```lua
result = IsSwimming([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsSwimming()
```

### Unit.IsUnitModelReadyForUI

```lua
isReady = IsUnitModelReadyForUI(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isReady` | bool | no |  |

**Example**

```lua
local isReady = IsUnitModelReadyForUI("player")
```

### Unit.PlayerIsPVPInactive

```lua
result = PlayerIsPVPInactive(unit)
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
local result = PlayerIsPVPInactive("player")
```

### Unit.PlayerIsSpellTarget

If the unit is currently casting a spell, returns whether spell's target unit is the player. Returns false if the unit is not casting a spell or the spell has no target.

```lua
result = PlayerIsSpellTarget(unit)
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
local result = PlayerIsSpellTarget("player")
```

### Unit.PlayerVehicleHasComboPoints

```lua
vehicleHasComboPoints = PlayerVehicleHasComboPoints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicleHasComboPoints` | bool | no |  |

**Example**

```lua
local vehicleHasComboPoints = PlayerVehicleHasComboPoints()
```

### Unit.RegionalUniqueNamesEnabled

```lua
result = RegionalUniqueNamesEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = RegionalUniqueNamesEnabled()
```

### Unit.ReportPlayerIsPVPAFK

```lua
ReportPlayerIsPVPAFK(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Example**

```lua
ReportPlayerIsPVPAFK("player")
```

### Unit.ResistancePercent

```lua
result = ResistancePercent(resistance, casterLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resistance` | number | no |  |
| `casterLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = ResistancePercent(0, 0)
```

### Unit.SetPortraitTexture

```lua
SetPortraitTexture(textureObject, unitToken, disableMasking)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |
| `unitToken` | UnitToken | no |  |
| `disableMasking` | bool | no | (default: False) |

**Example**

```lua
SetPortraitTexture(textureObject, "player", false)
```

### Unit.SetPortraitTextureFromCreatureDisplayID

```lua
SetPortraitTextureFromCreatureDisplayID(textureObject, creatureDisplayID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |
| `creatureDisplayID` | number | no |  |

**Example**

```lua
SetPortraitTextureFromCreatureDisplayID(textureObject, 0)
```

### Unit.SetUnitCursorTexture

```lua
hasCursor = SetUnitCursorTexture(textureObject, unit, [style], [includeLowPriority], [preferGamepadIcon])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |
| `unit` | UnitToken | no |  |
| `style` | CursorStyle | yes |  |
| `includeLowPriority` | bool | yes |  |
| `preferGamepadIcon` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCursor` | bool | no |  |

**Example**

```lua
local hasCursor = SetUnitCursorTexture(textureObject, "player")
```

### Unit.UnitAffectingCombat

```lua
result = UnitAffectingCombat(unit)
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
local result = UnitAffectingCombat("player")
```

### Unit.UnitAlliedRaceInfo

```lua
isAlliedRace, hasHeritageArmorUnlocked = UnitAlliedRaceInfo(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAlliedRace` | bool | no |  |
| `hasHeritageArmorUnlocked` | bool | no |  |

**Example**

```lua
local isAlliedRace, hasHeritageArmorUnlocked = UnitAlliedRaceInfo("player")
```

### Unit.UnitArmor

```lua
base, effective, real, bonus = UnitArmor(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `base` | number | no |  |
| `effective` | number | no |  |
| `real` | number | no |  |
| `bonus` | number | no |  |

**Example**

```lua
local base, effective, real, bonus = UnitArmor("player")
```

### Unit.UnitAttackPower

```lua
attackPower, posBuff, negBuff = UnitAttackPower(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attackPower` | number | no |  |
| `posBuff` | number | no |  |
| `negBuff` | number | no |  |

**Example**

```lua
local attackPower, posBuff, negBuff = UnitAttackPower("player")
```

### Unit.UnitAttackSpeed

```lua
attackSpeed, offhandAttackSpeed, rangedAttackSpeed = UnitAttackSpeed(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attackSpeed` | number | no |  |
| `offhandAttackSpeed` | number | yes |  |
| `rangedAttackSpeed` | number | yes |  |

**Example**

```lua
local attackSpeed, offhandAttackSpeed, rangedAttackSpeed = UnitAttackSpeed("player")
```

### Unit.UnitBattlePetLevel

```lua
result = UnitBattlePetLevel(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitBattlePetLevel("player")
```

### Unit.UnitBattlePetSpeciesID

```lua
result = UnitBattlePetSpeciesID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitBattlePetSpeciesID("player")
```

### Unit.UnitBattlePetType

```lua
result = UnitBattlePetType(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitBattlePetType("player")
```

### Unit.UnitCanAssist

```lua
result = UnitCanAssist(unit, target, canAssistImmunePC, canAssistUninteractable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |
| `canAssistImmunePC` | bool | no | (default: False) |
| `canAssistUninteractable` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitCanAssist("player", target, false, false)
```

### Unit.UnitCanAttack

```lua
result = UnitCanAttack(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitCanAttack("player", target)
```

### Unit.UnitCanCooperate

```lua
result = UnitCanCooperate(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitCanCooperate("player", target)
```

### Unit.UnitCanPetBattle

```lua
result = UnitCanPetBattle(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitCanPetBattle("player", target)
```

### Unit.UnitCastingDuration

```lua
duration = UnitCastingDuration(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = UnitCastingDuration("player")
```

### Unit.UnitCastingInfo

```lua
name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs = UnitCastingInfo(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayName` | string | no |  |
| `textureID` | fileID | no |  |
| `startTimeMs` | number | no |  |
| `endTimeMs` | number | no |  |
| `isTradeskill` | bool | no |  |
| `castID` | WOWGUID | no |  |
| `notInterruptible` | bool | yes |  |
| `castingSpellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |
| `delayTimeMs` | number | no |  |

**Example**

```lua
local name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs = UnitCastingInfo("player")
```

### Unit.UnitChannelDuration

```lua
duration = UnitChannelDuration(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = UnitChannelDuration("player")
```

### Unit.UnitChannelInfo

```lua
name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, notInterruptible, spellID, isEmpowered, numEmpowerStages, castBarID = UnitChannelInfo(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayName` | cstring | no |  |
| `textureID` | fileID | no |  |
| `startTimeMs` | number | no |  |
| `endTimeMs` | number | no |  |
| `isTradeskill` | bool | no |  |
| `notInterruptible` | bool | yes |  |
| `spellID` | number | no |  |
| `isEmpowered` | bool | no |  |
| `numEmpowerStages` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

**Example**

```lua
local name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, notInterruptible, spellID, isEmpowered, numEmpowerStages, castBarID = UnitChannelInfo("player")
```

### Unit.UnitChromieTimeID

```lua
ID = UnitChromieTimeID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |

**Example**

```lua
local ID = UnitChromieTimeID("player")
```

### Unit.UnitClass

```lua
className, classFilename, classID = UnitClass(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `className` | cstring | no |  |
| `classFilename` | cstring | no |  |
| `classID` | number | no |  |

**Example**

```lua
local className, classFilename, classID = UnitClass("player")
```

### Unit.UnitClassBase

```lua
classFilename, classID = UnitClassBase(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classFilename` | cstring | no |  |
| `classID` | number | no |  |

**Example**

```lua
local classFilename, classID = UnitClassBase("player")
```

### Unit.UnitClassFromGUID

```lua
className, classFilename, classID = UnitClassFromGUID(unitGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `className` | cstring | no |  |
| `classFilename` | cstring | no |  |
| `classID` | number | no |  |

**Example**

```lua
local className, classFilename, classID = UnitClassFromGUID("player")
```

### Unit.UnitClassification

```lua
result = UnitClassification(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = UnitClassification("player")
```

### Unit.UnitControllingVehicle

```lua
result = UnitControllingVehicle(unit)
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
local result = UnitControllingVehicle("player")
```

### Unit.UnitCreatureFamily

```lua
name, id = UnitCreatureFamily(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `id` | number | no |  |

**Example**

```lua
local name, id = UnitCreatureFamily("player")
```

### Unit.UnitCreatureID

```lua
creatureID = UnitCreatureID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | yes |  |

**Example**

```lua
local creatureID = UnitCreatureID("player")
```

### Unit.UnitCreatureType

```lua
name, id = UnitCreatureType(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `id` | number | no |  |

**Example**

```lua
local name, id = UnitCreatureType("player")
```

### Unit.UnitDamage

```lua
minDamage, maxDamage, offhandMinDamage, offhandMaxDamage, posBuff, negBuff, percent = UnitDamage(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minDamage` | number | no |  |
| `maxDamage` | number | no |  |
| `offhandMinDamage` | number | no |  |
| `offhandMaxDamage` | number | no |  |
| `posBuff` | number | no |  |
| `negBuff` | number | no |  |
| `percent` | number | no |  |

**Example**

```lua
local minDamage, maxDamage, offhandMinDamage, offhandMaxDamage, posBuff, negBuff, percent = UnitDamage("player")
```

### Unit.UnitDefenseSkill

```lua
base, modifier = UnitDefenseSkill(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `base` | number | no |  |
| `modifier` | number | no |  |

**Example**

```lua
local base, modifier = UnitDefenseSkill("player")
```

### Unit.UnitDetailedThreatSituation

```lua
isTanking, status, scaledPercentage, rawPercentage, rawThreat = UnitDetailedThreatSituation(unit, mobGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobGUID` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTanking` | bool | no |  |
| `status` | number | no |  |
| `scaledPercentage` | number | no |  |
| `rawPercentage` | number | no |  |
| `rawThreat` | number | no |  |

**Example**

```lua
local isTanking, status, scaledPercentage, rawPercentage, rawThreat = UnitDetailedThreatSituation("player", "Creature-0-0000-0-0-0-0")
```

### Unit.UnitDistanceSquared

```lua
distance, checkedDistance = UnitDistanceSquared(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |
| `checkedDistance` | bool | no |  |

**Example**

```lua
local distance, checkedDistance = UnitDistanceSquared("player")
```

### Unit.UnitEffectiveLevel

```lua
result = UnitEffectiveLevel(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitEffectiveLevel("")
```

### Unit.UnitEmpoweredChannelDuration

Returns a duration object that includes the duration of an empowered cast channel.

```lua
duration = UnitEmpoweredChannelDuration(unit, includeHoldAtMaxTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `includeHoldAtMaxTime` | bool | no | If true, include the hold-at-max time of the empowered channel in the total duration. (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = UnitEmpoweredChannelDuration("player", false)
```

### Unit.UnitEmpoweredStageDurations

Returns a vector of duration objects that measure the time spans for each individual stage in an empowered channel, with hold-at-max time included as the last element.

```lua
duration = UnitEmpoweredStageDurations(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject[] | no |  |

**Example**

```lua
local duration = UnitEmpoweredStageDurations("player")
```

### Unit.UnitEmpoweredStagePercentages

Returns a vector of percentages that describe how much of the total duration of an empowered channel is occupied by a stage.

```lua
percentages = UnitEmpoweredStagePercentages(unit, includeHoldAtMaxTime)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `includeHoldAtMaxTime` | bool | no | If true, include the hold-at-max time of the empowered channel in the total duration and add a percentage value for it. (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `percentages` | number[] | no |  |

**Example**

```lua
local percentages = UnitEmpoweredStagePercentages("player", false)
```

### Unit.UnitExists

```lua
result = UnitExists([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitExists()
```

### Unit.UnitFactionGroup

```lua
factionGroupTag, localized = UnitFactionGroup(unitName, checkDisplayRace)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `checkDisplayRace` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionGroupTag` | cstring | no |  |
| `localized` | cstring | no |  |

**Example**

```lua
local factionGroupTag, localized = UnitFactionGroup("player", false)
```

### Unit.UnitFullName

```lua
unitName, unitServer = UnitFullName(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `unitServer` | cstring | no |  |

**Example**

```lua
local unitName, unitServer = UnitFullName("player")
```

### Unit.UnitGetDetailedHealPrediction

```lua
UnitGetDetailedHealPrediction(unit, [healerUnit], healPredictionCalculator)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `healerUnit` | UnitTokenPvPRestrictedForAddOns | yes | If specified, a unit to evaluate as the 'healer' for incoming heal values. If nil, healer values will be zero. |
| `healPredictionCalculator` | UnitHealPredictionCalculator | no |  |

**Example**

```lua
UnitGetDetailedHealPrediction("player", healPredictionCalculator)
```

### Unit.UnitGetIncomingHeals

```lua
result = UnitGetIncomingHeals(unit, [healerGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `healerGUID` | UnitTokenPvPRestrictedForAddOns | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitGetIncomingHeals("player")
```

### Unit.UnitGetTotalAbsorbs

```lua
result = UnitGetTotalAbsorbs(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitGetTotalAbsorbs("player")
```

### Unit.UnitGetTotalHealAbsorbs

```lua
result = UnitGetTotalHealAbsorbs(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitGetTotalHealAbsorbs("player")
```

### Unit.UnitGroupRolesAssigned

```lua
result = UnitGroupRolesAssigned([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = UnitGroupRolesAssigned()
```

### Unit.UnitGroupRolesAssignedEnum

```lua
result = UnitGroupRolesAssignedEnum([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitGroupRolesAssignedEnum()
```

### Unit.UnitGUID

```lua
result = UnitGUID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | WOWGUID | yes |  |

**Example**

```lua
local result = UnitGUID("player")
```

### Unit.UnitHasEffectivelyTankAura

```lua
result = UnitHasEffectivelyTankAura([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitHasEffectivelyTankAura()
```

### Unit.UnitHasLootInteraction

```lua
result = UnitHasLootInteraction(unit)
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
local result = UnitHasLootInteraction("player")
```

### Unit.UnitHasMouseoverHighlight

```lua
result = UnitHasMouseoverHighlight(unit)
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
local result = UnitHasMouseoverHighlight("player")
```

### Unit.UnitHasPowerType

```lua
hasPower = UnitHasPowerType(unitToken, powerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPower` | bool | no |  |

**Example**

```lua
local hasPower = UnitHasPowerType("player", powerType)
```

### Unit.UnitHasRelicSlot

```lua
result = UnitHasRelicSlot(unit)
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
local result = UnitHasRelicSlot("player")
```

### Unit.UnitHasVehiclePlayerFrameUI

```lua
result = UnitHasVehiclePlayerFrameUI([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitHasVehiclePlayerFrameUI()
```

### Unit.UnitHasVehicleUI

```lua
result = UnitHasVehicleUI([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitHasVehicleUI()
```

### Unit.UnitHealth

```lua
result = UnitHealth(unit, usePredicted)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `usePredicted` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHealth("player", false)
```

### Unit.UnitHealthMax

```lua
result = UnitHealthMax(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHealthMax("player")
```

### Unit.UnitHealthMissing

Result of UnitHealthMax() - UnitHealth()

```lua
result = UnitHealthMissing(unit, usePredicted)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `usePredicted` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHealthMissing("player", false)
```

### Unit.UnitHealthPercent

Returns percent of health remaining - can be scaled via a curve for display purposes

```lua
result = UnitHealthPercent(unit, usePredicted, [curve])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `usePredicted` | bool | no | (default: True) |
| `curve` | LuaCurveObjectBase | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no | If no curve is specified, a floating point percentage value. Else, the result of evaluating the curve with the percentage as the input. |

**Example**

```lua
local result = UnitHealthPercent("player", false)
```

### Unit.UnitHonor

```lua
result = UnitHonor(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHonor("player")
```

### Unit.UnitHonorLevel

```lua
result = UnitHonorLevel(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHonorLevel("player")
```

### Unit.UnitHonorMax

```lua
result = UnitHonorMax(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHonorMax("player")
```

### Unit.UnitHPPerStamina

```lua
result = UnitHPPerStamina(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitHPPerStamina("player")
```

### Unit.UnitInAnyGroup

```lua
result = UnitInAnyGroup([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInAnyGroup()
```

### Unit.UnitInBattleground

```lua
result = UnitInBattleground([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | luaIndex | yes |  |

**Example**

```lua
local result = UnitInBattleground()
```

### Unit.UnitInOtherParty

Checks whether this unit cannot see your party chat because it is in an instance group

```lua
inOtherParty = UnitInOtherParty(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inOtherParty` | bool | no |  |

**Example**

```lua
local inOtherParty = UnitInOtherParty("player")
```

### Unit.UnitInParty

```lua
result = UnitInParty([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInParty()
```

### Unit.UnitInPartyIsAI

```lua
result = UnitInPartyIsAI([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInPartyIsAI()
```

### Unit.UnitInPartyShard

```lua
inPartyShard = UnitInPartyShard(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inPartyShard` | bool | no |  |

**Example**

```lua
local inPartyShard = UnitInPartyShard("player")
```

### Unit.UnitInRaid

```lua
result = UnitInRaid([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | luaIndex | yes |  |

**Example**

```lua
local result = UnitInRaid()
```

### Unit.UnitInRange

```lua
inRange, checkedRange = UnitInRange(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inRange` | bool | no |  |
| `checkedRange` | bool | no |  |

**Example**

```lua
local inRange, checkedRange = UnitInRange("player")
```

### Unit.UnitInSubgroup

```lua
result = UnitInSubgroup([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInSubgroup()
```

### Unit.UnitInVehicle

```lua
result = UnitInVehicle(unit)
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
local result = UnitInVehicle("player")
```

### Unit.UnitInVehicleControlSeat

```lua
result = UnitInVehicleControlSeat([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInVehicleControlSeat()
```

### Unit.UnitInVehicleHidesPetFrame

```lua
result = UnitInVehicleHidesPetFrame([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitInVehicleHidesPetFrame()
```

### Unit.UnitIsAFK

```lua
result = UnitIsAFK(unit)
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
local result = UnitIsAFK("player")
```

### Unit.UnitIsBattlePet

```lua
result = UnitIsBattlePet(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = UnitIsBattlePet("player")
```

### Unit.UnitIsBattlePetCompanion

```lua
result = UnitIsBattlePetCompanion(unit)
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
local result = UnitIsBattlePetCompanion("player")
```

### Unit.UnitIsBossMob

```lua
result = UnitIsBossMob(unit)
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
local result = UnitIsBossMob("player")
```

### Unit.UnitIsCharmed

```lua
result = UnitIsCharmed([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsCharmed()
```

### Unit.UnitIsConnected

```lua
isConnected = UnitIsConnected(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConnected` | bool | no |  |

**Example**

```lua
local isConnected = UnitIsConnected("player")
```

### Unit.UnitIsControlling

```lua
result = UnitIsControlling(unit)
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
local result = UnitIsControlling("player")
```

### Unit.UnitIsCorpse

```lua
result = UnitIsCorpse([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsCorpse()
```

### Unit.UnitIsDead

```lua
result = UnitIsDead(unit)
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
local result = UnitIsDead("player")
```

### Unit.UnitIsDeadOrGhost

```lua
result = UnitIsDeadOrGhost(unit)
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
local result = UnitIsDeadOrGhost("player")
```

### Unit.UnitIsDND

```lua
result = UnitIsDND(unit)
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
local result = UnitIsDND("player")
```

### Unit.UnitIsEnemy

```lua
result = UnitIsEnemy(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsEnemy("player", target)
```

### Unit.UnitIsFeignDeath

```lua
result = UnitIsFeignDeath(unit)
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
local result = UnitIsFeignDeath("player")
```

### Unit.UnitIsFriend

```lua
result = UnitIsFriend(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsFriend("player", target)
```

### Unit.UnitIsGameObject

```lua
result = UnitIsGameObject([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsGameObject()
```

### Unit.UnitIsGhost

```lua
result = UnitIsGhost(unit)
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
local result = UnitIsGhost("player")
```

### Unit.UnitIsGroupAssistant

```lua
isAssistant = UnitIsGroupAssistant(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAssistant` | bool | no |  |

**Example**

```lua
local isAssistant = UnitIsGroupAssistant("player")
```

### Unit.UnitIsGroupLeader

```lua
isLeader = UnitIsGroupLeader(unit, [partyCategory])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `partyCategory` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLeader` | bool | no |  |

**Example**

```lua
local isLeader = UnitIsGroupLeader("player")
```

### Unit.UnitIsHumanPlayer

```lua
result = UnitIsHumanPlayer([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsHumanPlayer()
```

### Unit.UnitIsInInteractRange

```lua
result = UnitIsInInteractRange(unit)
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
local result = UnitIsInInteractRange("player")
```

### Unit.UnitIsInMyGuild

```lua
result = UnitIsInMyGuild(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsInMyGuild("player")
```

### Unit.UnitIsInteractable

```lua
result = UnitIsInteractable([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsInteractable()
```

### Unit.UnitIsLieutenant

```lua
result = UnitIsLieutenant(unit)
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
local result = UnitIsLieutenant("player")
```

### Unit.UnitIsMercenary

```lua
result = UnitIsMercenary(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsMercenary("")
```

### Unit.UnitIsMinion

Returns whether the unit is considered a minion of a player, such as a pet, totem, or guardian.

```lua
result = UnitIsMinion(unit)
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
local result = UnitIsMinion("player")
```

### Unit.UnitIsNPCAsPlayer

```lua
result = UnitIsNPCAsPlayer([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsNPCAsPlayer()
```

### Unit.UnitIsOtherPlayersBattlePet

```lua
result = UnitIsOtherPlayersBattlePet([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsOtherPlayersBattlePet()
```

### Unit.UnitIsOtherPlayersPet

```lua
result = UnitIsOtherPlayersPet([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsOtherPlayersPet()
```

### Unit.UnitIsOwnerOrControllerOfUnit

```lua
unitIsOwnerOrControllerOfUnit = UnitIsOwnerOrControllerOfUnit(controllingUnit, controlledUnit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `controllingUnit` | UnitToken | no |  |
| `controlledUnit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitIsOwnerOrControllerOfUnit` | bool | no |  |

**Example**

```lua
local unitIsOwnerOrControllerOfUnit = UnitIsOwnerOrControllerOfUnit("player", "player")
```

### Unit.UnitIsPlayer

```lua
result = UnitIsPlayer([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsPlayer()
```

### Unit.UnitIsPlayerControlledOrGroupMember

Returns true for 'player', 'pet', 'vehicle', or any of 'partyn', 'partypetn', 'raidn', 'raidpetn'

```lua
result = UnitIsPlayerControlledOrGroupMember(unit)
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
local result = UnitIsPlayerControlledOrGroupMember("player")
```

### Unit.UnitIsPossessed

```lua
result = UnitIsPossessed([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsPossessed()
```

### Unit.UnitIsPVP

```lua
result = UnitIsPVP(unit)
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
local result = UnitIsPVP("player")
```

### Unit.UnitIsPVPFreeForAll

```lua
result = UnitIsPVPFreeForAll(unit)
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
local result = UnitIsPVPFreeForAll("player")
```

### Unit.UnitIsPVPSanctuary

```lua
result = UnitIsPVPSanctuary([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsPVPSanctuary()
```

### Unit.UnitIsQuestBoss

```lua
result = UnitIsQuestBoss(unit)
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
local result = UnitIsQuestBoss("player")
```

### Unit.UnitIsRaidOfficer

```lua
result = UnitIsRaidOfficer([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsRaidOfficer()
```

### Unit.UnitIsSameServer

```lua
result = UnitIsSameServer(unitName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsSameServer("player")
```

### Unit.UnitIsTapDenied

```lua
result = UnitIsTapDenied(unit)
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
local result = UnitIsTapDenied("player")
```

### Unit.UnitIsTrivial

```lua
result = UnitIsTrivial(unit)
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
local result = UnitIsTrivial("player")
```

### Unit.UnitIsUnconscious

```lua
result = UnitIsUnconscious(unit)
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
local result = UnitIsUnconscious("player")
```

### Unit.UnitIsUnit

```lua
result = UnitIsUnit(unit1, unit2)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit1` | UnitToken | no |  |
| `unit2` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsUnit("player", "player")
```

### Unit.UnitIsVisible

```lua
result = UnitIsVisible([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitIsVisible()
```

### Unit.UnitIsWildBattlePet

```lua
result = UnitIsWildBattlePet(unit)
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
local result = UnitIsWildBattlePet("player")
```

### Unit.UnitLeadsAnyGroup

```lua
isLeader = UnitLeadsAnyGroup(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLeader` | bool | no |  |

**Example**

```lua
local isLeader = UnitLeadsAnyGroup("player")
```

### Unit.UnitLevel

```lua
result = UnitLevel(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitLevel("")
```

### Unit.UnitName

```lua
unitName, unitServer = UnitName(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `unitServer` | cstring | no |  |

**Example**

```lua
local unitName, unitServer = UnitName("player")
```

### Unit.UnitNameFromGUID

```lua
unitName, unitServer = UnitNameFromGUID(unitGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `unitServer` | cstring | no |  |

**Example**

```lua
local unitName, unitServer = UnitNameFromGUID("player")
```

### Unit.UnitNameplateShowsWidgetsOnly

```lua
nameplateShowsWidgetsOnly = UnitNameplateShowsWidgetsOnly(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nameplateShowsWidgetsOnly` | bool | no |  |

**Example**

```lua
local nameplateShowsWidgetsOnly = UnitNameplateShowsWidgetsOnly("player")
```

### Unit.UnitNameUnmodified

```lua
unitName, unitServer = UnitNameUnmodified(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitName` | cstring | no |  |
| `unitServer` | cstring | no |  |

**Example**

```lua
local unitName, unitServer = UnitNameUnmodified("player")
```

### Unit.UnitNumPowerBarTimers

```lua
result = UnitNumPowerBarTimers(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitNumPowerBarTimers("player")
```

### Unit.UnitOnTaxi

```lua
result = UnitOnTaxi(unit)
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
local result = UnitOnTaxi("player")
```

### Unit.UnitOwnerGUID

```lua
ownerGUID = UnitOwnerGUID(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ownerGUID` | WOWGUID | no |  |

**Example**

```lua
local ownerGUID = UnitOwnerGUID("player")
```

### Unit.UnitPartialPower

```lua
partialPower = UnitPartialPower(unitToken, [powerType], unmodified)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | yes |  |
| `unmodified` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `partialPower` | number | no |  |

**Example**

```lua
local partialPower = UnitPartialPower("player", false)
```

### Unit.UnitPercentHealthFromGUID

```lua
percentHealth = UnitPercentHealthFromGUID(unitGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `percentHealth` | number | yes |  |

**Example**

```lua
local percentHealth = UnitPercentHealthFromGUID("player")
```

### Unit.UnitPhaseReason

```lua
reason = UnitPhaseReason(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reason` | PhaseReason | yes |  |

**Example**

```lua
local reason = UnitPhaseReason("player")
```

### Unit.UnitPlayerControlled

```lua
result = UnitPlayerControlled([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitPlayerControlled()
```

### Unit.UnitPlayerOrPetInParty

```lua
result = UnitPlayerOrPetInParty([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitPlayerOrPetInParty()
```

### Unit.UnitPlayerOrPetInRaid

```lua
result = UnitPlayerOrPetInRaid([unit], [partyIndex])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |
| `partyIndex` | luaIndex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitPlayerOrPetInRaid()
```

### Unit.UnitPosition

```lua
positionX, positionY, positionZ, mapID = UnitPosition(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `positionX` | number | no |  |
| `positionY` | number | no |  |
| `positionZ` | number | no |  |
| `mapID` | number | no |  |

**Example**

```lua
local positionX, positionY, positionZ, mapID = UnitPosition("player")
```

### Unit.UnitPower

```lua
power = UnitPower(unitToken, [powerType], unmodified)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | yes |  |
| `unmodified` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `power` | number | no |  |

**Example**

```lua
local power = UnitPower("player", false)
```

### Unit.UnitPowerBarID

```lua
barID = UnitPowerBarID(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `barID` | number | no |  |

**Example**

```lua
local barID = UnitPowerBarID("player")
```

### Unit.UnitPowerBarTimerInfo

```lua
duration, expiration, barID, auraID = UnitPowerBarTimerInfo(unit, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `index` | luaIndex | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | number | no |  |
| `expiration` | number | no |  |
| `barID` | number | no |  |
| `auraID` | number | no |  |

**Example**

```lua
local duration, expiration, barID, auraID = UnitPowerBarTimerInfo("player", 1)
```

### Unit.UnitPowerDisplayMod

```lua
displayMod = UnitPowerDisplayMod(powerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerType` | PowerType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayMod` | number | no |  |

**Example**

```lua
local displayMod = UnitPowerDisplayMod(powerType)
```

### Unit.UnitPowerMax

```lua
maxPower = UnitPowerMax(unitToken, [powerType], unmodified)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | yes |  |
| `unmodified` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxPower` | number | no |  |

**Example**

```lua
local maxPower = UnitPowerMax("player", false)
```

### Unit.UnitPowerMissing

Result of UnitPowerMax() - UnitPower()

```lua
result = UnitPowerMissing(unitToken, [powerType], unmodified)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | yes |  |
| `unmodified` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitPowerMissing("player", false)
```

### Unit.UnitPowerPercent

Queries the percent of power remaining, optionally evaluating it against a supplied curve.

```lua
result = UnitPowerPercent(unitToken, [powerType], unmodified, [curve])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitTokenPvPRestrictedForAddOns | no |  |
| `powerType` | PowerType | yes |  |
| `unmodified` | bool | no | (default: False) |
| `curve` | LuaCurveObjectBase | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no | If no curve is specified, a floating point percentage value. Else, the result of evaluating the curve with the percentage as the input. |

**Example**

```lua
local result = UnitPowerPercent("player", false)
```

### Unit.UnitPowerType

```lua
powerType, powerTypeToken, rgbX, rgbY, rgbZ = UnitPowerType(unit, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |
| `index` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerType` | PowerType | no |  |
| `powerTypeToken` | string | no |  |
| `rgbX` | number | no |  |
| `rgbY` | number | no |  |
| `rgbZ` | number | no |  |

**Example**

```lua
local powerType, powerTypeToken, rgbX, rgbY, rgbZ = UnitPowerType("player", 1)
```

### Unit.UnitPvpClassification

```lua
classification = UnitPvpClassification(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classification` | PvPUnitClassification | yes |  |

**Example**

```lua
local classification = UnitPvpClassification("player")
```

### Unit.UnitPVPName

```lua
result = UnitPVPName(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example**

```lua
local result = UnitPVPName("player")
```

### Unit.UnitQuestTrivialLevelRange

```lua
levelRange = UnitQuestTrivialLevelRange(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelRange` | number | no |  |

**Example**

```lua
local levelRange = UnitQuestTrivialLevelRange("player")
```

### Unit.UnitQuestTrivialLevelRangeScaling

```lua
levelRange = UnitQuestTrivialLevelRangeScaling(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levelRange` | number | no |  |

**Example**

```lua
local levelRange = UnitQuestTrivialLevelRangeScaling("player")
```

### Unit.UnitRace

```lua
localizedRaceName, englishRaceName, raceID = UnitRace(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localizedRaceName` | cstring | no |  |
| `englishRaceName` | cstring | no |  |
| `raceID` | number | no |  |

**Example**

```lua
local localizedRaceName, englishRaceName, raceID = UnitRace("player")
```

### Unit.UnitRangedAttackPower

```lua
attackPower, posBuff, negBuff = UnitRangedAttackPower(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attackPower` | number | no |  |
| `posBuff` | number | no |  |
| `negBuff` | number | no |  |

**Example**

```lua
local attackPower, posBuff, negBuff = UnitRangedAttackPower("player")
```

### Unit.UnitRangedDamage

```lua
speed, minDamage, maxDamage, posBuff, negBuff, percent = UnitRangedDamage(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `speed` | number | no |  |
| `minDamage` | number | no |  |
| `maxDamage` | number | no |  |
| `posBuff` | number | no |  |
| `negBuff` | number | no |  |
| `percent` | number | no |  |

**Example**

```lua
local speed, minDamage, maxDamage, posBuff, negBuff, percent = UnitRangedDamage("player")
```

### Unit.UnitReaction

```lua
result = UnitReaction(unit, target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | luaIndex | yes |  |

**Example**

```lua
local result = UnitReaction("player", target)
```

### Unit.UnitRealmRelationship

```lua
realmRelationship = UnitRealmRelationship(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `realmRelationship` | luaIndex | yes |  |

**Example**

```lua
local realmRelationship = UnitRealmRelationship("player")
```

### Unit.UnitResistance

```lua
baseResistance, realResistance, effectiveResistance, bonusResistance = UnitResistance(unit, damageClass)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `damageClass` | Damageclass | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseResistance` | number | no |  |
| `realResistance` | number | no |  |
| `effectiveResistance` | number | no |  |
| `bonusResistance` | number | no |  |

**Example**

```lua
local baseResistance, realResistance, effectiveResistance, bonusResistance = UnitResistance("player", damageClass)
```

### Unit.UnitSelectionColor

```lua
resultR, resultG, resultB, resultA = UnitSelectionColor(unit, useExtendedColors)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `useExtendedColors` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resultR` | number | no |  |
| `resultG` | number | no |  |
| `resultB` | number | no |  |
| `resultA` | number | no |  |

**Example**

```lua
local resultR, resultG, resultB, resultA = UnitSelectionColor("player", false)
```

### Unit.UnitSelectionType

```lua
result = UnitSelectionType(unit, useExtendedColors)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `useExtendedColors` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitSelectionType("player", false)
```

### Unit.UnitSex

```lua
sex = UnitSex(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sex` | number | yes |  |

**Example**

```lua
local sex = UnitSex("player")
```

### Unit.UnitSexBase

```lua
sex = UnitSexBase(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sex` | UnitSex | yes |  |

**Example**

```lua
local sex = UnitSexBase("player")
```

### Unit.UnitShouldDisplayName

```lua
result = UnitShouldDisplayName(unit)
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
local result = UnitShouldDisplayName("player")
```

### Unit.UnitShouldDisplaySpellTargetName

If the unit is currently casting a spell, returns whether the target's name should be displayed. Returns false if the unit is not casting a spell or the spell has no target.

```lua
result = UnitShouldDisplaySpellTargetName(unit)
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
local result = UnitShouldDisplaySpellTargetName("player")
```

### Unit.UnitSpellHaste

```lua
result = UnitSpellHaste(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitSpellHaste("player")
```

### Unit.UnitSpellTargetClass

If the unit is currently casting a spell, returns the class of the spell's target unit. Returns nil if the unit is not casting a spell or the spell has no target.

```lua
classFilename = UnitSpellTargetClass(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classFilename` | cstring | no |  |

**Example**

```lua
local classFilename = UnitSpellTargetClass("player")
```

### Unit.UnitSpellTargetName

If the unit is currently casting a spell, returns the name of the spell's target unit. Returns nil if the unit is not casting a spell or the spell has no target.

```lua
targetName = UnitSpellTargetName(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetName` | cstring | no |  |

**Example**

```lua
local targetName = UnitSpellTargetName("player")
```

### Unit.UnitStagger

```lua
result = UnitStagger(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitTokenPvPRestrictedForAddOns | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitStagger("player")
```

### Unit.UnitStat

```lua
currentStat, effectiveStat, statPositiveBuff, statNegativeBuff = UnitStat(unit, index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentStat` | number | no |  |
| `effectiveStat` | number | no |  |
| `statPositiveBuff` | number | no |  |
| `statNegativeBuff` | number | no |  |

**Example**

```lua
local currentStat, effectiveStat, statPositiveBuff, statNegativeBuff = UnitStat("player", 1)
```

### Unit.UnitSwitchToVehicleSeat

```lua
UnitSwitchToVehicleSeat(unit, virtualSeatIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `virtualSeatIndex` | luaIndex | no |  |

**Example**

```lua
UnitSwitchToVehicleSeat("player", 1)
```

### Unit.UnitTargetsVehicleInRaidUI

```lua
result = UnitTargetsVehicleInRaidUI([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = UnitTargetsVehicleInRaidUI()
```

### Unit.UnitThreatLeadSituation

Returns a threat state (0-3; representing none, yellow, orange, red) that indicates how far the provided unit is above the secondmost threat on the provided mob. If the unit is not first on threat, will always return red. Can return nil if the provided mob does not exist.

```lua
result = UnitThreatLeadSituation(unit, mobGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobGUID` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitThreatLeadSituation("player", "Creature-0-0000-0-0-0-0")
```

### Unit.UnitThreatPercentageOfLead

```lua
result = UnitThreatPercentageOfLead(unit, mobGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobGUID` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitThreatPercentageOfLead("player", "Creature-0-0000-0-0-0-0")
```

### Unit.UnitThreatSituation

```lua
result = UnitThreatSituation(unit, [mobGUID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `mobGUID` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = UnitThreatSituation("player")
```

### Unit.UnitTokenFromGUID

```lua
unitToken = UnitTokenFromGUID(unitGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | string | yes |  |

**Example**

```lua
local unitToken = UnitTokenFromGUID("player")
```

### Unit.UnitTreatAsPlayerForDisplay

```lua
treatAsPlayer = UnitTreatAsPlayerForDisplay(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `treatAsPlayer` | bool | no |  |

**Example**

```lua
local treatAsPlayer = UnitTreatAsPlayerForDisplay("player")
```

### Unit.UnitTrialBankedLevels

```lua
bankedLevels, xpIntoCurrentLevel, xpForNextLevel = UnitTrialBankedLevels(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bankedLevels` | number | no |  |
| `xpIntoCurrentLevel` | number | no |  |
| `xpForNextLevel` | number | no |  |

**Example**

```lua
local bankedLevels, xpIntoCurrentLevel, xpForNextLevel = UnitTrialBankedLevels("player")
```

### Unit.UnitTrialXP

```lua
result = UnitTrialXP(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitTrialXP("player")
```

### Unit.UnitUsingVehicle

```lua
result = UnitUsingVehicle(unit)
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
local result = UnitUsingVehicle("player")
```

### Unit.UnitVehicleSeatCount

```lua
result = UnitVehicleSeatCount(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitVehicleSeatCount("player")
```

### Unit.UnitVehicleSeatInfo

```lua
controlType, occupantName, serverName, ejectable, canSwitchSeats = UnitVehicleSeatInfo(unit, virtualSeatIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |
| `virtualSeatIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `controlType` | cstring | no |  |
| `occupantName` | cstring | no |  |
| `serverName` | cstring | no |  |
| `ejectable` | bool | no |  |
| `canSwitchSeats` | bool | no |  |

**Example**

```lua
local controlType, occupantName, serverName, ejectable, canSwitchSeats = UnitVehicleSeatInfo("player", 1)
```

### Unit.UnitVehicleSkin

```lua
result = UnitVehicleSkin([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | fileID | no |  |

**Example**

```lua
local result = UnitVehicleSkin()
```

### Unit.UnitWeaponAttackPower

```lua
mainHandWeaponAttackPower, offHandWeaponAttackPower, rangedWeaponAttackPower = UnitWeaponAttackPower(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mainHandWeaponAttackPower` | number | no |  |
| `offHandWeaponAttackPower` | number | no |  |
| `rangedWeaponAttackPower` | number | no |  |

**Example**

```lua
local mainHandWeaponAttackPower, offHandWeaponAttackPower, rangedWeaponAttackPower = UnitWeaponAttackPower("player")
```

### Unit.UnitWidgetSet

```lua
uiWidgetSet = UnitWidgetSet(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiWidgetSet` | number | no |  |

**Example**

```lua
local uiWidgetSet = UnitWidgetSet("player")
```

### Unit.UnitXP

```lua
result = UnitXP(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitXP("player")
```

### Unit.UnitXPMax

```lua
result = UnitXPMax(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = UnitXPMax("player")
```

### Unit.WorldLootObjectExists

```lua
result = WorldLootObjectExists([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = WorldLootObjectExists()
```

## Events

### ACTIVE_PLAYER_SPECIALIZATION_CHANGED

### ARENA_COOLDOWNS_UPDATE

### ARENA_CROWD_CONTROL_SPELL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `spellID` | number | no |  |

### AUTOFOLLOW_BEGIN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

### AUTOFOLLOW_END

### CANCEL_SUMMON

### COMBO_TARGET_CHANGED

### CONFIRM_BINDER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaName` | cstring | no |  |

### CONFIRM_SUMMON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `summonReason` | number | no |  |
| `skippingStartExperience` | bool | no |  |

### ECLIPSE_DIRECTION_CHANGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `direction` | cstring | no |  |

### HEARTHSTONE_BOUND

### HONOR_XP_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### INCOMING_RESURRECT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### INCOMING_SUMMON_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### KNOWN_TITLES_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### LOCALPLAYER_PET_RENAMED

### MIRROR_TIMER_PAUSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerName` | cstring | no |  |
| `paused` | number | no |  |

### MIRROR_TIMER_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerName` | cstring | no |  |
| `value` | number | no |  |
| `maxValue` | number | no |  |
| `scale` | number | no |  |
| `paused` | number | no |  |
| `timerLabel` | cstring | no |  |

### MIRROR_TIMER_STOP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerName` | cstring | no |  |

### NEUTRAL_FACTION_SELECT_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

### OBJECT_ENTERED_AOI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

### OBJECT_LEFT_AOI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

### PARTY_KILL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attackerGUID` | WOWGUID | no |  |
| `targetGUID` | WOWGUID | no |  |

### PET_BAR_UPDATE_USABLE

### PET_UI_UPDATE

### PLAYER_CAN_GLIDE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canGlide` | bool | no |  |

### PLAYER_DAMAGE_DONE_MODS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_ENTER_COMBAT

### PLAYER_FARSIGHT_FOCUS_CHANGED

### PLAYER_FLAGS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_FOCUS_CHANGED

### PLAYER_IMPULSE_APPLIED

### PLAYER_IS_GLIDING_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isGliding` | bool | no |  |

### PLAYER_LEAVE_COMBAT

### PLAYER_LEVEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldLevel` | number | no |  |
| `newLevel` | number | no |  |
| `real` | bool | no |  |

### PLAYER_LEVEL_UP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |
| `healthDelta` | number | no |  |
| `powerDelta` | number | no |  |
| `numNewTalents` | number | no |  |
| `numNewPvpTalentSlots` | number | no |  |
| `strengthDelta` | number | no |  |
| `agilityDelta` | number | no |  |
| `staminaDelta` | number | no |  |
| `intellectDelta` | number | no |  |

### PLAYER_MAX_LEVEL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_MOUNT_DISPLAY_CHANGED

### PLAYER_PVP_KILLS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_PVP_RANK_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_REGEN_DISABLED

### PLAYER_REGEN_ENABLED

### PLAYER_SOFT_ENEMY_CHANGED

### PLAYER_SOFT_FRIEND_CHANGED

### PLAYER_SOFT_INTERACT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldTarget` | WOWGUID | no |  |
| `newTarget` | WOWGUID | no |  |

### PLAYER_SOFT_TARGET_INTERACTION

### PLAYER_SPECIALIZATION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_STARTED_LOOKING

### PLAYER_STARTED_MOVING

### PLAYER_STARTED_TURNING

### PLAYER_STOPPED_LOOKING

### PLAYER_STOPPED_MOVING

### PLAYER_STOPPED_TURNING

### PLAYER_TARGET_CHANGED

### PLAYER_TRIAL_XP_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PLAYER_UPDATE_RESTING

### PLAYER_XP_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### PORTRAITS_UPDATED

### PROVING_GROUNDS_SCORE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `points` | number | no |  |

### PVP_TIMER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### RUNE_POWER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeIndex` | number | no |  |
| `added` | bool | yes |  |

### RUNE_TYPE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeIndex` | number | no |  |

### SHOW_FACTION_SELECT_UI

### SPELL_CONFIRMATION_PROMPT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `effectValue` | number | no |  |
| `message` | cstring | no |  |
| `duration` | number | no |  |
| `currencyTypesID` | number | no |  |
| `currencyCost` | number | no |  |
| `currentDifficulty` | number | no |  |
| `displayItemID` | number | no |  |
| `itemContext` | number | no |  |
| `treasureContextLevel` | number | no |  |

### SPELL_CONFIRMATION_TIMEOUT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `effectValue` | number | no |  |

### UNIT_ABSORB_AMOUNT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_AREA_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_ARENA_COOLDOWNS_UPDATE

Only signaled when the active player is a commentator or spectator.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_ATTACK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_ATTACK_POWER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_ATTACK_SPEED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_CHEAT_TOGGLE_EVENT

### UNIT_CLASSIFICATION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_COMBAT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `event` | cstring | no |  |
| `flagText` | cstring | no |  |
| `amount` | number | no |  |
| `schoolMask` | number | no |  |

### UNIT_CONNECTION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `isConnected` | bool | no |  |

### UNIT_CTR_OPTIONS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_DAMAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_DEFENSE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_DIED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |

### UNIT_DISPLAYPOWER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_DISTANCE_CHECK_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `isInDistance` | bool | no |  |

### UNIT_FACTION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_FLAGS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_FORM_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_HAPPINESS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_HEAL_ABSORB_AMOUNT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_HEAL_PREDICTION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_HEALTH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_IN_RANGE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `isInRange` | bool | no |  |

### UNIT_INVENTORY_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_LEVEL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_LOOT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | WOWGUID | no |  |
| `hasLoot` | bool | no |  |

### UNIT_MANA

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_MAXHEALTH

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_MAX_HEALTH_MODIFIERS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `percentMaxHealthAdjusted` | number | no |  |

### UNIT_MAXPOWER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `powerType` | cstring | no |  |

### UNIT_MODEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_NAME_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_OTHER_PARTY_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_PET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_PET_EXPERIENCE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_PET_TRAINING_POINTS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_PHASE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_PORTRAIT_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_POWER_BAR_HIDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_POWER_BAR_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_POWER_BAR_TIMER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_POWER_FREQUENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `powerType` | cstring | no |  |

### UNIT_POWER_POINT_CHARGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_POWER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `powerType` | cstring | no |  |

### UNIT_QUEST_LOG_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_RANGED_ATTACK_POWER

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_RANGEDDAMAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_RESISTANCES

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_SPELLCAST_CHANNEL_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_CHANNEL_STOP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `interruptedBy` | WOWGUID | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_CHANNEL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_DELAYED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_EMPOWER_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_EMPOWER_STOP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `complete` | bool | no |  |
| `interruptedBy` | WOWGUID | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_EMPOWER_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_FAILED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_FAILED_QUIET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_INTERRUPTED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `interruptedBy` | WOWGUID | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_INTERRUPTIBLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_SPELLCAST_NOT_INTERRUPTIBLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_SPELLCAST_RETICLE_CLEAR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |

### UNIT_SPELLCAST_RETICLE_TARGET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |

### UNIT_SPELLCAST_SENT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `target` | cstring | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |

### UNIT_SPELLCAST_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_STOP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELLCAST_SUCCEEDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |
| `castGUID` | WOWGUID | no |  |
| `spellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UNIT_SPELL_HASTE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_STATS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_TARGET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_TARGETABLE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_THREAT_LIST_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UNIT_THREAT_SITUATION_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitTarget` | UnitTokenVariant | no |  |

### UPDATE_EXHAUSTION

### UPDATE_MOUSEOVER_UNIT

### UPDATE_STEALTH

### VEHICLE_ANGLE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `normalizedPitch` | number | no |  |
| `radians` | number | no |  |

## Types

### CorruptionEffectInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `description` | string | no |  |
| `minCorruption` | number | no |  |

### PhaseReason (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Phasing` | PhaseReason | no |  |
| `Sharding` | PhaseReason | no |  |
| `WarMode` | PhaseReason | no |  |
| `ChromieTime` | PhaseReason | no |  |
| `TimerunningHwt` | PhaseReason | no |  |
| `RuleSet` | PhaseReason | no |  |

### PvPUnitClassification (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `FlagCarrierHorde` | PvPUnitClassification | no |  |
| `FlagCarrierAlliance` | PvPUnitClassification | no |  |
| `FlagCarrierNeutral` | PvPUnitClassification | no |  |
| `CartRunnerHorde` | PvPUnitClassification | no |  |
| `CartRunnerAlliance` | PvPUnitClassification | no |  |
| `AssassinHorde` | PvPUnitClassification | no |  |
| `AssassinAlliance` | PvPUnitClassification | no |  |
| `OrbCarrierBlue` | PvPUnitClassification | no |  |
| `OrbCarrierGreen` | PvPUnitClassification | no |  |
| `OrbCarrierOrange` | PvPUnitClassification | no |  |
| `OrbCarrierPurple` | PvPUnitClassification | no |  |

### UnitCastingInfoResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayName` | string | no |  |
| `textureID` | fileID | no |  |
| `startTimeMs` | number | no |  |
| `endTimeMs` | number | no |  |
| `isTradeskill` | bool | no |  |
| `castID` | WOWGUID | no |  |
| `notInterruptible` | bool | yes |  |
| `castingSpellID` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |
| `delayTimeMs` | number | no |  |

### UnitChannelInfoResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `displayName` | cstring | no |  |
| `textureID` | fileID | no |  |
| `startTimeMs` | number | no |  |
| `endTimeMs` | number | no |  |
| `isTradeskill` | bool | no |  |
| `notInterruptible` | bool | yes |  |
| `spellID` | number | no |  |
| `isEmpowered` | bool | no |  |
| `numEmpowerStages` | number | no |  |
| `castBarID` | UnitCastBarID | yes |  |

### UnitCreatureFamilyResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `id` | number | no |  |

### UnitCreatureTypeResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `id` | number | no |  |

### UnitPowerBarInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |
| `barType` | number | no |  |
| `minPower` | number | no |  |
| `startInset` | number | no |  |
| `endInset` | number | no |  |
| `smooth` | bool | no |  |
| `hideFromOthers` | bool | no |  |
| `showOnRaid` | bool | no |  |
| `opaqueSpark` | bool | no |  |
| `opaqueFlash` | bool | no |  |
| `anchorTop` | bool | no |  |
| `forcePercentage` | bool | no |  |
| `sparkUnderFrame` | bool | no |  |
| `flashAtMinPower` | bool | no |  |
| `fractionalCounter` | bool | no |  |
| `animateNumbers` | bool | no |  |
| `attachTooltipToBar` | bool | no |  |

