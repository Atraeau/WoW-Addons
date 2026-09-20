# C_ScenarioInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **9** events · **7** types

## Functions

### C_ScenarioInfo.GetCriteriaInfo

```lua
scenarioCriteriaInfo = C_ScenarioInfo.GetCriteriaInfo(criteriaIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criteriaIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioCriteriaInfo` | ScenarioCriteriaInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scenarioCriteriaInfo = C_ScenarioInfo.GetCriteriaInfo(1)
```

### C_ScenarioInfo.GetCriteriaInfoByStep

```lua
scenarioCriteriaInfo = C_ScenarioInfo.GetCriteriaInfoByStep(stepID, criteriaIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stepID` | number | no |  |
| `criteriaIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioCriteriaInfo` | ScenarioCriteriaInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scenarioCriteriaInfo = C_ScenarioInfo.GetCriteriaInfoByStep(0, 1)
```

### C_ScenarioInfo.GetDisplayInfo

```lua
info = C_ScenarioInfo.GetDisplayInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ScenarioDisplayInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ScenarioInfo.GetDisplayInfo()
```

### C_ScenarioInfo.GetJailersTowerTypeString

```lua
typeString = C_ScenarioInfo.GetJailersTowerTypeString(runType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `runType` | JailersTowerType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `typeString` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local typeString = C_ScenarioInfo.GetJailersTowerTypeString(Enum.JailersTowerType.TwistingCorridors)
```

### C_ScenarioInfo.GetScenarioIconInfo

```lua
scenarioInfos = C_ScenarioInfo.GetScenarioIconInfo(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioInfos` | ScenarioIconInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scenarioInfos = C_ScenarioInfo.GetScenarioIconInfo(0)
```

### C_ScenarioInfo.GetScenarioInfo

```lua
scenarioInfo = C_ScenarioInfo.GetScenarioInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioInfo` | ScenarioInformation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scenarioInfo = C_ScenarioInfo.GetScenarioInfo()
```

### C_ScenarioInfo.GetScenarioStepInfo

```lua
scenarioStepInfo = C_ScenarioInfo.GetScenarioStepInfo([scenarioStepID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioStepID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scenarioStepInfo` | ScenarioStepInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scenarioStepInfo = C_ScenarioInfo.GetScenarioStepInfo()
```

### C_ScenarioInfo.GetTieredEntranceActiveSpells

Returns list of active challenge spells if inside a tiered entrance scenario

```lua
spellIDs = C_ScenarioInfo.GetTieredEntranceActiveSpells()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local spellIDs = C_ScenarioInfo.GetTieredEntranceActiveSpells()
```

### C_ScenarioInfo.GetUnitCriteriaProgressValues

```lua
actualValue, percentValue, percentValueString = C_ScenarioInfo.GetUnitCriteriaProgressValues(unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actualValue` | number | no |  |
| `percentValue` | number | no |  |
| `percentValueString` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local actualValue, percentValue, percentValueString = C_ScenarioInfo.GetUnitCriteriaProgressValues("player")
```

### C_ScenarioInfo.IsTieredEntranceScenario

```lua
isTieredEntrance = C_ScenarioInfo.IsTieredEntranceScenario()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTieredEntrance` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTieredEntrance = C_ScenarioInfo.IsTieredEntranceScenario()
```

## Events

### JAILERS_TOWER_LEVEL_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |
| `type` | JailersTowerType | no |  |

### SCENARIO_BONUS_OBJECTIVE_COMPLETE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusObjectiveID` | number | no |  |

### SCENARIO_BONUS_VISIBILITY_UPDATE

### SCENARIO_COMPLETED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `xp` | number | yes |  |
| `money` | number | yes |  |

### SCENARIO_CRITERIA_SHOW_STATE_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `show` | bool | no |  |

### SCENARIO_CRITERIA_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `criteriaID` | number | no |  |

### SCENARIO_POI_UPDATE

### SCENARIO_SPELL_UPDATE

### SCENARIO_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newStep` | bool | yes |  |

## Types

### JailersTowerType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `TwistingCorridors` | JailersTowerType | no |  |
| `SkoldusHalls` | JailersTowerType | no |  |
| `FractureChambers` | JailersTowerType | no |  |
| `Soulforges` | JailersTowerType | no |  |
| `Coldheart` | JailersTowerType | no |  |
| `Mortregar` | JailersTowerType | no |  |
| `UpperReaches` | JailersTowerType | no |  |
| `ArkobanHall` | JailersTowerType | no |  |
| `TormentChamberJaina` | JailersTowerType | no |  |
| `TormentChamberThrall` | JailersTowerType | no |  |
| `TormentChamberAnduin` | JailersTowerType | no |  |
| `AdamantVaults` | JailersTowerType | no |  |
| `ForgottenCatacombs` | JailersTowerType | no |  |
| `Ossuary` | JailersTowerType | no |  |
| `BossRush` | JailersTowerType | no |  |

### ScenarioCriteriaInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no |  |
| `criteriaType` | number | no | (default: 0) |
| `completed` | bool | no | (default: False) |
| `quantity` | number | no | (default: 0) |
| `totalQuantity` | number | no | (default: 0) |
| `flags` | number | no | (default: 0) |
| `assetID` | number | no | (default: 0) |
| `criteriaID` | number | no |  |
| `duration` | number | no | (default: 0) |
| `elapsed` | number | no | (default: 0) |
| `failed` | bool | no | (default: False) |
| `isWeightedProgress` | bool | no | (default: False) |
| `isFormatted` | bool | no | (default: False) |
| `quantityString` | string | no |  |

### ScenarioDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `themeColor` | colorRGB | yes |  |
| `startSoundKitID` | number | yes |  |

### ScenarioIconInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |
| `atlas` | textureAtlas | no |  |
| `description` | cstring | no |  |

### ScenarioInformation (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `currentStage` | number | no |  |
| `numStages` | number | no |  |
| `flags` | number | no |  |
| `isComplete` | bool | no |  |
| `xp` | number | no |  |
| `money` | number | no |  |
| `type` | number | no |  |
| `area` | string | no |  |
| `uiTextureKit` | textureKit | no |  |
| `scenarioID` | number | no |  |

### ScenarioStepInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | string | no |  |
| `description` | string | no |  |
| `numCriteria` | number | no |  |
| `stepFailed` | bool | no |  |
| `isBonusStep` | bool | no |  |
| `isForCurrentStepOnly` | bool | no |  |
| `shouldShowBonusObjective` | bool | no |  |
| `spells` | ScenarioStepSpellInfo[] | no |  |
| `weightedProgress` | number | yes |  |
| `rewardQuestID` | number | no |  |
| `widgetSetID` | number | yes |  |
| `stepID` | number | no |  |

### ScenarioStepSpellInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `name` | string | no |  |
| `icon` | number | no |  |

