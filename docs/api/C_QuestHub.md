# C_QuestHub

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **0** types

## Functions

### C_QuestHub.IsAreaPOICurrentlyRelatedToHub

```lua
isRelated = C_QuestHub.IsAreaPOICurrentlyRelatedToHub(areaPoiID, hubAreaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areaPoiID` | number | no |  |
| `hubAreaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRelated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRelated = C_QuestHub.IsAreaPOICurrentlyRelatedToHub(0, 0)
```

### C_QuestHub.IsQuestCurrentlyRelatedToHub

```lua
isRelated = C_QuestHub.IsQuestCurrentlyRelatedToHub(questID, hubAreaPoiID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |
| `hubAreaPoiID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRelated` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRelated = C_QuestHub.IsQuestCurrentlyRelatedToHub(0, 0)
```

