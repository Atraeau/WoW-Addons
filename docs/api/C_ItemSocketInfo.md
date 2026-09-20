# C_ItemSocketInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**16** functions · **8** events · **3** types

## Functions

### C_ItemSocketInfo.AcceptSockets

```lua
C_ItemSocketInfo.AcceptSockets()
```

**Example**

```lua
C_ItemSocketInfo.AcceptSockets()
```

### C_ItemSocketInfo.ClickSocketButton

```lua
C_ItemSocketInfo.ClickSocketButton(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Example**

```lua
C_ItemSocketInfo.ClickSocketButton(1)
```

### C_ItemSocketInfo.CloseSocketInfo

```lua
C_ItemSocketInfo.CloseSocketInfo()
```

**Example**

```lua
C_ItemSocketInfo.CloseSocketInfo()
```

### C_ItemSocketInfo.CompleteSocketing

```lua
C_ItemSocketInfo.CompleteSocketing()
```

**Example**

```lua
C_ItemSocketInfo.CompleteSocketing()
```

### C_ItemSocketInfo.GetCurrUIType

```lua
uiType = C_ItemSocketInfo.GetCurrUIType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiType` | ItemSocketInfoUIType | no |  |

**Example**

```lua
local uiType = C_ItemSocketInfo.GetCurrUIType()
```

### C_ItemSocketInfo.GetExistingSocketInfo

```lua
name, icon, gemMatchesSocket = C_ItemSocketInfo.GetExistingSocketInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `icon` | fileID | yes |  |
| `gemMatchesSocket` | bool | no |  |

**Example**

```lua
local name, icon, gemMatchesSocket = C_ItemSocketInfo.GetExistingSocketInfo(1)
```

### C_ItemSocketInfo.GetExistingSocketLink

```lua
existingSocketLink = C_ItemSocketInfo.GetExistingSocketLink(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `existingSocketLink` | string | yes |  |

**Example**

```lua
local existingSocketLink = C_ItemSocketInfo.GetExistingSocketLink(1)
```

### C_ItemSocketInfo.GetNewSocketInfo

```lua
name, icon, gemMatchesSocket = C_ItemSocketInfo.GetNewSocketInfo(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `icon` | fileID | yes |  |
| `gemMatchesSocket` | bool | no |  |

**Example**

```lua
local name, icon, gemMatchesSocket = C_ItemSocketInfo.GetNewSocketInfo(1)
```

### C_ItemSocketInfo.GetNewSocketLink

```lua
newSocketLink = C_ItemSocketInfo.GetNewSocketLink(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newSocketLink` | string | yes |  |

**Example**

```lua
local newSocketLink = C_ItemSocketInfo.GetNewSocketLink(1)
```

### C_ItemSocketInfo.GetNumSockets

```lua
numSockets = C_ItemSocketInfo.GetNumSockets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numSockets` | number | no |  |

**Example**

```lua
local numSockets = C_ItemSocketInfo.GetNumSockets()
```

### C_ItemSocketInfo.GetSocketItemBoundTradeable

```lua
socketItemTradeable = C_ItemSocketInfo.GetSocketItemBoundTradeable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `socketItemTradeable` | bool | no |  |

**Example**

```lua
local socketItemTradeable = C_ItemSocketInfo.GetSocketItemBoundTradeable()
```

### C_ItemSocketInfo.GetSocketItemInfo

```lua
name, icon, quality = C_ItemSocketInfo.GetSocketItemInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `icon` | fileID | yes |  |
| `quality` | ItemQuality | no |  |

**Example**

```lua
local name, icon, quality = C_ItemSocketInfo.GetSocketItemInfo()
```

### C_ItemSocketInfo.GetSocketItemRefundable

```lua
socketItemRefundable = C_ItemSocketInfo.GetSocketItemRefundable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `socketItemRefundable` | bool | no |  |

**Example**

```lua
local socketItemRefundable = C_ItemSocketInfo.GetSocketItemRefundable()
```

### C_ItemSocketInfo.GetSocketTypes

```lua
socketType = C_ItemSocketInfo.GetSocketTypes(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `socketType` | string | yes |  |

**Example**

```lua
local socketType = C_ItemSocketInfo.GetSocketTypes(1)
```

### C_ItemSocketInfo.HasBoundGemProposed

```lua
hasBoundGemProposed = C_ItemSocketInfo.HasBoundGemProposed()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBoundGemProposed` | bool | no |  |

**Example**

```lua
local hasBoundGemProposed = C_ItemSocketInfo.HasBoundGemProposed()
```

### C_ItemSocketInfo.IsArtifactRelicItem

```lua
isArtifactRelicItem = C_ItemSocketInfo.IsArtifactRelicItem(info)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ItemInfo | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isArtifactRelicItem` | bool | no |  |

**Example**

```lua
local isArtifactRelicItem = C_ItemSocketInfo.IsArtifactRelicItem(info)
```

## Events

### SOCKET_INFO_ACCEPT

### SOCKET_INFO_BIND_CONFIRM

### SOCKET_INFO_CLOSE

### SOCKET_INFO_FAILURE

### SOCKET_INFO_REFUNDABLE_CONFIRM

### SOCKET_INFO_SUCCESS

### SOCKET_INFO_UI_EVENT_REGISTRATION_UPDATE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiType` | ItemSocketInfoUIType | no |  |

### SOCKET_INFO_UPDATE

## Types

### ItemSocketInfoUIType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | ItemSocketInfoUIType | no |  |

### SocketInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `icon` | fileID | yes |  |
| `gemMatchesSocket` | bool | no |  |

### SocketItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | yes |  |
| `icon` | fileID | yes |  |
| `quality` | ItemQuality | no |  |

