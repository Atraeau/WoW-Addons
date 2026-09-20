# C_GenericWidgetDisplay

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **1** events · **1** types

## Functions

### C_GenericWidgetDisplay.Acknowledge

```lua
C_GenericWidgetDisplay.Acknowledge()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GenericWidgetDisplay.Acknowledge()
```

### C_GenericWidgetDisplay.Close

```lua
C_GenericWidgetDisplay.Close()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GenericWidgetDisplay.Close()
```

## Events

### GENERIC_WIDGET_DISPLAY_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | GenericWidgetDisplayFrameInfo | no |  |

## Types

### GenericWidgetDisplayFrameInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiWidgetSetID` | number | yes |  |
| `uiTextureKit` | textureKit | yes |  |
| `title` | string | yes |  |
| `frameWidth` | number | no |  |
| `frameHeight` | number | no |  |
| `extraButtonText` | string | yes |  |
| `closeButtonText` | string | yes |  |

