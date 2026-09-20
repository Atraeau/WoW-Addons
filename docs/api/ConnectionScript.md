# ConnectionScript

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**13** functions · **0** events · **0** types

## Functions

### ConnectionScript.CancelLogout

```lua
CancelLogout()
```

**Example**

```lua
CancelLogout()
```

### ConnectionScript.ForceLogout

```lua
ForceLogout()
```

**Example**

```lua
ForceLogout()
```

### ConnectionScript.ForceQuit

```lua
ForceQuit()
```

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
local result = IsOnTournamentRealm()
```

### ConnectionScript.Logout

```lua
Logout()
```

**Example**

```lua
Logout()
```

### ConnectionScript.Quit

```lua
Quit()
```

**Example**

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

**Example**

```lua
local selectedRealmName = SelectedRealmName()
```

