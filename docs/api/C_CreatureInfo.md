# C_CreatureInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **0** events · **5** types

## Functions

### C_CreatureInfo.GetClassInfo

```lua
classInfo = C_CreatureInfo.GetClassInfo(classID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classInfo` | ClassInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local classInfo = C_CreatureInfo.GetClassInfo(0)
```

### C_CreatureInfo.GetCreatureFamilyIDs

```lua
creatureFamilyIDs = C_CreatureInfo.GetCreatureFamilyIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureFamilyIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureFamilyIDs = C_CreatureInfo.GetCreatureFamilyIDs()
```

### C_CreatureInfo.GetCreatureFamilyInfo

```lua
creatureFamilyInfo = C_CreatureInfo.GetCreatureFamilyInfo(creatureFamilyID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureFamilyID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureFamilyInfo` | CreatureFamilyInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureFamilyInfo = C_CreatureInfo.GetCreatureFamilyInfo(0)
```

### C_CreatureInfo.GetCreatureID

```lua
creatureID = C_CreatureInfo.GetCreatureID(creatureGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureID = C_CreatureInfo.GetCreatureID(UnitGUID("player"))
```

### C_CreatureInfo.GetCreatureTypeIDs

```lua
creatureTypeIDs = C_CreatureInfo.GetCreatureTypeIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureTypeIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureTypeIDs = C_CreatureInfo.GetCreatureTypeIDs()
```

### C_CreatureInfo.GetCreatureTypeInfo

```lua
creatureTypeInfo = C_CreatureInfo.GetCreatureTypeInfo(creatureTypeID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureTypeID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureTypeInfo` | CreatureTypeInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local creatureTypeInfo = C_CreatureInfo.GetCreatureTypeInfo(0)
```

### C_CreatureInfo.GetFactionInfo

```lua
factionInfo = C_CreatureInfo.GetFactionInfo(raceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionInfo` | FactionInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local factionInfo = C_CreatureInfo.GetFactionInfo(0)
```

### C_CreatureInfo.GetRaceInfo

```lua
raceInfo = C_CreatureInfo.GetRaceInfo(raceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceInfo` | RaceInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local raceInfo = C_CreatureInfo.GetRaceInfo(0)
```

## Types

### ClassInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `className` | string | no |  |
| `classFile` | string | no |  |
| `classID` | number | no |  |

### CreatureFamilyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `iconFile` | fileID | yes |  |

### CreatureTypeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |

### FactionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `groupTag` | cstring | no |  |

### RaceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raceName` | string | no |  |
| `clientFileString` | string | no |  |
| `raceID` | number | no |  |

