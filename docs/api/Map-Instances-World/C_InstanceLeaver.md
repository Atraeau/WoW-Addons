# C_InstanceLeaver

[← API index](../README.md) · group: [Map, Instances & World](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**1** functions · **1** events · **0** types

## Functions

### C_InstanceLeaver.IsPlayerLeaver

Returns whether the player is considered a leaver for repeatedly abandoning mythic+ groups.

```lua
isLeaver = C_InstanceLeaver.IsPlayerLeaver()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLeaver` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isLeaver = C_InstanceLeaver.IsPlayerLeaver()
```

## Events

### INSTANCE_LEAVER_STATUS_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isLeaver` | bool | no |  |

