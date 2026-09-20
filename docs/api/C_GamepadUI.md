# C_GamepadUI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **2** events · **3** types

## Functions

### C_GamepadUI.GetFirstGamepadActionBarStorageSlotIndexForActiveStance

```lua
activeStanceFirstGamepadStorageSlotIndex = C_GamepadUI.GetFirstGamepadActionBarStorageSlotIndexForActiveStance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activeStanceFirstGamepadStorageSlotIndex` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local activeStanceFirstGamepadStorageSlotIndex = C_GamepadUI.GetFirstGamepadActionBarStorageSlotIndexForActiveStance()
```

### C_GamepadUI.GetFirstGamepadActionStorageSlotIndex

```lua
firstGamepadActionStorageSlotIndex = C_GamepadUI.GetFirstGamepadActionStorageSlotIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `firstGamepadActionStorageSlotIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local firstGamepadActionStorageSlotIndex = C_GamepadUI.GetFirstGamepadActionStorageSlotIndex()
```

### C_GamepadUI.GetFirstGamepadPetActionStorageSlotIndex

```lua
firstGamepadPetActionStorageSlotID = C_GamepadUI.GetFirstGamepadPetActionStorageSlotIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `firstGamepadPetActionStorageSlotID` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local firstGamepadPetActionStorageSlotID = C_GamepadUI.GetFirstGamepadPetActionStorageSlotIndex()
```

### C_GamepadUI.IsValidGamepadActionStorageSlotIndex

```lua
isValid = C_GamepadUI.IsValidGamepadActionStorageSlotIndex(gamepadActionStorageSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gamepadActionStorageSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_GamepadUI.IsValidGamepadActionStorageSlotIndex(1)
```

### C_GamepadUI.IsValidGamepadPossessBarStorageSlotIndex

```lua
isValid = C_GamepadUI.IsValidGamepadPossessBarStorageSlotIndex(gamepadPossessBarStorageSlotIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gamepadPossessBarStorageSlotIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValid` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isValid = C_GamepadUI.IsValidGamepadPossessBarStorageSlotIndex(1)
```

## Events

### GAMEPAD_POSSESS_BAR_OVERRIDE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldOverride` | GamepadPossessBarOverride | no |  |
| `newOverride` | GamepadPossessBarOverride | no |  |

### GAMEPAD_STANCE_BAR_OVERRIDE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `oldOverride` | GamepadStanceBarOverride | no |  |
| `newOverride` | GamepadStanceBarOverride | no |  |

## Types

### GamepadActionBarConstants (Constants)

### GamepadPossessBarOverride (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `SpecialPageTopBar` | GamepadPossessBarOverride | no |  |
| `Page1LeftBar` | GamepadPossessBarOverride | no |  |
| `Page1RightBar` | GamepadPossessBarOverride | no |  |
| `Page1BottomBar` | GamepadPossessBarOverride | no |  |
| `Page2TopBar` | GamepadPossessBarOverride | no |  |
| `Page2LeftBar` | GamepadPossessBarOverride | no |  |
| `Page2RightBar` | GamepadPossessBarOverride | no |  |
| `Page2BottomBar` | GamepadPossessBarOverride | no |  |
| `Page3TopBar` | GamepadPossessBarOverride | no |  |
| `Page3LeftBar` | GamepadPossessBarOverride | no |  |
| `Page3RightBar` | GamepadPossessBarOverride | no |  |
| `Page3BottomBar` | GamepadPossessBarOverride | no |  |

### GamepadStanceBarOverride (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | GamepadStanceBarOverride | no |  |
| `Page1LeftBar` | GamepadStanceBarOverride | no |  |
| `Page1RightBar` | GamepadStanceBarOverride | no |  |
| `Page1BottomBar` | GamepadStanceBarOverride | no |  |
| `Page2TopBar` | GamepadStanceBarOverride | no |  |
| `Page2LeftBar` | GamepadStanceBarOverride | no |  |
| `Page2RightBar` | GamepadStanceBarOverride | no |  |
| `Page2BottomBar` | GamepadStanceBarOverride | no |  |
| `Page3TopBar` | GamepadStanceBarOverride | no |  |
| `Page3LeftBar` | GamepadStanceBarOverride | no |  |
| `Page3RightBar` | GamepadStanceBarOverride | no |  |
| `Page3BottomBar` | GamepadStanceBarOverride | no |  |

