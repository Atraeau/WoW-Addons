# FrameAPIQuestPOI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### FrameAPIQuestPOI.GetNumTooltips

```lua
numObjectives = GetNumTooltips()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numObjectives` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numObjectives = GetNumTooltips()
```

### FrameAPIQuestPOI.GetTooltipIndex

```lua
objectiveIndex = GetTooltipIndex(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectiveIndex` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local objectiveIndex = GetTooltipIndex(1)
```

### FrameAPIQuestPOI.UpdateMouseOverTooltip

```lua
questID, numObjectives = UpdateMouseOverTooltip(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `questID` | number | yes |  |
| `numObjectives` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local questID, numObjectives = UpdateMouseOverTooltip(0, 0)
```

