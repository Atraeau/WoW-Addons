# C_CovenantSanctumUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**16** functions · **2** events · **3** types

## Functions

### C_CovenantSanctumUI.CanAccessReservoir

```lua
canAccess = C_CovenantSanctumUI.CanAccessReservoir()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccess` | bool | no |  |

**Example**

```lua
local canAccess = C_CovenantSanctumUI.CanAccessReservoir()
```

### C_CovenantSanctumUI.CanDepositAnima

```lua
canDeposit = C_CovenantSanctumUI.CanDepositAnima()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canDeposit` | bool | no |  |

**Example**

```lua
local canDeposit = C_CovenantSanctumUI.CanDepositAnima()
```

### C_CovenantSanctumUI.DepositAnima

```lua
C_CovenantSanctumUI.DepositAnima()
```

**Example**

```lua
C_CovenantSanctumUI.DepositAnima()
```

### C_CovenantSanctumUI.EndInteraction

```lua
C_CovenantSanctumUI.EndInteraction()
```

**Example**

```lua
C_CovenantSanctumUI.EndInteraction()
```

### C_CovenantSanctumUI.GetAnimaInfo

```lua
currencyID, maxDisplayableValue = C_CovenantSanctumUI.GetAnimaInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no |  |
| `maxDisplayableValue` | number | no |  |

**Example**

```lua
local currencyID, maxDisplayableValue = C_CovenantSanctumUI.GetAnimaInfo()
```

### C_CovenantSanctumUI.GetCurrentTalentTreeID

```lua
currentTalentTreeID = C_CovenantSanctumUI.GetCurrentTalentTreeID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentTalentTreeID` | number | yes |  |

**Example**

```lua
local currentTalentTreeID = C_CovenantSanctumUI.GetCurrentTalentTreeID()
```

### C_CovenantSanctumUI.GetFeatures

```lua
features = C_CovenantSanctumUI.GetFeatures()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `features` | CovenantSanctumFeatureInfo[] | no |  |

**Example**

```lua
local features = C_CovenantSanctumUI.GetFeatures()
```

### C_CovenantSanctumUI.GetRenownLevel

```lua
level = C_CovenantSanctumUI.GetRenownLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Example**

```lua
local level = C_CovenantSanctumUI.GetRenownLevel()
```

### C_CovenantSanctumUI.GetRenownLevels

```lua
levels = C_CovenantSanctumUI.GetRenownLevels(covenantID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `levels` | CovenantSanctumRenownLevelInfo[] | no |  |

**Example**

```lua
local levels = C_CovenantSanctumUI.GetRenownLevels(0)
```

### C_CovenantSanctumUI.GetRenownRewardsForLevel

```lua
rewards = C_CovenantSanctumUI.GetRenownRewardsForLevel(covenantID, renownLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `covenantID` | number | no |  |
| `renownLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewards` | CovenantSanctumRenownRewardInfo[] | no |  |

**Example**

```lua
local rewards = C_CovenantSanctumUI.GetRenownRewardsForLevel(0, 0)
```

### C_CovenantSanctumUI.GetSanctumType

```lua
sanctumType = C_CovenantSanctumUI.GetSanctumType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sanctumType` | GarrTalentFeatureSubtype | yes |  |

**Example**

```lua
local sanctumType = C_CovenantSanctumUI.GetSanctumType()
```

### C_CovenantSanctumUI.GetSoulCurrencies

```lua
currencyIDs = C_CovenantSanctumUI.GetSoulCurrencies()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyIDs` | number[] | no |  |

**Example**

```lua
local currencyIDs = C_CovenantSanctumUI.GetSoulCurrencies()
```

### C_CovenantSanctumUI.HasMaximumRenown

```lua
hasMaxRenown = C_CovenantSanctumUI.HasMaximumRenown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasMaxRenown` | bool | no |  |

**Example**

```lua
local hasMaxRenown = C_CovenantSanctumUI.HasMaximumRenown()
```

### C_CovenantSanctumUI.IsPlayerInRenownCatchUpMode

```lua
isInCatchUpMode = C_CovenantSanctumUI.IsPlayerInRenownCatchUpMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInCatchUpMode` | bool | no |  |

**Example**

```lua
local isInCatchUpMode = C_CovenantSanctumUI.IsPlayerInRenownCatchUpMode()
```

### C_CovenantSanctumUI.IsWeeklyRenownCapped

```lua
isWeeklyCapped = C_CovenantSanctumUI.IsWeeklyRenownCapped()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWeeklyCapped` | bool | no |  |

**Example**

```lua
local isWeeklyCapped = C_CovenantSanctumUI.IsWeeklyRenownCapped()
```

### C_CovenantSanctumUI.RequestCatchUpState

```lua
C_CovenantSanctumUI.RequestCatchUpState()
```

**Example**

```lua
C_CovenantSanctumUI.RequestCatchUpState()
```

## Events

### COVENANT_RENOWN_CATCH_UP_STATE_UPDATE

### COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newRenownLevel` | number | no |  |
| `oldRenownLevel` | number | no |  |

## Types

### CovenantSanctumFeatureInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `garrTalentTreeID` | number | no |  |
| `featureType` | number | no |  |
| `uiOrder` | number | no |  |

### CovenantSanctumRenownLevelInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |
| `locked` | bool | no |  |
| `isMilestone` | bool | no |  |
| `isCapstone` | bool | no |  |

### CovenantSanctumRenownRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiOrder` | number | no |  |
| `itemID` | number | yes |  |
| `spellID` | number | yes |  |
| `mountID` | number | yes |  |
| `transmogID` | number | yes |  |
| `transmogSetID` | number | yes |  |
| `titleMaskID` | number | yes |  |
| `garrFollowerID` | number | yes |  |
| `transmogIllusionSourceID` | number | yes |  |
| `icon` | fileID | yes |  |
| `name` | cstring | yes |  |
| `description` | cstring | yes |  |
| `toastDescription` | cstring | yes |  |

