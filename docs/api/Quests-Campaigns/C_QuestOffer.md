# C_QuestOffer

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **5** events · **1** types

## Functions

### C_QuestOffer.GetHideRequiredItems

```lua
hideRequiredItems = C_QuestOffer.GetHideRequiredItems()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hideRequiredItems` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hideRequiredItems = C_QuestOffer.GetHideRequiredItems()
```

### C_QuestOffer.GetQuestOfferMajorFactionReputationRewards

```lua
reputationRewards = C_QuestOffer.GetQuestOfferMajorFactionReputationRewards()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reputationRewards` | QuestRewardReputationInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local reputationRewards = C_QuestOffer.GetQuestOfferMajorFactionReputationRewards()
```

### C_QuestOffer.GetQuestRequiredCurrencyInfo

```lua
questRequiredCurrencyInfo = C_QuestOffer.GetQuestRequiredCurrencyInfo(questRewardIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRewardIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRequiredCurrencyInfo` | QuestRequiredCurrencyInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questRequiredCurrencyInfo = C_QuestOffer.GetQuestRequiredCurrencyInfo(1)
```

### C_QuestOffer.GetQuestRewardCurrencyInfo

```lua
questRewardCurrencyInfo = C_QuestOffer.GetQuestRewardCurrencyInfo(questInfoType, questRewardIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questInfoType` | cstring | no |  |
| `questRewardIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questRewardCurrencyInfo` | QuestRewardCurrencyInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questRewardCurrencyInfo = C_QuestOffer.GetQuestRewardCurrencyInfo("", 1)
```

## Events

### QUEST_ACCEPT_CONFIRM

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `questTitle` | cstring | no |  |
| `questID` | number | no |  |

### QUEST_FINISHED

### QUEST_GREETING

### QUEST_ITEM_UPDATE

### QUEST_PROGRESS

## Types

### QuestRequiredCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | fileID | no |  |
| `name` | cstring | no |  |
| `currencyID` | number | no |  |
| `quality` | number | no |  |
| `requiredAmount` | number | no |  |

