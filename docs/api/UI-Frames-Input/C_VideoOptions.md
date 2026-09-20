# C_VideoOptions

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**11** functions · **9** events · **2** types

## Functions

### C_VideoOptions.AreHighResTexturesAvailable

```lua
areAvailable = C_VideoOptions.AreHighResTexturesAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `areAvailable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local areAvailable = C_VideoOptions.AreHighResTexturesAvailable()
```

### C_VideoOptions.GetCurrentGameWindowSize

```lua
size = C_VideoOptions.GetCurrentGameWindowSize()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `size` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local size = C_VideoOptions.GetCurrentGameWindowSize()
```

### C_VideoOptions.GetDefaultGameWindowSize

```lua
size = C_VideoOptions.GetDefaultGameWindowSize(monitor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `monitor` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `size` | vector2 | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local size = C_VideoOptions.GetDefaultGameWindowSize(0)
```

### C_VideoOptions.GetGameWindowSizes

```lua
sizes = C_VideoOptions.GetGameWindowSizes(monitor, fullscreen)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `monitor` | number | no |  |
| `fullscreen` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sizes` | vector2[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local sizes = C_VideoOptions.GetGameWindowSizes(0, false)
```

### C_VideoOptions.GetGxAdapterInfo

```lua
adapters = C_VideoOptions.GetGxAdapterInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `adapters` | GxAdapterInfoDetails[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local adapters = C_VideoOptions.GetGxAdapterInfo()
```

### C_VideoOptions.IsLinearEnabledOnStart

```lua
isEnabled = C_VideoOptions.IsLinearEnabledOnStart()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_VideoOptions.IsLinearEnabledOnStart()
```

### C_VideoOptions.IsOutlineModeSupported

```lua
isSupported = C_VideoOptions.IsOutlineModeSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSupported = C_VideoOptions.IsOutlineModeSupported()
```

### C_VideoOptions.IsPBRWaterSupported

```lua
isSupported = C_VideoOptions.IsPBRWaterSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSupported = C_VideoOptions.IsPBRWaterSupported()
```

### C_VideoOptions.IsSecondaryLightingSupported

```lua
isSupported = C_VideoOptions.IsSecondaryLightingSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSupported = C_VideoOptions.IsSecondaryLightingSupported()
```

### C_VideoOptions.IsSpellVisualDensitySystemSupported

```lua
isSupported = C_VideoOptions.IsSpellVisualDensitySystemSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSupported` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSupported = C_VideoOptions.IsSpellVisualDensitySystemSupported()
```

### C_VideoOptions.SetGameWindowSize

```lua
C_VideoOptions.SetGameWindowSize(x, y)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_VideoOptions.SetGameWindowSize(0, 0)
```

## Events

### ADAPTER_LIST_CHANGED

### DISPLAY_SIZE_CHANGED

### GLUE_SCREENSHOT_FAILED

### GLUE_SCREENSHOT_STARTED

### GLUE_SCREENSHOT_SUCCEEDED

### GX_RESTARTED

### SCREENSHOT_FAILED

### SCREENSHOT_STARTED

### SCREENSHOT_SUCCEEDED

## Types

### GraphicsValidationResult (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Supported` | GraphicsValidationResult | no |  |
| `Illegal` | GraphicsValidationResult | no |  |
| `Unsupported` | GraphicsValidationResult | no |  |
| `Graphics` | GraphicsValidationResult | no |  |
| `DualCore` | GraphicsValidationResult | no |  |
| `QuadCore` | GraphicsValidationResult | no |  |
| `CpuMem_2` | GraphicsValidationResult | no |  |
| `CpuMem_4` | GraphicsValidationResult | no |  |
| `CpuMem_8` | GraphicsValidationResult | no |  |
| `Needs_5_0` | GraphicsValidationResult | no |  |
| `Needs_6_0` | GraphicsValidationResult | no |  |
| `NeedsRt` | GraphicsValidationResult | no |  |
| `NeedsDx12` | GraphicsValidationResult | no |  |
| `NeedsDx12Vrs2` | GraphicsValidationResult | no |  |
| `NeedsAppleGpu` | GraphicsValidationResult | no |  |
| `NeedsAmdGpu` | GraphicsValidationResult | no |  |
| `NeedsIntelGpu` | GraphicsValidationResult | no |  |
| `NeedsNvidiaGpu` | GraphicsValidationResult | no |  |
| `NeedsQualcommGpu` | GraphicsValidationResult | no |  |
| `NeedsMacOs_10_13` | GraphicsValidationResult | no |  |
| `NeedsMacOs_10_14` | GraphicsValidationResult | no |  |
| `NeedsMacOs_10_15` | GraphicsValidationResult | no |  |
| `NeedsMacOs_11_0` | GraphicsValidationResult | no |  |
| `NeedsMacOs_12_0` | GraphicsValidationResult | no |  |
| `NeedsMacOs_13_0` | GraphicsValidationResult | no |  |
| `NeedsWindows_10` | GraphicsValidationResult | no |  |
| `NeedsWindows_11` | GraphicsValidationResult | no |  |
| `MacOsUnsupported` | GraphicsValidationResult | no |  |
| `WindowsUnsupported` | GraphicsValidationResult | no |  |
| `LegacyUnsupported` | GraphicsValidationResult | no |  |
| `Dx11Unsupported` | GraphicsValidationResult | no |  |
| `Dx12Win7Unsupported` | GraphicsValidationResult | no |  |
| `RemoteDesktopUnsupported` | GraphicsValidationResult | no |  |
| `WineUnsupported` | GraphicsValidationResult | no |  |
| `NvapiWineUnsupported` | GraphicsValidationResult | no |  |
| `AppleGpuUnsupported` | GraphicsValidationResult | no |  |
| `AmdGpuUnsupported` | GraphicsValidationResult | no |  |
| `IntelGpuUnsupported` | GraphicsValidationResult | no |  |
| `NvidiaGpuUnsupported` | GraphicsValidationResult | no |  |
| `QualcommGpuUnsupported` | GraphicsValidationResult | no |  |
| `GpuDriver` | GraphicsValidationResult | no |  |
| `CompatMode` | GraphicsValidationResult | no |  |
| `Unknown` | GraphicsValidationResult | no |  |

### GxAdapterInfoDetails (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `isLowPower` | bool | no |  |
| `isExternal` | bool | no |  |

