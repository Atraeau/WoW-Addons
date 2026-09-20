# C_MacOptions

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**10** functions · **0** events · **0** types

## Functions

### C_MacOptions.AreOSShortcutsDisabled

```lua
osShortcutsDisabledCVar, osShortcutsDisabled = C_MacOptions.AreOSShortcutsDisabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `osShortcutsDisabledCVar` | bool | yes |  |
| `osShortcutsDisabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local osShortcutsDisabledCVar, osShortcutsDisabled = C_MacOptions.AreOSShortcutsDisabled()
```

### C_MacOptions.GetGameBundleName

```lua
result = C_MacOptions.GetGameBundleName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_MacOptions.GetGameBundleName()
```

### C_MacOptions.HasNewStyleInputMonitoring

```lua
result = C_MacOptions.HasNewStyleInputMonitoring()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_MacOptions.HasNewStyleInputMonitoring()
```

### C_MacOptions.IsInputMonitoringEnabled

```lua
result = C_MacOptions.IsInputMonitoringEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_MacOptions.IsInputMonitoringEnabled()
```

### C_MacOptions.IsMicrophoneEnabled

```lua
result = C_MacOptions.IsMicrophoneEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_MacOptions.IsMicrophoneEnabled()
```

### C_MacOptions.IsUniversalAccessEnabled

```lua
result = C_MacOptions.IsUniversalAccessEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = C_MacOptions.IsUniversalAccessEnabled()
```

### C_MacOptions.OpenInputMonitoring

```lua
C_MacOptions.OpenInputMonitoring()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MacOptions.OpenInputMonitoring()
```

### C_MacOptions.OpenMicrophoneRequestDialogue

```lua
C_MacOptions.OpenMicrophoneRequestDialogue()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MacOptions.OpenMicrophoneRequestDialogue()
```

### C_MacOptions.OpenUniversalAccess

```lua
C_MacOptions.OpenUniversalAccess()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MacOptions.OpenUniversalAccess()
```

### C_MacOptions.SetOSShortcutsDisabled

```lua
C_MacOptions.SetOSShortcutsDisabled(disable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_MacOptions.SetOSShortcutsDisabled(false)
```

