# C_PlayerInteractionManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **2** events · **0** types

## Functions

### C_PlayerInteractionManager.ClearInteraction

```lua
C_PlayerInteractionManager.ClearInteraction([type])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | yes |  |

**Example**

```lua
C_PlayerInteractionManager.ClearInteraction()
```

### C_PlayerInteractionManager.ConfirmationInteraction

```lua
C_PlayerInteractionManager.ConfirmationInteraction([type])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | yes |  |

**Example**

```lua
C_PlayerInteractionManager.ConfirmationInteraction()
```

### C_PlayerInteractionManager.InteractUnit

```lua
success = C_PlayerInteractionManager.InteractUnit(unit, exactMatch, looseTargeting)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | string | no |  |
| `exactMatch` | bool | no | (default: False) |
| `looseTargeting` | bool | no | (default: True) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_PlayerInteractionManager.InteractUnit("player", false, false)
```

### C_PlayerInteractionManager.IsInteractingWithNpcOfType

```lua
interacting = C_PlayerInteractionManager.IsInteractingWithNpcOfType(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `interacting` | bool | no |  |

**Example**

```lua
local interacting = C_PlayerInteractionManager.IsInteractingWithNpcOfType(type)
```

### C_PlayerInteractionManager.IsReplacingUnit

```lua
replacing = C_PlayerInteractionManager.IsReplacingUnit()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `replacing` | bool | no |  |

**Example**

```lua
local replacing = C_PlayerInteractionManager.IsReplacingUnit()
```

### C_PlayerInteractionManager.IsValidNPCInteraction

```lua
isValidInteraction = C_PlayerInteractionManager.IsValidNPCInteraction(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isValidInteraction` | bool | no |  |

**Example**

```lua
local isValidInteraction = C_PlayerInteractionManager.IsValidNPCInteraction(type)
```

### C_PlayerInteractionManager.ReopenInteraction

```lua
C_PlayerInteractionManager.ReopenInteraction()
```

**Example**

```lua
C_PlayerInteractionManager.ReopenInteraction()
```

### C_PlayerInteractionManager.ShardTransferConfirm

```lua
C_PlayerInteractionManager.ShardTransferConfirm()
```

**Example**

```lua
C_PlayerInteractionManager.ShardTransferConfirm()
```

## Events

### PLAYER_INTERACTION_MANAGER_FRAME_HIDE

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | no |  |

### PLAYER_INTERACTION_MANAGER_FRAME_SHOW

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | PlayerInteractionType | no |  |

