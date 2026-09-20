# C_Sound

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**6** functions · **2** events · **2** types

## Functions

### C_Sound.GetSoundScaledVolume

```lua
scaledVolume = C_Sound.GetSoundScaledVolume(soundHandle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundHandle` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scaledVolume` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scaledVolume = C_Sound.GetSoundScaledVolume(0)
```

### C_Sound.IsPlaying

```lua
isPlaying = C_Sound.IsPlaying(soundHandle)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundHandle` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPlaying` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isPlaying = C_Sound.IsPlaying(0)
```

### C_Sound.PlayItemSound

```lua
C_Sound.PlayItemSound(soundType, itemLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundType` | ItemSoundType | no |  |
| `itemLocation` | ItemLocation | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Sound.PlayItemSound(soundType, 6948)
```

### C_Sound.PlaySound

```lua
success, soundHandle = C_Sound.PlaySound(soundKitID, uiSoundSubType, forceNoDuplicates, runFinishCallback, [overridePriority], [volumeOverride])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundKitID` | number | no |  |
| `uiSoundSubType` | UISoundSubType | no | (default: g_defaultSI3UISoundSubTypeForLua) |
| `forceNoDuplicates` | bool | no | (default: False) |
| `runFinishCallback` | bool | no | (default: False) |
| `overridePriority` | number | yes |  |
| `volumeOverride` | number | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `soundHandle` | SoundHandle | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success, soundHandle = C_Sound.PlaySound(0, uiSoundSubType, false, false)
```

### C_Sound.PlaySoundWithOptions

```lua
success, soundHandle = C_Sound.PlaySoundWithOptions(params)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `params` | PlaySoundParams | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `soundHandle` | SoundHandle | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local success, soundHandle = C_Sound.PlaySoundWithOptions(params)
```

### C_Sound.PlayVocalErrorSound

```lua
C_Sound.PlayVocalErrorSound(vocalErrorSoundID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vocalErrorSoundID` | Vocalerrorsounds | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_Sound.PlayVocalErrorSound(vocalErrorSoundID)
```

## Events

### SOUND_DEVICE_UPDATE

### SOUNDKIT_FINISHED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundHandle` | number | no |  |

## Types

### PlaySoundParams (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `soundKitID` | number | no |  |
| `uiSoundSubType` | UISoundSubType | no | (default: g_defaultSI3UISoundSubTypeForLua) |
| `forceNoDuplicates` | bool | no | (default: False) |
| `runFinishCallback` | bool | no | (default: False) |
| `overridePriority` | number | yes |  |
| `volumeOverride` | number | yes |  |

### PlaySoundResult (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |
| `soundHandle` | SoundHandle | no |  |

