# GameError

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **0** types

## Functions

### GameError.GetGameMessageInfo

```lua
errorName, soundKitID, voiceID = GetGameMessageInfo(gameErrorIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `gameErrorIndex` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `errorName` | cstring | no |  |
| `soundKitID` | number | yes |  |
| `voiceID` | number | yes |  |

**Example**

```lua
local errorName, soundKitID, voiceID = GetGameMessageInfo(1)
```

### GameError.NotWhileDeadError

```lua
NotWhileDeadError()
```

**Example**

```lua
NotWhileDeadError()
```

