# LuaCurveObjectBaseAPI

[← API index](../README.md) · group: [System & Config](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**3** functions · **0** events · **0** types

## Functions

### LuaCurveObjectBaseAPI.GetType

Returns the configured type of the curve.

```lua
curveType = GetType()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `curveType` | LuaCurveType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local curveType = GetType()
```

### LuaCurveObjectBaseAPI.HasSecretValues

Returns true if the curve has been configured with any secret values. Curves with secret values always produce secret results when evaluated.

```lua
hasSecretValues = HasSecretValues()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSecretValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasSecretValues = HasSecretValues()
```

### LuaCurveObjectBaseAPI.SetType

Changes the evaluation type of the curve.

```lua
SetType(type)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | LuaCurveType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetType(type)
```

