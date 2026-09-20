# Movie

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

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

**Example**

```lua
PreloadMovie(0)
```

