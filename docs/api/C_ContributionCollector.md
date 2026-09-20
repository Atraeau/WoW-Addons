# C_ContributionCollector

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**18** functions · **4** events · **3** types

## Functions

### C_ContributionCollector.Close

```lua
C_ContributionCollector.Close()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ContributionCollector.Close()
```

### C_ContributionCollector.Contribute

```lua
C_ContributionCollector.Contribute(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ContributionCollector.Contribute(0)
```

### C_ContributionCollector.GetActive

```lua
contributionID = C_ContributionCollector.GetActive()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contributionID = C_ContributionCollector.GetActive()
```

### C_ContributionCollector.GetAtlases

```lua
atlasName = C_ContributionCollector.GetAtlases(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `atlasName` | textureAtlas[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local atlasName = C_ContributionCollector.GetAtlases(0)
```

### C_ContributionCollector.GetBuffs

```lua
spellID = C_ContributionCollector.GetBuffs(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellID = C_ContributionCollector.GetBuffs(0)
```

### C_ContributionCollector.GetContributionAppearance

```lua
appearance = C_ContributionCollector.GetContributionAppearance(contributionID, contributionState)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |
| `contributionState` | ContributionState | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearance` | ContributionAppearance | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local appearance = C_ContributionCollector.GetContributionAppearance(0, contributionState)
```

### C_ContributionCollector.GetContributionCollectorsForMap

```lua
contributionCollectors = C_ContributionCollector.GetContributionCollectorsForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionCollectors` | ContributionMapInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contributionCollectors = C_ContributionCollector.GetContributionCollectorsForMap(0)
```

### C_ContributionCollector.GetContributionResult

```lua
result = C_ContributionCollector.GetContributionResult(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | ContributionResult | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_ContributionCollector.GetContributionResult(0)
```

### C_ContributionCollector.GetDescription

```lua
description = C_ContributionCollector.GetDescription(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local description = C_ContributionCollector.GetDescription(0)
```

### C_ContributionCollector.GetManagedContributionsForCreatureID

```lua
contributionID = C_ContributionCollector.GetManagedContributionsForCreatureID(creatureID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contributionID = C_ContributionCollector.GetManagedContributionsForCreatureID(0)
```

### C_ContributionCollector.GetName

```lua
name = C_ContributionCollector.GetName(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_ContributionCollector.GetName(0)
```

### C_ContributionCollector.GetOrderIndex

```lua
orderIndex = C_ContributionCollector.GetOrderIndex(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local orderIndex = C_ContributionCollector.GetOrderIndex(0)
```

### C_ContributionCollector.GetRequiredContributionCurrency

```lua
currencyID, currencyAmount = C_ContributionCollector.GetRequiredContributionCurrency(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | no | (default: 0) |
| `currencyAmount` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currencyID, currencyAmount = C_ContributionCollector.GetRequiredContributionCurrency(0)
```

### C_ContributionCollector.GetRequiredContributionItem

```lua
itemID, itemCount = C_ContributionCollector.GetRequiredContributionItem(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no | (default: 0) |
| `itemCount` | number | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local itemID, itemCount = C_ContributionCollector.GetRequiredContributionItem(0)
```

### C_ContributionCollector.GetRewardQuestID

```lua
questID = C_ContributionCollector.GetRewardQuestID(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questID = C_ContributionCollector.GetRewardQuestID(0)
```

### C_ContributionCollector.GetState

```lua
contributionState, contributionPercentageComplete, timeOfNextStateChange, startTime = C_ContributionCollector.GetState(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionState` | ContributionState | no | (default: None) |
| `contributionPercentageComplete` | number | no |  |
| `timeOfNextStateChange` | time_t | yes |  |
| `startTime` | time_t | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local contributionState, contributionPercentageComplete, timeOfNextStateChange, startTime = C_ContributionCollector.GetState(0)
```

### C_ContributionCollector.HasPendingContribution

```lua
hasPending = C_ContributionCollector.HasPendingContribution(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPending` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasPending = C_ContributionCollector.HasPendingContribution(0)
```

### C_ContributionCollector.IsAwaitingRewardQuestData

```lua
awaitingData = C_ContributionCollector.IsAwaitingRewardQuestData(contributionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `awaitingData` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local awaitingData = C_ContributionCollector.IsAwaitingRewardQuestData(0)
```

## Events

### CONTRIBUTION_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | ContributionState | no |  |
| `result` | ContributionResult | no |  |
| `name` | string | no |  |
| `contributionID` | number | no |  |

### CONTRIBUTION_COLLECTOR_PENDING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |
| `isPending` | bool | no |  |
| `result` | number | no |  |

### CONTRIBUTION_COLLECTOR_UPDATE

### CONTRIBUTION_COLLECTOR_UPDATE_SINGLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `contributionID` | number | no |  |

## Types

### ContributionAppearance (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stateName` | cstring | no |  |
| `stateColor` | colorRGB | no |  |
| `tooltipLine` | cstring | no |  |
| `tooltipUseTimeRemaining` | bool | no |  |
| `statusBarAtlas` | textureAtlas | no |  |
| `borderAtlas` | textureAtlas | no |  |
| `bannerAtlas` | textureAtlas | no |  |

### ContributionMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `position` | vector2 | no |  |
| `name` | cstring | no |  |
| `atlasName` | string | no |  |
| `collectorCreatureID` | number | no |  |

### ContributionResult (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Success` | ContributionResult | no |  |
| `MustBeNearNpc` | ContributionResult | no |  |
| `IncorrectState` | ContributionResult | no |  |
| `InvalidID` | ContributionResult | no |  |
| `QuestDataMissing` | ContributionResult | no |  |
| `FailedConditionCheck` | ContributionResult | no |  |
| `UnableToCompleteTurnIn` | ContributionResult | no |  |
| `InternalError` | ContributionResult | no |  |

