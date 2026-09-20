# Cinematic

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **6** events · **0** types

## Functions

### Cinematic.CinematicFinished

```lua
CinematicFinished(movieType, userCanceled, didError)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieType` | CinematicType | no |  |
| `userCanceled` | bool | no | (default: False) |
| `didError` | bool | no | (default: False) |

**Example**

```lua
CinematicFinished(movieType, false, false)
```

### Cinematic.CinematicStarted

```lua
CinematicStarted(movieType, movieID, canCancel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieType` | CinematicType | no |  |
| `movieID` | number | no |  |
| `canCancel` | bool | no | (default: True) |

**Example**

```lua
CinematicStarted(movieType, 0, false)
```

### Cinematic.GetCurrentCinematicSummary

```lua
summary = GetCurrentCinematicSummary()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `summary` | cstring | no |  |

**Example**

```lua
local summary = GetCurrentCinematicSummary()
```

### Cinematic.InCinematic

```lua
inCinematic = InCinematic()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inCinematic` | bool | no |  |

**Example**

```lua
local inCinematic = InCinematic()
```

### Cinematic.MouseOverrideCinematicDisable

```lua
MouseOverrideCinematicDisable(doOverride)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `doOverride` | bool | no | (default: False) |

**Example**

```lua
MouseOverrideCinematicDisable(false)
```

### Cinematic.OpeningCinematic

```lua
OpeningCinematic()
```

**Example**

```lua
OpeningCinematic()
```

### Cinematic.StopCinematic

```lua
StopCinematic()
```

**Example**

```lua
StopCinematic()
```

## Events

### CINEMATIC_START

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canBeCancelled` | bool | no |  |
| `forcedAspectRatio` | CameraModeAspectRatio | no |  |

### CINEMATIC_STOP

### HIDE_SUBTITLE

### PLAY_MOVIE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieID` | number | no |  |

### SHOW_SUBTITLE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `subtitle` | cstring | no |  |
| `sender` | cstring | yes |  |

### STOP_MOVIE

