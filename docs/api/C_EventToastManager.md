# C_EventToastManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **2** events · **1** types

## Functions

### C_EventToastManager.GetLevelUpDisplayToastsFromLevel

```lua
toastInfo = C_EventToastManager.GetLevelUpDisplayToastsFromLevel(level)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `level` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `toastInfo` | EventToastInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local toastInfo = C_EventToastManager.GetLevelUpDisplayToastsFromLevel(0)
```

### C_EventToastManager.GetNextToastToDisplay

```lua
toastInfo = C_EventToastManager.GetNextToastToDisplay()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `toastInfo` | EventToastInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local toastInfo = C_EventToastManager.GetNextToastToDisplay()
```

### C_EventToastManager.RemoveCurrentToast

```lua
C_EventToastManager.RemoveCurrentToast()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_EventToastManager.RemoveCurrentToast()
```

## Events

### DISPLAY_EVENT_TOAST_LINK

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `link` | string | no |  |

### DISPLAY_EVENT_TOASTS

## Types

### EventToastInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventToastID` | number | no |  |
| `title` | string | no |  |
| `subtitle` | string | no |  |
| `instructionText` | string | no |  |
| `iconFileID` | fileID | no |  |
| `subIcon` | textureAtlas | yes |  |
| `link` | string | no |  |
| `qualityString` | string | yes |  |
| `quality` | number | yes |  |
| `eventType` | EventToastEventType | no |  |
| `displayType` | EventToastDisplayType | no |  |
| `uiTextureKit` | textureKit | no |  |
| `sortOrder` | number | no |  |
| `time` | number | yes |  |
| `uiWidgetSetID` | number | yes |  |
| `extraUiWidgetSetID` | number | yes |  |
| `titleTooltip` | string | yes |  |
| `subtitleTooltip` | string | yes |  |
| `titleTooltipUiWidgetSetID` | number | yes |  |
| `subtitleTooltipUiWidgetSetID` | number | yes |  |
| `showSoundKitID` | number | yes |  |
| `hideSoundKitID` | number | yes |  |
| `colorTint` | colorRGB | yes |  |
| `flags` | number | no |  |

