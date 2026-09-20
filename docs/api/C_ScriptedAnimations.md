# C_ScriptedAnimations

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**1** functions · **1** events · **4** types

## Functions

### C_ScriptedAnimations.GetAllScriptedAnimationEffects

```lua
scriptedAnimationEffects = C_ScriptedAnimations.GetAllScriptedAnimationEffects()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scriptedAnimationEffects` | ScriptedAnimationEffect[] | no |  |

**Example**

```lua
local scriptedAnimationEffects = C_ScriptedAnimations.GetAllScriptedAnimationEffects()
```

## Events

### SCRIPTED_ANIMATIONS_UPDATE

## Types

### ScriptedAnimationBehavior (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ScriptedAnimationBehavior | no |  |
| `TargetShake` | ScriptedAnimationBehavior | no |  |
| `TargetKnockBack` | ScriptedAnimationBehavior | no |  |
| `SourceRecoil` | ScriptedAnimationBehavior | no |  |
| `SourceCollideWithTarget` | ScriptedAnimationBehavior | no |  |
| `UIParentShake` | ScriptedAnimationBehavior | no |  |

### ScriptedAnimationEffect (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `visual` | fileID | no |  |
| `visualScale` | number | no |  |
| `duration` | number | no |  |
| `trajectory` | ScriptedAnimationTrajectory | no |  |
| `yawRadians` | number | no |  |
| `pitchRadians` | number | no |  |
| `rollRadians` | number | no |  |
| `offsetX` | number | no |  |
| `offsetY` | number | no |  |
| `offsetZ` | number | no |  |
| `animation` | number | no |  |
| `animationSpeed` | number | no |  |
| `alpha` | number | no |  |
| `useTargetAsSource` | bool | no |  |
| `startBehavior` | ScriptedAnimationBehavior | yes |  |
| `startSoundKitID` | number | yes |  |
| `finishEffectID` | number | yes |  |
| `finishBehavior` | ScriptedAnimationBehavior | yes |  |
| `finishSoundKitID` | number | yes |  |
| `startAlphaFade` | number | yes |  |
| `startAlphaFadeDuration` | number | yes |  |
| `endAlphaFade` | number | yes |  |
| `endAlphaFadeDuration` | number | yes |  |
| `animationStartOffset` | number | yes |  |
| `loopingSoundKitID` | number | yes |  |
| `particleOverrideScale` | number | yes |  |

### ScriptedAnimationFlags (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `UseTargetAsSource` | ScriptedAnimationFlags | no |  |

### ScriptedAnimationTrajectory (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `AtSource` | ScriptedAnimationTrajectory | no |  |
| `AtTarget` | ScriptedAnimationTrajectory | no |  |
| `Straight` | ScriptedAnimationTrajectory | no |  |
| `CurveLeft` | ScriptedAnimationTrajectory | no |  |
| `CurveRight` | ScriptedAnimationTrajectory | no |  |
| `CurveRandom` | ScriptedAnimationTrajectory | no |  |
| `HalfwayBetween` | ScriptedAnimationTrajectory | no |  |

