# Movie

[← API index](../README.md) · group: [UI, Frames & Input](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**6** functions · **0** events · **0** types

## Functions

### Movie.CancelPreloadingMovie

```lua
CancelPreloadingMovie(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
CancelPreloadingMovie(0)
```

### Movie.GetMovieDownloadProgress

```lua
inProgress, downloaded, total = GetMovieDownloadProgress(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inProgress` | bool | no |  |
| `downloaded` | BigUInteger | no |  |
| `total` | BigUInteger | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local inProgress, downloaded, total = GetMovieDownloadProgress(0)
```

### Movie.IsMovieLocal

```lua
isLocal = IsMovieLocal(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLocal` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLocal = IsMovieLocal(0)
```

### Movie.IsMoviePlayable

```lua
isPlayable = IsMoviePlayable(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlayable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlayable = IsMoviePlayable(0)
```

### Movie.IsMovieReadable

```lua
readable = IsMovieReadable(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `readable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local readable = IsMovieReadable(0)
```

### Movie.PreloadMovie

```lua
PreloadMovie(movieId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `movieId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
PreloadMovie(0)
```

