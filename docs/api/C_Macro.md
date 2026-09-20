# C_Macro

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **1** events · **1** types

## Functions

### C_Macro.GetMacroName

```lua
name = C_Macro.GetMacroName(macroId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `macroId` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local name = C_Macro.GetMacroName(1)
```

### C_Macro.GetSelectedMacroIcon

```lua
textureNum = C_Macro.GetSelectedMacroIcon(macroId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `macroId` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureNum` | fileID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local textureNum = C_Macro.GetSelectedMacroIcon(1)
```

### C_Macro.RunMacroText

```lua
C_Macro.RunMacroText(text, button)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |
| `button` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Macro.RunMacroText("", "")
```

### C_Macro.SetMacroExecuteLineCallback

```lua
C_Macro.SetMacroExecuteLineCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | MacroExecuteLineCallback | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Macro.SetMacroExecuteLineCallback(cb)
```

## Events

### UPDATE_MACROS

## Types

### MacroExecuteLineCallback (CallbackType)

