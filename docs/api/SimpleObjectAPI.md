# SimpleObjectAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **0** events · **0** types

## Functions

### SimpleObjectAPI.ClearParentKey

```lua
ClearParentKey()
```

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
SetParentKey("", false)
```

