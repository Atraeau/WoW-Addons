# C_AdventureMap

[← API index](../README.md) · group: [Quests & Campaigns](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

**5** functions · **5** events · **1** types

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

### C_AdventureMap.GetNumMapInsets

```lua
numMapInsets = C_AdventureMap.GetNumMapInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numMapInsets` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numMapInsets = C_AdventureMap.GetNumMapInsets()
```

### C_AdventureMap.GetNumQuestOffers

```lua
numQuestOffers = C_AdventureMap.GetNumQuestOffers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numQuestOffers` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numQuestOffers = C_AdventureMap.GetNumQuestOffers()
```

### C_AdventureMap.GetNumZoneChoices

```lua
numZoneChoices = C_AdventureMap.GetNumZoneChoices()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numZoneChoices` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numZoneChoices = C_AdventureMap.GetNumZoneChoices()
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

