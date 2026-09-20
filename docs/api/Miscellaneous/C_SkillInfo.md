# C_SkillInfo

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**8** functions · **1** events · **1** types

## Functions

### C_SkillInfo.AbandonSkill

```lua
C_SkillInfo.AbandonSkill(skillLineID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SkillInfo.AbandonSkill(0)
```

### C_SkillInfo.CollapseSkillHeader

```lua
C_SkillInfo.CollapseSkillHeader(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SkillInfo.CollapseSkillHeader(1)
```

### C_SkillInfo.ExpandSkillHeader

```lua
C_SkillInfo.ExpandSkillHeader(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SkillInfo.ExpandSkillHeader(1)
```

### C_SkillInfo.GetNumSkillLines

```lua
numSkillLines = C_SkillInfo.GetNumSkillLines()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSkillLines` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numSkillLines = C_SkillInfo.GetNumSkillLines()
```

### C_SkillInfo.GetSelectedSkill

```lua
index = C_SkillInfo.GetSelectedSkill()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local index = C_SkillInfo.GetSelectedSkill()
```

### C_SkillInfo.GetSkillLineInfo

```lua
skillLineAttributes = C_SkillInfo.GetSkillLineInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAttributes` | SkillLineAttributes | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineAttributes = C_SkillInfo.GetSkillLineInfo(1)
```

### C_SkillInfo.GetSkillLineInfoByID

```lua
skillLineAttributes = C_SkillInfo.GetSkillLineInfoByID(ID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillLineAttributes` | SkillLineAttributes | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local skillLineAttributes = C_SkillInfo.GetSkillLineInfoByID(0)
```

### C_SkillInfo.SetSelectedSkill

```lua
C_SkillInfo.SetSelectedSkill(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SkillInfo.SetSelectedSkill(1)
```

## Events

### SKILL_LINES_CHANGED

## Types

### SkillLineAttributes (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `skillID` | number | no |  |
| `name` | cstring | no |  |
| `isHeader` | bool | no |  |
| `isCollapsed` | bool | no |  |
| `rank` | number | no |  |
| `tempPoints` | number | no |  |
| `modifier` | number | no |  |
| `maxRank` | number | no |  |
| `isAbandonable` | bool | no |  |
| `stepCost` | number | no |  |
| `rankCost` | number | no |  |
| `minLevel` | number | no |  |
| `costType` | number | no |  |
| `parentSkillLineID` | number | no |  |
| `skillLineCategoryID` | number | no |  |
| `description` | cstring | no |  |

