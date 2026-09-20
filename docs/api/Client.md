# Client

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
ReportSuggestion("")
```

### Client.RestartGx

```lua
RestartGx()
```

**Example**

```lua
RestartGx()
```

### Client.Screenshot

```lua
Screenshot()
```

**Example**

```lua
Screenshot()
```

### Client.UIReload

```lua
UIReload()
```

**Example**

```lua
UIReload()
```

### Client.UpdateWindow

```lua
UpdateWindow()
```

**Example**

```lua
UpdateWindow()
```

