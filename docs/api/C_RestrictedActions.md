# C_RestrictedActions

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **5** events · **0** types

## Functions

### C_RestrictedActions.CheckAllowProtectedFunctions

Returns true if the calling context has permissions to call protected functions on the supplied object.

```lua
protectedFunctionsAllowed = C_RestrictedActions.CheckAllowProtectedFunctions(object, silent)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `object` | FrameScriptObject | no |  |
| `silent` | bool | no | If true, don't signal blocked action errors if protected function calls are disallowed. (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `protectedFunctionsAllowed` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local protectedFunctionsAllowed = C_RestrictedActions.CheckAllowProtectedFunctions(object, false)
```

### C_RestrictedActions.GetAddOnRestrictionState

Returns the current state of an addon restriction type.

```lua
state = C_RestrictedActions.GetAddOnRestrictionState(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | AddOnRestrictionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | AddOnRestrictionState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_RestrictedActions.GetAddOnRestrictionState(type)
```

### C_RestrictedActions.InCombatLockdown

```lua
inCombatLockdown = C_RestrictedActions.InCombatLockdown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inCombatLockdown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inCombatLockdown = C_RestrictedActions.InCombatLockdown()
```

### C_RestrictedActions.IsAddOnRestrictionActive

Returns true if an addon restriction type is in an active state. Will always return false during dispatch of ADDON_RESTRICTION_STATE_CHANGED.

```lua
active = C_RestrictedActions.IsAddOnRestrictionActive(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | AddOnRestrictionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local active = C_RestrictedActions.IsAddOnRestrictionActive(type)
```

## Events

### ADDON_ACTION_BLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTainted` | cstring | no |  |
| `function` | cstring | no |  |

### ADDON_ACTION_FORBIDDEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTainted` | cstring | no |  |
| `function` | cstring | no |  |

### ADDON_RESTRICTION_STATE_CHANGED

Fired when the state of an addon restriction type is changing. This event is sequenced such that it will always be fired before a restriction becomes active, or after it is deactivated.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | AddOnRestrictionType | no |  |
| `state` | AddOnRestrictionState | no |  |

### MACRO_ACTION_BLOCKED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `function` | cstring | no |  |

### MACRO_ACTION_FORBIDDEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `function` | cstring | no |  |

