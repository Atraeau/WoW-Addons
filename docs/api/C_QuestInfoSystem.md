# C_QuestInfoSystem

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **0** events · **0** types

## Functions

### C_QuestInfoSystem.GetQuestClassification

```lua
classification = C_QuestInfoSystem.GetQuestClassification([questID], [questInfoID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `questInfoID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classification` | QuestClassification | no |  |

**Example**

```lua
local classification = C_QuestInfoSystem.GetQuestClassification()
```

### C_QuestInfoSystem.GetQuestHasShortExpirationWarning

```lua
hasShortExpirationWarning = C_QuestInfoSystem.GetQuestHasShortExpirationWarning([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasShortExpirationWarning` | bool | no |  |

**Example**

```lua
local hasShortExpirationWarning = C_QuestInfoSystem.GetQuestHasShortExpirationWarning()
```

### C_QuestInfoSystem.GetQuestLogRewardFavor

```lua
amount = C_QuestInfoSystem.GetQuestLogRewardFavor([questID], [clampFavorToCycleCap])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `clampFavorToCycleCap` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `amount` | number | no |  |

**Example**

```lua
local amount = C_QuestInfoSystem.GetQuestLogRewardFavor()
```

### C_QuestInfoSystem.GetQuestRewardCurrencies

```lua
questRewardCurrencyInfo = C_QuestInfoSystem.GetQuestRewardCurrencies([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRewardCurrencyInfo` | QuestRewardCurrencyInfo[] | no |  |

**Example**

```lua
local questRewardCurrencyInfo = C_QuestInfoSystem.GetQuestRewardCurrencies()
```

### C_QuestInfoSystem.GetQuestRewardSpellInfo

```lua
info = C_QuestInfoSystem.GetQuestRewardSpellInfo([questID], spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | QuestRewardSpellInfo | yes |  |

**Example**

```lua
local info = C_QuestInfoSystem.GetQuestRewardSpellInfo(12345)
```

### C_QuestInfoSystem.GetQuestRewardSpells

```lua
spellIDs = C_QuestInfoSystem.GetQuestRewardSpells([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellIDs` | number[] | no |  |

**Example**

```lua
local spellIDs = C_QuestInfoSystem.GetQuestRewardSpells()
```

### C_QuestInfoSystem.GetQuestShouldToastCompletion

```lua
shouldToast = C_QuestInfoSystem.GetQuestShouldToastCompletion([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldToast` | bool | no |  |

**Example**

```lua
local shouldToast = C_QuestInfoSystem.GetQuestShouldToastCompletion()
```

### C_QuestInfoSystem.HasQuestRewardCurrencies

```lua
hasQuestRewardCurrencies = C_QuestInfoSystem.HasQuestRewardCurrencies([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasQuestRewardCurrencies` | bool | no |  |

**Example**

```lua
local hasQuestRewardCurrencies = C_QuestInfoSystem.HasQuestRewardCurrencies()
```

### C_QuestInfoSystem.HasQuestRewardSpells

```lua
hasRewardSpells = C_QuestInfoSystem.HasQuestRewardSpells([questID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRewardSpells` | bool | no |  |

**Example**

```lua
local hasRewardSpells = C_QuestInfoSystem.HasQuestRewardSpells()
```

