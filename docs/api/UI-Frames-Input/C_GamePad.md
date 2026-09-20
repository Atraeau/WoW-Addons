# C_GamePad

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**25** functions · **6** events · **9** types

## Functions

### C_GamePad.AddSDLMapping

```lua
success = C_GamePad.AddSDLMapping(platform, mapping)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `platform` | ClientPlatformType | no |  |
| `mapping` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success = C_GamePad.AddSDLMapping(Enum.ClientPlatformType.Windows, "")
```

### C_GamePad.ApplyConfigs

```lua
C_GamePad.ApplyConfigs()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.ApplyConfigs()
```

### C_GamePad.AxisIndexToConfigName

```lua
configName = C_GamePad.AxisIndexToConfigName(axisIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `axisIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configName` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configName = C_GamePad.AxisIndexToConfigName(1)
```

### C_GamePad.ButtonBindingToIndex

```lua
buttonIndex = C_GamePad.ButtonBindingToIndex(bindingName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bindingName` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonIndex` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local buttonIndex = C_GamePad.ButtonBindingToIndex("")
```

### C_GamePad.ButtonIndexToBinding

```lua
bindingName = C_GamePad.ButtonIndexToBinding(buttonIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bindingName` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local bindingName = C_GamePad.ButtonIndexToBinding(1)
```

### C_GamePad.ButtonIndexToConfigName

```lua
configName = C_GamePad.ButtonIndexToConfigName(buttonIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `buttonIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configName` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configName = C_GamePad.ButtonIndexToConfigName(1)
```

### C_GamePad.ClearLedColor

```lua
C_GamePad.ClearLedColor()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.ClearLedColor()
```

### C_GamePad.DeleteConfig

```lua
C_GamePad.DeleteConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | GamePadConfigID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.DeleteConfig(configID)
```

### C_GamePad.GetActiveDeviceID

```lua
deviceID = C_GamePad.GetActiveDeviceID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deviceID = C_GamePad.GetActiveDeviceID()
```

### C_GamePad.GetAllConfigIDs

```lua
configIDs = C_GamePad.GetAllConfigIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configIDs` | GamePadConfigID[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configIDs = C_GamePad.GetAllConfigIDs()
```

### C_GamePad.GetAllDeviceIDs

```lua
deviceIDs = C_GamePad.GetAllDeviceIDs()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceIDs` | number[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deviceIDs = C_GamePad.GetAllDeviceIDs()
```

### C_GamePad.GetAllowHoverEventsWithFreeLook

```lua
enabled = C_GamePad.GetAllowHoverEventsWithFreeLook()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GamePad.GetAllowHoverEventsWithFreeLook()
```

### C_GamePad.GetCombinedDeviceID

```lua
deviceID = C_GamePad.GetCombinedDeviceID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local deviceID = C_GamePad.GetCombinedDeviceID()
```

### C_GamePad.GetConfig

```lua
config = C_GamePad.GetConfig(configID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configID` | GamePadConfigID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `config` | GamePadConfig | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local config = C_GamePad.GetConfig(configID)
```

### C_GamePad.GetDeviceMappedState

```lua
state = C_GamePad.GetDeviceMappedState([deviceID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | GamePadMappedState | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_GamePad.GetDeviceMappedState()
```

### C_GamePad.GetDeviceRawState

```lua
rawState = C_GamePad.GetDeviceRawState(deviceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rawState` | GamePadRawState | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local rawState = C_GamePad.GetDeviceRawState(0)
```

### C_GamePad.GetLedColor

```lua
color = C_GamePad.GetLedColor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local color = C_GamePad.GetLedColor()
```

### C_GamePad.GetPowerLevel

```lua
powerLevel = C_GamePad.GetPowerLevel([deviceID])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `deviceID` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerLevel` | GamePadPowerLevel | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local powerLevel = C_GamePad.GetPowerLevel()
```

### C_GamePad.IsEnabled

```lua
enabled = C_GamePad.IsEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = C_GamePad.IsEnabled()
```

### C_GamePad.SetAllowHoverEventsWithFreeLook

```lua
C_GamePad.SetAllowHoverEventsWithFreeLook(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.SetAllowHoverEventsWithFreeLook(false)
```

### C_GamePad.SetConfig

```lua
C_GamePad.SetConfig(config)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `config` | GamePadConfig | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.SetConfig(config)
```

### C_GamePad.SetLedColor

```lua
C_GamePad.SetLedColor(color)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `color` | colorRGB | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.SetLedColor(color)
```

### C_GamePad.SetVibration

```lua
C_GamePad.SetVibration(vibrationType, intensity)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vibrationType` | cstring | no |  |
| `intensity` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.SetVibration("", 0)
```

### C_GamePad.StickIndexToConfigName

```lua
configName = C_GamePad.StickIndexToConfigName(stickIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stickIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `configName` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local configName = C_GamePad.StickIndexToConfigName(1)
```

### C_GamePad.StopVibration

```lua
C_GamePad.StopVibration()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_GamePad.StopVibration()
```

## Events

### GAME_PAD_ACTIVE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isActive` | bool | no |  |

### GAME_PAD_ALLOW_HOVER_EVENTS_WITH_FREE_LOOK_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

### GAME_PAD_CONFIGS_CHANGED

### GAME_PAD_CONNECTED

### GAME_PAD_DISCONNECTED

### GAME_PAD_POWER_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `powerLevel` | GamePadPowerLevel | no |  |

## Types

### GamePadAxisConfig (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `axis` | string | no |  |
| `shift` | number | yes |  |
| `scale` | number | yes |  |
| `deadzone` | number | yes |  |
| `buttonThreshold` | number | yes |  |
| `buttonPos` | string | yes |  |
| `buttonNeg` | string | yes |  |
| `comment` | string | yes |  |

### GamePadConfig (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `comment` | string | yes |  |
| `name` | string | yes |  |
| `configID` | GamePadConfigID | no |  |
| `labelStyle` | string | yes |  |
| `rawButtonMappings` | GamePadRawButtonMapping[] | no |  |
| `rawAxisMappings` | GamePadRawAxisMapping[] | no |  |
| `axisConfigs` | GamePadAxisConfig[] | no |  |
| `stickConfigs` | GamePadStickConfig[] | no |  |

### GamePadConfigID (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vendorID` | number | yes |  |
| `productID` | number | yes |  |

### GamePadMappedState (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `labelStyle` | string | no |  |
| `buttonCount` | number | no |  |
| `axisCount` | number | no |  |
| `stickCount` | number | no |  |
| `buttons` | bool[] | no |  |
| `axes` | number[] | no |  |
| `sticks` | GamePadStick[] | no |  |

### GamePadRawAxisMapping (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rawIndex` | number | no |  |
| `axis` | string | yes |  |
| `comment` | string | yes |  |

### GamePadRawButtonMapping (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rawIndex` | number | no |  |
| `button` | string | yes |  |
| `axis` | string | yes |  |
| `axisValue` | number | yes |  |
| `comment` | string | yes |  |

### GamePadRawState (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | string | no |  |
| `vendorID` | number | no |  |
| `productID` | number | no |  |
| `rawButtonCount` | number | no |  |
| `rawAxisCount` | number | no |  |
| `rawButtons` | bool[] | no |  |
| `rawAxes` | number[] | no |  |

### GamePadStick (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |
| `len` | number | no |  |

### GamePadStickConfig (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `stick` | string | no |  |
| `axisX` | string | yes |  |
| `axisY` | string | yes |  |
| `deadzone` | number | yes |  |
| `deadzoneX` | number | yes |  |
| `deadzoneY` | number | yes |  |
| `comment` | string | yes |  |

