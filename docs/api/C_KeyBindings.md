# C_KeyBindings

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**11** functions · **4** events · **5** types

## Functions

### C_KeyBindings.ActivateBindingContext

```lua
C_KeyBindings.ActivateBindingContext(newContext)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `newContext` | BindingContext | no |  |

**Example**

```lua
C_KeyBindings.ActivateBindingContext(newContext)
```

### C_KeyBindings.DeactivateBindingContext

```lua
C_KeyBindings.DeactivateBindingContext(context)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `context` | BindingContext | no |  |

**Example**

```lua
C_KeyBindings.DeactivateBindingContext(context)
```

### C_KeyBindings.GetBindingByKey

```lua
binding = C_KeyBindings.GetBindingByKey(action, [context])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `action` | cstring | no |  |
| `context` | BindingContext | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `binding` | cstring | no |  |

**Example**

```lua
local binding = C_KeyBindings.GetBindingByKey("")
```

### C_KeyBindings.GetBindingContextForAction

```lua
context = C_KeyBindings.GetBindingContextForAction(action)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `action` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `context` | BindingContext | yes |  |

**Example**

```lua
local context = C_KeyBindings.GetBindingContextForAction("")
```

### C_KeyBindings.GetBindingIndex

```lua
bindingIndex = C_KeyBindings.GetBindingIndex(action)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `action` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bindingIndex` | luaIndex | yes |  |

**Example**

```lua
local bindingIndex = C_KeyBindings.GetBindingIndex("")
```

### C_KeyBindings.GetCustomBindingType

```lua
customBindingType = C_KeyBindings.GetCustomBindingType(bindingIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bindingIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `customBindingType` | CustomBindingType | yes |  |

**Example**

```lua
local customBindingType = C_KeyBindings.GetCustomBindingType(1)
```

### C_KeyBindings.GetSearchTagsForAction

```lua
searchTags = C_KeyBindings.GetSearchTagsForAction(action)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `action` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `searchTags` | string[] | yes |  |

**Example**

```lua
local searchTags = C_KeyBindings.GetSearchTagsForAction("")
```

### C_KeyBindings.GetTurnStrafeStyle

```lua
style = C_KeyBindings.GetTurnStrafeStyle()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `style` | TurnStrafeStyle | no |  |

**Example**

```lua
local style = C_KeyBindings.GetTurnStrafeStyle()
```

### C_KeyBindings.IsBindingContextActive

```lua
isActive = C_KeyBindings.IsBindingContextActive(context)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `context` | BindingContext | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

**Example**

```lua
local isActive = C_KeyBindings.IsBindingContextActive(context)
```

### C_KeyBindings.SetTurnStrafeStyle

Can only set to Modern or Legacy.

```lua
C_KeyBindings.SetTurnStrafeStyle(style)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `style` | TurnStrafeStyle | no |  |

**Example**

```lua
C_KeyBindings.SetTurnStrafeStyle(style)
```

### C_KeyBindings.UpdateTurnStrafeBindingsForCharacter

```lua
C_KeyBindings.UpdateTurnStrafeBindingsForCharacter()
```

**Example**

```lua
C_KeyBindings.UpdateTurnStrafeBindingsForCharacter()
```

## Events

### BINDINGS_LOADED

### MODIFIER_STATE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | cstring | no |  |
| `down` | number | no |  |

### NOTIFY_TURN_STRAFE_CHANGE

### UPDATE_BINDINGS

## Types

### BindingContext (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | BindingContext | no |  |
| `HousingEditor` | BindingContext | no |  |
| `HousingEditorBasicDecorMode` | BindingContext | no |  |
| `HousingEditorExpertDecorMode` | BindingContext | no |  |
| `HousingEditorCustomizeMode` | BindingContext | no |  |
| `HousingEditorCleanupMode` | BindingContext | no |  |
| `HousingEditorLayoutMode` | BindingContext | no |  |
| `HousingEditorBasicAndExpertDecorMode` | BindingContext | no |  |
| `HousingEditorExteriorCustomizationMode` | BindingContext | no |  |
| `GamepadModeInGameCore` | BindingContext | no |  |

### BindingSet (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | BindingSet | no |  |
| `Account` | BindingSet | no |  |
| `Character` | BindingSet | no |  |
| `Current` | BindingSet | no |  |

### CustomBindingType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `VoicePushToTalk` | CustomBindingType | no |  |

### InputCommandCallback (CallbackType)

### TurnStrafeStyle (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Modern` | TurnStrafeStyle | no |  |
| `Legacy` | TurnStrafeStyle | no |  |
| `Custom` | TurnStrafeStyle | no |  |

