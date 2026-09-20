# SimpleSliderAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**19** functions · **0** events · **0** types

## Functions

### SimpleSliderAPI.Disable

```lua
Disable()
```

**Example**

```lua
Disable()
```

### SimpleSliderAPI.Enable

```lua
Enable()
```

**Example**

```lua
Enable()
```

### SimpleSliderAPI.GetMinMaxValues

```lua
minValue, maxValue = GetMinMaxValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minValue` | number | no |  |
| `maxValue` | number | no |  |

**Example**

```lua
local minValue, maxValue = GetMinMaxValues()
```

### SimpleSliderAPI.GetObeyStepOnDrag

```lua
isObeyStepOnDrag = GetObeyStepOnDrag()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isObeyStepOnDrag` | bool | no |  |

**Example**

```lua
local isObeyStepOnDrag = GetObeyStepOnDrag()
```

### SimpleSliderAPI.GetOrientation

```lua
orientation = GetOrientation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orientation` | Orientation | no |  |

**Example**

```lua
local orientation = GetOrientation()
```

### SimpleSliderAPI.GetStepsPerPage

```lua
stepsPerPage = GetStepsPerPage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stepsPerPage` | number | no |  |

**Example**

```lua
local stepsPerPage = GetStepsPerPage()
```

### SimpleSliderAPI.GetThumbTexture

```lua
texture = GetThumbTexture()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example**

```lua
local texture = GetThumbTexture()
```

### SimpleSliderAPI.GetValue

```lua
value = GetValue()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |

**Example**

```lua
local value = GetValue()
```

### SimpleSliderAPI.GetValueStep

```lua
valueStep = GetValueStep()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valueStep` | number | no |  |

**Example**

```lua
local valueStep = GetValueStep()
```

### SimpleSliderAPI.IsDraggingThumb

```lua
isDraggingThumb = IsDraggingThumb()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDraggingThumb` | bool | no |  |

**Example**

```lua
local isDraggingThumb = IsDraggingThumb()
```

### SimpleSliderAPI.IsEnabled

```lua
enabled = IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsEnabled()
```

### SimpleSliderAPI.SetEnabled

```lua
SetEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
SetEnabled(false)
```

### SimpleSliderAPI.SetMinMaxValues

```lua
SetMinMaxValues(minValue, maxValue)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minValue` | number | no |  |
| `maxValue` | number | no |  |

**Example**

```lua
SetMinMaxValues(0, 0)
```

### SimpleSliderAPI.SetObeyStepOnDrag

```lua
SetObeyStepOnDrag(obeyStepOnDrag)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `obeyStepOnDrag` | bool | no |  |

**Example**

```lua
SetObeyStepOnDrag(false)
```

### SimpleSliderAPI.SetOrientation

```lua
SetOrientation(orientation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orientation` | Orientation | no |  |

**Example**

```lua
SetOrientation(orientation)
```

### SimpleSliderAPI.SetStepsPerPage

```lua
SetStepsPerPage(stepsPerPage)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stepsPerPage` | number | no |  |

**Example**

```lua
SetStepsPerPage(0)
```

### SimpleSliderAPI.SetThumbTexture

```lua
SetThumbTexture(asset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `asset` | TextureAsset | no |  |

**Example**

```lua
SetThumbTexture(asset)
```

### SimpleSliderAPI.SetValue

```lua
SetValue(value, treatAsMouseEvent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | number | no |  |
| `treatAsMouseEvent` | bool | no | (default: False) |

**Example**

```lua
SetValue(0, false)
```

### SimpleSliderAPI.SetValueStep

```lua
SetValueStep(valueStep)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `valueStep` | number | no |  |

**Example**

```lua
SetValueStep(0)
```

