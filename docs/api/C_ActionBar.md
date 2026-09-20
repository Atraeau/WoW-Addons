# C_ActionBar

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**72** functions · **15** events · **1** types

## Functions

### C_ActionBar.EnableActionRangeCheck

Used in conjunction with ActionRangeCheckUpdate to inform the UI when an action goes in or out of range with its current target.

```lua
C_ActionBar.EnableActionRangeCheck(actionID, enable)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `enable` | bool | no | True if changes in range for the action should dispatch ActionRangeCheckUpdate. False if the action no longer needs the event. |

**Example**

```lua
C_ActionBar.EnableActionRangeCheck(actionID, false)
```

### C_ActionBar.FindAssistedCombatActionButtons

Returns the list of action bar slots that contain the Assisted Combat action spell.

```lua
slots = C_ActionBar.FindAssistedCombatActionButtons(setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example**

```lua
local slots = C_ActionBar.FindAssistedCombatActionButtons(setToSearch)
```

### C_ActionBar.FindFlyoutActionButtons

```lua
slots = C_ActionBar.FindFlyoutActionButtons(flyoutID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example**

```lua
local slots = C_ActionBar.FindFlyoutActionButtons(0, setToSearch)
```

### C_ActionBar.FindPetActionButtons

```lua
slots = C_ActionBar.FindPetActionButtons(petActionID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petActionID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example**

```lua
local slots = C_ActionBar.FindPetActionButtons(0, setToSearch)
```

### C_ActionBar.FindSpellActionButtons

Returns the list of action bar slots that contain a specified spell.

```lua
slots = C_ActionBar.FindSpellActionButtons(spellID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no | Expects a base spell, so if a spell is overridden the base ID should be provided. |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example**

```lua
local slots = C_ActionBar.FindSpellActionButtons(12345, setToSearch)
```

### C_ActionBar.ForceUpdateAction

Force updates some internals for an action button slot.

```lua
C_ActionBar.ForceUpdateAction(slotID, suppressEvents)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |
| `suppressEvents` | bool | no | (default: False) |

**Example**

```lua
C_ActionBar.ForceUpdateAction(1, false)
```

### C_ActionBar.GetActionAutocast

```lua
autocastAllowed, autocastEnabled = C_ActionBar.GetActionAutocast(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `autocastAllowed` | bool | no |  |
| `autocastEnabled` | bool | no |  |

**Example**

```lua
local autocastAllowed, autocastEnabled = C_ActionBar.GetActionAutocast(actionID)
```

### C_ActionBar.GetActionBarPage

```lua
currentPage = C_ActionBar.GetActionBarPage()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `currentPage` | luaIndex | no |  |

**Example**

```lua
local currentPage = C_ActionBar.GetActionBarPage()
```

### C_ActionBar.GetActionChargeDuration

Returns a duration object describing the active recharge time for an action.

```lua
duration = C_ActionBar.GetActionChargeDuration(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = C_ActionBar.GetActionChargeDuration(actionID)
```

### C_ActionBar.GetActionCharges

```lua
chargeInfo = C_ActionBar.GetActionCharges(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chargeInfo` | SpellChargeInfo | no |  |

**Example**

```lua
local chargeInfo = C_ActionBar.GetActionCharges(actionID)
```

### C_ActionBar.GetActionCooldown

```lua
cooldownInfo = C_ActionBar.GetActionCooldown(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `cooldownInfo` | SpellCooldownInfo | no |  |

**Example**

```lua
local cooldownInfo = C_ActionBar.GetActionCooldown(actionID)
```

### C_ActionBar.GetActionCooldownDuration

Returns a duration object describing the active cooldown duration for an action.

```lua
duration = C_ActionBar.GetActionCooldownDuration(actionID, ignoreGCD)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `ignoreGCD` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = C_ActionBar.GetActionCooldownDuration(actionID, false)
```

### C_ActionBar.GetActionDisplayCount

Depending on the action type, return a string that is either the use count or number of charges. If value is beyond the display count parameter, returns the replacementString (defaults to '*').

```lua
displayCount = C_ActionBar.GetActionDisplayCount(actionID, maxDisplayCount, replacementString)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `maxDisplayCount` | number | no | (default: 9999) |
| `replacementString` | cstring | no | (default: *) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `displayCount` | string | no |  |

**Example**

```lua
local displayCount = C_ActionBar.GetActionDisplayCount(actionID, 0, "")
```

### C_ActionBar.GetActionLossOfControlCooldownDuration

Returns a duration object describing the active loss of control cooldown duration for an action.

```lua
duration = C_ActionBar.GetActionLossOfControlCooldownDuration(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `duration` | LuaDurationObject | no |  |

**Example**

```lua
local duration = C_ActionBar.GetActionLossOfControlCooldownDuration(actionID)
```

### C_ActionBar.GetActionLossOfControlCooldownInfo

```lua
lossOfControlInfo = C_ActionBar.GetActionLossOfControlCooldownInfo(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `lossOfControlInfo` | SpellLossOfControlInfo | no |  |

**Example**

```lua
local lossOfControlInfo = C_ActionBar.GetActionLossOfControlCooldownInfo(actionID)
```

### C_ActionBar.GetActionText

```lua
text = C_ActionBar.GetActionText(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |

**Example**

```lua
local text = C_ActionBar.GetActionText(actionID)
```

### C_ActionBar.GetActionTexture

```lua
textureFileID = C_ActionBar.GetActionTexture(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureFileID` | fileID | no |  |

**Example**

```lua
local textureFileID = C_ActionBar.GetActionTexture(actionID)
```

### C_ActionBar.GetActionUseCount

```lua
count = C_ActionBar.GetActionUseCount(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no |  |

**Example**

```lua
local count = C_ActionBar.GetActionUseCount(actionID)
```

### C_ActionBar.GetBonusBarIndex

```lua
bonusBarIndex = C_ActionBar.GetBonusBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusBarIndex` | luaIndex | no |  |

**Example**

```lua
local bonusBarIndex = C_ActionBar.GetBonusBarIndex()
```

### C_ActionBar.GetBonusBarIndexForSlot

```lua
bonusBarIndex = C_ActionBar.GetBonusBarIndexForSlot(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusBarIndex` | luaIndex | yes |  |

**Example**

```lua
local bonusBarIndex = C_ActionBar.GetBonusBarIndexForSlot(1)
```

### C_ActionBar.GetBonusBarOffset

```lua
bonusBarOffset = C_ActionBar.GetBonusBarOffset()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `bonusBarOffset` | number | no |  |

**Example**

```lua
local bonusBarOffset = C_ActionBar.GetBonusBarOffset()
```

### C_ActionBar.GetExtraBarIndex

```lua
extraBarIndex = C_ActionBar.GetExtraBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `extraBarIndex` | luaIndex | no |  |

**Example**

```lua
local extraBarIndex = C_ActionBar.GetExtraBarIndex()
```

### C_ActionBar.GetItemActionOnEquipSpellID

```lua
onEquipSpellID = C_ActionBar.GetItemActionOnEquipSpellID(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `onEquipSpellID` | number | yes |  |

**Example**

```lua
local onEquipSpellID = C_ActionBar.GetItemActionOnEquipSpellID(actionID)
```

### C_ActionBar.GetMultiCastBarIndex

```lua
multiCastBarIndex = C_ActionBar.GetMultiCastBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `multiCastBarIndex` | luaIndex | no |  |

**Example**

```lua
local multiCastBarIndex = C_ActionBar.GetMultiCastBarIndex()
```

### C_ActionBar.GetOverrideBarIndex

```lua
overrideBarIndex = C_ActionBar.GetOverrideBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `overrideBarIndex` | luaIndex | no |  |

**Example**

```lua
local overrideBarIndex = C_ActionBar.GetOverrideBarIndex()
```

### C_ActionBar.GetOverrideBarSkin

```lua
textureFileID = C_ActionBar.GetOverrideBarSkin()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureFileID` | fileID | yes |  |

**Example**

```lua
local textureFileID = C_ActionBar.GetOverrideBarSkin()
```

### C_ActionBar.GetPetActionPetBarIndices

```lua
slots = C_ActionBar.GetPetActionPetBarIndices(petActionID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petActionID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slots` | luaIndex[] | no |  |

**Example**

```lua
local slots = C_ActionBar.GetPetActionPetBarIndices(0, setToSearch)
```

### C_ActionBar.GetProfessionQuality

```lua
quality = C_ActionBar.GetProfessionQuality(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `quality` | number | yes |  |

**Example**

```lua
local quality = C_ActionBar.GetProfessionQuality(actionID)
```

### C_ActionBar.GetProfessionQualityInfo

```lua
info = C_ActionBar.GetProfessionQualityInfo(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | CraftingQualityInfo | yes |  |

**Example**

```lua
local info = C_ActionBar.GetProfessionQualityInfo(actionID)
```

### C_ActionBar.GetSpell

```lua
spellID = C_ActionBar.GetSpell(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |

**Example**

```lua
local spellID = C_ActionBar.GetSpell(actionID)
```

### C_ActionBar.GetTempShapeshiftBarIndex

```lua
tempShapeshiftBarIndex = C_ActionBar.GetTempShapeshiftBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `tempShapeshiftBarIndex` | luaIndex | no |  |

**Example**

```lua
local tempShapeshiftBarIndex = C_ActionBar.GetTempShapeshiftBarIndex()
```

### C_ActionBar.GetVehicleBarIndex

```lua
vehicleBarIndex = C_ActionBar.GetVehicleBarIndex()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `vehicleBarIndex` | luaIndex | no |  |

**Example**

```lua
local vehicleBarIndex = C_ActionBar.GetVehicleBarIndex()
```

### C_ActionBar.HasAction

Returns true if an actionbar slot is populated with an action.

```lua
hasAction = C_ActionBar.HasAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasAction` | bool | no |  |

**Example**

```lua
local hasAction = C_ActionBar.HasAction(actionID)
```

### C_ActionBar.HasAssistedCombatActionButtons

```lua
hasButtons = C_ActionBar.HasAssistedCombatActionButtons(setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasButtons` | bool | no |  |

**Example**

```lua
local hasButtons = C_ActionBar.HasAssistedCombatActionButtons(setToSearch)
```

### C_ActionBar.HasBonusActionBar

```lua
hasBonusActionBar = C_ActionBar.HasBonusActionBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasBonusActionBar` | bool | no |  |

**Example**

```lua
local hasBonusActionBar = C_ActionBar.HasBonusActionBar()
```

### C_ActionBar.HasExtraActionBar

```lua
hasExtraActionBar = C_ActionBar.HasExtraActionBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasExtraActionBar` | bool | no |  |

**Example**

```lua
local hasExtraActionBar = C_ActionBar.HasExtraActionBar()
```

### C_ActionBar.HasFlyoutActionButtons

```lua
hasFlyoutActionButtons = C_ActionBar.HasFlyoutActionButtons(flyoutID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `flyoutID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasFlyoutActionButtons` | bool | no |  |

**Example**

```lua
local hasFlyoutActionButtons = C_ActionBar.HasFlyoutActionButtons(0, setToSearch)
```

### C_ActionBar.HasOverrideActionBar

```lua
hasOverrideActionBar = C_ActionBar.HasOverrideActionBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasOverrideActionBar` | bool | no |  |

**Example**

```lua
local hasOverrideActionBar = C_ActionBar.HasOverrideActionBar()
```

### C_ActionBar.HasPetActionButtons

```lua
hasPetActionButtons = C_ActionBar.HasPetActionButtons(petActionID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petActionID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPetActionButtons` | bool | no |  |

**Example**

```lua
local hasPetActionButtons = C_ActionBar.HasPetActionButtons(0, setToSearch)
```

### C_ActionBar.HasPetActionPetBarIndices

```lua
hasPetActionPetBarIndices = C_ActionBar.HasPetActionPetBarIndices(petActionID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `petActionID` | number | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasPetActionPetBarIndices` | bool | no |  |

**Example**

```lua
local hasPetActionPetBarIndices = C_ActionBar.HasPetActionPetBarIndices(0, setToSearch)
```

### C_ActionBar.HasRangeRequirements

```lua
hasRangeRequirements = C_ActionBar.HasRangeRequirements(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasRangeRequirements` | bool | no |  |

**Example**

```lua
local hasRangeRequirements = C_ActionBar.HasRangeRequirements(actionID)
```

### C_ActionBar.HasSpellActionButtons

```lua
hasSpellActionButtons = C_ActionBar.HasSpellActionButtons(spellID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasSpellActionButtons` | bool | no |  |

**Example**

```lua
local hasSpellActionButtons = C_ActionBar.HasSpellActionButtons(12345, setToSearch)
```

### C_ActionBar.HasTempShapeshiftActionBar

```lua
hasTempShapeshiftActionBar = C_ActionBar.HasTempShapeshiftActionBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasTempShapeshiftActionBar` | bool | no |  |

**Example**

```lua
local hasTempShapeshiftActionBar = C_ActionBar.HasTempShapeshiftActionBar()
```

### C_ActionBar.HasVehicleActionBar

```lua
hasVehicleActionBar = C_ActionBar.HasVehicleActionBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `hasVehicleActionBar` | bool | no |  |

**Example**

```lua
local hasVehicleActionBar = C_ActionBar.HasVehicleActionBar()
```

### C_ActionBar.IsActionInRange

```lua
isInRange = C_ActionBar.IsActionInRange(actionID, [target])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `target` | UnitToken | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInRange` | bool | yes | If nil, range cannot be determined (eg. no target is available). |

**Example**

```lua
local isInRange = C_ActionBar.IsActionInRange(actionID)
```

### C_ActionBar.IsAssistedCombatAction

Returns whether the given action button contains the Assisted Combat action spell.

```lua
isAssistedCombatAction = C_ActionBar.IsAssistedCombatAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAssistedCombatAction` | bool | no |  |

**Example**

```lua
local isAssistedCombatAction = C_ActionBar.IsAssistedCombatAction(1)
```

### C_ActionBar.IsAttackAction

```lua
isAttackAction = C_ActionBar.IsAttackAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAttackAction` | bool | no |  |

**Example**

```lua
local isAttackAction = C_ActionBar.IsAttackAction(actionID)
```

### C_ActionBar.IsAutoCastPetAction

```lua
isAutoCastPetAction = C_ActionBar.IsAutoCastPetAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoCastPetAction` | bool | no |  |

**Example**

```lua
local isAutoCastPetAction = C_ActionBar.IsAutoCastPetAction(1)
```

### C_ActionBar.IsAutoRepeatAction

```lua
isAutoRepeatAction = C_ActionBar.IsAutoRepeatAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAutoRepeatAction` | bool | no |  |

**Example**

```lua
local isAutoRepeatAction = C_ActionBar.IsAutoRepeatAction(actionID)
```

### C_ActionBar.IsConsumableAction

```lua
isConsumableAction = C_ActionBar.IsConsumableAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isConsumableAction` | bool | no |  |

**Example**

```lua
local isConsumableAction = C_ActionBar.IsConsumableAction(actionID)
```

### C_ActionBar.IsCurrentAction

```lua
isCurrentAction = C_ActionBar.IsCurrentAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isCurrentAction` | bool | no |  |

**Example**

```lua
local isCurrentAction = C_ActionBar.IsCurrentAction(actionID)
```

### C_ActionBar.IsEnabledAutoCastPetAction

```lua
isEnabledAutoCastPetAction = C_ActionBar.IsEnabledAutoCastPetAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEnabledAutoCastPetAction` | bool | no |  |

**Example**

```lua
local isEnabledAutoCastPetAction = C_ActionBar.IsEnabledAutoCastPetAction(1)
```

### C_ActionBar.IsEquippedAction

```lua
isEquippedAction = C_ActionBar.IsEquippedAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEquippedAction` | bool | no |  |

**Example**

```lua
local isEquippedAction = C_ActionBar.IsEquippedAction(actionID)
```

### C_ActionBar.IsEquippedGearOutfitAction

```lua
isEquippedGearOutfitAction = C_ActionBar.IsEquippedGearOutfitAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isEquippedGearOutfitAction` | bool | no |  |

**Example**

```lua
local isEquippedGearOutfitAction = C_ActionBar.IsEquippedGearOutfitAction(1)
```

### C_ActionBar.IsHarmfulAction

```lua
isHarmful = C_ActionBar.IsHarmfulAction(actionID, useNeutral)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `useNeutral` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHarmful` | bool | no |  |

**Example**

```lua
local isHarmful = C_ActionBar.IsHarmfulAction(actionID, false)
```

### C_ActionBar.IsHelpfulAction

```lua
isHelpful = C_ActionBar.IsHelpfulAction(actionID, useNeutral)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |
| `useNeutral` | bool | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isHelpful` | bool | no |  |

**Example**

```lua
local isHelpful = C_ActionBar.IsHelpfulAction(actionID, false)
```

### C_ActionBar.IsInterruptAction

Returns whether the given action button contains a spell that can interrupt spellcasting.

```lua
isInterruptAction = C_ActionBar.IsInterruptAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isInterruptAction` | bool | no |  |

**Example**

```lua
local isInterruptAction = C_ActionBar.IsInterruptAction(1)
```

### C_ActionBar.IsItemAction

```lua
isItemAction = C_ActionBar.IsItemAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isItemAction` | bool | no |  |

**Example**

```lua
local isItemAction = C_ActionBar.IsItemAction(actionID)
```

### C_ActionBar.IsMacroActionWithShowTooltip

Returns whether the given action button contains a macro with an explicit #showtooltip directive.

```lua
isMacroActionWithShowTooltip = C_ActionBar.IsMacroActionWithShowTooltip(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isMacroActionWithShowTooltip` | bool | no |  |

**Example**

```lua
local isMacroActionWithShowTooltip = C_ActionBar.IsMacroActionWithShowTooltip(actionID)
```

### C_ActionBar.IsOnBarOrSpecialBar

```lua
isOnBarOrSpecialBar = C_ActionBar.IsOnBarOrSpecialBar(spellID, setToSearch)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | SpellIdentifier | no |  |
| `setToSearch` | ActionBarSet | no | (default: All) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isOnBarOrSpecialBar` | bool | no |  |

**Example**

```lua
local isOnBarOrSpecialBar = C_ActionBar.IsOnBarOrSpecialBar(12345, setToSearch)
```

### C_ActionBar.IsPossessBarVisible

```lua
isPossessBarVisible = C_ActionBar.IsPossessBarVisible()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isPossessBarVisible` | bool | no |  |

**Example**

```lua
local isPossessBarVisible = C_ActionBar.IsPossessBarVisible()
```

### C_ActionBar.IsStackableAction

```lua
isStackableAction = C_ActionBar.IsStackableAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isStackableAction` | bool | no |  |

**Example**

```lua
local isStackableAction = C_ActionBar.IsStackableAction(actionID)
```

### C_ActionBar.IsUsableAction

```lua
isUsable, isLackingResources = C_ActionBar.IsUsableAction(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isUsable` | bool | no |  |
| `isLackingResources` | bool | no |  |

**Example**

```lua
local isUsable, isLackingResources = C_ActionBar.IsUsableAction(actionID)
```

### C_ActionBar.PutActionInSlot

```lua
C_ActionBar.PutActionInSlot(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Example**

```lua
C_ActionBar.PutActionInSlot(1)
```

### C_ActionBar.RegisterActionUIButton

```lua
C_ActionBar.RegisterActionUIButton(checkboxFrame, actionID, cooldownFrame)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checkboxFrame` | SimpleCheckbox | no |  |
| `actionID` | luaIndex | no |  |
| `cooldownFrame` | CooldownFrame | no |  |

**Example**

```lua
C_ActionBar.RegisterActionUIButton(checkboxFrame, actionID, cooldownFrame)
```

### C_ActionBar.SetActionBarPage

```lua
C_ActionBar.SetActionBarPage(pageIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `pageIndex` | luaIndex | no |  |

**Example**

```lua
C_ActionBar.SetActionBarPage(1)
```

### C_ActionBar.ShouldOverrideBarShowHealthBar

```lua
showHealthBar = C_ActionBar.ShouldOverrideBarShowHealthBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showHealthBar` | bool | no |  |

**Example**

```lua
local showHealthBar = C_ActionBar.ShouldOverrideBarShowHealthBar()
```

### C_ActionBar.ShouldOverrideBarShowManaBar

```lua
showManaBar = C_ActionBar.ShouldOverrideBarShowManaBar()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `showManaBar` | bool | no |  |

**Example**

```lua
local showManaBar = C_ActionBar.ShouldOverrideBarShowManaBar()
```

### C_ActionBar.ShouldShowKeyring

```lua
isKeyringEnabled = C_ActionBar.ShouldShowKeyring()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isKeyringEnabled` | bool | no |  |

**Example**

```lua
local isKeyringEnabled = C_ActionBar.ShouldShowKeyring()
```

### C_ActionBar.ToggleAutoCastPetAction

```lua
C_ActionBar.ToggleAutoCastPetAction(slotID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slotID` | luaIndex | no |  |

**Example**

```lua
C_ActionBar.ToggleAutoCastPetAction(1)
```

### C_ActionBar.UnregisterActionUIButton

```lua
C_ActionBar.UnregisterActionUIButton(checkboxFrame)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `checkboxFrame` | SimpleCheckbox | no |  |

**Example**

```lua
C_ActionBar.UnregisterActionUIButton(checkboxFrame)
```

### C_ActionBar.UsesActionText

```lua
usesActionText = C_ActionBar.UsesActionText(actionID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `actionID` | luaIndex | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `usesActionText` | bool | no |  |

**Example**

```lua
local usesActionText = C_ActionBar.UsesActionText(actionID)
```

## Events

### ACTIONBAR_HIDEGRID

### ACTIONBAR_PAGE_CHANGED

### ACTIONBAR_SHOW_BOTTOMLEFT

### ACTIONBAR_SHOWGRID

### ACTIONBAR_SLOT_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | number | no |  |

### ACTIONBAR_UPDATE_COOLDOWN

### ACTIONBAR_UPDATE_STATE

### ACTIONBAR_UPDATE_USABLE

### ACTION_RANGE_CHECK_UPDATE

Used in conjunction with EnableActionRangeCheck to inform the UI when an action goes in or out of range with its current target.

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `slot` | luaIndex | no |  |
| `isInRange` | bool | no | Whether or not the current target is in range of the action. Should not be used if the 'checksRange' parameter is false. |
| `checksRange` | bool | no | Can be false if a range check was not made for any reason, for example there is not a current target. |

### ACTION_USABLE_CHANGED

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `changes` | ActionUsableState[] | no |  |

### PET_BAR_UPDATE

### UPDATE_BONUS_ACTIONBAR

### UPDATE_EXTRA_ACTIONBAR

### UPDATE_MULTI_CAST_ACTIONBAR

### UPDATE_OVERRIDE_ACTIONBAR

## Types

### ActionBarSet (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | ActionBarSet | no |  |
| `Mkb` | ActionBarSet | no |  |
| `Gamepad` | ActionBarSet | no |  |
| `All` | ActionBarSet | no |  |

