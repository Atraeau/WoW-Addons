# ExpansionInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### ExpansionInfo.ClassicExpansionAtLeast

```lua
isAtLeast = ClassicExpansionAtLeast(expansionLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtLeast` | bool | no |  |

**Example**

```lua
local isAtLeast = ClassicExpansionAtLeast(0)
```

### ExpansionInfo.ClassicExpansionAtMost

```lua
isAtMost = ClassicExpansionAtMost(expansionLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAtMost` | bool | no |  |

**Example**

```lua
local isAtMost = ClassicExpansionAtMost(0)
```

### ExpansionInfo.GetClassicExpansionLevel

```lua
expansionLevel = GetClassicExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example**

```lua
local expansionLevel = GetClassicExpansionLevel()
```

