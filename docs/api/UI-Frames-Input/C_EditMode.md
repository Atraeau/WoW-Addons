# C_EditMode

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**12** functions · **1** events · **5** types

## Functions

### C_EditMode.ConvertLayoutInfoToString

```lua
layoutInfoAsString = C_EditMode.ConvertLayoutInfoToString(layoutInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfo` | EditModeLayoutInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfoAsString` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layoutInfoAsString = C_EditMode.ConvertLayoutInfoToString(layoutInfo)
```

### C_EditMode.ConvertStringToLayoutInfo

```lua
layoutInfo = C_EditMode.ConvertStringToLayoutInfo(layoutInfoAsString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfoAsString` | string | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfo` | EditModeLayoutInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layoutInfo = C_EditMode.ConvertStringToLayoutInfo("")
```

### C_EditMode.GetAccountSettings

```lua
accountSettings = C_EditMode.GetAccountSettings()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `accountSettings` | EditModeSettingInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local accountSettings = C_EditMode.GetAccountSettings()
```

### C_EditMode.GetEditModeDefaultLayout

```lua
defaultLayout = C_EditMode.GetEditModeDefaultLayout()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultLayout` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local defaultLayout = C_EditMode.GetEditModeDefaultLayout()
```

### C_EditMode.GetLayouts

```lua
layoutInfo = C_EditMode.GetLayouts()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfo` | EditModeLayouts | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local layoutInfo = C_EditMode.GetLayouts()
```

### C_EditMode.IsValidLayoutName

```lua
isApproved = C_EditMode.IsValidLayoutName(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isApproved` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isApproved = C_EditMode.IsValidLayoutName("")
```

### C_EditMode.OnEditModeExit

```lua
C_EditMode.OnEditModeExit()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.OnEditModeExit()
```

### C_EditMode.OnLayoutAdded

```lua
C_EditMode.OnLayoutAdded(addedLayoutIndex, activateNewLayout, isLayoutImported)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `addedLayoutIndex` | luaIndex | no |  |
| `activateNewLayout` | bool | no |  |
| `isLayoutImported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.OnLayoutAdded(1, false, false)
```

### C_EditMode.OnLayoutDeleted

```lua
C_EditMode.OnLayoutDeleted(deletedLayoutIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deletedLayoutIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.OnLayoutDeleted(1)
```

### C_EditMode.SaveLayouts

```lua
C_EditMode.SaveLayouts(saveInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `saveInfo` | EditModeLayouts | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.SaveLayouts(saveInfo)
```

### C_EditMode.SetAccountSetting

```lua
C_EditMode.SetAccountSetting(setting, value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | EditModeAccountSetting | no |  |
| `value` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.SetAccountSetting(setting, 0)
```

### C_EditMode.SetActiveLayout

```lua
C_EditMode.SetActiveLayout(activeLayout)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeLayout` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EditMode.SetActiveLayout(1)
```

## Events

### EDIT_MODE_LAYOUTS_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutInfo` | EditModeLayouts | no |  |
| `reconcileLayouts` | bool | no |  |

## Types

### EditModeAnchorInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `point` | FramePoint | no |  |
| `relativeTo` | string | no |  |
| `relativePoint` | FramePoint | no |  |
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |

### EditModeLayoutInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutName` | string | no |  |
| `layoutType` | EditModeLayoutType | no |  |
| `systems` | EditModeSystemInfo[] | no |  |

### EditModeLayouts (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layouts` | EditModeLayoutInfo[] | no |  |
| `activeLayout` | luaIndex | no |  |

### EditModeSettingInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setting` | number | no |  |
| `value` | number | no |  |

### EditModeSystemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `system` | EditModeSystem | no |  |
| `systemIndex` | luaIndex | yes |  |
| `anchorInfo` | EditModeAnchorInfo | no |  |
| `anchorInfo2` | EditModeAnchorInfo | yes |  |
| `settings` | EditModeSettingInfo[] | no |  |
| `isInDefaultPosition` | bool | no |  |

