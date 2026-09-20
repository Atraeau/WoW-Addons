# C_PetBattles

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### C_PetBattles.GetBreedQuality

```lua
quality = C_PetBattles.GetBreedQuality(petOwner, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petOwner` | BattlePetOwner | no |  |
| `slot` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | BattlePetBreedQuality | no |  |

**Example**

```lua
local quality = C_PetBattles.GetBreedQuality(petOwner, 1)
```

### C_PetBattles.GetIcon

```lua
iconFileID = C_PetBattles.GetIcon(petOwner, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petOwner` | BattlePetOwner | no |  |
| `slot` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFileID` | fileID | no |  |

**Example**

```lua
local iconFileID = C_PetBattles.GetIcon(petOwner, 1)
```

### C_PetBattles.GetName

```lua
customName, speciesName = C_PetBattles.GetName(petOwner, slot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petOwner` | BattlePetOwner | no |  |
| `slot` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customName` | string | no |  |
| `speciesName` | string | no |  |

**Example**

```lua
local customName, speciesName = C_PetBattles.GetName(petOwner, 1)
```

### C_PetBattles.IsPlayerNPC

```lua
isPlayerNPC = C_PetBattles.IsPlayerNPC()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlayerNPC` | bool | no |  |

**Example**

```lua
local isPlayerNPC = C_PetBattles.IsPlayerNPC()
```

### C_PetBattles.IsWildBattle

```lua
isWildBattle = C_PetBattles.IsWildBattle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWildBattle` | bool | no |  |

**Example**

```lua
local isWildBattle = C_PetBattles.IsWildBattle()
```

