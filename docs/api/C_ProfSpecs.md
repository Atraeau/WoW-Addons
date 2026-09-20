# C_ProfSpecs

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**27** functions · **2** events · **0** types

## Functions

### C_ProfSpecs.CanRefundPath

```lua
canRefund = C_ProfSpecs.CanRefundPath(pathID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canRefund` | bool | no |  |

**Example**

```lua
local canRefund = C_ProfSpecs.CanRefundPath(0, 0)
```

### C_ProfSpecs.CanUnlockTab

```lua
canUnlock = C_ProfSpecs.CanUnlockTab(tabTreeID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabTreeID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUnlock` | bool | no |  |

**Example**

```lua
local canUnlock = C_ProfSpecs.CanUnlockTab(0, 0)
```

### C_ProfSpecs.GetChildrenForPath

```lua
childIDs = C_ProfSpecs.GetChildrenForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `childIDs` | number[] | no |  |

**Example**

```lua
local childIDs = C_ProfSpecs.GetChildrenForPath(0)
```

### C_ProfSpecs.GetConfigIDForSkillLine

```lua
configID = C_ProfSpecs.GetConfigIDForSkillLine(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | number | no |  |

**Example**

```lua
local configID = C_ProfSpecs.GetConfigIDForSkillLine(0)
```

### C_ProfSpecs.GetCurrencyInfoForSkillLine

```lua
info = C_ProfSpecs.GetCurrencyInfoForSkillLine(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | SpecializationCurrencyInfo | no |  |

**Example**

```lua
local info = C_ProfSpecs.GetCurrencyInfoForSkillLine(0)
```

### C_ProfSpecs.GetDefaultSpecSkillLine

```lua
defaultSpecSkillLine = C_ProfSpecs.GetDefaultSpecSkillLine()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultSpecSkillLine` | number | yes |  |

**Example**

```lua
local defaultSpecSkillLine = C_ProfSpecs.GetDefaultSpecSkillLine()
```

### C_ProfSpecs.GetDescriptionForPath

```lua
description = C_ProfSpecs.GetDescriptionForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no |  |

**Example**

```lua
local description = C_ProfSpecs.GetDescriptionForPath(0)
```

### C_ProfSpecs.GetDescriptionForPerk

```lua
description = C_ProfSpecs.GetDescriptionForPerk(perkID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perkID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | string | no |  |

**Example**

```lua
local description = C_ProfSpecs.GetDescriptionForPerk(0)
```

### C_ProfSpecs.GetEntryIDForPerk

```lua
entryID = C_ProfSpecs.GetEntryIDForPerk(perkID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perkID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |

**Example**

```lua
local entryID = C_ProfSpecs.GetEntryIDForPerk(0)
```

### C_ProfSpecs.GetNewSpecReminderProfName

```lua
profName = C_ProfSpecs.GetNewSpecReminderProfName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `profName` | cstring | yes |  |

**Example**

```lua
local profName = C_ProfSpecs.GetNewSpecReminderProfName()
```

### C_ProfSpecs.GetPerksForPath

```lua
perkInfos = C_ProfSpecs.GetPerksForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perkInfos` | SpecPerkInfo[] | no |  |

**Example**

```lua
local perkInfos = C_ProfSpecs.GetPerksForPath(0)
```

### C_ProfSpecs.GetRootPathForTab

```lua
rootPathID = C_ProfSpecs.GetRootPathForTab(tabTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rootPathID` | number | yes |  |

**Example**

```lua
local rootPathID = C_ProfSpecs.GetRootPathForTab(0)
```

### C_ProfSpecs.GetSourceTextForPath

```lua
sourceText = C_ProfSpecs.GetSourceTextForPath(pathID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceText` | cstring | no |  |

**Example**

```lua
local sourceText = C_ProfSpecs.GetSourceTextForPath(0, 0)
```

### C_ProfSpecs.GetSpecTabIDsForSkillLine

```lua
specTabIDs = C_ProfSpecs.GetSpecTabIDsForSkillLine(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specTabIDs` | number[] | no |  |

**Example**

```lua
local specTabIDs = C_ProfSpecs.GetSpecTabIDsForSkillLine(0)
```

### C_ProfSpecs.GetSpecTabInfo

```lua
specTabInfo = C_ProfSpecs.GetSpecTabInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specTabInfo` | SpecializationTabInfo | no |  |

**Example**

```lua
local specTabInfo = C_ProfSpecs.GetSpecTabInfo()
```

### C_ProfSpecs.GetSpendCurrencyForPath

```lua
currencyID = C_ProfSpecs.GetSpendCurrencyForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyID` | number | yes |  |

**Example**

```lua
local currencyID = C_ProfSpecs.GetSpendCurrencyForPath(0)
```

### C_ProfSpecs.GetSpendEntryForPath

```lua
entryID = C_ProfSpecs.GetSpendEntryForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |

**Example**

```lua
local entryID = C_ProfSpecs.GetSpendEntryForPath(0)
```

### C_ProfSpecs.GetStateForPath

```lua
state = C_ProfSpecs.GetStateForPath(pathID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | ProfessionsSpecPathState | no |  |

**Example**

```lua
local state = C_ProfSpecs.GetStateForPath(0, 0)
```

### C_ProfSpecs.GetStateForPerk

```lua
state = C_ProfSpecs.GetStateForPerk(perkID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perkID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | ProfessionsSpecPerkState | no |  |

**Example**

```lua
local state = C_ProfSpecs.GetStateForPerk(0, 0)
```

### C_ProfSpecs.GetStateForTab

```lua
tabInfo = C_ProfSpecs.GetStateForTab(tabTreeID, configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabTreeID` | number | no |  |
| `configID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabInfo` | ProfessionsSpecTabState | no |  |

**Example**

```lua
local tabInfo = C_ProfSpecs.GetStateForTab(0, 0)
```

### C_ProfSpecs.GetTabInfo

```lua
tabInfo = C_ProfSpecs.GetTabInfo(tabTreeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabTreeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tabInfo` | ProfTabInfo | yes |  |

**Example**

```lua
local tabInfo = C_ProfSpecs.GetTabInfo(0)
```

### C_ProfSpecs.GetUnlockEntryForPath

```lua
entryID = C_ProfSpecs.GetUnlockEntryForPath(pathID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pathID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `entryID` | number | no |  |

**Example**

```lua
local entryID = C_ProfSpecs.GetUnlockEntryForPath(0)
```

### C_ProfSpecs.GetUnlockRankForPerk

```lua
unlockRank = C_ProfSpecs.GetUnlockRankForPerk(perkID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `perkID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unlockRank` | number | yes |  |

**Example**

```lua
local unlockRank = C_ProfSpecs.GetUnlockRankForPerk(0)
```

### C_ProfSpecs.ShouldShowPointsReminder

```lua
showReminder = C_ProfSpecs.ShouldShowPointsReminder()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showReminder` | bool | no |  |

**Example**

```lua
local showReminder = C_ProfSpecs.ShouldShowPointsReminder()
```

### C_ProfSpecs.ShouldShowPointsReminderForSkillLine

```lua
showReminder = C_ProfSpecs.ShouldShowPointsReminderForSkillLine(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showReminder` | bool | no |  |

**Example**

```lua
local showReminder = C_ProfSpecs.ShouldShowPointsReminderForSkillLine(0)
```

### C_ProfSpecs.ShouldShowSpecTab

```lua
showSpecTab = C_ProfSpecs.ShouldShowSpecTab()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showSpecTab` | bool | no |  |

**Example**

```lua
local showSpecTab = C_ProfSpecs.ShouldShowSpecTab()
```

### C_ProfSpecs.SkillLineHasSpecialization

```lua
hasSpecialization = C_ProfSpecs.SkillLineHasSpecialization(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSpecialization` | bool | no |  |

**Example**

```lua
local hasSpecialization = C_ProfSpecs.SkillLineHasSpecialization(0)
```

## Events

### SKILL_LINE_SPECS_RANKS_CHANGED

### SKILL_LINE_SPECS_UNLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |
| `tradeSkillID` | number | no |  |

