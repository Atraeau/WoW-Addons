# SimpleMovieAPI

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**4** functions · **0** events · **0** types

## Functions

### SimpleMovieAPI.EnableSubtitles

```lua
EnableSubtitles(enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
EnableSubtitles(false)
```

### SimpleMovieAPI.StartMovie

```lua
success, returnCode = StartMovie(movieID, looping)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieID` | number | no |  |
| `looping` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `returnCode` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success, returnCode = StartMovie(0, false)
```

### SimpleMovieAPI.StartMovieByName

```lua
success, returnCode = StartMovieByName(movieName, looping, resolution)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieName` | cstring | no |  |
| `looping` | bool | no | (default: False) |
| `resolution` | number | no | (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `returnCode` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success, returnCode = StartMovieByName("", false, 0)
```

### SimpleMovieAPI.StopMovie

```lua
StopMovie()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopMovie()
```

