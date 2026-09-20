# C_SplashScreen

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**5** functions · **1** events · **1** types

## Functions

### C_SplashScreen.AcknowledgeSplash

```lua
C_SplashScreen.AcknowledgeSplash()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SplashScreen.AcknowledgeSplash()
```

### C_SplashScreen.CanViewSplashScreen

```lua
canView = C_SplashScreen.CanViewSplashScreen()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canView` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canView = C_SplashScreen.CanViewSplashScreen()
```

### C_SplashScreen.RequestLatestSplashScreen

```lua
C_SplashScreen.RequestLatestSplashScreen(fromGameMenu)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fromGameMenu` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SplashScreen.RequestLatestSplashScreen(false)
```

### C_SplashScreen.SendSplashScreenActionLaunchedTelem

```lua
C_SplashScreen.SendSplashScreenActionLaunchedTelem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SplashScreen.SendSplashScreenActionLaunchedTelem()
```

### C_SplashScreen.SendSplashScreenCloseTelem

```lua
C_SplashScreen.SendSplashScreenCloseTelem()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SplashScreen.SendSplashScreenCloseTelem()
```

## Events

### OPEN_SPLASH_SCREEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | SplashScreenInfo | yes |  |

## Types

### SplashScreenInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureKit` | textureKit | no |  |
| `minDisplayCharLevel` | number | no |  |
| `minQuestDisplayLevel` | number | no |  |
| `soundKitID` | number | no |  |
| `allianceQuestID` | number | yes |  |
| `hordeQuestID` | number | yes |  |
| `header` | string | no |  |
| `topLeftFeatureTitle` | string | no |  |
| `topLeftFeatureDesc` | string | no |  |
| `bottomLeftFeatureTitle` | string | no |  |
| `bottomLeftFeatureDesc` | string | no |  |
| `rightFeatureTitle` | string | no |  |
| `rightFeatureDesc` | string | no |  |
| `shouldShowQuest` | bool | no |  |
| `screenType` | SplashScreenType | no |  |
| `gameMenuRequest` | bool | no |  |

