# C_ConfigurationWarnings

[← API index](../README.md) · group: [AddOns & Scripting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **0** events · **0** types

## Functions

### C_ConfigurationWarnings.GetConfigurationWarnings

```lua
configurationWarnings = C_ConfigurationWarnings.GetConfigurationWarnings(includeSeenWarnings)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `includeSeenWarnings` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configurationWarnings` | ConfigurationWarning[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configurationWarnings = C_ConfigurationWarnings.GetConfigurationWarnings(false)
```

### C_ConfigurationWarnings.GetConfigurationWarningSeen

```lua
hasSeenConfigurationWarning = C_ConfigurationWarnings.GetConfigurationWarningSeen(configurationWarning)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configurationWarning` | ConfigurationWarning | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSeenConfigurationWarning` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSeenConfigurationWarning = C_ConfigurationWarnings.GetConfigurationWarningSeen(configurationWarning)
```

### C_ConfigurationWarnings.GetConfigurationWarningString

```lua
configurationWarningString = C_ConfigurationWarnings.GetConfigurationWarningString(configurationWarning)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configurationWarning` | ConfigurationWarning | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configurationWarningString` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configurationWarningString = C_ConfigurationWarnings.GetConfigurationWarningString(configurationWarning)
```

### C_ConfigurationWarnings.SetConfigurationWarningSeen

```lua
C_ConfigurationWarnings.SetConfigurationWarningSeen(configurationWarning)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configurationWarning` | ConfigurationWarning | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ConfigurationWarnings.SetConfigurationWarningSeen(configurationWarning)
```

