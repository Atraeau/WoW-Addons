# C_InvasionInfo

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **0** events · **1** types

## Functions

### C_InvasionInfo.AreInvasionsAvailable

Returns true if invasions are active in the same physical area as the player.

```lua
areInvasionsAvailable = C_InvasionInfo.AreInvasionsAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areInvasionsAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areInvasionsAvailable = C_InvasionInfo.AreInvasionsAvailable()
```

### C_InvasionInfo.GetInvasionForUiMapID

```lua
invasionID = C_InvasionInfo.GetInvasionForUiMapID(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invasionID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invasionID = C_InvasionInfo.GetInvasionForUiMapID(0)
```

### C_InvasionInfo.GetInvasionInfo

```lua
invasionInfo = C_InvasionInfo.GetInvasionInfo(invasionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invasionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invasionInfo` | InvasionMapInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local invasionInfo = C_InvasionInfo.GetInvasionInfo(0)
```

### C_InvasionInfo.GetInvasionTimeLeft

```lua
timeLeftMinutes = C_InvasionInfo.GetInvasionTimeLeft(invasionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invasionID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `timeLeftMinutes` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local timeLeftMinutes = C_InvasionInfo.GetInvasionTimeLeft(0)
```

## Types

### InvasionMapInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `invasionID` | number | no |  |
| `name` | string | no |  |
| `position` | vector2 | no |  |
| `atlasName` | textureAtlas | no |  |
| `rewardQuestID` | number | yes |  |

