# C_PlayerChoice

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**7** functions · **2** events · **8** types

## Functions

### C_PlayerChoice.GetCurrentPlayerChoiceInfo

```lua
choiceInfo = C_PlayerChoice.GetCurrentPlayerChoiceInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `choiceInfo` | PlayerChoiceInfo | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local choiceInfo = C_PlayerChoice.GetCurrentPlayerChoiceInfo()
```

### C_PlayerChoice.GetNumRerolls

```lua
numRerolls = C_PlayerChoice.GetNumRerolls()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numRerolls` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numRerolls = C_PlayerChoice.GetNumRerolls()
```

### C_PlayerChoice.GetRemainingTime

```lua
remainingTime = C_PlayerChoice.GetRemainingTime()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `remainingTime` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local remainingTime = C_PlayerChoice.GetRemainingTime()
```

### C_PlayerChoice.IsWaitingForPlayerChoiceResponse

```lua
isWaitingForResponse = C_PlayerChoice.IsWaitingForPlayerChoiceResponse()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isWaitingForResponse` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isWaitingForResponse = C_PlayerChoice.IsWaitingForPlayerChoiceResponse()
```

### C_PlayerChoice.OnUIClosed

```lua
C_PlayerChoice.OnUIClosed()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PlayerChoice.OnUIClosed()
```

### C_PlayerChoice.RequestRerollPlayerChoice

```lua
C_PlayerChoice.RequestRerollPlayerChoice()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PlayerChoice.RequestRerollPlayerChoice()
```

### C_PlayerChoice.SendPlayerChoiceResponse

```lua
C_PlayerChoice.SendPlayerChoiceResponse(responseID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `responseID` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_PlayerChoice.SendPlayerChoiceResponse(0)
```

## Events

### PLAYER_CHOICE_CLOSE

### PLAYER_CHOICE_UPDATE

## Types

### PlayerChoiceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `objectGUID` | WOWGUID | no |  |
| `choiceID` | number | no |  |
| `questionText` | string | no |  |
| `pendingChoiceText` | string | no |  |
| `uiTextureKit` | textureKit | no |  |
| `hideWarboardHeader` | bool | no |  |
| `keepOpenAfterChoice` | bool | no |  |
| `requiresSelection` | bool | no |  |
| `hideAnswerArt` | bool | no |  |
| `playerChoiceLayout` | PlayerChoiceLayout | no |  |
| `options` | PlayerChoiceOptionInfo[] | no |  |
| `soundKitID` | number | yes |  |
| `closeUISoundKitID` | number | yes |  |

### PlayerChoiceOptionButtonInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `text` | string | no |  |
| `disabled` | bool | no |  |
| `showCheckmark` | bool | no |  |
| `hideButtonShowText` | bool | no |  |
| `selected` | bool | no |  |
| `confirmation` | string | yes |  |
| `tooltip` | string | yes |  |
| `rewardQuestID` | number | yes |  |
| `soundKitID` | number | yes |  |
| `listText` | string | yes |  |

### PlayerChoiceOptionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `description` | string | no |  |
| `header` | string | no |  |
| `choiceArtID` | number | no |  |
| `desaturatedArt` | bool | no |  |
| `disabledOption` | bool | no |  |
| `hasRewards` | bool | no |  |
| `rewardInfo` | PlayerChoiceOptionRewardInfo | no |  |
| `uiTextureKit` | textureKit | no |  |
| `maxStacks` | number | no |  |
| `buttons` | PlayerChoiceOptionButtonInfo[] | no |  |
| `widgetSetID` | number | yes |  |
| `spellID` | number | yes |  |
| `rarity` | PlayerChoiceRarity | yes |  |
| `typeArtID` | number | yes |  |
| `headerIconAtlasElement` | string | yes |  |
| `subHeader` | string | yes |  |
| `consolidateWidgets` | bool | no |  |

### PlayerChoiceOptionRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyRewards` | PlayerChoiceRewardCurrencyInfo[] | no |  |
| `itemRewards` | PlayerChoiceRewardItemInfo[] | no |  |
| `repRewards` | PlayerChoiceRewardReputationInfo[] | no |  |

### PlayerChoiceRarity (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Common` | PlayerChoiceRarity | no |  |
| `Uncommon` | PlayerChoiceRarity | no |  |
| `Rare` | PlayerChoiceRarity | no |  |
| `Epic` | PlayerChoiceRarity | no |  |

### PlayerChoiceRewardCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currencyId` | number | no |  |
| `name` | string | no |  |
| `currencyTexture` | number | no |  |
| `quantity` | number | no |  |
| `isCurrencyContainer` | bool | no |  |

### PlayerChoiceRewardItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemId` | number | no |  |
| `name` | string | no |  |
| `quantity` | number | no |  |

### PlayerChoiceRewardReputationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `factionId` | number | no |  |
| `quantity` | number | no |  |

