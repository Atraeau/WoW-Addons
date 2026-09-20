# C_UI

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**7** functions · **2** events · **0** types

## Functions

### C_UI.DoesAnyDisplayHaveNotch

True if any display attached has a notch. This does not mean the current view intersects the notch.

```lua
notchPresent = C_UI.DoesAnyDisplayHaveNotch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `notchPresent` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local notchPresent = C_UI.DoesAnyDisplayHaveNotch()
```

### C_UI.GetTopLeftNotchSafeRegion

Region of screen left of screen notch. Zeros if no notch.

```lua
left, right, top, bottom = C_UI.GetTopLeftNotchSafeRegion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no |  |
| `right` | number | no |  |
| `top` | number | no |  |
| `bottom` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = C_UI.GetTopLeftNotchSafeRegion()
```

### C_UI.GetTopRightNotchSafeRegion

Region of screen right of screen notch. Zeros if no notch.

```lua
left, right, top, bottom = C_UI.GetTopRightNotchSafeRegion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `left` | number | no |  |
| `right` | number | no |  |
| `top` | number | no |  |
| `bottom` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local left, right, top, bottom = C_UI.GetTopRightNotchSafeRegion()
```

### C_UI.GetUIParent

```lua
uiParent = C_UI.GetUIParent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiParent` | SimpleFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiParent = C_UI.GetUIParent()
```

### C_UI.GetWorldFrame

```lua
worldFrame = C_UI.GetWorldFrame()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `worldFrame` | SimpleFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local worldFrame = C_UI.GetWorldFrame()
```

### C_UI.Reload

```lua
C_UI.Reload()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_UI.Reload()
```

### C_UI.ShouldUIParentAvoidNotch

UIParent will shift down to avoid notch if true. This does not mean there is a notch.

```lua
willAvoidNotch = C_UI.ShouldUIParentAvoidNotch()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `willAvoidNotch` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local willAvoidNotch = C_UI.ShouldUIParentAvoidNotch()
```

## Events

### NOTCHED_DISPLAY_MODE_CHANGED

### UI_SCALE_CHANGED

