# C_AlliedRaces

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **2** events · **2** types

## Functions

### C_AlliedRaces.GetAllRacialAbilitiesFromID

```lua
allDisplayInfo = C_AlliedRaces.GetAllRacialAbilitiesFromID(raceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `allDisplayInfo` | AlliedRaceRacialAbility[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local allDisplayInfo = C_AlliedRaces.GetAllRacialAbilitiesFromID(0)
```

### C_AlliedRaces.GetRaceInfoByID

```lua
info = C_AlliedRaces.GetRaceInfoByID(raceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | AlliedRaceInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_AlliedRaces.GetRaceInfoByID(0)
```

## Events

### ALLIED_RACE_CLOSE

### ALLIED_RACE_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |

## Types

### AlliedRaceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |
| `maleModelID` | number | no |  |
| `femaleModelID` | number | no |  |
| `achievementIds` | number[] | no |  |
| `maleName` | cstring | no |  |
| `femaleName` | cstring | no |  |
| `description` | cstring | no |  |
| `raceFileString` | cstring | no |  |
| `crestAtlas` | textureAtlas | no |  |
| `modelBackgroundAtlas` | textureAtlas | no |  |
| `bannerColor` | colorRGB | no |  |

### AlliedRaceRacialAbility (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |
| `name` | cstring | no |  |
| `icon` | fileID | no |  |

