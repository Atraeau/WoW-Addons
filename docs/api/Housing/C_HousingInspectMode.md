# C_HousingInspectMode

[← API index](../README.md) · group: [Housing](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**5** functions · **2** events · **0** types

## Functions

### C_HousingInspectMode.EnterInspectMode

Enters inspect mode, enabling decor inspection

```lua
C_HousingInspectMode.EnterInspectMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingInspectMode.EnterInspectMode()
```

### C_HousingInspectMode.ExitInspectMode

Exits inspect mode, disabling decor inspection

```lua
C_HousingInspectMode.ExitInspectMode()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_HousingInspectMode.ExitInspectMode()
```

### C_HousingInspectMode.GetHoveredDecorGUID

Returns the GUID of the decor instance currently being hovered, if there is one

```lua
decorGUID = C_HousingInspectMode.GetHoveredDecorGUID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `decorGUID` | WOWGUID | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local decorGUID = C_HousingInspectMode.GetHoveredDecorGUID()
```

### C_HousingInspectMode.IsHoveringDecor

Returns true if a decor instance is currently being hovered in inspect mode

```lua
isHoveringDecor = C_HousingInspectMode.IsHoveringDecor()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHoveringDecor` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isHoveringDecor = C_HousingInspectMode.IsHoveringDecor()
```

### C_HousingInspectMode.IsInInspectMode

Returns true if the player is currently in inspect mode

```lua
isInInspectMode = C_HousingInspectMode.IsInInspectMode()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInInspectMode` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isInInspectMode = C_HousingInspectMode.IsInInspectMode()
```

## Events

### HOUSING_INSPECT_MODE_DECOR_HOVERED_CHANGED

### HOUSING_INSPECT_MODE_STATE_UPDATED

