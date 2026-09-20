# C_WorldLootObject

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **1** events · **1** types

## Functions

### C_WorldLootObject.DoesSlotMatchInventoryType

```lua
matches = C_WorldLootObject.DoesSlotMatchInventoryType(slot, inventoryType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |
| `inventoryType` | InventoryType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `matches` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local matches = C_WorldLootObject.DoesSlotMatchInventoryType(1, inventoryType)
```

### C_WorldLootObject.GetWorldLootObjectDistanceSquared

```lua
distanceSquared = C_WorldLootObject.GetWorldLootObjectDistanceSquared(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `distanceSquared` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local distanceSquared = C_WorldLootObject.GetWorldLootObjectDistanceSquared("player")
```

### C_WorldLootObject.GetWorldLootObjectInfo

```lua
info = C_WorldLootObject.GetWorldLootObjectInfo(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | WorldLootObjectInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_WorldLootObject.GetWorldLootObjectInfo("player")
```

### C_WorldLootObject.GetWorldLootObjectInfoByGUID

```lua
info = C_WorldLootObject.GetWorldLootObjectInfoByGUID(objectGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | WorldLootObjectInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_WorldLootObject.GetWorldLootObjectInfoByGUID(UnitGUID("player"))
```

### C_WorldLootObject.IsWorldLootObject

```lua
isWorldLootObject = C_WorldLootObject.IsWorldLootObject(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWorldLootObject` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWorldLootObject = C_WorldLootObject.IsWorldLootObject("player")
```

### C_WorldLootObject.IsWorldLootObjectByGUID

```lua
isWorldLootObject = C_WorldLootObject.IsWorldLootObjectByGUID(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWorldLootObject` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWorldLootObject = C_WorldLootObject.IsWorldLootObjectByGUID(UnitGUID("player"))
```

### C_WorldLootObject.IsWorldLootObjectInRange

```lua
isWorldLootObjectInRange = C_WorldLootObject.IsWorldLootObjectInRange(unitToken)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWorldLootObjectInRange` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWorldLootObjectInRange = C_WorldLootObject.IsWorldLootObjectInRange("player")
```

### C_WorldLootObject.OnWorldLootObjectClick

```lua
C_WorldLootObject.OnWorldLootObjectClick(unitToken, isLeftClick)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | UnitToken | no |  |
| `isLeftClick` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_WorldLootObject.OnWorldLootObjectClick("player", false)
```

## Events

### WORLD_LOOT_OBJECT_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

## Types

### WorldLootObjectInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `inventoryType` | InventoryType | no |  |
| `atMaxQuality` | bool | no |  |
| `isUpgrade` | bool | no |  |

