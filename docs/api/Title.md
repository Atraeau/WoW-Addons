# Title

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### Title.GetCurrentTitle

```lua
result = GetCurrentTitle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetCurrentTitle()
```

### Title.GetNumTitles

```lua
result = GetNumTitles()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | number | no |  |

**Example**

```lua
local result = GetNumTitles()
```

### Title.GetTitleName

```lua
titleString, playerTitle = GetTitleName(titleMaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleMaskID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleString` | string | no |  |
| `playerTitle` | bool | no |  |

**Example**

```lua
local titleString, playerTitle = GetTitleName(0)
```

### Title.IsTitleKnown

```lua
result = IsTitleKnown(titleMaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleMaskID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = IsTitleKnown(0)
```

### Title.SetCurrentTitle

```lua
SetCurrentTitle(titleMaskID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleMaskID` | number | no |  |

**Example**

```lua
SetCurrentTitle(0)
```

