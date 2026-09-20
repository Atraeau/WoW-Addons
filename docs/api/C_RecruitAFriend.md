# C_RecruitAFriend

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**16** functions · **5** events · **17** types

## Functions

### C_RecruitAFriend.CanSummonFriend

```lua
canSummon, reason = C_RecruitAFriend.CanSummonFriend(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canSummon` | bool | no |  |
| `reason` | RecruitAFriendFailure | no |  |

**Example**

```lua
local canSummon, reason = C_RecruitAFriend.CanSummonFriend("Creature-0-0000-0-0-0-0")
```

### C_RecruitAFriend.ClaimActivityReward

```lua
success = C_RecruitAFriend.ClaimActivityReward(activityID, acceptanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `acceptanceID` | RecruitAcceptanceID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_RecruitAFriend.ClaimActivityReward(0, acceptanceID)
```

### C_RecruitAFriend.ClaimNextReward

```lua
success = C_RecruitAFriend.ClaimNextReward([rafVersion])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rafVersion` | RecruitAFriendRewardsVersion | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_RecruitAFriend.ClaimNextReward()
```

### C_RecruitAFriend.GenerateRecruitmentLink

```lua
success = C_RecruitAFriend.GenerateRecruitmentLink()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_RecruitAFriend.GenerateRecruitmentLink()
```

### C_RecruitAFriend.GetRAFInfo

```lua
info = C_RecruitAFriend.GetRAFInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RafInfo | no |  |

**Example**

```lua
local info = C_RecruitAFriend.GetRAFInfo()
```

### C_RecruitAFriend.GetRAFSystemInfo

```lua
systemInfo = C_RecruitAFriend.GetRAFSystemInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `systemInfo` | RafSystemInfo | no |  |

**Example**

```lua
local systemInfo = C_RecruitAFriend.GetRAFSystemInfo()
```

### C_RecruitAFriend.GetRecruitActivityRequirementsText

```lua
requirementsText = C_RecruitAFriend.GetRecruitActivityRequirementsText(activityID, acceptanceID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `acceptanceID` | RecruitAcceptanceID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requirementsText` | string[] | no |  |

**Example**

```lua
local requirementsText = C_RecruitAFriend.GetRecruitActivityRequirementsText(0, acceptanceID)
```

### C_RecruitAFriend.GetRecruitInfo

```lua
active, faction = C_RecruitAFriend.GetRecruitInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `active` | bool | no |  |
| `faction` | number | no |  |

**Example**

```lua
local active, faction = C_RecruitAFriend.GetRecruitInfo()
```

### C_RecruitAFriend.GetSummonFriendCooldown

```lua
startTimeSeconds, durationSeconds, enableCooldownTimer = C_RecruitAFriend.GetSummonFriendCooldown()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `startTimeSeconds` | number | no |  |
| `durationSeconds` | number | no |  |
| `enableCooldownTimer` | bool | no |  |

**Example**

```lua
local startTimeSeconds, durationSeconds, enableCooldownTimer = C_RecruitAFriend.GetSummonFriendCooldown()
```

### C_RecruitAFriend.IsRecruitAFriendLinked

```lua
result = C_RecruitAFriend.IsRecruitAFriendLinked(guid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `guid` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | bool | no |  |

**Example**

```lua
local result = C_RecruitAFriend.IsRecruitAFriendLinked("Creature-0-0000-0-0-0-0")
```

### C_RecruitAFriend.IsRecruitingEnabled

```lua
enabled = C_RecruitAFriend.IsRecruitingEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

**Example**

```lua
local enabled = C_RecruitAFriend.IsRecruitingEnabled()
```

### C_RecruitAFriend.IsSystemEnabled

```lua
isSystemEnabled = C_RecruitAFriend.IsSystemEnabled()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSystemEnabled` | bool | no |  |

**Example**

```lua
local isSystemEnabled = C_RecruitAFriend.IsSystemEnabled()
```

### C_RecruitAFriend.IsSystemSupported

```lua
isSystemSupported = C_RecruitAFriend.IsSystemSupported()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSystemSupported` | bool | no |  |

**Example**

```lua
local isSystemSupported = C_RecruitAFriend.IsSystemSupported()
```

### C_RecruitAFriend.RemoveRAFRecruit

```lua
success = C_RecruitAFriend.RemoveRAFRecruit(wowAccountGUID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wowAccountGUID` | WOWGUID | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_RecruitAFriend.RemoveRAFRecruit("Creature-0-0000-0-0-0-0")
```

### C_RecruitAFriend.RequestUpdatedRecruitmentInfo

```lua
success = C_RecruitAFriend.RequestUpdatedRecruitmentInfo()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `success` | bool | no |  |

**Example**

```lua
local success = C_RecruitAFriend.RequestUpdatedRecruitmentInfo()
```

### C_RecruitAFriend.SummonFriend

```lua
C_RecruitAFriend.SummonFriend(target, name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `target` | WOWGUID | no |  |
| `name` | cstring | no |  |

**Example**

```lua
C_RecruitAFriend.SummonFriend(target, "")
```

## Events

### RAF_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | RafInfo | no |  |

### RAF_RECRUITING_ENABLED_STATUS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

### RAF_REWARD_CLAIM_FAILED

### RAF_SYSTEM_ENABLED_STATUS

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `enabled` | bool | no |  |

### RAF_SYSTEM_INFO_UPDATED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `systemInfo` | RafSystemInfo | no |  |

## Types

### RafAppearanceInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `appearanceID` | number | no |  |

### RafAppearanceSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |
| `setName` | string | no |  |
| `appearanceIDs` | number[] | no |  |

### RafIllusionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellItemEnchantmentID` | number | no |  |

### RafInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `versions` | RafVersionInfo[] | no |  |
| `recruitmentInfo` | RafRecruitmentinfo | yes |  |
| `recruits` | RafRecruit[] | no |  |
| `claimInProgress` | bool | no |  |

### RafMonthCount (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lifetimeMonths` | number | no |  |
| `spentMonths` | number | no |  |
| `availableMonths` | number | no |  |

### RafMountInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `mountID` | number | no |  |

### RafPetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `creatureID` | number | no |  |
| `speciesID` | number | no |  |
| `displayID` | number | no |  |
| `speciesName` | string | no |  |
| `description` | string | no |  |

### RafRecruit (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bnetAccountID` | number | no |  |
| `wowAccountGUID` | WOWGUID | no |  |
| `battleTag` | string | no |  |
| `monthsRemaining` | number | no |  |
| `subStatus` | RafRecruitSubStatus | no |  |
| `acceptanceID` | RecruitAcceptanceID | no |  |
| `versionRecruited` | RecruitAFriendRewardsVersion | no |  |
| `activities` | RafRecruitActivity[] | no |  |

### RafRecruitActivity (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `activityID` | number | no |  |
| `rewardQuestID` | number | no |  |
| `state` | RafRecruitActivityState | no |  |

### RafRecruitActivityState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Incomplete` | RafRecruitActivityState | no |  |
| `Complete` | RafRecruitActivityState | no |  |
| `RewardClaimed` | RafRecruitActivityState | no |  |

### RafRecruitmentinfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `recruitmentCode` | string | no |  |
| `recruitmentURL` | string | no |  |
| `expireTime` | number | no |  |
| `remainingTimeSeconds` | number | no |  |
| `totalUses` | number | no |  |
| `remainingUses` | number | no |  |
| `sourceRealm` | string | no |  |
| `sourceFaction` | string | no |  |

### RafRecruitSubStatus (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Trial` | RafRecruitSubStatus | no |  |
| `Active` | RafRecruitSubStatus | no |  |
| `Inactive` | RafRecruitSubStatus | no |  |

### RafReward (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rewardID` | number | no |  |
| `rafVersion` | RecruitAFriendRewardsVersion | no |  |
| `itemID` | number | no |  |
| `rewardType` | RafRewardType | no |  |
| `petInfo` | RafPetInfo | yes |  |
| `mountInfo` | RafMountInfo | yes |  |
| `appearanceInfo` | RafAppearanceInfo | yes |  |
| `titleInfo` | RafTitleInfo | yes |  |
| `appearanceSetInfo` | RafAppearanceSetInfo | yes |  |
| `illusionInfo` | RafIllusionInfo | yes |  |
| `canClaim` | bool | no |  |
| `claimed` | bool | no |  |
| `canAfford` | bool | no |  |
| `repeatable` | bool | no |  |
| `repeatableClaimCount` | number | no |  |
| `monthsRequired` | number | no |  |
| `monthCost` | number | no |  |
| `availableInMonths` | number | no |  |
| `iconID` | fileID | no |  |

### RafRewardType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Pet` | RafRewardType | no |  |
| `Mount` | RafRewardType | no |  |
| `Appearance` | RafRewardType | no |  |
| `Title` | RafRewardType | no |  |
| `GameTime` | RafRewardType | no |  |
| `AppearanceSet` | RafRewardType | no |  |
| `Illusion` | RafRewardType | no |  |
| `Invalid` | RafRewardType | no |  |

### RafSystemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxRecruits` | number | no |  |
| `maxRecruitMonths` | number | no |  |
| `maxRecruitmentUses` | number | no |  |
| `daysInCycle` | number | no |  |

### RafTitleInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `titleMaskID` | number | no |  |

### RafVersionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `rafVersion` | RecruitAFriendRewardsVersion | no |  |
| `monthCount` | RafMonthCount | no |  |
| `rewards` | RafReward[] | no |  |
| `nextReward` | RafReward | yes |  |
| `numAffordableRewards` | number | no |  |
| `numRecruits` | number | no |  |

