# C_AutoComplete

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **1** types

## Functions

### C_AutoComplete.GetAutoCompletePresenceID

```lua
presenceID = C_AutoComplete.GetAutoCompletePresenceID(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `presenceID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local presenceID = C_AutoComplete.GetAutoCompletePresenceID("")
```

### C_AutoComplete.GetAutoCompleteRealms

```lua
realms = C_AutoComplete.GetAutoCompleteRealms()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `realms` | string[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local realms = C_AutoComplete.GetAutoCompleteRealms()
```

### C_AutoComplete.GetAutoCompleteResults

```lua
results = C_AutoComplete.GetAutoCompleteResults(name, numResults, cursorPosition, allowFullMatch, includeFlags, excludeFlags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `numResults` | number | no |  |
| `cursorPosition` | number | no |  |
| `allowFullMatch` | bool | no |  |
| `includeFlags` | number | no |  |
| `excludeFlags` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `results` | AutoCompleteResult[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local results = C_AutoComplete.GetAutoCompleteResults("", 0, 0, false, 0, 0)
```

### C_AutoComplete.IsRecognizedName

```lua
isRecognizedName = C_AutoComplete.IsRecognizedName(name, includeFlags, excludeFlags)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `includeFlags` | number | no |  |
| `excludeFlags` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isRecognizedName` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isRecognizedName = C_AutoComplete.IsRecognizedName("", 0, 0)
```

## Types

### AutoCompleteResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `priority` | AutoCompletePriority | no |  |
| `bnetID` | number | no |  |

