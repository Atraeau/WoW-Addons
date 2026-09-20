# SimpleFrameScriptObjectAPI

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**21** functions · **0** events · **0** types

## Functions

### SimpleFrameScriptObjectAPI.AddAccessRestrictions

Adds access restrictions to a script object, preventing it from being used in API calls when enforced.

```lua
AddAccessRestrictions(restrictions)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictions` | ScriptObjectAccessRestriction | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddAccessRestrictions(restrictions)
```

### SimpleFrameScriptObjectAPI.AddForbiddenAspects

Adds forbidden aspects to a script object, restricting access to various functionalities such as script bindings.

```lua
AddForbiddenAspects(aspects)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspects` | ForbiddenAspect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddForbiddenAspects(aspects)
```

### SimpleFrameScriptObjectAPI.AddSecretAspect

```lua
AddSecretAspect(aspect)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspect` | SecretAspect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddSecretAspect(aspect)
```

### SimpleFrameScriptObjectAPI.CanBeAccessedInContext

Returns whether the current Lua execution context has permission to access this object.

```lua
canAccess = CanBeAccessedInContext()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccess` | bool | no | False if access is denied, such as when execution is tainted and the object is forbidden or enforcing access restrictions. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccess = CanBeAccessedInContext()
```

### SimpleFrameScriptObjectAPI.GetAccessRestrictions

Returns the mask of all access restrictions applied to this object.

```lua
restrictions = GetAccessRestrictions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictions` | ScriptObjectAccessRestriction | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local restrictions = GetAccessRestrictions()
```

### SimpleFrameScriptObjectAPI.GetForbiddenAspects

Returns the mask of all forbidden aspects applied to this object.

```lua
aspects = GetForbiddenAspects()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspects` | ForbiddenAspect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aspects = GetForbiddenAspects()
```

### SimpleFrameScriptObjectAPI.GetInheritableForbiddenAspects

Returns the mask of all forbidden aspects applied to this object that can propagate to others.

```lua
aspects = GetInheritableForbiddenAspects(path)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `path` | ScriptObjectPropagationPath | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspects` | ForbiddenAspect | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local aspects = GetInheritableForbiddenAspects(path)
```

### SimpleFrameScriptObjectAPI.GetName

```lua
name = GetName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = GetName()
```

### SimpleFrameScriptObjectAPI.GetObjectTable

```lua
objectTable = GetObjectTable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectTable` | FrameScriptObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local objectTable = GetObjectTable()
```

### SimpleFrameScriptObjectAPI.GetObjectType

```lua
objectType = GetObjectType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectType` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local objectType = GetObjectType()
```

### SimpleFrameScriptObjectAPI.HasAccessConstraints

Returns whether this object has any access constraints that may limit access from some Lua execution contexts.

```lua
hasAccessConstraints = HasAccessConstraints()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAccessConstraints` | bool | no | True if this object is forbidden or subject to conditional access restrictions. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAccessConstraints = HasAccessConstraints()
```

### SimpleFrameScriptObjectAPI.HasAnyAccessRestrictions

Returns true if this object has any of the supplied access restrictions applied.

```lua
hasAnyAccessRestriction = HasAnyAccessRestrictions([restrictions])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `restrictions` | ScriptObjectAccessRestriction | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyAccessRestriction` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnyAccessRestriction = HasAnyAccessRestrictions()
```

### SimpleFrameScriptObjectAPI.HasAnyForbiddenAspects

Returns true if this object has any of the supplied forbidden aspects added.

```lua
hasAnyForbiddenAspect = HasAnyForbiddenAspects([aspects])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspects` | ForbiddenAspect | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAnyForbiddenAspect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasAnyForbiddenAspect = HasAnyForbiddenAspects()
```

### SimpleFrameScriptObjectAPI.HasAnySecretAspect

```lua
hasSecretAspect = HasAnySecretAspect()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretAspect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretAspect = HasAnySecretAspect()
```

### SimpleFrameScriptObjectAPI.HasSecretAspect

```lua
hasSecretAspect = HasSecretAspect(aspect)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `aspect` | SecretAspect | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretAspect` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretAspect = HasSecretAspect(aspect)
```

### SimpleFrameScriptObjectAPI.HasSecretValues

```lua
hasSecretValues = HasSecretValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretValues = HasSecretValues()
```

### SimpleFrameScriptObjectAPI.IsForbidden

Returns whether this object has been explicitly marked as forbidden.

```lua
isForbidden = IsForbidden()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isForbidden` | bool | no | True if this object has been explicitly marked as forbidden, regardless of the current Lua execution context. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isForbidden = IsForbidden()
```

### SimpleFrameScriptObjectAPI.IsObjectType

```lua
isType = IsObjectType(objectType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectType` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isType` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isType = IsObjectType("")
```

### SimpleFrameScriptObjectAPI.IsPreventingSecretValues

```lua
isPreventingSecretValues = IsPreventingSecretValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPreventingSecretValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPreventingSecretValues = IsPreventingSecretValues()
```

### SimpleFrameScriptObjectAPI.SetForbidden

```lua
SetForbidden()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetForbidden()
```

### SimpleFrameScriptObjectAPI.SetToDefaults

Reset all script accessible values to their default values. If possible, clears secret states.

```lua
SetToDefaults()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetToDefaults()
```

