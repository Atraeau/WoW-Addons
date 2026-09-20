# C_Ping

[← API index](../README.md) · group: [Guild, Social & Chat](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**6** functions · **1** events · **1** types

## Functions

### C_Ping.GetCooldownInfo

```lua
cooldownInfo = C_Ping.GetCooldownInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownInfo` | PingCooldownInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local cooldownInfo = C_Ping.GetCooldownInfo()
```

### C_Ping.GetDefaultPingOptions

```lua
pingTypes = C_Ping.GetDefaultPingOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pingTypes` | PingTypeInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local pingTypes = C_Ping.GetDefaultPingOptions()
```

### C_Ping.GetTextureKitForType

```lua
uiTextureKitID = C_Ping.GetTextureKitForType(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PingSubjectType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiTextureKitID` | textureKit | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local uiTextureKitID = C_Ping.GetTextureKitForType(type)
```

### C_Ping.IsPingSystemEnabled

```lua
isEnabled = C_Ping.IsPingSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isEnabled = C_Ping.IsPingSystemEnabled()
```

### C_Ping.SendMacroPing

```lua
C_Ping.SendMacroPing(macroInfo)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `macroInfo` | PingMacroInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Ping.SendMacroPing(macroInfo)
```

### C_Ping.TogglePingListener

```lua
C_Ping.TogglePingListener(down)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `down` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Ping.TogglePingListener(false)
```

## Events

### PING_SYSTEM_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | cstring | no |  |

## Types

### PingTypeInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `orderIndex` | number | no |  |
| `type` | PingSubjectType | no |  |
| `uiTextureKitID` | textureKit | no |  |

