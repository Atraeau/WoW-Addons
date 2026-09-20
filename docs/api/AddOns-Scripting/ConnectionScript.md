# ConnectionScript

[← API index](../README.md) · group: [AddOns & Scripting](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**13** functions · **0** events · **0** types

## Functions

### ConnectionScript.CancelLogout

```lua
CancelLogout()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
CancelLogout()
```

### ConnectionScript.ForceLogout

```lua
ForceLogout()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ForceLogout()
```

### ConnectionScript.ForceQuit

```lua
ForceQuit()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ForceQuit()
```

### ConnectionScript.GetNativeRealmID

```lua
nativeRealmID = GetNativeRealmID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nativeRealmID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nativeRealmID = GetNativeRealmID()
```

### ConnectionScript.GetNetIpTypes

```lua
ipTypes = GetNetIpTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ipTypes` | ConnectionIptype | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local ipTypes = GetNetIpTypes()
```

### ConnectionScript.GetNetStats

```lua
in, out, latencyList = GetNetStats()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `in` | number | no |  |
| `out` | number | no |  |
| `latencyList` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local in, out, latencyList = GetNetStats()
```

### ConnectionScript.GetProtocolTypes

```lua
protocolTypes = GetProtocolTypes()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `protocolTypes` | ConnectionProtocol | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local protocolTypes = GetProtocolTypes()
```

### ConnectionScript.GetRealmID

```lua
realmID = GetRealmID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `realmID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local realmID = GetRealmID()
```

### ConnectionScript.GetRealmName

```lua
realmName = GetRealmName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `realmName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local realmName = GetRealmName()
```

### ConnectionScript.IsOnTournamentRealm

```lua
result = IsOnTournamentRealm()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = IsOnTournamentRealm()
```

### ConnectionScript.Logout

```lua
Logout()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Logout()
```

### ConnectionScript.Quit

```lua
Quit()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
Quit()
```

### ConnectionScript.SelectedRealmName

```lua
selectedRealmName = SelectedRealmName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `selectedRealmName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local selectedRealmName = SelectedRealmName()
```

