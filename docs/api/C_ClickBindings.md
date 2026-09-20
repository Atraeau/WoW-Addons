# C_ClickBindings

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **1** events · **0** types

## Functions

### C_ClickBindings.CanSpellBeClickBound

```lua
canBeBound = C_ClickBindings.CanSpellBeClickBound(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no | Base spellID for spell, spellID for PetAction |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canBeBound` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canBeBound = C_ClickBindings.CanSpellBeClickBound(2050)
```

### C_ClickBindings.ExecuteBinding

```lua
C_ClickBindings.ExecuteBinding(targetToken, button, modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `targetToken` | cstring | no |  |
| `button` | cstring | no |  |
| `modifiers` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClickBindings.ExecuteBinding("", "", 0)
```

### C_ClickBindings.GetBindingType

```lua
type = C_ClickBindings.GetBindingType(button, modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no |  |
| `modifiers` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | ClickBindingType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local type = C_ClickBindings.GetBindingType("", 0)
```

### C_ClickBindings.GetEffectiveInteractionButton

```lua
effectiveButton = C_ClickBindings.GetEffectiveInteractionButton(button, modifiers)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no |  |
| `modifiers` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `effectiveButton` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local effectiveButton = C_ClickBindings.GetEffectiveInteractionButton("", 0)
```

### C_ClickBindings.GetProfileInfo

```lua
infoVec = C_ClickBindings.GetProfileInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infoVec` | ClickBindingInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local infoVec = C_ClickBindings.GetProfileInfo()
```

### C_ClickBindings.GetTutorialShown

```lua
tutorialShown = C_ClickBindings.GetTutorialShown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tutorialShown` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local tutorialShown = C_ClickBindings.GetTutorialShown()
```

### C_ClickBindings.ResetCurrentProfile

```lua
C_ClickBindings.ResetCurrentProfile()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClickBindings.ResetCurrentProfile()
```

### C_ClickBindings.SetProfileByInfo

```lua
C_ClickBindings.SetProfileByInfo(infoVec)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `infoVec` | ClickBindingInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClickBindings.SetProfileByInfo(infoVec)
```

### C_ClickBindings.SetTutorialShown

```lua
C_ClickBindings.SetTutorialShown()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ClickBindings.SetTutorialShown()
```

## Events

### CLICKBINDINGS_SET_HIGHLIGHTS_SHOWN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showHighlights` | bool | no |  |

