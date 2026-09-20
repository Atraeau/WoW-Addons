# RaidMarkers

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**9** functions · **0** events · **0** types

## Functions

### RaidMarkers.CanBeRaidTarget

```lua
result = CanBeRaidTarget(target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = CanBeRaidTarget(target)
```

### RaidMarkers.ClearRaidMarker

```lua
ClearRaidMarker(raidMarkerIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `raidMarkerIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
ClearRaidMarker(1)
```

### RaidMarkers.GetNextAvailableRaidTargetMarkerIndex

```lua
nextAvailableRaidTargetMarkerIndex = GetNextAvailableRaidTargetMarkerIndex(startIndex, reverseSearch, wrapSearch, treatDeadNonFriendlyAsAvailable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startIndex` | luaIndex | no |  |
| `reverseSearch` | bool | no | (default: False) |
| `wrapSearch` | bool | no | (default: False) |
| `treatDeadNonFriendlyAsAvailable` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `nextAvailableRaidTargetMarkerIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local nextAvailableRaidTargetMarkerIndex = GetNextAvailableRaidTargetMarkerIndex(1, false, false, false)
```

### RaidMarkers.GetRaidTargetIndex

```lua
result = GetRaidTargetIndex(target)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | luaIndex | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = GetRaidTargetIndex(target)
```

### RaidMarkers.IsRaidMarkerActive

```lua
result = IsRaidMarkerActive(index)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = IsRaidMarkerActive(1)
```

### RaidMarkers.IsRaidMarkerSystemEnabled

```lua
enabled = IsRaidMarkerSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local enabled = IsRaidMarkerSystemEnabled()
```

### RaidMarkers.PlaceRaidMarker

```lua
PlaceRaidMarker(index, [token])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | luaIndex | no |  |
| `token` | cstring | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
PlaceRaidMarker(1)
```

### RaidMarkers.RemoveRaidTargets

Removes all assigned raid target markers.

```lua
RemoveRaidTargets()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
RemoveRaidTargets()
```

### RaidMarkers.SetRaidTarget

```lua
SetRaidTarget(target, userIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | UnitToken | no |  |
| `userIndex` | luaIndex | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetRaidTarget(target, 1)
```

