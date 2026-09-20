# FrameAPIScenarioPOI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **0** types

## Functions

### FrameAPIScenarioPOI.GetScenarioTooltipText

```lua
tooltipText = GetScenarioTooltipText()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tooltipText` | cstring | yes |  |

**Example**

```lua
local tooltipText = GetScenarioTooltipText()
```

### FrameAPIScenarioPOI.UpdateMouseOverTooltip

```lua
hasTooltip = UpdateMouseOverTooltip(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTooltip` | bool | no |  |

**Example**

```lua
local hasTooltip = UpdateMouseOverTooltip(0, 0)
```

