# Input

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**29** functions · **1** events · **0** types

## Functions

### Input.GetCursorDelta

```lua
deltaX, deltaY = GetCursorDelta()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deltaX` | number | no |  |
| `deltaY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deltaX, deltaY = GetCursorDelta()
```

### Input.GetCursorPosition

```lua
posX, posY = GetCursorPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `posX` | number | no |  |
| `posY` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local posX, posY = GetCursorPosition()
```

### Input.GetMouseButtonClicked

```lua
buttonName = GetMouseButtonClicked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buttonName = GetMouseButtonClicked()
```

### Input.GetMouseButtonName

```lua
buttonName = GetMouseButtonName(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | mouseButton | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buttonName = GetMouseButtonName(button)
```

### Input.GetMouseFoci

```lua
region = GetMouseFoci()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `region` | ScriptRegion[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local region = GetMouseFoci()
```

### Input.GetStringFromModifiers

```lua
modifierString = GetStringFromModifiers(modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifiers` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifierString` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modifierString = GetStringFromModifiers(0)
```

### Input.IsAltKeyDown

```lua
down = IsAltKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsAltKeyDown()
```

### Input.IsControlKeyDown

```lua
down = IsControlKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsControlKeyDown()
```

### Input.IsKeyDown

```lua
down = IsKeyDown(keyOrMouseName, excludeBindingState)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keyOrMouseName` | cstring | no |  |
| `excludeBindingState` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsKeyDown("", false)
```

### Input.IsLeftAltKeyDown

```lua
down = IsLeftAltKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsLeftAltKeyDown()
```

### Input.IsLeftControlKeyDown

```lua
down = IsLeftControlKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsLeftControlKeyDown()
```

### Input.IsLeftMetaKeyDown

```lua
down = IsLeftMetaKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsLeftMetaKeyDown()
```

### Input.IsLeftShiftKeyDown

```lua
down = IsLeftShiftKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsLeftShiftKeyDown()
```

### Input.IsMetaKeyDown

```lua
down = IsMetaKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsMetaKeyDown()
```

### Input.IsModifierKeyDown

```lua
down = IsModifierKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsModifierKeyDown()
```

### Input.IsMouseButtonDown

```lua
down = IsMouseButtonDown([button])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | mouseButton | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsMouseButtonDown()
```

### Input.IsRightAltKeyDown

```lua
down = IsRightAltKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsRightAltKeyDown()
```

### Input.IsRightControlKeyDown

```lua
down = IsRightControlKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsRightControlKeyDown()
```

### Input.IsRightMetaKeyDown

```lua
down = IsRightMetaKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsRightMetaKeyDown()
```

### Input.IsRightShiftKeyDown

```lua
down = IsRightShiftKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsRightShiftKeyDown()
```

### Input.IsShiftKeyDown

```lua
down = IsShiftKeyDown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsShiftKeyDown()
```

### Input.IsUsingGamepad

```lua
down = IsUsingGamepad()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsUsingGamepad()
```

### Input.IsUsingMouse

```lua
down = IsUsingMouse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local down = IsUsingMouse()
```

### Input.MakeModifiers

```lua
modifiers = MakeModifiers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modifiers` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modifiers = MakeModifiers()
```

### Input.SetCursorPosition

Insecure code can only call this once in response to gamepad input hardware events.

```lua
SetCursorPosition(xPosition, yPosition)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `xPosition` | uiUnit | no |  |
| `yPosition` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetCursorPosition(xPosition, yPosition)
```

### Input.SimulateMouseClick

Effectively the same as SimulateMouseDown plus SimulateMouseUp and consumes limited input for both.

```lua
SimulateMouseClick(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | mouseButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SimulateMouseClick(button)
```

### Input.SimulateMouseDown

Insecure code can only call this once in response to gamepad input hardware events.

```lua
SimulateMouseDown(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | mouseButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SimulateMouseDown(button)
```

### Input.SimulateMouseUp

Insecure code can only call this once in response to gamepad input hardware events.

```lua
SimulateMouseUp(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | mouseButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SimulateMouseUp(button)
```

### Input.SimulateMouseWheel

Insecure code can only call this once in response to gamepad input hardware events.

```lua
SimulateMouseWheel(delta)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delta` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SimulateMouseWheel(0)
```

## Events

### INPUT_DEVICE_INTERFACE_TRANSITION

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newMode` | InputDeviceInterfaceType | no |  |
| `oldMode` | InputDeviceInterfaceType | no |  |

