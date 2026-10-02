# GameError

[← API index](../README.md) · group: [UI Systems & Input](README.md)

> Generated from the WoW: Forever client (build 70170, interface 16001) on 2026-10-01 21:34:30.

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local errorName, soundKitID, voiceID = GetGameMessageInfo(1)
```

### GameError.NotWhileDeadError

```lua
NotWhileDeadError()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
NotWhileDeadError()
```
