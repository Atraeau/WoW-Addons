# Expansion

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**23** functions · **3** events · **4** types

## Functions

### Expansion.CanUpgradeToCurrentExpansion

```lua
canUpgradeExpansion = CanUpgradeToCurrentExpansion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canUpgradeExpansion` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canUpgradeExpansion = CanUpgradeToCurrentExpansion()
```

### Expansion.DoesCurrentLocaleSellExpansionLevels

```lua
regionSellsExpansions = DoesCurrentLocaleSellExpansionLevels()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `regionSellsExpansions` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local regionSellsExpansions = DoesCurrentLocaleSellExpansionLevels()
```

### Expansion.GetAccountExpansionLevel

```lua
expansionLevel = GetAccountExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetAccountExpansionLevel()
```

### Expansion.GetClientDisplayExpansionLevel

```lua
expansionLevel = GetClientDisplayExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetClientDisplayExpansionLevel()
```

### Expansion.GetCurrentRegionName

```lua
regionName = GetCurrentRegionName()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `regionName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local regionName = GetCurrentRegionName()
```

### Expansion.GetExpansionDisplayInfo

```lua
info = GetExpansionDisplayInfo(expansionLevel, [desiredReleaseType])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |
| `desiredReleaseType` | ReleaseType | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ExpansionDisplayInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = GetExpansionDisplayInfo(0)
```

### Expansion.GetExpansionForLevel

```lua
expansionLevel = GetExpansionForLevel(playerLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetExpansionForLevel(0)
```

### Expansion.GetExpansionLevel

```lua
expansionLevel = GetExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetExpansionLevel()
```

### Expansion.GetExpansionTrialInfo

```lua
isExpansionTrialAccount, expansionTrialRemainingSeconds = GetExpansionTrialInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isExpansionTrialAccount` | bool | no |  |
| `expansionTrialRemainingSeconds` | time_t | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isExpansionTrialAccount, expansionTrialRemainingSeconds = GetExpansionTrialInfo()
```

### Expansion.GetMaximumExpansionLevel

```lua
expansionLevel = GetMaximumExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetMaximumExpansionLevel()
```

### Expansion.GetMaxLevelForExpansionLevel

Maps an expansion level to a maximum character level for that expansion.

```lua
maxLevel = GetMaxLevelForExpansionLevel(expansionLevel)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxLevel = GetMaxLevelForExpansionLevel(0)
```

### Expansion.GetMaxLevelForLatestExpansion

```lua
maxLevel = GetMaxLevelForLatestExpansion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxLevel = GetMaxLevelForLatestExpansion()
```

### Expansion.GetMaxLevelForPlayerExpansion

```lua
maxLevel = GetMaxLevelForPlayerExpansion()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local maxLevel = GetMaxLevelForPlayerExpansion()
```

### Expansion.GetMinimumExpansionLevel

```lua
expansionLevel = GetMinimumExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionLevel = GetMinimumExpansionLevel()
```

### Expansion.GetNumExpansions

```lua
numExpansions = GetNumExpansions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numExpansions` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numExpansions = GetNumExpansions()
```

### Expansion.GetServerExpansionLevel

```lua
serverExpansionLevel = GetServerExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `serverExpansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local serverExpansionLevel = GetServerExpansionLevel()
```

### Expansion.GetUpgradeExpansionLevel

```lua
upgradeExpansionLevel = GetUpgradeExpansionLevel()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `upgradeExpansionLevel` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local upgradeExpansionLevel = GetUpgradeExpansionLevel()
```

### Expansion.IsDemonHunterAvailable

```lua
available = IsDemonHunterAvailable()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `available` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local available = IsDemonHunterAvailable()
```

### Expansion.IsExpansionTrial

```lua
isExpansionTrialAccount = IsExpansionTrial()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isExpansionTrialAccount` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isExpansionTrialAccount = IsExpansionTrial()
```

### Expansion.IsTrialAccount

```lua
isTrialAccount = IsTrialAccount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isTrialAccount` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isTrialAccount = IsTrialAccount()
```

### Expansion.IsVeteranTrialAccount

```lua
isVeteranTrialAccount = IsVeteranTrialAccount()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isVeteranTrialAccount` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isVeteranTrialAccount = IsVeteranTrialAccount()
```

### Expansion.SendSubscriptionInterstitialResponse

```lua
SendSubscriptionInterstitialResponse(response)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `response` | SubscriptionInterstitialResponseType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SendSubscriptionInterstitialResponse(Enum.SubscriptionInterstitialResponseType.Clicked)
```

### Expansion.ShouldShowExpansionUpgradeBanner

```lua
showUpgradeBanner = ShouldShowExpansionUpgradeBanner()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showUpgradeBanner` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local showUpgradeBanner = ShouldShowExpansionUpgradeBanner()
```

## Events

### MAX_EXPANSION_LEVEL_UPDATED

### MIN_EXPANSION_LEVEL_UPDATED

### SHOW_SUBSCRIPTION_INTERSTITIAL

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | SubscriptionInterstitialType | no |  |

## Types

### ExpansionDisplayInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `logo` | fileID | no |  |
| `banner` | textureAtlas | no |  |
| `features` | ExpansionDisplayInfoFeature[] | no |  |
| `highResBackgroundID` | fileID | no |  |
| `lowResBackgroundID` | fileID | no |  |
| `textureKit` | textureKit | no |  |
| `glueAmbianceSoundKit` | number | yes |  |
| `glueMusicSoundKit` | number | yes |  |
| `glueCreditsSoundKit` | number | yes |  |

### ExpansionDisplayInfoFeature (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `icon` | fileID | no |  |
| `text` | cstring | no |  |

### SubscriptionInterstitialResponseType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Clicked` | SubscriptionInterstitialResponseType | no |  |
| `Closed` | SubscriptionInterstitialResponseType | no |  |
| `WebRedirect` | SubscriptionInterstitialResponseType | no |  |

### SubscriptionInterstitialType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Standard` | SubscriptionInterstitialType | no |  |
| `LeftNpeArea` | SubscriptionInterstitialType | no |  |
| `MaxLevel` | SubscriptionInterstitialType | no |  |

