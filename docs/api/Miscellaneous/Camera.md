# Camera

[← API index](../README.md) · group: [Miscellaneous](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**2** functions · **0** events · **0** types

## Functions

### Camera.GetCameraFOVDefaults

```lua
fieldOfViewDegreesDefault, fieldOfViewDegreesPlayerMin, fieldOfViewDegreesPlayerMax = GetCameraFOVDefaults()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fieldOfViewDegreesDefault` | number | no |  |
| `fieldOfViewDegreesPlayerMin` | number | no |  |
| `fieldOfViewDegreesPlayerMax` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local fieldOfViewDegreesDefault, fieldOfViewDegreesPlayerMin, fieldOfViewDegreesPlayerMax = GetCameraFOVDefaults()
```

### Camera.GetUICameraInfo

```lua
posX, posY, posZ, lookAtX, lookAtY, lookAtZ, animID, animVariation, animFrame, useModelCenter = GetUICameraInfo(uiCameraID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `uiCameraID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `posX` | number | no |  |
| `posY` | number | no |  |
| `posZ` | number | no |  |
| `lookAtX` | number | no |  |
| `lookAtY` | number | no |  |
| `lookAtZ` | number | no |  |
| `animID` | number | no |  |
| `animVariation` | number | no |  |
| `animFrame` | number | no |  |
| `useModelCenter` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local posX, posY, posZ, lookAtX, lookAtY, lookAtZ, animID, animVariation, animFrame, useModelCenter = GetUICameraInfo(0)
```

