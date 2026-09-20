# SimpleScriptRegionAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**55** functions · **0** events · **0** types

## Functions

### SimpleScriptRegionAPI.CanChangeProtectedState

```lua
canChange = CanChangeProtectedState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChange` | bool | no |  |

**Example**

```lua
local canChange = CanChangeProtectedState()
```

### SimpleScriptRegionAPI.CanPropagateMouseClicks

```lua
canPropagate = CanPropagateMouseClicks()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPropagate` | bool | no |  |

**Example**

```lua
local canPropagate = CanPropagateMouseClicks()
```

### SimpleScriptRegionAPI.CanPropagateMouseMotion

```lua
canPropagate = CanPropagateMouseMotion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPropagate` | bool | no |  |

**Example**

```lua
local canPropagate = CanPropagateMouseMotion()
```

### SimpleScriptRegionAPI.ClearScripts

Remove all script handlers set through Scripts in XML or SetScript in Lua

```lua
ClearScripts()
```

**Example**

```lua
ClearScripts()
```

### SimpleScriptRegionAPI.CollapsesLayout

```lua
collapsesLayout = CollapsesLayout()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collapsesLayout` | bool | no |  |

**Example**

```lua
local collapsesLayout = CollapsesLayout()
```

### SimpleScriptRegionAPI.EnableMouse

```lua
EnableMouse(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
EnableMouse(false)
```

### SimpleScriptRegionAPI.EnableMouseMotion

```lua
EnableMouseMotion(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
EnableMouseMotion(false)
```

### SimpleScriptRegionAPI.EnableMouseWheel

```lua
EnableMouseWheel(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example**

```lua
EnableMouseWheel(false)
```

### SimpleScriptRegionAPI.FocusEnter

```lua
FocusEnter(fromMouseMotion)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fromMouseMotion` | bool | no | (default: True) |

**Example**

```lua
FocusEnter(false)
```

### SimpleScriptRegionAPI.FocusExit

```lua
FocusExit(fromMouseMotion)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fromMouseMotion` | bool | no | (default: True) |

**Example**

```lua
FocusExit(false)
```

### SimpleScriptRegionAPI.GetBottom

```lua
bottom = GetBottom()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bottom` | uiUnit | no |  |

**Example**

```lua
local bottom = GetBottom()
```

### SimpleScriptRegionAPI.GetCenter

```lua
x, y = GetCenter()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | uiUnit | no |  |
| `y` | uiUnit | no |  |

**Example**

```lua
local x, y = GetCenter()
```

### SimpleScriptRegionAPI.GetHeight

```lua
height = GetHeight(ignoreRect)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreRect` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | uiUnit | no |  |

**Example**

```lua
local height = GetHeight(false)
```

### SimpleScriptRegionAPI.GetLeft

```lua
left = GetLeft()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |

**Example**

```lua
local left = GetLeft()
```

### SimpleScriptRegionAPI.GetRect

```lua
left, bottom, width, height = GetRect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example**

```lua
local left, bottom, width, height = GetRect()
```

### SimpleScriptRegionAPI.GetRight

```lua
right = GetRight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `right` | uiUnit | no |  |

**Example**

```lua
local right = GetRight()
```

### SimpleScriptRegionAPI.GetRoundLayoutToNearestPixel

```lua
enabled = GetRoundLayoutToNearestPixel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = GetRoundLayoutToNearestPixel()
```

### SimpleScriptRegionAPI.GetScaledRect

```lua
left, bottom, width, height = GetScaledRect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example**

```lua
local left, bottom, width, height = GetScaledRect()
```

### SimpleScriptRegionAPI.GetScript

```lua
script = GetScript(scriptTypeName, bindingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `bindingType` | ScriptBindingType | no | (default: Extrinsic) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `script` | LuaFunctionReference | no |  |

**Example**

```lua
local script = GetScript(scriptTypeName, bindingType)
```

### SimpleScriptRegionAPI.GetSize

```lua
width, height = GetSize(ignoreRect)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreRect` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example**

```lua
local width, height = GetSize(false)
```

### SimpleScriptRegionAPI.GetSourceLocation

```lua
location = GetSourceLocation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `location` | string | no |  |

**Example**

```lua
local location = GetSourceLocation()
```

### SimpleScriptRegionAPI.GetTop

```lua
top = GetTop()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `top` | uiUnit | no |  |

**Example**

```lua
local top = GetTop()
```

### SimpleScriptRegionAPI.GetWidth

```lua
width = GetWidth(ignoreRect)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignoreRect` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `width` | uiUnit | no |  |

**Example**

```lua
local width = GetWidth(false)
```

### SimpleScriptRegionAPI.HasScript

```lua
hasScript = HasScript(scriptName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasScript` | bool | no |  |

**Example**

```lua
local hasScript = HasScript("")
```

### SimpleScriptRegionAPI.Hide

```lua
Hide()
```

**Example**

```lua
Hide()
```

### SimpleScriptRegionAPI.HookScript

```lua
success = HookScript(scriptTypeName, script, bindingType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `script` | LuaFunctionReference | no |  |
| `bindingType` | ScriptBindingType | no | (default: Extrinsic) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = HookScript(scriptTypeName, script, bindingType)
```

### SimpleScriptRegionAPI.Intersects

```lua
intersects = Intersects(region)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `region` | ScriptRegion | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `intersects` | bool | no |  |

**Example**

```lua
local intersects = Intersects(region)
```

### SimpleScriptRegionAPI.IsAnchoringRestricted

```lua
isRestricted = IsAnchoringRestricted()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRestricted` | bool | no |  |

**Example**

```lua
local isRestricted = IsAnchoringRestricted()
```

### SimpleScriptRegionAPI.IsAnchoringSecret

```lua
isSecret = IsAnchoringSecret()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSecret` | bool | no |  |

**Example**

```lua
local isSecret = IsAnchoringSecret()
```

### SimpleScriptRegionAPI.IsCollapsed

```lua
isCollapsed = IsCollapsed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCollapsed` | bool | no |  |

**Example**

```lua
local isCollapsed = IsCollapsed()
```

### SimpleScriptRegionAPI.IsDragging

```lua
isDragging = IsDragging()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDragging` | bool | no |  |

**Example**

```lua
local isDragging = IsDragging()
```

### SimpleScriptRegionAPI.IsMouseClickEnabled

```lua
enabled = IsMouseClickEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsMouseClickEnabled()
```

### SimpleScriptRegionAPI.IsMouseEnabled

```lua
enabled = IsMouseEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsMouseEnabled()
```

### SimpleScriptRegionAPI.IsMouseMotionEnabled

```lua
enabled = IsMouseMotionEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsMouseMotionEnabled()
```

### SimpleScriptRegionAPI.IsMouseMotionFocus

```lua
isMouseMotionFocus = IsMouseMotionFocus()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMouseMotionFocus` | bool | no |  |

**Example**

```lua
local isMouseMotionFocus = IsMouseMotionFocus()
```

### SimpleScriptRegionAPI.IsMouseOver

```lua
isMouseOver = IsMouseOver(offsetTop, offsetBottom, offsetLeft, offsetRight)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `offsetTop` | uiUnit | no | (default: 0) |
| `offsetBottom` | uiUnit | no | (default: 0) |
| `offsetLeft` | uiUnit | no | (default: 0) |
| `offsetRight` | uiUnit | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMouseOver` | bool | no |  |

**Example**

```lua
local isMouseOver = IsMouseOver(offsetTop, offsetBottom, offsetLeft, offsetRight)
```

### SimpleScriptRegionAPI.IsMouseWheelEnabled

```lua
enabled = IsMouseWheelEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = IsMouseWheelEnabled()
```

### SimpleScriptRegionAPI.IsProtected

```lua
isProtected, isProtectedExplicitly = IsProtected()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isProtected` | bool | no |  |
| `isProtectedExplicitly` | bool | no |  |

**Example**

```lua
local isProtected, isProtectedExplicitly = IsProtected()
```

### SimpleScriptRegionAPI.IsRectValid

```lua
isValid = IsRectValid()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example**

```lua
local isValid = IsRectValid()
```

### SimpleScriptRegionAPI.IsShown

```lua
isShown = IsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isShown` | bool | no |  |

**Example**

```lua
local isShown = IsShown()
```

### SimpleScriptRegionAPI.IsVisible

```lua
isVisible = IsVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example**

```lua
local isVisible = IsVisible()
```

### SimpleScriptRegionAPI.MouseDown

```lua
MouseDown(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no | (default: LeftButton) |

**Example**

```lua
MouseDown("")
```

### SimpleScriptRegionAPI.MouseUp

```lua
MouseUp(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no | (default: LeftButton) |

**Example**

```lua
MouseUp("")
```

### SimpleScriptRegionAPI.SetCollapsesLayout

```lua
SetCollapsesLayout(collapsesLayout)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `collapsesLayout` | bool | no |  |

**Example**

```lua
SetCollapsesLayout(false)
```

### SimpleScriptRegionAPI.SetMouseClickEnabled

```lua
SetMouseClickEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example**

```lua
SetMouseClickEnabled(false)
```

### SimpleScriptRegionAPI.SetMouseMotionEnabled

```lua
SetMouseMotionEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example**

```lua
SetMouseMotionEnabled(false)
```

### SimpleScriptRegionAPI.SetParent

```lua
SetParent([parent])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parent` | SimpleFrame | yes |  |

**Example**

```lua
SetParent()
```

### SimpleScriptRegionAPI.SetPassThroughButtons

```lua
SetPassThroughButtons(buttons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttons` | MouseButton | no |  |

**Example**

```lua
SetPassThroughButtons(buttons)
```

### SimpleScriptRegionAPI.SetPropagateMouseClicks

```lua
SetPropagateMouseClicks(propagate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `propagate` | bool | no |  |

**Example**

```lua
SetPropagateMouseClicks(false)
```

### SimpleScriptRegionAPI.SetPropagateMouseMotion

```lua
SetPropagateMouseMotion(propagate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `propagate` | bool | no |  |

**Example**

```lua
SetPropagateMouseMotion(false)
```

### SimpleScriptRegionAPI.SetRoundLayoutToNearestPixel

```lua
SetRoundLayoutToNearestPixel(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
SetRoundLayoutToNearestPixel(false)
```

### SimpleScriptRegionAPI.SetScript

```lua
SetScript(scriptTypeName, [script])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptTypeName` | ScriptTypeName | no |  |
| `script` | LuaFunctionReference | yes |  |

**Example**

```lua
SetScript(scriptTypeName)
```

### SimpleScriptRegionAPI.SetShown

```lua
SetShown(show)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `show` | bool | no | (default: False) |

**Example**

```lua
SetShown(false)
```

### SimpleScriptRegionAPI.ShouldButtonPassThrough

```lua
shouldPassThrough = ShouldButtonPassThrough(button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | MouseButton | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shouldPassThrough` | bool | no |  |

**Example**

```lua
local shouldPassThrough = ShouldButtonPassThrough(button)
```

### SimpleScriptRegionAPI.Show

```lua
Show()
```

**Example**

```lua
Show()
```

