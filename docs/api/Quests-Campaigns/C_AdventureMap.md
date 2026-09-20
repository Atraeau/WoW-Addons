# C_AdventureMap

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **5** events · **1** types

## Functions

### C_AdventureMap.GetAdventureMapTextureKit

```lua
adventureMapTextureKit = C_AdventureMap.GetAdventureMapTextureKit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `adventureMapTextureKit` | textureKit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local adventureMapTextureKit = C_AdventureMap.GetAdventureMapTextureKit()
```

### C_AdventureMap.GetQuestPortraitInfo

```lua
info = C_AdventureMap.GetQuestPortraitInfo(questID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AdventureMapQuestPortraitInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AdventureMap.GetQuestPortraitInfo(0)
```

## Events

### ADVENTURE_MAP_CLOSE

### ADVENTURE_MAP_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `followerTypeID` | number | no |  |

### ADVENTURE_MAP_QUEST_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | no |  |

### ADVENTURE_MAP_UPDATE_INSETS

### ADVENTURE_MAP_UPDATE_POIS

## Types

### AdventureMapQuestPortraitInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `portraitDisplayID` | number | no |  |
| `mountPortraitDisplayID` | number | no |  |
| `name` | string | no |  |
| `text` | string | no |  |
| `modelSceneID` | number | yes |  |

