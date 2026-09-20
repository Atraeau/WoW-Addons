# Build

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**12** functions · **0** events · **0** types

## Functions

### Build.GetBuildInfo

```lua
buildVersion, buildNumber, buildDate, interfaceVersion, localizedVersion, buildInfo = GetBuildInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buildVersion` | cstring | no |  |
| `buildNumber` | cstring | no |  |
| `buildDate` | cstring | no |  |
| `interfaceVersion` | number | no |  |
| `localizedVersion` | cstring | no |  |
| `buildInfo` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buildVersion, buildNumber, buildDate, interfaceVersion, localizedVersion, buildInfo = GetBuildInfo()
```

### Build.GetBuildOption

```lua
isSet = GetBuildOption(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSet` | bool | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSet = GetBuildOption("")
```

### Build.Is64BitClient

```lua
is64Bit = Is64BitClient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `is64Bit` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local is64Bit = Is64BitClient()
```

### Build.IsBetaBuild

```lua
isBetaBuild = IsBetaBuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isBetaBuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isBetaBuild = IsBetaBuild()
```

### Build.IsDebugBuild

```lua
isDebugBuild = IsDebugBuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isDebugBuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isDebugBuild = IsDebugBuild()
```

### Build.IsLinuxClient

```lua
isLinux = IsLinuxClient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLinux` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLinux = IsLinuxClient()
```

### Build.IsMacClient

```lua
isMac = IsMacClient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMac` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isMac = IsMacClient()
```

### Build.IsPublicBuild

```lua
isPublicBuild = IsPublicBuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPublicBuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPublicBuild = IsPublicBuild()
```

### Build.IsPublicTestClient

Reflects the state of the OnlyBetaAndPTR TOC directive

```lua
isPublicTestClient = IsPublicTestClient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPublicTestClient` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPublicTestClient = IsPublicTestClient()
```

### Build.IsTestBuild

```lua
isTestBuild = IsTestBuild()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTestBuild` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTestBuild = IsTestBuild()
```

### Build.IsWindowsClient

```lua
isWindows = IsWindowsClient()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWindows` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWindows = IsWindowsClient()
```

### Build.SupportsClipCursor

```lua
supportsClipCursor = SupportsClipCursor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `supportsClipCursor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local supportsClipCursor = SupportsClipCursor()
```

