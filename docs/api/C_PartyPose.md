# C_PartyPose

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **1** events · **1** types

## Functions

### C_PartyPose.ExtraAction

```lua
C_PartyPose.ExtraAction(partyPoseID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `partyPoseID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PartyPose.ExtraAction(0)
```

### C_PartyPose.GetPartyPoseInfoByID

```lua
info = C_PartyPose.GetPartyPoseInfoByID(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PartyPoseInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PartyPose.GetPartyPoseInfoByID(0)
```

### C_PartyPose.GetPartyPoseInfoByMapID

```lua
info = C_PartyPose.GetPartyPoseInfoByMapID(mapID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | PartyPoseInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_PartyPose.GetPartyPoseInfoByMapID(0)
```

### C_PartyPose.HasExtraAction

```lua
hasExtraAction = C_PartyPose.HasExtraAction(partyPoseID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `partyPoseID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasExtraAction` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local hasExtraAction = C_PartyPose.HasExtraAction(0)
```

## Events

### SHOW_PARTY_POSE_UI

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapID` | number | no |  |
| `won` | bool | no |  |

## Types

### PartyPoseInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `partyPoseID` | number | no |  |
| `mapID` | number | no |  |
| `widgetSetID` | number | yes |  |
| `victoryModelSceneID` | number | no |  |
| `defeatModelSceneID` | number | no |  |
| `victorySoundKitID` | number | no |  |
| `defeatSoundKitID` | number | no |  |
| `uiTextureKit` | textureKit | yes |  |
| `titleText` | string | yes |  |
| `extraButtonText` | string | yes |  |
| `flags` | PartyPoseFlags | no |  |

