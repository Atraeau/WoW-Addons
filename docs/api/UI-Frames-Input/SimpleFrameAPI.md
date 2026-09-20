# SimpleFrameAPI

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**126** functions · **0** events · **2** types

## Functions

### SimpleFrameAPI.AbortDrag

```lua
AbortDrag()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
AbortDrag()
```

### SimpleFrameAPI.AddRoleset

Adds a roleset tag to this frame without removing existing ones.

```lua
AddRoleset(roleset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roleset` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddRoleset("")
```

### SimpleFrameAPI.CanChangeAttribute

```lua
canChangeAttributes = CanChangeAttribute()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canChangeAttributes` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canChangeAttributes = CanChangeAttribute()
```

### SimpleFrameAPI.ClearAlphaGradient

```lua
ClearAlphaGradient()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearAlphaGradient()
```

### SimpleFrameAPI.ClearAttribute

```lua
cleared = ClearAttribute(attributeName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attributeName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cleared` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cleared = ClearAttribute("")
```

### SimpleFrameAPI.ClearAttributes

```lua
ClearAttributes()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearAttributes()
```

### SimpleFrameAPI.CreateFontString

```lua
line = CreateFontString([name], [drawLayer], [templateName])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `line` | SimpleFontString | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local line = CreateFontString()
```

### SimpleFrameAPI.CreateLine

```lua
line = CreateLine([name], [drawLayer], [templateName], [subLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |
| `subLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `line` | SimpleLine | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local line = CreateLine()
```

### SimpleFrameAPI.CreateMaskTexture

```lua
maskTexture = CreateMaskTexture([name], [drawLayer], [templateName], [subLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |
| `subLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maskTexture` | SimpleMaskTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maskTexture = CreateMaskTexture()
```

### SimpleFrameAPI.CreateTexture

```lua
texture = CreateTexture([name], [drawLayer], [templateName], [subLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |
| `subLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `texture` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local texture = CreateTexture()
```

### SimpleFrameAPI.CreateVectorGraphics

```lua
vectorGraphics = CreateVectorGraphics([name], [drawLayer], [templateName], [subLevel])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |
| `subLevel` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vectorGraphics` | SimpleVectorGraphics | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local vectorGraphics = CreateVectorGraphics()
```

### SimpleFrameAPI.DesaturateHierarchy

```lua
DesaturateHierarchy(desaturation, excludeRoot)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `desaturation` | number | no |  |
| `excludeRoot` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
DesaturateHierarchy(0, false)
```

### SimpleFrameAPI.DisableDrawLayer

```lua
DisableDrawLayer(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
DisableDrawLayer(layer)
```

### SimpleFrameAPI.DoesClipChildren

```lua
clipsChildren = DoesClipChildren()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clipsChildren` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clipsChildren = DoesClipChildren()
```

### SimpleFrameAPI.DoesHyperlinkPropagateToParent

Returns whether hyperlink events (ex. OnHyperlinkEnter, OnHyperlinkLeave, OnHyperlinkClick) are propagated to this frame's parent.

```lua
canPropagate = DoesHyperlinkPropagateToParent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPropagate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canPropagate = DoesHyperlinkPropagateToParent()
```

### SimpleFrameAPI.EnableDrawLayer

```lua
EnableDrawLayer(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EnableDrawLayer(layer)
```

### SimpleFrameAPI.EnableGamePadButton

```lua
EnableGamePadButton(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EnableGamePadButton(false)
```

### SimpleFrameAPI.EnableGamePadStick

```lua
EnableGamePadStick(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EnableGamePadStick(false)
```

### SimpleFrameAPI.EnableKeyboard

```lua
EnableKeyboard(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EnableKeyboard(false)
```

### SimpleFrameAPI.ExecuteAttribute

```lua
success, returns = ExecuteAttribute(attributeName, [arguments])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attributeName` | cstring | no |  |
| `arguments` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `returns` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success, returns = ExecuteAttribute("")
```

### SimpleFrameAPI.GetAlpha

```lua
alpha = GetAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local alpha = GetAlpha()
```

### SimpleFrameAPI.GetAttribute

```lua
value = GetAttribute(attributeName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attributeName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = GetAttribute("")
```

### SimpleFrameAPI.GetBoundsRect

```lua
left, bottom, width, height = GetBoundsRect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |
| `width` | uiUnit | no |  |
| `height` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, bottom, width, height = GetBoundsRect()
```

### SimpleFrameAPI.GetChildren

```lua
children = GetChildren()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `children` | SimpleFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local children = GetChildren()
```

### SimpleFrameAPI.GetClampRectInsets

```lua
left, right, top, bottom = GetClampRectInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = GetClampRectInsets()
```

### SimpleFrameAPI.GetDontSavePosition

```lua
dontSave = GetDontSavePosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dontSave` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local dontSave = GetDontSavePosition()
```

### SimpleFrameAPI.GetEffectiveAlpha

```lua
effectiveAlpha = GetEffectiveAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveAlpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveAlpha = GetEffectiveAlpha()
```

### SimpleFrameAPI.GetEffectivelyFlattensRenderLayers

```lua
flatten = GetEffectivelyFlattensRenderLayers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flatten` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flatten = GetEffectivelyFlattensRenderLayers()
```

### SimpleFrameAPI.GetEffectiveScale

```lua
effectiveScale = GetEffectiveScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveScale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveScale = GetEffectiveScale()
```

### SimpleFrameAPI.GetFlattensRenderLayers

```lua
flatten = GetFlattensRenderLayers()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flatten` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local flatten = GetFlattensRenderLayers()
```

### SimpleFrameAPI.GetFrameLevel

```lua
frameLevel = GetFrameLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frameLevel = GetFrameLevel()
```

### SimpleFrameAPI.GetFrameStrata

```lua
strata = GetFrameStrata()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strata` | FrameStrata | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local strata = GetFrameStrata()
```

### SimpleFrameAPI.GetHighestFrameLevel

Returns the highest framelevel of the frame and its first order children, or all children if iterateAllChildren is true.

```lua
frameLevel = GetHighestFrameLevel(iterateAllChildren)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iterateAllChildren` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frameLevel = GetHighestFrameLevel(false)
```

### SimpleFrameAPI.GetHitRectInsets

```lua
left, right, top, bottom = GetHitRectInsets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = GetHitRectInsets()
```

### SimpleFrameAPI.GetHyperlinksEnabled

```lua
enabled = GetHyperlinksEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = GetHyperlinksEnabled()
```

### SimpleFrameAPI.GetID

```lua
id = GetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local id = GetID()
```

### SimpleFrameAPI.GetNumChildren

```lua
numChildren = GetNumChildren()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numChildren` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numChildren = GetNumChildren()
```

### SimpleFrameAPI.GetNumRegions

```lua
numRegions = GetNumRegions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRegions` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numRegions = GetNumRegions()
```

### SimpleFrameAPI.GetOnUpdateMode

Returns the currently configured OnUpdate script execution mode.

```lua
onUpdateMode = GetOnUpdateMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onUpdateMode` | OnUpdateMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local onUpdateMode = GetOnUpdateMode()
```

### SimpleFrameAPI.GetPropagateKeyboardInput

```lua
propagate = GetPropagateKeyboardInput()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `propagate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local propagate = GetPropagateKeyboardInput()
```

### SimpleFrameAPI.GetRaisedFrameLevel

```lua
frameLevel = GetRaisedFrameLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frameLevel = GetRaisedFrameLevel()
```

### SimpleFrameAPI.GetRegions

```lua
regions = GetRegions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `regions` | SimpleRegion | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local regions = GetRegions()
```

### SimpleFrameAPI.GetResizeBounds

```lua
minWidth, minHeight, maxWidth, maxHeight = GetResizeBounds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minWidth` | uiUnit | no |  |
| `minHeight` | uiUnit | no |  |
| `maxWidth` | uiUnit | no |  |
| `maxHeight` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minWidth, minHeight, maxWidth, maxHeight = GetResizeBounds()
```

### SimpleFrameAPI.GetRolesetNames

Returns the roleset tags assigned to this frame. Returns a list containing 'roleless' if none are assigned.

```lua
rolesets = GetRolesetNames()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rolesets` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rolesets = GetRolesetNames()
```

### SimpleFrameAPI.GetScale

```lua
frameScale = GetScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameScale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frameScale = GetScale()
```

### SimpleFrameAPI.GetWindow

```lua
window = GetWindow()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `window` | SimpleWindow | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local window = GetWindow()
```

### SimpleFrameAPI.HasAlphaGradient

```lua
hasAlphaGradient = HasAlphaGradient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAlphaGradient` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAlphaGradient = HasAlphaGradient()
```

### SimpleFrameAPI.HasFixedFrameLevel

```lua
isFixed = HasFixedFrameLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFixed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFixed = HasFixedFrameLevel()
```

### SimpleFrameAPI.HasFixedFrameStrata

```lua
isFixed = HasFixedFrameStrata()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFixed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFixed = HasFixedFrameStrata()
```

### SimpleFrameAPI.Hide

```lua
Hide()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Hide()
```

### SimpleFrameAPI.InterceptStartDrag

```lua
success = InterceptStartDrag(delegate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `delegate` | SimpleFrame | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = InterceptStartDrag(delegate)
```

### SimpleFrameAPI.IsClampedToScreen

```lua
clampedToScreen = IsClampedToScreen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clampedToScreen` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local clampedToScreen = IsClampedToScreen()
```

### SimpleFrameAPI.IsDrawLayerEnabled

```lua
isEnabled = IsDrawLayerEnabled(layer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = IsDrawLayerEnabled(layer)
```

### SimpleFrameAPI.IsEventRegistered

```lua
isRegistered, units = IsEventRegistered(eventName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRegistered` | bool | no |  |
| `units` | UnitTokenType | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRegistered, units = IsEventRegistered("")
```

### SimpleFrameAPI.IsFrameBuffer

```lua
isFrameBuffer = IsFrameBuffer()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFrameBuffer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isFrameBuffer = IsFrameBuffer()
```

### SimpleFrameAPI.IsGamePadButtonEnabled

```lua
enabled = IsGamePadButtonEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = IsGamePadButtonEnabled()
```

### SimpleFrameAPI.IsGamePadStickEnabled

```lua
enabled = IsGamePadStickEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = IsGamePadStickEnabled()
```

### SimpleFrameAPI.IsHighlightLocked

```lua
locked = IsHighlightLocked()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local locked = IsHighlightLocked()
```

### SimpleFrameAPI.IsIgnoringChildrenForBounds

```lua
ignore = IsIgnoringChildrenForBounds()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ignore = IsIgnoringChildrenForBounds()
```

### SimpleFrameAPI.IsIgnoringParentAlpha

```lua
ignore = IsIgnoringParentAlpha()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ignore = IsIgnoringParentAlpha()
```

### SimpleFrameAPI.IsIgnoringParentScale

```lua
ignore = IsIgnoringParentScale()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ignore = IsIgnoringParentScale()
```

### SimpleFrameAPI.IsKeyboardEnabled

```lua
enabled = IsKeyboardEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = IsKeyboardEnabled()
```

### SimpleFrameAPI.IsMovable

```lua
isMovable = IsMovable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMovable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMovable = IsMovable()
```

### SimpleFrameAPI.IsObjectLoaded

```lua
isLoaded = IsObjectLoaded()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLoaded` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLoaded = IsObjectLoaded()
```

### SimpleFrameAPI.IsResizable

```lua
resizable = IsResizable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resizable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local resizable = IsResizable()
```

### SimpleFrameAPI.IsRolesetFiltered

Returns whether this frame is hidden because of its rolesets being filtered.

```lua
isRolesetFiltered = IsRolesetFiltered()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRolesetFiltered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRolesetFiltered = IsRolesetFiltered()
```

### SimpleFrameAPI.IsShown

```lua
isShown = IsShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isShown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isShown = IsShown()
```

### SimpleFrameAPI.IsToplevel

```lua
isTopLevel = IsToplevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTopLevel` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTopLevel = IsToplevel()
```

### SimpleFrameAPI.IsUserPlaced

```lua
isUserPlaced = IsUserPlaced()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUserPlaced` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isUserPlaced = IsUserPlaced()
```

### SimpleFrameAPI.IsUsingParentLevel

```lua
usingParentLevel = IsUsingParentLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usingParentLevel` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local usingParentLevel = IsUsingParentLevel()
```

### SimpleFrameAPI.IsVisible

```lua
isVisible = IsVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVisible` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isVisible = IsVisible()
```

### SimpleFrameAPI.LockHighlight

```lua
LockHighlight()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
LockHighlight()
```

### SimpleFrameAPI.Lower

```lua
Lower()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Lower()
```

### SimpleFrameAPI.Raise

```lua
Raise()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Raise()
```

### SimpleFrameAPI.RegisterAllEvents

```lua
RegisterAllEvents()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterAllEvents()
```

### SimpleFrameAPI.RegisterEvent

```lua
registered = RegisterEvent(eventName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = RegisterEvent("")
```

### SimpleFrameAPI.RegisterEventCallback

```lua
registered = RegisterEventCallback(eventName, cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `cb` | FrameEventCallbackType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = RegisterEventCallback("", cb)
```

### SimpleFrameAPI.RegisterForDrag

```lua
RegisterForDrag(buttons)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttons` | MouseButton | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterForDrag(buttons)
```

### SimpleFrameAPI.RegisterUnitEvent

```lua
registered = RegisterUnitEvent(eventName, units)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `units` | UnitTokenType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = RegisterUnitEvent("", "player")
```

### SimpleFrameAPI.RegisterUnitEventCallback

```lua
registered = RegisterUnitEventCallback(eventName, cb, units)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `cb` | FrameEventCallbackType | no |  |
| `units` | UnitTokenType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = RegisterUnitEventCallback("", cb, "player")
```

### SimpleFrameAPI.RemoveRoleset

Removes a roleset tag from this frame.

```lua
RemoveRoleset(roleset)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `roleset` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RemoveRoleset("")
```

### SimpleFrameAPI.ResizeToBoundsRect

```lua
ResizeToBoundsRect()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ResizeToBoundsRect()
```

### SimpleFrameAPI.RotateTextures

```lua
RotateTextures(radians, x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `radians` | number | no |  |
| `x` | number | no | (default: 0.5) |
| `y` | number | no | (default: 0.5) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RotateTextures(0, 0, 0)
```

### SimpleFrameAPI.SetAlpha

```lua
SetAlpha(alpha)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alpha` | SingleColorValue | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlpha(alpha)
```

### SimpleFrameAPI.SetAlphaFromBoolean

```lua
SetAlphaFromBoolean(value, alphaIfTrue, alphaIfFalse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | bool | no |  |
| `alphaIfTrue` | SingleColorValue | no | (default: 255) |
| `alphaIfFalse` | SingleColorValue | no | (default: 0) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlphaFromBoolean(false, alphaIfTrue, alphaIfFalse)
```

### SimpleFrameAPI.SetAlphaGradient

```lua
SetAlphaGradient(index, gradient)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | no |  |
| `gradient` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAlphaGradient(1, gradient)
```

### SimpleFrameAPI.SetAttribute

```lua
SetAttribute(attributeName, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attributeName` | cstring | no |  |
| `value` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAttribute("", "")
```

### SimpleFrameAPI.SetAttributeNoHandler

```lua
SetAttributeNoHandler(attributeName, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `attributeName` | cstring | no |  |
| `value` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetAttributeNoHandler("", "")
```

### SimpleFrameAPI.SetClampedToScreen

```lua
SetClampedToScreen(clampedToScreen)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clampedToScreen` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetClampedToScreen(false)
```

### SimpleFrameAPI.SetClampRectInsets

```lua
SetClampRectInsets(left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetClampRectInsets(left, right, top, bottom)
```

### SimpleFrameAPI.SetClipsChildren

```lua
SetClipsChildren(clipsChildren)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `clipsChildren` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetClipsChildren(false)
```

### SimpleFrameAPI.SetDontSavePosition

```lua
SetDontSavePosition(dontSave)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `dontSave` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDontSavePosition(false)
```

### SimpleFrameAPI.SetDrawLayerEnabled

```lua
SetDrawLayerEnabled(layer, isEnabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layer` | DrawLayer | no |  |
| `isEnabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetDrawLayerEnabled(layer, false)
```

### SimpleFrameAPI.SetFixedFrameLevel

```lua
SetFixedFrameLevel(isFixed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFixed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFixedFrameLevel(false)
```

### SimpleFrameAPI.SetFixedFrameStrata

```lua
SetFixedFrameStrata(isFixed)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFixed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFixedFrameStrata(false)
```

### SimpleFrameAPI.SetFlattensRenderLayers

```lua
SetFlattensRenderLayers(flatten)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flatten` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFlattensRenderLayers(false)
```

### SimpleFrameAPI.SetFrameLevel

```lua
SetFrameLevel(frameLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFrameLevel(0)
```

### SimpleFrameAPI.SetFrameStrata

```lua
SetFrameStrata(strata)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `strata` | FrameStrata | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetFrameStrata(strata)
```

### SimpleFrameAPI.SetHighlightLocked

```lua
SetHighlightLocked(locked)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `locked` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHighlightLocked(false)
```

### SimpleFrameAPI.SetHitRectInsets

```lua
SetHitRectInsets(left, right, top, bottom)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | uiUnit | no |  |
| `right` | uiUnit | no |  |
| `top` | uiUnit | no |  |
| `bottom` | uiUnit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHitRectInsets(left, right, top, bottom)
```

### SimpleFrameAPI.SetHyperlinkPropagateToParent

Enables or disables propagating hyperlink events (ex. OnHyperlinkEnter, OnHyperlinkLeave, OnHyperlinkClick) to this frame's parent.

```lua
SetHyperlinkPropagateToParent(canPropagate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canPropagate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHyperlinkPropagateToParent(false)
```

### SimpleFrameAPI.SetHyperlinksEnabled

```lua
SetHyperlinksEnabled(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetHyperlinksEnabled(false)
```

### SimpleFrameAPI.SetID

```lua
SetID(id)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetID(0)
```

### SimpleFrameAPI.SetIgnoreParentAlpha

```lua
SetIgnoreParentAlpha(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIgnoreParentAlpha(false)
```

### SimpleFrameAPI.SetIgnoreParentScale

```lua
SetIgnoreParentScale(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIgnoreParentScale(false)
```

### SimpleFrameAPI.SetIgnoringChildrenForBounds

```lua
SetIgnoringChildrenForBounds(ignore)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ignore` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIgnoringChildrenForBounds(false)
```

### SimpleFrameAPI.SetIsFrameBuffer

```lua
SetIsFrameBuffer(isFrameBuffer)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isFrameBuffer` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetIsFrameBuffer(false)
```

### SimpleFrameAPI.SetMovable

```lua
SetMovable(movable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetMovable(false)
```

### SimpleFrameAPI.SetOnUpdateMode

Changes when OnUpdate scripts are executed for this object.

```lua
SetOnUpdateMode(onUpdateMode)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onUpdateMode` | OnUpdateMode | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetOnUpdateMode(onUpdateMode)
```

### SimpleFrameAPI.SetPropagateKeyboardInput

```lua
SetPropagateKeyboardInput(propagate)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `propagate` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetPropagateKeyboardInput(false)
```

### SimpleFrameAPI.SetResizable

```lua
SetResizable(resizable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resizable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetResizable(false)
```

### SimpleFrameAPI.SetResizeBounds

```lua
SetResizeBounds(minWidth, minHeight, [maxWidth], [maxHeight])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minWidth` | uiUnit | no |  |
| `minHeight` | uiUnit | no |  |
| `maxWidth` | uiUnit | yes |  |
| `maxHeight` | uiUnit | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetResizeBounds(minWidth, minHeight)
```

### SimpleFrameAPI.SetRolesets

Sets the roleset tags for this frame, used by the UI mode system to gate visibility. Supports comma-separated names to assign multiple rolesets. Pass nil to clear.

```lua
SetRolesets([rolesetsString])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rolesetsString` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRolesets()
```

### SimpleFrameAPI.SetScale

```lua
SetScale(scale)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scale` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetScale(0)
```

### SimpleFrameAPI.SetShown

```lua
SetShown(shown)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shown` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetShown(false)
```

### SimpleFrameAPI.SetToplevel

```lua
SetToplevel(topLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `topLevel` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToplevel(false)
```

### SimpleFrameAPI.SetUserPlaced

```lua
SetUserPlaced(userPlaced)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `userPlaced` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUserPlaced(false)
```

### SimpleFrameAPI.SetUsingParentLevel

```lua
SetUsingParentLevel(usingParentLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usingParentLevel` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetUsingParentLevel(false)
```

### SimpleFrameAPI.SetWindow

```lua
SetWindow([window])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `window` | SimpleWindow | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetWindow()
```

### SimpleFrameAPI.Show

```lua
Show()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Show()
```

### SimpleFrameAPI.StartMoving

```lua
StartMoving(alwaysStartFromMouse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `alwaysStartFromMouse` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
StartMoving(false)
```

### SimpleFrameAPI.StartSizing

```lua
StartSizing([resizePoint], alwaysStartFromMouse)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `resizePoint` | FramePoint | yes |  |
| `alwaysStartFromMouse` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
StartSizing(false)
```

### SimpleFrameAPI.StopMovingOrSizing

```lua
StopMovingOrSizing()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopMovingOrSizing()
```

### SimpleFrameAPI.UnlockHighlight

```lua
UnlockHighlight()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UnlockHighlight()
```

### SimpleFrameAPI.UnregisterAllEvents

```lua
UnregisterAllEvents()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UnregisterAllEvents()
```

### SimpleFrameAPI.UnregisterEvent

```lua
registered = UnregisterEvent(eventName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `registered` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local registered = UnregisterEvent("")
```

## Types

### CreateRegionParams (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `drawLayer` | DrawLayer | yes |  |
| `templateName` | cstring | yes |  |
| `subLevel` | number | yes |  |

### FrameEventCallbackType (CallbackType)

