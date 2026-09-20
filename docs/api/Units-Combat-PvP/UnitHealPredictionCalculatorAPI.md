# UnitHealPredictionCalculatorAPI

[← API index](../README.md) · group: [Units, Combat & PvP](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**35** functions · **0** events · **0** types

## Functions

### UnitHealPredictionCalculatorAPI.EvaluateCurrentHealthPercent

Calculates the percentage of current unit health and evaluates it against the supplied curve.

```lua
result = EvaluateCurrentHealthPercent(curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = EvaluateCurrentHealthPercent(curve)
```

### UnitHealPredictionCalculatorAPI.EvaluateMissingHealthPercent

Calculates the percentage of missing unit health and evaluates it against the supplied curve.

```lua
result = EvaluateMissingHealthPercent(curve)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curve` | LuaCurveObjectBase | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaCurveEvaluatedResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = EvaluateMissingHealthPercent(curve)
```

### UnitHealPredictionCalculatorAPI.GetCurrentHealth

Returns the base amount of unit health.

```lua
currentHealth = GetCurrentHealth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentHealth` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentHealth = GetCurrentHealth()
```

### UnitHealPredictionCalculatorAPI.GetCurrentHealthPercent

Returns the percentage of current unit health.

```lua
currentHealthPercent = GetCurrentHealthPercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentHealthPercent` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentHealthPercent = GetCurrentHealthPercent()
```

### UnitHealPredictionCalculatorAPI.GetDamageAbsorbClampMode

Returns the configured damage absorb clamping mode.

```lua
damageAbsorbClampMode = GetDamageAbsorbClampMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `damageAbsorbClampMode` | UnitDamageAbsorbClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local damageAbsorbClampMode = GetDamageAbsorbClampMode()
```

### UnitHealPredictionCalculatorAPI.GetDamageAbsorbs

Calculates damage absorb values and clamping according to the configured options.

```lua
amount, clamped = GetDamageAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no | Amount of applied damage absorb affects with potential reductions from clamping included. |
| `clamped` | bool | no | If true, the value is in excess of the clamp boundary. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount, clamped = GetDamageAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetHealAbsorbClampMode

Returns the configured heal absorb clamping mode.

```lua
healAbsorbClampMode = GetHealAbsorbClampMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healAbsorbClampMode` | UnitHealAbsorbClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local healAbsorbClampMode = GetHealAbsorbClampMode()
```

### UnitHealPredictionCalculatorAPI.GetHealAbsorbMode

Returns the configured heal absorb processing mode.

```lua
healAbsorbMode = GetHealAbsorbMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healAbsorbMode` | UnitHealAbsorbMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local healAbsorbMode = GetHealAbsorbMode()
```

### UnitHealPredictionCalculatorAPI.GetHealAbsorbs

Calculates heal absorb values and clamping according to the configured options.

```lua
amount, clamped = GetHealAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no | Amount of applied heal absorb affects with potential reductions from incoming heals and clamping included. |
| `clamped` | bool | no | If true, the value is in excess of the clamp boundary. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount, clamped = GetHealAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetIncomingHealClampMode

Returns the configured incoming heal clamping mode.

```lua
incomingHealClampMode = GetIncomingHealClampMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `incomingHealClampMode` | UnitIncomingHealClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local incomingHealClampMode = GetIncomingHealClampMode()
```

### UnitHealPredictionCalculatorAPI.GetIncomingHealOverflowPercent

Returns the configured incoming heal maximum overflow percentage.

```lua
incomingHealOverflowPercent = GetIncomingHealOverflowPercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `incomingHealOverflowPercent` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local incomingHealOverflowPercent = GetIncomingHealOverflowPercent()
```

### UnitHealPredictionCalculatorAPI.GetIncomingHeals

Calculates incoming heal values and clamping according to the configured options.

```lua
amount, amountFromHealer, amountFromOthers, clamped = GetIncomingHeals()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no | Amount of incoming heals across all units with potential reductions from heal absorb effects included. |
| `amountFromHealer` | number | no | Amount of incoming heals from the healer unit. Will never exceed the all-units value. |
| `amountFromOthers` | number | no | Amount of incoming heals from units other than theh healer. Calculated as the difference between amount and amount-from-healer. |
| `clamped` | bool | no | If true, the value is in excess of the clamp boundary. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local amount, amountFromHealer, amountFromOthers, clamped = GetIncomingHeals()
```

### UnitHealPredictionCalculatorAPI.GetMaximumDamageAbsorbs

Returns the maximum clamping amount for damage absorbs.

```lua
maximumDamageAbsorbs = GetMaximumDamageAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumDamageAbsorbs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maximumDamageAbsorbs = GetMaximumDamageAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetMaximumHealAbsorbs

Returns the maximum clamping amount for heal absorbs.

```lua
maximumHealAbsorbs = GetMaximumHealAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumHealAbsorbs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maximumHealAbsorbs = GetMaximumHealAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetMaximumHealth

Returns the base amount of maximum unit health.

```lua
maximumHealth = GetMaximumHealth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumHealth` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maximumHealth = GetMaximumHealth()
```

### UnitHealPredictionCalculatorAPI.GetMaximumHealthMode

Returns the configured maximum health mode.

```lua
maximumHealthMode = GetMaximumHealthMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumHealthMode` | UnitMaximumHealthMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maximumHealthMode = GetMaximumHealthMode()
```

### UnitHealPredictionCalculatorAPI.GetMaximumIncomingHeals

Returns the maximum clamping amount for incoming heals.

```lua
maximumIncomingHeals = GetMaximumIncomingHeals()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumIncomingHeals` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maximumIncomingHeals = GetMaximumIncomingHeals()
```

### UnitHealPredictionCalculatorAPI.GetMissingHealth

Returns the base amount of missing unit health.

```lua
missingHealth = GetMissingHealth()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missingHealth` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local missingHealth = GetMissingHealth()
```

### UnitHealPredictionCalculatorAPI.GetMissingHealthPercent

Returns the percentage of missing unit health.

```lua
missingHealthPercent = GetMissingHealthPercent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `missingHealthPercent` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local missingHealthPercent = GetMissingHealthPercent()
```

### UnitHealPredictionCalculatorAPI.GetPredictedValues

Returns the raw total figures used for data calculations.

```lua
predictedValues = GetPredictedValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `predictedValues` | UnitHealPredictionValues | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local predictedValues = GetPredictedValues()
```

### UnitHealPredictionCalculatorAPI.GetTotalDamageAbsorbs

Returns the base total amount of all applied damage absorb shields.

```lua
totalDamageAbsorbs = GetTotalDamageAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalDamageAbsorbs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalDamageAbsorbs = GetTotalDamageAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetTotalHealAbsorbs

Returns the base total amount of all applied heal absorption effects.

```lua
totalHealAbsorbs = GetTotalHealAbsorbs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalHealAbsorbs` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalHealAbsorbs = GetTotalHealAbsorbs()
```

### UnitHealPredictionCalculatorAPI.GetTotalIncomingHeals

Returns the base total amount of all incoming heals.

```lua
totalIncomingHeals = GetTotalIncomingHeals()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalIncomingHeals` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalIncomingHeals = GetTotalIncomingHeals()
```

### UnitHealPredictionCalculatorAPI.GetTotalIncomingHealsFromHealer

Returns the base total amount of all incoming heals from the healer unit, if any.

```lua
totalIncomingHealsFromHealer = GetTotalIncomingHealsFromHealer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalIncomingHealsFromHealer` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalIncomingHealsFromHealer = GetTotalIncomingHealsFromHealer()
```

### UnitHealPredictionCalculatorAPI.HasSecretValues

Returns true if the object has been configured with any secret values.

```lua
hasSecretValues = HasSecretValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretValues = HasSecretValues()
```

### UnitHealPredictionCalculatorAPI.Reset

Resets all stored state on the object.

```lua
Reset()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Reset()
```

### UnitHealPredictionCalculatorAPI.ResetPredictedValues

Resets all stored healing values used for calculations.

```lua
ResetPredictedValues()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResetPredictedValues()
```

### UnitHealPredictionCalculatorAPI.SetDamageAbsorbClampMode

Changes the clamping mode used when calculating damage absorb amounts.

```lua
SetDamageAbsorbClampMode(damageAbsorbClampMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `damageAbsorbClampMode` | UnitDamageAbsorbClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDamageAbsorbClampMode(damageAbsorbClampMode)
```

### UnitHealPredictionCalculatorAPI.SetHealAbsorbClampMode

Changes the clamping mode used when calculating heal absorb amounts.

```lua
SetHealAbsorbClampMode(healAbsorbClampMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healAbsorbClampMode` | UnitHealAbsorbClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHealAbsorbClampMode(healAbsorbClampMode)
```

### UnitHealPredictionCalculatorAPI.SetHealAbsorbMode

Changes the processing mode used when calculating both heal absorb and incoming heal amounts.

```lua
SetHealAbsorbMode(healAbsorbMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `healAbsorbMode` | UnitHealAbsorbMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHealAbsorbMode(healAbsorbMode)
```

### UnitHealPredictionCalculatorAPI.SetIncomingHealClampMode

Changes the clamping mode used when calculating incoming heal amounts.

```lua
SetIncomingHealClampMode(incomingHealClampMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `incomingHealClampMode` | UnitIncomingHealClampMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIncomingHealClampMode(incomingHealClampMode)
```

### UnitHealPredictionCalculatorAPI.SetIncomingHealOverflowPercent

Changes the maximum overflow percentage for incoming heals. Increasing this to a value over 1.0 will mean that incoming heals can extend beyond maximum health.

```lua
SetIncomingHealOverflowPercent(incomingHealOverflowPercent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `incomingHealOverflowPercent` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIncomingHealOverflowPercent(0)
```

### UnitHealPredictionCalculatorAPI.SetMaximumHealthMode

Changes the calculation mode for maximum health values used for clamping.

```lua
SetMaximumHealthMode(maximumHealthMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maximumHealthMode` | UnitMaximumHealthMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMaximumHealthMode(maximumHealthMode)
```

### UnitHealPredictionCalculatorAPI.SetPredictedValues

Sets the healing values used for all calculations.

```lua
SetPredictedValues(predictedValues)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `predictedValues` | UnitHealPredictionValues | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPredictedValues(predictedValues)
```

### UnitHealPredictionCalculatorAPI.SetToDefaults

Resets all state on the object, and clears the secret values flag.

```lua
SetToDefaults()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToDefaults()
```

