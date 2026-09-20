# Client

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**12** functions · **0** events · **0** types

## Functions

### Client.FlashClientIcon

```lua
FlashClientIcon(briefly)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `briefly` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
FlashClientIcon(false)
```

### Client.GetBillingTimeRested

```lua
billingTimeRested = GetBillingTimeRested()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `billingTimeRested` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local billingTimeRested = GetBillingTimeRested()
```

### Client.GetFileIDFromPath

```lua
fileID = GetFileIDFromPath(filePath)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `filePath` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileID` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fileID = GetFileIDFromPath("")
```

### Client.GetFramerate

```lua
framerate = GetFramerate()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `framerate` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local framerate = GetFramerate()
```

### Client.IsCpuBound

```lua
isCpuBound = IsCpuBound()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCpuBound` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isCpuBound = IsCpuBound()
```

### Client.PlatformIsHandheld

```lua
isHandheld = PlatformIsHandheld()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHandheld` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHandheld = PlatformIsHandheld()
```

### Client.ReportBug

```lua
ReportBug(description)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ReportBug("")
```

### Client.ReportSuggestion

```lua
ReportSuggestion(description)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `description` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ReportSuggestion("")
```

### Client.RestartGx

```lua
RestartGx()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RestartGx()
```

### Client.Screenshot

```lua
Screenshot()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Screenshot()
```

### Client.UIReload

```lua
UIReload()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UIReload()
```

### Client.UpdateWindow

```lua
UpdateWindow()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
UpdateWindow()
```

