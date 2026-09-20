# PlayerScript

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**185** functions · **2** events · **1** types

## Functions

### PlayerScript.AcceptAreaSpiritHeal

```lua
AcceptAreaSpiritHeal()
```

**Example**

```lua
AcceptAreaSpiritHeal()
```

### PlayerScript.AcceptGuild

```lua
AcceptGuild()
```

**Example**

```lua
AcceptGuild()
```

### PlayerScript.AcceptResurrect

```lua
AcceptResurrect()
```

**Example**

```lua
AcceptResurrect()
```

### PlayerScript.Ambiguate

```lua
result = Ambiguate(fullName, context)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fullName` | cstring | no |  |
| `context` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | no |  |

**Example**

```lua
local result = Ambiguate("", "")
```

### PlayerScript.AutoEquipCursorItem

```lua
AutoEquipCursorItem()
```

**Example**

```lua
AutoEquipCursorItem()
```

### PlayerScript.BeginTrade

```lua
BeginTrade()
```

**Example**

```lua
BeginTrade()
```

### PlayerScript.CancelAreaSpiritHeal

```lua
CancelAreaSpiritHeal()
```

**Example**

```lua
CancelAreaSpiritHeal()
```

### PlayerScript.CancelPendingEquip

```lua
CancelPendingEquip(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Example**

```lua
CancelPendingEquip(1)
```

### PlayerScript.CancelTrade

```lua
CancelTrade()
```

**Example**

```lua
CancelTrade()
```

### PlayerScript.CanDualWield

```lua
result = CanDualWield()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CanDualWield()
```

### PlayerScript.CanInspect

```lua
result = CanInspect(targetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetGUID` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CanInspect("Creature-0-0000-0-0-0-0")
```

### PlayerScript.CanLootUnit

```lua
hasLoot, canLoot = CanLootUnit(targetUnit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetUnit` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasLoot` | bool | no |  |
| `canLoot` | bool | no |  |

**Example**

```lua
local hasLoot, canLoot = CanLootUnit("player")
```

### PlayerScript.CanPortGraveyard

```lua
canPortGraveyard = CanPortGraveyard()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPortGraveyard` | bool | no |  |

**Example**

```lua
local canPortGraveyard = CanPortGraveyard()
```

### PlayerScript.CheckInteractDistance

```lua
result = CheckInteractDistance(unitGUID, distIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitGUID` | UnitToken | no |  |
| `distIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CheckInteractDistance("player", 1)
```

### PlayerScript.CheckTalentMasterDist

```lua
result = CheckTalentMasterDist()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = CheckTalentMasterDist()
```

### PlayerScript.ClearPendingBindConversionItem

```lua
ClearPendingBindConversionItem()
```

**Example**

```lua
ClearPendingBindConversionItem()
```

### PlayerScript.ConfirmTalentWipe

```lua
ConfirmTalentWipe()
```

**Example**

```lua
ConfirmTalentWipe()
```

### PlayerScript.ConvertItemToBindToAccount

```lua
ConvertItemToBindToAccount()
```

**Example**

```lua
ConvertItemToBindToAccount()
```

### PlayerScript.DeclineGuild

```lua
DeclineGuild()
```

**Example**

```lua
DeclineGuild()
```

### PlayerScript.DeclineResurrect

```lua
DeclineResurrect()
```

**Example**

```lua
DeclineResurrect()
```

### PlayerScript.Dismount

```lua
Dismount()
```

**Example**

```lua
Dismount()
```

### PlayerScript.EquipPendingItem

```lua
EquipPendingItem(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |

**Example**

```lua
EquipPendingItem(1)
```

### PlayerScript.FollowUnit

```lua
FollowUnit(name, exactMatch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no | (default: 0) |
| `exactMatch` | bool | no | (default: False) |

**Example**

```lua
FollowUnit("", false)
```

### PlayerScript.GetAllowLowLevelRaid

```lua
result = GetAllowLowLevelRaid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetAllowLowLevelRaid()
```

### PlayerScript.GetAllowRecentAlliesSeeLocation

```lua
allowRecentAlliesSeeLocation = GetAllowRecentAlliesSeeLocation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowRecentAlliesSeeLocation` | bool | no |  |

**Example**

```lua
local allowRecentAlliesSeeLocation = GetAllowRecentAlliesSeeLocation()
```

### PlayerScript.GetAreaSpiritHealerTime

```lua
result = GetAreaSpiritHealerTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetAreaSpiritHealerTime()
```

### PlayerScript.GetArmorPenetration

```lua
result = GetArmorPenetration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetArmorPenetration()
```

### PlayerScript.GetAttackPowerForStat

```lua
result = GetAttackPowerForStat(stat, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stat` | luaIndex | no |  |
| `value` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetAttackPowerForStat(stat, 0)
```

### PlayerScript.GetAutoDeclineGuildInvites

```lua
result = GetAutoDeclineGuildInvites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetAutoDeclineGuildInvites()
```

### PlayerScript.GetAutoDeclineNeighborhoodInvites

```lua
result = GetAutoDeclineNeighborhoodInvites()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetAutoDeclineNeighborhoodInvites()
```

### PlayerScript.GetAvoidance

```lua
result = GetAvoidance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetAvoidance()
```

### PlayerScript.GetBindLocation

```lua
result = GetBindLocation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = GetBindLocation()
```

### PlayerScript.GetBlockChance

```lua
result = GetBlockChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetBlockChance()
```

### PlayerScript.GetCemeteryPreference

```lua
result = GetCemeteryPreference()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCemeteryPreference()
```

### PlayerScript.GetCollapsingStarCost

```lua
cost = GetCollapsingStarCost()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cost` | number | no |  |

**Example**

```lua
local cost = GetCollapsingStarCost()
```

### PlayerScript.GetCombatRating

```lua
result = GetCombatRating(ratingIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratingIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetCombatRating(1)
```

### PlayerScript.GetCombatRatingBonus

```lua
result = GetCombatRatingBonus(ratingIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratingIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetCombatRatingBonus(1)
```

### PlayerScript.GetCombatRatingBonusForCombatRatingValue

```lua
result = GetCombatRatingBonusForCombatRatingValue(ratingIndex, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ratingIndex` | luaIndex | no |  |
| `value` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetCombatRatingBonusForCombatRatingValue(1, 0)
```

### PlayerScript.GetCorpseRecoveryDelay

```lua
result = GetCorpseRecoveryDelay()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCorpseRecoveryDelay()
```

### PlayerScript.GetCorruption

```lua
result = GetCorruption()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCorruption()
```

### PlayerScript.GetCorruptionResistance

```lua
result = GetCorruptionResistance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCorruptionResistance()
```

### PlayerScript.GetCritChance

```lua
result = GetCritChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCritChance()
```

### PlayerScript.GetCritChanceFromStat

```lua
critChance = GetCritChanceFromStat(stat, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stat` | luaIndex | no |  |
| `value` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `critChance` | number | no |  |

**Example**

```lua
local critChance = GetCritChanceFromStat(stat, 0)
```

### PlayerScript.GetCritChanceProvidesParryEffect

```lua
result = GetCritChanceProvidesParryEffect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetCritChanceProvidesParryEffect()
```

### PlayerScript.GetDodgeChance

```lua
result = GetDodgeChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetDodgeChance()
```

### PlayerScript.GetDodgeChanceFromAttribute

```lua
result = GetDodgeChanceFromAttribute()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetDodgeChanceFromAttribute()
```

### PlayerScript.GetEvictionTimeRemaining

```lua
result = GetEvictionTimeRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetEvictionTimeRemaining()
```

### PlayerScript.GetExpertise

```lua
mainhandExpertise, offhandExpertise, rangedExpertise = GetExpertise()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mainhandExpertise` | number | no |  |
| `offhandExpertise` | number | no |  |
| `rangedExpertise` | number | no |  |

**Example**

```lua
local mainhandExpertise, offhandExpertise, rangedExpertise = GetExpertise()
```

### PlayerScript.GetExpertisePercent

```lua
mainhandExpertisePercent, offhandExpertisePercent, rangedExpertisePercent = GetExpertisePercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mainhandExpertisePercent` | number | no |  |
| `offhandExpertisePercent` | number | no |  |
| `rangedExpertisePercent` | number | no |  |

**Example**

```lua
local mainhandExpertisePercent, offhandExpertisePercent, rangedExpertisePercent = GetExpertisePercent()
```

### PlayerScript.GetHaste

```lua
result = GetHaste()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetHaste()
```

### PlayerScript.GetHealthRegen

```lua
healthRegen, combatHealthRegen = GetHealthRegen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healthRegen` | number | no |  |
| `combatHealthRegen` | number | no |  |

**Example**

```lua
local healthRegen, combatHealthRegen = GetHealthRegen()
```

### PlayerScript.GetHealthRegenFromSpirit

```lua
healthRegen, combatHealthRegen = GetHealthRegenFromSpirit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healthRegen` | number | no |  |
| `combatHealthRegen` | number | no |  |

**Example**

```lua
local healthRegen, combatHealthRegen = GetHealthRegenFromSpirit()
```

### PlayerScript.GetHitModifier

```lua
result = GetHitModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetHitModifier()
```

### PlayerScript.GetJailersTowerLevel

```lua
result = GetJailersTowerLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetJailersTowerLevel()
```

### PlayerScript.GetLifesteal

```lua
result = GetLifesteal()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetLifesteal()
```

### PlayerScript.GetLootSpecialization

```lua
specializationID = GetLootSpecialization()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | no |  |

**Example**

```lua
local specializationID = GetLootSpecialization()
```

### PlayerScript.GetManaRegen

```lua
baseManaRegen, castingManaRegen = GetManaRegen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `baseManaRegen` | number | no |  |
| `castingManaRegen` | number | no |  |

**Example**

```lua
local baseManaRegen, castingManaRegen = GetManaRegen()
```

### PlayerScript.GetManaRegenFromSpirit

```lua
powerRegen, combatPowerRegen = GetManaRegenFromSpirit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerRegen` | number | no |  |
| `combatPowerRegen` | number | no |  |

**Example**

```lua
local powerRegen, combatPowerRegen = GetManaRegenFromSpirit()
```

### PlayerScript.GetMastery

```lua
result = GetMastery()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetMastery()
```

### PlayerScript.GetMasteryEffect

```lua
masteryEffect, bonusCoefficient = GetMasteryEffect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `masteryEffect` | number | no |  |
| `bonusCoefficient` | number | no |  |

**Example**

```lua
local masteryEffect, bonusCoefficient = GetMasteryEffect()
```

### PlayerScript.GetMaxPlayerLevel

```lua
maxPlayerLevel = GetMaxPlayerLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxPlayerLevel` | number | no |  |

**Example**

```lua
local maxPlayerLevel = GetMaxPlayerLevel()
```

### PlayerScript.GetMeleeHaste

```lua
result = GetMeleeHaste()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetMeleeHaste()
```

### PlayerScript.GetModResilienceDamageReduction

```lua
result = GetModResilienceDamageReduction()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetModResilienceDamageReduction()
```

### PlayerScript.GetMoney

```lua
result = GetMoney()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetMoney()
```

### PlayerScript.GetNormalizedRealmName

```lua
result = GetNormalizedRealmName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = GetNormalizedRealmName()
```

### PlayerScript.GetOverrideAPBySpellPower

```lua
result = GetOverrideAPBySpellPower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetOverrideAPBySpellPower()
```

### PlayerScript.GetOverrideSpellPowerByAP

```lua
result = GetOverrideSpellPowerByAP()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetOverrideSpellPowerByAP()
```

### PlayerScript.GetParryChance

```lua
result = GetParryChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetParryChance()
```

### PlayerScript.GetParryChanceFromAttribute

```lua
result = GetParryChanceFromAttribute()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetParryChanceFromAttribute()
```

### PlayerScript.GetPetHitChanceModifier

```lua
result = GetPetHitChanceModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPetHitChanceModifier()
```

### PlayerScript.GetPetMeleeHaste

```lua
result = GetPetMeleeHaste()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPetMeleeHaste()
```

### PlayerScript.GetPetSpellBonusDamage

```lua
result = GetPetSpellBonusDamage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPetSpellBonusDamage()
```

### PlayerScript.GetPetSpellHitChanceModifier

```lua
result = GetPetSpellHitChanceModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPetSpellHitChanceModifier()
```

### PlayerScript.GetPlayerFacing

```lua
result = GetPlayerFacing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetPlayerFacing()
```

### PlayerScript.GetPlayerInfoByGUID

```lua
localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName, level = GetPlayerInfoByGUID(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `localizedClass` | cstring | no |  |
| `englishClass` | cstring | no |  |
| `localizedRace` | cstring | no |  |
| `englishRace` | cstring | no |  |
| `sex` | number | no |  |
| `name` | cstring | no |  |
| `realmName` | cstring | no |  |
| `level` | number | yes |  |

**Example**

```lua
local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName, level = GetPlayerInfoByGUID("Creature-0-0000-0-0-0-0")
```

### PlayerScript.GetPowerRegen

```lua
basePowerRegen, castingPowerRegen = GetPowerRegen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `basePowerRegen` | number | no |  |
| `castingPowerRegen` | number | no |  |

**Example**

```lua
local basePowerRegen, castingPowerRegen = GetPowerRegen()
```

### PlayerScript.GetPowerRegenForPowerType

```lua
basePowerRegen, castingPowerRegen = GetPowerRegenForPowerType(powerType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerType` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `basePowerRegen` | number | no |  |
| `castingPowerRegen` | number | no |  |

**Example**

```lua
local basePowerRegen, castingPowerRegen = GetPowerRegenForPowerType(0)
```

### PlayerScript.GetPVPDesired

```lua
result = GetPVPDesired()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetPVPDesired()
```

### PlayerScript.GetPVPGearStatRules

```lua
result = GetPVPGearStatRules()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetPVPGearStatRules()
```

### PlayerScript.GetPVPLifetimeStats

```lua
lifetimeHonorableKills, lifetimeMaxPVPRank = GetPVPLifetimeStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lifetimeHonorableKills` | number | no |  |
| `lifetimeMaxPVPRank` | PvPRanks | no |  |

**Example**

```lua
local lifetimeHonorableKills, lifetimeMaxPVPRank = GetPVPLifetimeStats()
```

### PlayerScript.GetPvpPowerDamage

```lua
result = GetPvpPowerDamage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPvpPowerDamage()
```

### PlayerScript.GetPvpPowerHealing

```lua
result = GetPvpPowerHealing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPvpPowerHealing()
```

### PlayerScript.GetPVPSessionStats

```lua
honorableKills, dishonorableKills = GetPVPSessionStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honorableKills` | number | no |  |
| `dishonorableKills` | number | no |  |

**Example**

```lua
local honorableKills, dishonorableKills = GetPVPSessionStats()
```

### PlayerScript.GetPVPTimer

```lua
result = GetPVPTimer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetPVPTimer()
```

### PlayerScript.GetPVPYesterdayStats

```lua
honorableKills, dishonorableKills = GetPVPYesterdayStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `honorableKills` | number | no |  |
| `dishonorableKills` | number | no |  |

**Example**

```lua
local honorableKills, dishonorableKills = GetPVPYesterdayStats()
```

### PlayerScript.GetRangedAttackPowerForStat

```lua
result = GetRangedAttackPowerForStat(stat, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stat` | luaIndex | no |  |
| `value` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetRangedAttackPowerForStat(stat, 0)
```

### PlayerScript.GetRangedCritChance

```lua
result = GetRangedCritChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetRangedCritChance()
```

### PlayerScript.GetRangedHaste

```lua
result, quiverHaste = GetRangedHaste()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |
| `quiverHaste` | number | no |  |

**Example**

```lua
local result, quiverHaste = GetRangedHaste()
```

### PlayerScript.GetRangedHitModifier

```lua
result = GetRangedHitModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetRangedHitModifier()
```

### PlayerScript.GetReleaseTimeRemaining

```lua
result = GetReleaseTimeRemaining()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetReleaseTimeRemaining()
```

### PlayerScript.GetResSicknessDuration

```lua
result = GetResSicknessDuration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | string | yes |  |

**Example**

```lua
local result = GetResSicknessDuration()
```

### PlayerScript.GetRestrictedAccountData

```lua
maxLevel, maxMoney, professionCap = GetRestrictedAccountData()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLevel` | number | no |  |
| `maxMoney` | WOWMONEY | no |  |
| `professionCap` | number | no |  |

**Example**

```lua
local maxLevel, maxMoney, professionCap = GetRestrictedAccountData()
```

### PlayerScript.GetRestState

```lua
exhaustionID, name, factor = GetRestState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exhaustionID` | number | no |  |
| `name` | cstring | no |  |
| `factor` | number | no |  |

**Example**

```lua
local exhaustionID, name, factor = GetRestState()
```

### PlayerScript.GetRuneCooldown

```lua
startTime, duration, isRuneReady = GetRuneCooldown(runeIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTime` | number | no |  |
| `duration` | number | no |  |
| `isRuneReady` | bool | no |  |

**Example**

```lua
local startTime, duration, isRuneReady = GetRuneCooldown(1)
```

### PlayerScript.GetRuneCount

```lua
result = GetRuneCount(runeIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runeIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetRuneCount(1)
```

### PlayerScript.GetSheathState

```lua
result = GetSheathState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetSheathState()
```

### PlayerScript.GetShieldBlock

```lua
result = GetShieldBlock()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetShieldBlock()
```

### PlayerScript.GetSpeed

```lua
result = GetSpeed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSpeed()
```

### PlayerScript.GetSpellBonusDamage

```lua
result = GetSpellBonusDamage(school)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `school` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetSpellBonusDamage(school)
```

### PlayerScript.GetSpellBonusHealing

```lua
result = GetSpellBonusHealing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSpellBonusHealing()
```

### PlayerScript.GetSpellCritChance

```lua
result = GetSpellCritChance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSpellCritChance()
```

### PlayerScript.GetSpellCritChanceFromStat

```lua
spellCritChance = GetSpellCritChanceFromStat(stat, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stat` | luaIndex | no |  |
| `value` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCritChance` | number | no |  |

**Example**

```lua
local spellCritChance = GetSpellCritChanceFromStat(stat, 0)
```

### PlayerScript.GetSpellHitModifier

```lua
result = GetSpellHitModifier()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSpellHitModifier()
```

### PlayerScript.GetSpellPenetration

```lua
result = GetSpellPenetration()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSpellPenetration()
```

### PlayerScript.GetSturdiness

```lua
result = GetSturdiness()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetSturdiness()
```

### PlayerScript.GetTaxiBenchmarkMode

```lua
result = GetTaxiBenchmarkMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = GetTaxiBenchmarkMode()
```

### PlayerScript.GetVersatilityBonus

```lua
result = GetVersatilityBonus(combatRating)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `combatRating` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetVersatilityBonus(combatRating)
```

### PlayerScript.GetXPExhaustion

```lua
result = GetXPExhaustion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | yes |  |

**Example**

```lua
local result = GetXPExhaustion()
```

### PlayerScript.HasAPEffectsSpellPower

```lua
result = HasAPEffectsSpellPower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = HasAPEffectsSpellPower()
```

### PlayerScript.HasDualWieldPenalty

```lua
result = HasDualWieldPenalty()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = HasDualWieldPenalty()
```

### PlayerScript.HasFullControl

```lua
result = HasFullControl()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = HasFullControl()
```

### PlayerScript.HasIgnoreDualWieldWeapon

```lua
result = HasIgnoreDualWieldWeapon()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = HasIgnoreDualWieldWeapon()
```

### PlayerScript.HasKey

```lua
hasKey = HasKey()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasKey` | bool | no |  |

**Example**

```lua
local hasKey = HasKey()
```

### PlayerScript.HasNoReleaseAura

```lua
hasCannotReleaseEffect, longestDuration, hasUntilCancelledDuration = HasNoReleaseAura()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasCannotReleaseEffect` | bool | no |  |
| `longestDuration` | number | no |  |
| `hasUntilCancelledDuration` | bool | no |  |

**Example**

```lua
local hasCannotReleaseEffect, longestDuration, hasUntilCancelledDuration = HasNoReleaseAura()
```

### PlayerScript.HasSPEffectsAttackPower

```lua
result = HasSPEffectsAttackPower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = HasSPEffectsAttackPower()
```

### PlayerScript.InitiateTrade

```lua
InitiateTrade(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | UnitToken | no |  |

**Example**

```lua
InitiateTrade("Creature-0-0000-0-0-0-0")
```

### PlayerScript.IsAccountSecured

```lua
result = IsAccountSecured()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsAccountSecured()
```

### PlayerScript.IsAdvancedFlyableArea

```lua
result = IsAdvancedFlyableArea()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsAdvancedFlyableArea()
```

### PlayerScript.IsCemeterySelectionAvailable

```lua
result = IsCemeterySelectionAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsCemeterySelectionAvailable()
```

### PlayerScript.IsCharacterNewlyBoosted

```lua
newlyBoosted = IsCharacterNewlyBoosted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newlyBoosted` | bool | no |  |

**Example**

```lua
local newlyBoosted = IsCharacterNewlyBoosted()
```

### PlayerScript.IsDrivableArea

```lua
result = IsDrivableArea()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsDrivableArea()
```

### PlayerScript.IsDualWielding

```lua
result = IsDualWielding()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsDualWielding()
```

### PlayerScript.IsFlyableArea

```lua
result = IsFlyableArea()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsFlyableArea()
```

### PlayerScript.IsGuildLeader

```lua
result = IsGuildLeader()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsGuildLeader()
```

### PlayerScript.IsIndoors

```lua
result = IsIndoors()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsIndoors()
```

### PlayerScript.IsInGuild

```lua
result = IsInGuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsInGuild()
```

### PlayerScript.IsInJailersTower

```lua
result = IsInJailersTower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsInJailersTower()
```

### PlayerScript.IsInsane

```lua
result = IsInsane()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsInsane()
```

### PlayerScript.IsItemPreferredArmorType

```lua
isItemPreferredArmorType = IsItemPreferredArmorType(itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemLocation` | ItemLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemPreferredArmorType` | bool | no |  |

**Example**

```lua
local isItemPreferredArmorType = IsItemPreferredArmorType(6948)
```

### PlayerScript.IsJailersTowerLayerTimeLocked

```lua
result = IsJailersTowerLayerTimeLocked(layerLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layerLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example**

```lua
local result = IsJailersTowerLayerTimeLocked(0)
```

### PlayerScript.IsLoggedIn

```lua
result = IsLoggedIn()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsLoggedIn()
```

### PlayerScript.IsMounted

```lua
result = IsMounted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsMounted()
```

### PlayerScript.IsOnGroundFloorInJailersTower

```lua
result = IsOnGroundFloorInJailersTower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsOnGroundFloorInJailersTower()
```

### PlayerScript.IsOutdoors

```lua
result = IsOutdoors()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsOutdoors()
```

### PlayerScript.IsOutOfBounds

```lua
result = IsOutOfBounds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsOutOfBounds()
```

### PlayerScript.IsPlayerInWorld

```lua
result = IsPlayerInWorld()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsPlayerInWorld()
```

### PlayerScript.IsPlayerMoving

```lua
result = IsPlayerMoving()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsPlayerMoving()
```

### PlayerScript.IsPVPTimerRunning

```lua
result = IsPVPTimerRunning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsPVPTimerRunning()
```

### PlayerScript.IsRangedWeapon

```lua
result = IsRangedWeapon()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsRangedWeapon()
```

### PlayerScript.IsResting

```lua
result = IsResting()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsResting()
```

### PlayerScript.IsRestrictedAccount

```lua
result = IsRestrictedAccount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsRestrictedAccount()
```

### PlayerScript.IsStealthed

```lua
result = IsStealthed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsStealthed()
```

### PlayerScript.IsXPUserDisabled

```lua
result = IsXPUserDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsXPUserDisabled()
```

### PlayerScript.NoPlayTime

```lua
result = NoPlayTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = NoPlayTime()
```

### PlayerScript.NotifyInspect

```lua
NotifyInspect(targetGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetGUID` | UnitToken | no |  |

**Example**

```lua
NotifyInspect("Creature-0-0000-0-0-0-0")
```

### PlayerScript.PartialPlayTime

```lua
result = PartialPlayTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | yes |  |

**Example**

```lua
local result = PartialPlayTime()
```

### PlayerScript.PlayerCanTeleport

```lua
result = PlayerCanTeleport()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = PlayerCanTeleport()
```

### PlayerScript.PlayerEffectiveAttackPower

```lua
mainHandAttackPower, offHandAttackPower, rangedAttackPower, baseAttackPower, baseRangedAttackPower = PlayerEffectiveAttackPower()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mainHandAttackPower` | number | no |  |
| `offHandAttackPower` | number | no |  |
| `rangedAttackPower` | number | no |  |
| `baseAttackPower` | number | no |  |
| `baseRangedAttackPower` | number | no |  |

**Example**

```lua
local mainHandAttackPower, offHandAttackPower, rangedAttackPower, baseAttackPower, baseRangedAttackPower = PlayerEffectiveAttackPower()
```

### PlayerScript.PlayerGetTimerunningSeasonID

```lua
timerunningSeasonID = PlayerGetTimerunningSeasonID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timerunningSeasonID` | number | yes |  |

**Example**

```lua
local timerunningSeasonID = PlayerGetTimerunningSeasonID()
```

### PlayerScript.PlayerIsInCombat

```lua
playerIsInCombat = PlayerIsInCombat()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerIsInCombat` | bool | no |  |

**Example**

```lua
local playerIsInCombat = PlayerIsInCombat()
```

### PlayerScript.PlayerIsTimerunning

```lua
playerIsTimerunning = PlayerIsTimerunning()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerIsTimerunning` | bool | no |  |

**Example**

```lua
local playerIsTimerunning = PlayerIsTimerunning()
```

### PlayerScript.PortGraveyard

```lua
PortGraveyard()
```

**Example**

```lua
PortGraveyard()
```

### PlayerScript.RandomRoll

```lua
RandomRoll(min, max)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `min` | number | no |  |
| `max` | number | no |  |

**Example**

```lua
RandomRoll(0, 0)
```

### PlayerScript.ReagentsFromBankAllowed

```lua
allowed = ReagentsFromBankAllowed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowed` | bool | no |  |

**Example**

```lua
local allowed = ReagentsFromBankAllowed()
```

### PlayerScript.RepopMe

```lua
RepopMe()
```

**Example**

```lua
RepopMe()
```

### PlayerScript.RequestTimePlayed

```lua
RequestTimePlayed()
```

**Example**

```lua
RequestTimePlayed()
```

### PlayerScript.RespondInstanceLock

```lua
RespondInstanceLock(acceptLock)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `acceptLock` | bool | no |  |

**Example**

```lua
RespondInstanceLock(false)
```

### PlayerScript.ResurrectGetOfferer

```lua
name = ResurrectGetOfferer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example**

```lua
local name = ResurrectGetOfferer()
```

### PlayerScript.ResurrectHasSickness

```lua
result = ResurrectHasSickness()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ResurrectHasSickness()
```

### PlayerScript.ResurrectHasTimer

```lua
result = ResurrectHasTimer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ResurrectHasTimer()
```

### PlayerScript.RetrieveCorpse

```lua
RetrieveCorpse()
```

**Example**

```lua
RetrieveCorpse()
```

### PlayerScript.SetAllowLowLevelRaid

```lua
SetAllowLowLevelRaid(allow)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allow` | bool | no | (default: False) |

**Example**

```lua
SetAllowLowLevelRaid(false)
```

### PlayerScript.SetAllowRecentAlliesSeeLocation

```lua
SetAllowRecentAlliesSeeLocation(allowRecentAlliesSeeLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allowRecentAlliesSeeLocation` | bool | no |  |

**Example**

```lua
SetAllowRecentAlliesSeeLocation(false)
```

### PlayerScript.SetAutoDeclineGuildInvites

```lua
SetAutoDeclineGuildInvites(allow)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allow` | bool | no | (default: False) |

**Example**

```lua
SetAutoDeclineGuildInvites(false)
```

### PlayerScript.SetAutoDeclineNeighborhoodInvites

```lua
SetAutoDeclineNeighborhoodInvites(allow)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allow` | bool | no | (default: False) |

**Example**

```lua
SetAutoDeclineNeighborhoodInvites(false)
```

### PlayerScript.SetCemeteryPreference

```lua
SetCemeteryPreference(cemetaryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cemetaryID` | number | no |  |

**Example**

```lua
SetCemeteryPreference(0)
```

### PlayerScript.SetLootSpecialization

```lua
SetLootSpecialization(specializationID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specializationID` | number | no |  |

**Example**

```lua
SetLootSpecialization(0)
```

### PlayerScript.SetTaxiBenchmarkMode

```lua
SetTaxiBenchmarkMode(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
SetTaxiBenchmarkMode(false)
```

### PlayerScript.ShouldDisplayRaidRolesInSocialFrame

```lua
result = ShouldDisplayRaidRolesInSocialFrame()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShouldDisplayRaidRolesInSocialFrame()
```

### PlayerScript.ShouldDisplayStoryModeTooltipInSocialFrame

```lua
result = ShouldDisplayStoryModeTooltipInSocialFrame()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShouldDisplayStoryModeTooltipInSocialFrame()
```

### PlayerScript.ShouldShowIslandsWeeklyPOI

```lua
result = ShouldShowIslandsWeeklyPOI()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShouldShowIslandsWeeklyPOI()
```

### PlayerScript.ShouldShowSpecialSplashScreen

```lua
result = ShouldShowSpecialSplashScreen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShouldShowSpecialSplashScreen()
```

### PlayerScript.ShowCloak

```lua
ShowCloak(show)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `show` | bool | no |  |

**Example**

```lua
ShowCloak(false)
```

### PlayerScript.ShowHelm

```lua
ShowHelm(show)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `show` | bool | no |  |

**Example**

```lua
ShowHelm(false)
```

### PlayerScript.ShowingCloak

```lua
result = ShowingCloak()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShowingCloak()
```

### PlayerScript.ShowingHelm

```lua
result = ShowingHelm()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = ShowingHelm()
```

### PlayerScript.SitStandOrDescendStart

```lua
SitStandOrDescendStart()
```

**Example**

```lua
SitStandOrDescendStart()
```

### PlayerScript.SplashFrameCanBeShown

```lua
result = SplashFrameCanBeShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = SplashFrameCanBeShown()
```

### PlayerScript.StartAttack

```lua
StartAttack(name, exactMatch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no | (default: 0) |
| `exactMatch` | bool | no | (default: False) |

**Example**

```lua
StartAttack("", false)
```

### PlayerScript.StopAttack

```lua
StopAttack()
```

**Example**

```lua
StopAttack()
```

### PlayerScript.Stuck

```lua
Stuck()
```

**Example**

```lua
Stuck()
```

### PlayerScript.TimeoutResurrect

```lua
TimeoutResurrect()
```

**Example**

```lua
TimeoutResurrect()
```

### PlayerScript.ToggleSelfHighlight

```lua
enabled = ToggleSelfHighlight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = ToggleSelfHighlight()
```

### PlayerScript.ToggleSheath

```lua
ToggleSheath()
```

**Example**

```lua
ToggleSheath()
```

### PlayerScript.ToggleSit

```lua
ToggleSit()
```

**Example**

```lua
ToggleSit()
```

## Events

### PLAYER_IN_COMBAT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inCombat` | bool | no |  |

### PLAYER_TARGET_DIED

## Types

### PlayerAttackPowerInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mainHandAttackPower` | number | no |  |
| `offHandAttackPower` | number | no |  |
| `rangedAttackPower` | number | no |  |
| `baseAttackPower` | number | no |  |
| `baseRangedAttackPower` | number | no |  |

