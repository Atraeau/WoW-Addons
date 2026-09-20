# C_CampaignInfo

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**10** functions · **0** events · **4** types

## Functions

### C_CampaignInfo.GetAvailableCampaigns

```lua
campaignIDs = C_CampaignInfo.GetAvailableCampaigns()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local campaignIDs = C_CampaignInfo.GetAvailableCampaigns()
```

### C_CampaignInfo.GetCampaignChapterInfo

```lua
campaignChapterInfo = C_CampaignInfo.GetCampaignChapterInfo(campaignChapterID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignChapterID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignChapterInfo` | CampaignChapterInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local campaignChapterInfo = C_CampaignInfo.GetCampaignChapterInfo(0)
```

### C_CampaignInfo.GetCampaignID

```lua
campaignID = C_CampaignInfo.GetCampaignID(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local campaignID = C_CampaignInfo.GetCampaignID(0)
```

### C_CampaignInfo.GetCampaignInfo

```lua
campaignInfo = C_CampaignInfo.GetCampaignInfo(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignInfo` | CampaignInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local campaignInfo = C_CampaignInfo.GetCampaignInfo(0)
```

### C_CampaignInfo.GetChapterIDs

```lua
chapterIDs = C_CampaignInfo.GetChapterIDs(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chapterIDs` | number[] | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local chapterIDs = C_CampaignInfo.GetChapterIDs(0)
```

### C_CampaignInfo.GetCurrentChapterID

```lua
currentChapterID = C_CampaignInfo.GetCurrentChapterID(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentChapterID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local currentChapterID = C_CampaignInfo.GetCurrentChapterID(0)
```

### C_CampaignInfo.GetFailureReason

```lua
failureReason = C_CampaignInfo.GetFailureReason(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `failureReason` | CampaignFailureReason | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local failureReason = C_CampaignInfo.GetFailureReason(0)
```

### C_CampaignInfo.GetState

```lua
state = C_CampaignInfo.GetState(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | CampaignState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_CampaignInfo.GetState(0)
```

### C_CampaignInfo.IsCampaignQuest

```lua
isCampaignQuest = C_CampaignInfo.IsCampaignQuest(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCampaignQuest` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCampaignQuest = C_CampaignInfo.IsCampaignQuest(0)
```

### C_CampaignInfo.SortAsNormalQuest

```lua
sortAsNormalQuest = C_CampaignInfo.SortAsNormalQuest(campaignID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `campaignID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sortAsNormalQuest` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sortAsNormalQuest = C_CampaignInfo.SortAsNormalQuest(0)
```

## Types

### CampaignChapterInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `rewardQuestID` | number | no |  |

### CampaignFailureReason (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `questID` | number | yes |  |
| `mapID` | number | yes |  |

### CampaignInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `uiTextureKit` | textureKit | no |  |
| `isWarCampaign` | bool | no |  |
| `usesNormalQuestIcons` | bool | no |  |
| `isContainerCampaign` | bool | no |  |
| `sortAsNormalQuest` | bool | no |  |
| `hideFutureChapters` | bool | no |  |

### CampaignState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Invalid` | CampaignState | no |  |
| `Complete` | CampaignState | no |  |
| `InProgress` | CampaignState | no |  |
| `Stalled` | CampaignState | no |  |

