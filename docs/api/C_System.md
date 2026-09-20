# C_System

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **28** events · **0** types

## Functions

### C_System.GetFrameStack

```lua
objects = C_System.GetFrameStack()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objects` | ScriptRegion[] | no |  |

**Example**

```lua
local objects = C_System.GetFrameStack()
```

## Events

### CAPTUREFRAMES_FAILED

### CAPTUREFRAMES_SUCCEEDED

### DISABLE_TAXI_BENCHMARK

### ENABLE_TAXI_BENCHMARK

### FIRST_FRAME_RENDERED

### GENERIC_ERROR

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorMessage` | cstring | no |  |

### GLOBAL_MOUSE_DOWN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no |  |

### GLOBAL_MOUSE_UP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `button` | cstring | no |  |

### INITIAL_HOTFIXES_APPLIED

### LOC_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | cstring | no |  |

### LOGOUT_CANCEL

### PLAYER_CAMPING

### PLAYER_ENTERING_WORLD

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInitialLogin` | bool | no |  |
| `isReloadingUi` | bool | no |  |

### PLAYER_LEAVING_WORLD

### PLAYER_LOGIN

### PLAYER_LOGOUT

### PLAYER_QUITING

### SEARCH_DB_LOADED

### SHARD_TRANSFER

### SHARD_TRANSFER_IMMINENT

### STREAMING_ICON

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `streamingStatus` | number | no |  |

### SYSMSG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `string` | cstring | no |  |
| `r` | number | no |  |
| `g` | number | no |  |
| `b` | number | no |  |

### TIME_PLAYED_MSG

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalTimePlayed` | number | no |  |
| `timePlayedThisLevel` | number | no |  |

### UI_ERROR_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorType` | luaIndex | no |  |
| `message` | string | no |  |

### UI_ERROR_POPUP

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorType` | luaIndex | no |  |
| `message` | string | no |  |

### UI_INFO_MESSAGE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorType` | luaIndex | no |  |
| `message` | string | no |  |

### VARIABLES_LOADED

### WOW_MOUSE_NOT_FOUND

