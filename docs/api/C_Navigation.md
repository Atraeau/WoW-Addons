# C_Navigation

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **3** events · **1** types

## Functions

### C_Navigation.GetDistance

```lua
distance = C_Navigation.GetDistance()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distance` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local distance = C_Navigation.GetDistance()
```

### C_Navigation.GetFrame

```lua
frame = C_Navigation.GetFrame()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frame` | ScriptRegion | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frame = C_Navigation.GetFrame()
```

### C_Navigation.GetNearestPartyMemberToken

```lua
unitToken = C_Navigation.GetNearestPartyMemberToken()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local unitToken = C_Navigation.GetNearestPartyMemberToken()
```

### C_Navigation.GetNextWaypointForMap

```lua
x, y, waypointDescription = C_Navigation.GetNextWaypointForMap(uiMapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiMapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `x` | number | no |  |
| `y` | number | no |  |
| `waypointDescription` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local x, y, waypointDescription = C_Navigation.GetNextWaypointForMap(0)
```

### C_Navigation.GetTargetState

```lua
state = C_Navigation.GetTargetState()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | NavigationState | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local state = C_Navigation.GetTargetState()
```

### C_Navigation.HasValidScreenPosition

```lua
hasValidScreenPosition = C_Navigation.HasValidScreenPosition()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasValidScreenPosition` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasValidScreenPosition = C_Navigation.HasValidScreenPosition()
```

### C_Navigation.WasClampedToScreen

```lua
wasClamped = C_Navigation.WasClampedToScreen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wasClamped` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wasClamped = C_Navigation.WasClampedToScreen()
```

## Events

### NAVIGATION_DESTINATION_REACHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWaypoint` | bool | no |  |

### NAVIGATION_FRAME_CREATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `region` | ScriptRegion | no |  |

### NAVIGATION_FRAME_DESTROYED

## Types

### NavigationState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Invalid` | NavigationState | no |  |
| `Occluded` | NavigationState | no |  |
| `InRange` | NavigationState | no |  |
| `Disabled` | NavigationState | no |  |

