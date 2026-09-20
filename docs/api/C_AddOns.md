# C_AddOns

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**29** functions · **3** events · **2** types

## Functions

### C_AddOns.DisableAddOn

```lua
C_AddOns.DisableAddOn(name, character)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |
| `character` | cstring | no | (default: 0) |

**Example**

```lua
C_AddOns.DisableAddOn(name, "")
```

### C_AddOns.DisableAllAddOns

```lua
C_AddOns.DisableAllAddOns([character])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `character` | cstring | yes |  |

**Example**

```lua
C_AddOns.DisableAllAddOns()
```

### C_AddOns.DoesAddOnExist

```lua
exists = C_AddOns.DoesAddOnExist(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `exists` | bool | no |  |

**Example**

```lua
local exists = C_AddOns.DoesAddOnExist(name)
```

### C_AddOns.DoesAddOnHaveLoadError

```lua
hadError = C_AddOns.DoesAddOnHaveLoadError(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hadError` | bool | no |  |

**Example**

```lua
local hadError = C_AddOns.DoesAddOnHaveLoadError(name)
```

### C_AddOns.EnableAddOn

```lua
C_AddOns.EnableAddOn(name, character)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |
| `character` | cstring | no | (default: 0) |

**Example**

```lua
C_AddOns.EnableAddOn(name, "")
```

### C_AddOns.EnableAllAddOns

```lua
C_AddOns.EnableAllAddOns([character])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `character` | cstring | yes |  |

**Example**

```lua
C_AddOns.EnableAllAddOns()
```

### C_AddOns.GetAddOnDependencies

```lua
deps = C_AddOns.GetAddOnDependencies(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deps` | cstring | no |  |

**Example**

```lua
local deps = C_AddOns.GetAddOnDependencies(name)
```

### C_AddOns.GetAddOnEnableState

```lua
state = C_AddOns.GetAddOnEnableState(name, character)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |
| `character` | cstring | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | AddOnEnableState | no |  |

**Example**

```lua
local state = C_AddOns.GetAddOnEnableState(name, "")
```

### C_AddOns.GetAddOnInfo

```lua
name, title, notes, loadable, reason, security = C_AddOns.GetAddOnInfo(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `title` | cstring | no |  |
| `notes` | cstring | no |  |
| `loadable` | bool | no |  |
| `reason` | cstring | no |  |
| `security` | cstring | no |  |

**Example**

```lua
local name, title, notes, loadable, reason, security = C_AddOns.GetAddOnInfo(name)
```

### C_AddOns.GetAddOnInterfaceVersion

```lua
interfaceVersion = C_AddOns.GetAddOnInterfaceVersion(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interfaceVersion` | number | no |  |

**Example**

```lua
local interfaceVersion = C_AddOns.GetAddOnInterfaceVersion(name)
```

### C_AddOns.GetAddOnLocalTable

Returns the addon table (passed as the second argument of ... to files) for any addon that opts in through setting AllowAddOnTableAccess: 1 in the toc file. Insecure code cannot query addon tables from Blizzard addons.

```lua
table = C_AddOns.GetAddOnLocalTable(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | LuaValueVariant | no |  |

**Example**

```lua
local table = C_AddOns.GetAddOnLocalTable(name)
```

### C_AddOns.GetAddOnMetadata

```lua
value = C_AddOns.GetAddOnMetadata(name, variable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |
| `variable` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | cstring | no |  |

**Example**

```lua
local value = C_AddOns.GetAddOnMetadata(name, "")
```

### C_AddOns.GetAddOnName

```lua
name = C_AddOns.GetAddOnName(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Example**

```lua
local name = C_AddOns.GetAddOnName(1)
```

### C_AddOns.GetAddOnNotes

```lua
notes = C_AddOns.GetAddOnNotes(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `notes` | cstring | no |  |

**Example**

```lua
local notes = C_AddOns.GetAddOnNotes(name)
```

### C_AddOns.GetAddOnOptionalDependencies

```lua
deps = C_AddOns.GetAddOnOptionalDependencies(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deps` | cstring | no |  |

**Example**

```lua
local deps = C_AddOns.GetAddOnOptionalDependencies(name)
```

### C_AddOns.GetAddOnSecurity

```lua
security = C_AddOns.GetAddOnSecurity(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `security` | AddOnSecurityStatus | no |  |

**Example**

```lua
local security = C_AddOns.GetAddOnSecurity(name)
```

### C_AddOns.GetAddOnTitle

```lua
title = C_AddOns.GetAddOnTitle(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `title` | cstring | no |  |

**Example**

```lua
local title = C_AddOns.GetAddOnTitle(name)
```

### C_AddOns.GetNumAddOns

```lua
numAddOns = C_AddOns.GetNumAddOns()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numAddOns` | number | no |  |

**Example**

```lua
local numAddOns = C_AddOns.GetNumAddOns()
```

### C_AddOns.GetScriptsDisallowedForBeta

```lua
disallowed = C_AddOns.GetScriptsDisallowedForBeta()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `disallowed` | bool | no |  |

**Example**

```lua
local disallowed = C_AddOns.GetScriptsDisallowedForBeta()
```

### C_AddOns.IsAddOnDefaultEnabled

```lua
defaultEnabled = C_AddOns.IsAddOnDefaultEnabled(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `defaultEnabled` | bool | no |  |

**Example**

```lua
local defaultEnabled = C_AddOns.IsAddOnDefaultEnabled(name)
```

### C_AddOns.IsAddOnLoadable

```lua
loadable, reason = C_AddOns.IsAddOnLoadable(name, character, demandLoaded)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |
| `character` | cstring | no | (default: 0) |
| `demandLoaded` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadable` | bool | no |  |
| `reason` | cstring | no |  |

**Example**

```lua
local loadable, reason = C_AddOns.IsAddOnLoadable(name, "", false)
```

### C_AddOns.IsAddOnLoaded

```lua
loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadedOrLoading` | bool | no |  |
| `loaded` | bool | no |  |

**Example**

```lua
local loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(name)
```

### C_AddOns.IsAddOnLoadOnDemand

```lua
loadOnDemand = C_AddOns.IsAddOnLoadOnDemand(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadOnDemand` | bool | no |  |

**Example**

```lua
local loadOnDemand = C_AddOns.IsAddOnLoadOnDemand(name)
```

### C_AddOns.IsAddonVersionCheckEnabled

```lua
isEnabled = C_AddOns.IsAddonVersionCheckEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabled` | bool | no |  |

**Example**

```lua
local isEnabled = C_AddOns.IsAddonVersionCheckEnabled()
```

### C_AddOns.LoadAddOn

```lua
loaded, value = C_AddOns.LoadAddOn(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | uiAddon | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loaded` | bool | yes |  |
| `value` | string | yes |  |

**Example**

```lua
local loaded, value = C_AddOns.LoadAddOn(name)
```

### C_AddOns.ResetAddOns

```lua
C_AddOns.ResetAddOns()
```

**Example**

```lua
C_AddOns.ResetAddOns()
```

### C_AddOns.ResetDisabledAddOns

```lua
C_AddOns.ResetDisabledAddOns()
```

**Example**

```lua
C_AddOns.ResetDisabledAddOns()
```

### C_AddOns.SaveAddOns

```lua
C_AddOns.SaveAddOns()
```

**Example**

```lua
C_AddOns.SaveAddOns()
```

### C_AddOns.SetAddonVersionCheck

```lua
C_AddOns.SetAddonVersionCheck(enabled)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
C_AddOns.SetAddonVersionCheck(false)
```

## Events

### ADDON_LOADED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `addOnName` | cstring | no |  |
| `containsBindings` | bool | no |  |

### ADDONS_UNLOADING

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `closingClient` | bool | no |  |

### SAVED_VARIABLES_TOO_LARGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `addOnName` | cstring | no |  |

## Types

### AddOnInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `title` | cstring | no |  |
| `notes` | cstring | no |  |
| `loadable` | bool | no |  |
| `reason` | cstring | no |  |
| `security` | cstring | no |  |

### AddOnLoadableInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `loadable` | bool | no |  |
| `reason` | cstring | no |  |

