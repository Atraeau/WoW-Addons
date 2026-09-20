# SpecializationShared

[← API index](../README.md) · group: [Spells, Auras & Talents](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **0** events · **2** types

## Functions

### SpecializationShared.GetSpecializationInfoForClassID

```lua
id, name, description, icon, role, recommended, allowedForBoost, masterySpell1, masterySpell2 = GetSpecializationInfoForClassID(classID, index, [gender])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `classID` | number | no |  |
| `index` | luaIndex | no |  |
| `gender` | UnitSex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `description` | string | no |  |
| `icon` | fileID | no |  |
| `role` | cstring | no |  |
| `recommended` | bool | no |  |
| `allowedForBoost` | bool | no |  |
| `masterySpell1` | number | yes |  |
| `masterySpell2` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local id, name, description, icon, role, recommended, allowedForBoost, masterySpell1, masterySpell2 = GetSpecializationInfoForClassID(0, 1)
```

### SpecializationShared.GetSpecializationInfoForSpecID

```lua
id, name, description, icon, role, recommended, allowedForBoost, masterySpell1, masterySpell2 = GetSpecializationInfoForSpecID(specID, [gender])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `gender` | UnitSex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `description` | string | no |  |
| `icon` | fileID | no |  |
| `role` | cstring | no |  |
| `recommended` | bool | no |  |
| `allowedForBoost` | bool | no |  |
| `masterySpell1` | number | yes |  |
| `masterySpell2` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local id, name, description, icon, role, recommended, allowedForBoost, masterySpell1, masterySpell2 = GetSpecializationInfoForSpecID(0)
```

### SpecializationShared.GetSpecializationNameForSpecID

```lua
name = GetSpecializationNameForSpecID(specID, [gender])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `specID` | number | no |  |
| `gender` | UnitSex | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = GetSpecializationNameForSpecID(0)
```

### SpecializationShared.GetSpecializationSystem

```lua
system = GetSpecializationSystem()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `system` | SpecializationSystem | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local system = GetSpecializationSystem()
```

### SpecializationShared.HasLootSpecializations

```lua
hasLootSpecializations = HasLootSpecializations()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasLootSpecializations` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasLootSpecializations = HasLootSpecializations()
```

## Types

### SpecializationInfoResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `description` | string | no |  |
| `icon` | fileID | no |  |
| `role` | cstring | no |  |
| `recommended` | bool | no |  |
| `allowedForBoost` | bool | no |  |
| `masterySpell1` | number | yes |  |
| `masterySpell2` | number | yes |  |

### SpecializationSystem (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `TalentTab` | SpecializationSystem | no |  |
| `ChrSpecialization` | SpecializationSystem | no |  |

