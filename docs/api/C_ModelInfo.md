# C_ModelInfo

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**8** functions · **1** events · **3** types

## Functions

### C_ModelInfo.AddActiveModelScene

This function does nothing in public clients

```lua
C_ModelInfo.AddActiveModelScene(modelSceneFrame, modelSceneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneFrame` | ModelSceneFrame | no |  |
| `modelSceneID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ModelInfo.AddActiveModelScene(modelSceneFrame, 0)
```

### C_ModelInfo.AddActiveModelSceneActor

This function does nothing in public clients

```lua
C_ModelInfo.AddActiveModelSceneActor(modelSceneFrameActor, modelSceneActorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneFrameActor` | ModelSceneFrameActor | no |  |
| `modelSceneActorID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ModelInfo.AddActiveModelSceneActor(modelSceneFrameActor, 0)
```

### C_ModelInfo.ClearActiveModelScene

This function does nothing in public clients

```lua
C_ModelInfo.ClearActiveModelScene(modelSceneFrame)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneFrame` | ModelSceneFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ModelInfo.ClearActiveModelScene(modelSceneFrame)
```

### C_ModelInfo.ClearActiveModelSceneActor

This function does nothing in public clients

```lua
C_ModelInfo.ClearActiveModelSceneActor(modelSceneFrameActor)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneFrameActor` | ModelSceneFrameActor | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ModelInfo.ClearActiveModelSceneActor(modelSceneFrameActor)
```

### C_ModelInfo.GetModelSceneActorDisplayInfoByID

```lua
actorDisplayInfo = C_ModelInfo.GetModelSceneActorDisplayInfoByID(modelActorDisplayID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelActorDisplayID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actorDisplayInfo` | UIModelSceneActorDisplayInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local actorDisplayInfo = C_ModelInfo.GetModelSceneActorDisplayInfoByID(0)
```

### C_ModelInfo.GetModelSceneActorInfoByID

```lua
actorInfo = C_ModelInfo.GetModelSceneActorInfoByID(modelActorID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelActorID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actorInfo` | UIModelSceneActorInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local actorInfo = C_ModelInfo.GetModelSceneActorInfoByID(0)
```

### C_ModelInfo.GetModelSceneCameraInfoByID

```lua
modelSceneCameraInfo = C_ModelInfo.GetModelSceneCameraInfoByID(modelSceneCameraID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneCameraID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneCameraInfo` | UIModelSceneCameraInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modelSceneCameraInfo = C_ModelInfo.GetModelSceneCameraInfoByID(0)
```

### C_ModelInfo.GetModelSceneInfoByID

```lua
modelSceneType, modelCameraIDs, modelActorsIDs, flags = C_ModelInfo.GetModelSceneInfoByID(modelSceneID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneType` | ModelSceneType | no |  |
| `modelCameraIDs` | number[] | no |  |
| `modelActorsIDs` | number[] | no |  |
| `flags` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local modelSceneType, modelCameraIDs, modelActorsIDs, flags = C_ModelInfo.GetModelSceneInfoByID(0)
```

## Events

### UI_MODEL_SCENE_INFO_UPDATED

## Types

### UIModelSceneActorDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `animation` | number | no |  |
| `animationVariation` | number | no |  |
| `animSpeed` | number | no |  |
| `animationKitID` | number | yes |  |
| `spellVisualKitID` | number | yes |  |
| `alpha` | number | no |  |
| `scale` | number | no |  |

### UIModelSceneActorInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelActorID` | number | no |  |
| `scriptTag` | cstring | no |  |
| `position` | vector3 | no |  |
| `yaw` | number | no |  |
| `pitch` | number | no |  |
| `roll` | number | no |  |
| `normalizeScaleAggressiveness` | number | yes |  |
| `useCenterForOriginX` | bool | no |  |
| `useCenterForOriginY` | bool | no |  |
| `useCenterForOriginZ` | bool | no |  |
| `modelActorDisplayID` | number | yes |  |

### UIModelSceneCameraInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `modelSceneCameraID` | number | no |  |
| `scriptTag` | cstring | no |  |
| `cameraType` | cstring | no |  |
| `target` | vector3 | no |  |
| `yaw` | number | no |  |
| `pitch` | number | no |  |
| `roll` | number | no |  |
| `zoomDistance` | number | no |  |
| `minZoomDistance` | number | no |  |
| `maxZoomDistance` | number | no |  |
| `zoomedTargetOffset` | vector3 | no |  |
| `zoomedYawOffset` | number | no |  |
| `zoomedPitchOffset` | number | no |  |
| `zoomedRollOffset` | number | no |  |
| `flags` | ModelSceneSetting | no |  |

