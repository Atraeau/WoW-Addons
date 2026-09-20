# SimpleObjectAPI

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **0** events · **0** types

## Functions

### SimpleObjectAPI.ClearParentKey

```lua
ClearParentKey()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearParentKey()
```

### SimpleObjectAPI.GetDebugName

```lua
debugName = GetDebugName(preferParentKey)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `preferParentKey` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `debugName` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local debugName = GetDebugName(false)
```

### SimpleObjectAPI.GetParent

```lua
parent = GetParent()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parent` | CScriptObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local parent = GetParent()
```

### SimpleObjectAPI.GetParentKey

```lua
parentKey = GetParentKey()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parentKey` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local parentKey = GetParentKey()
```

### SimpleObjectAPI.SetParentKey

```lua
SetParentKey(parentKey, clearOtherKeys)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `parentKey` | cstring | no |  |
| `clearOtherKeys` | bool | no | (default: False) |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetParentKey("", false)
```

