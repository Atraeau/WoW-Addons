# C_PingSecure

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**19** functions · **2** events · **11** types

## Functions

### C_PingSecure.ClearHitTestPingInfo

```lua
C_PingSecure.ClearHitTestPingInfo()
```

**Example**

```lua
C_PingSecure.ClearHitTestPingInfo()
```

### C_PingSecure.CreateFrame

```lua
C_PingSecure.CreateFrame()
```

**Example**

```lua
C_PingSecure.CreateFrame()
```

### C_PingSecure.DisplayError

```lua
C_PingSecure.DisplayError(error)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `error` | cstring | no |  |

**Example**

```lua
C_PingSecure.DisplayError("")
```

### C_PingSecure.GetTargetPingReceiver

```lua
frame = C_PingSecure.GetTargetPingReceiver(mousePosX, mousePosY)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mousePosX` | number | no |  |
| `mousePosY` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frame` | ScriptRegion | no |  |

**Example**

```lua
local frame = C_PingSecure.GetTargetPingReceiver(0, 0)
```

### C_PingSecure.SendHitTestPing

```lua
result = C_PingSecure.SendHitTestPing([type])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PingSubjectType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SendHitTestPing()
```

### C_PingSecure.SendPlayerItemPing

```lua
result = C_PingSecure.SendPlayerItemPing(itemID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SendPlayerItemPing(6948)
```

### C_PingSecure.SendPlayerSpellCategoryPing

```lua
result = C_PingSecure.SendPlayerSpellCategoryPing(spellCategoryID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellCategoryID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SendPlayerSpellCategoryPing(12345)
```

### C_PingSecure.SendPlayerSpellPing

```lua
result = C_PingSecure.SendPlayerSpellPing(spellID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SendPlayerSpellPing(12345)
```

### C_PingSecure.SendUnitPing

```lua
result = C_PingSecure.SendUnitPing(target, [type], [isPlayerResource])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | WOWGUID | no |  |
| `type` | PingSubjectType | yes |  |
| `isPlayerResource` | bool | yes | Player unit frame contextual pings have the optional ability to call out the player's health and in some cases mana. This field does nothing for non player pings. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SendUnitPing(target)
```

### C_PingSecure.SetHitTestPingTarget

```lua
state = C_PingSecure.SetHitTestPingTarget(mousePosX, mousePosY, [forcePointPing])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mousePosX` | number | no |  |
| `mousePosY` | number | no |  |
| `forcePointPing` | bool | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | PingSetTargetState | no |  |

**Example**

```lua
local state = C_PingSecure.SetHitTestPingTarget(0, 0)
```

### C_PingSecure.SetHitTestTargetAndSendPing

```lua
result = C_PingSecure.SetHitTestTargetAndSendPing()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendPingResult | no |  |

**Example**

```lua
local result = C_PingSecure.SetHitTestTargetAndSendPing()
```

### C_PingSecure.SetPendingPingOffScreenCallback

```lua
C_PingSecure.SetPendingPingOffScreenCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PendingPingOffScreenCallback | no |  |

**Example**

```lua
C_PingSecure.SetPendingPingOffScreenCallback(cb)
```

### C_PingSecure.SetPingCooldownStartedCallback

```lua
C_PingSecure.SetPingCooldownStartedCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PingCooldownStartedCallback | no |  |

**Example**

```lua
C_PingSecure.SetPingCooldownStartedCallback(cb)
```

### C_PingSecure.SetPingPinFrameAddedCallback

```lua
C_PingSecure.SetPingPinFrameAddedCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PingPinFrameAddedCallback | no |  |

**Example**

```lua
C_PingSecure.SetPingPinFrameAddedCallback(cb)
```

### C_PingSecure.SetPingPinFrameRemovedCallback

```lua
C_PingSecure.SetPingPinFrameRemovedCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PingPinFrameRemovedCallback | no |  |

**Example**

```lua
C_PingSecure.SetPingPinFrameRemovedCallback(cb)
```

### C_PingSecure.SetPingPinFrameScreenClampStateUpdatedCallback

```lua
C_PingSecure.SetPingPinFrameScreenClampStateUpdatedCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PingPinFrameScreenClampStateUpdatedCallback | no |  |

**Example**

```lua
C_PingSecure.SetPingPinFrameScreenClampStateUpdatedCallback(cb)
```

### C_PingSecure.SetPingRadialWheelCreatedCallback

```lua
C_PingSecure.SetPingRadialWheelCreatedCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | PingRadialWheelCreatedCallback | no |  |

**Example**

```lua
C_PingSecure.SetPingRadialWheelCreatedCallback(cb)
```

### C_PingSecure.SetSendMacroPingCallback

```lua
C_PingSecure.SetSendMacroPingCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | SendMacroPingCallback | no |  |

**Example**

```lua
C_PingSecure.SetSendMacroPingCallback(cb)
```

### C_PingSecure.SetTogglePingListenerCallback

```lua
C_PingSecure.SetTogglePingListenerCallback(cb)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cb` | TogglePingListenerCallback | no |  |

**Example**

```lua
C_PingSecure.SetTogglePingListenerCallback(cb)
```

## Events

### UNIT_PING_PIN_ADDED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |
| `uiTextureKit` | textureKit | no |  |

### UNIT_PING_PIN_REMOVED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

## Types

### PendingPingOffScreenCallback (CallbackType)

### PingActionCooldownUIInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `durationMs` | number | no | (default: 0) |
| `remainingMs` | number | no | (default: 0) |

### PingActionUIInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no | (default: 0) |
| `itemID` | number | no | (default: 0) |
| `textureFileDataID` | number | no | (default: 0) |
| `cooldownInfo` | PingActionCooldownUIInfo | yes |  |
| `spellCategoryID` | number | no | (default: 0) |

### PingCooldownStartedCallback (CallbackType)

### PingPinFrameAddedCallback (CallbackType)

### PingPinFrameRemovedCallback (CallbackType)

### PingPinFrameScreenClampStateUpdatedCallback (CallbackType)

### PingRadialWheelCreatedCallback (CallbackType)

### SendMacroPingCallback (CallbackType)

### SendPingResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PingSubjectType | yes |  |
| `result` | PingResult | no |  |

### TogglePingListenerCallback (CallbackType)

