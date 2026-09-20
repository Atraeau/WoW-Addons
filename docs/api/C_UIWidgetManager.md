# C_UIWidgetManager

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**42** functions · **2** events · **91** types

## Functions

### C_UIWidgetManager.GetAllWidgetsBySetID

```lua
widgets = C_UIWidgetManager.GetAllWidgetsBySetID(setID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgets` | UIWidgetInfo[] | no |  |

**Example**

```lua
local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(0)
```

### C_UIWidgetManager.GetBelowMinimapWidgetSetID

```lua
setID = C_UIWidgetManager.GetBelowMinimapWidgetSetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Example**

```lua
local setID = C_UIWidgetManager.GetBelowMinimapWidgetSetID()
```

### C_UIWidgetManager.GetBulletTextListWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetBulletTextListWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | BulletTextListWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetBulletTextListWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetButtonHeaderWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetButtonHeaderWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ButtonHeaderWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetButtonHeaderWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | CaptureBarWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetCaptureBarWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetCaptureZoneVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetCaptureZoneVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | CaptureZoneVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetCaptureZoneVisualizationInfo(0)
```

### C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | DiscreteProgressStepsVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo(0)
```

### C_UIWidgetManager.GetDoubleIconAndTextWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetDoubleIconAndTextWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | DoubleIconAndTextWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetDoubleIconAndTextWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | DoubleStateIconRowVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo(0)
```

### C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | DoubleStatusBarWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | FillUpFramesWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetHorizontalCurrenciesWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetHorizontalCurrenciesWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | HorizontalCurrenciesWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetHorizontalCurrenciesWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | IconAndTextWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | IconTextAndBackgroundWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetIconTextAndBackgroundWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | IconTextAndCurrenciesWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetIconTextAndCurrenciesWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetItemDisplayVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetItemDisplayVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ItemDisplayVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetItemDisplayVisualizationInfo(0)
```

### C_UIWidgetManager.GetMapPinAnimationWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetMapPinAnimationWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | MapPinAnimationWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetMapPinAnimationWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetObjectiveTrackerWidgetSetID

```lua
setID = C_UIWidgetManager.GetObjectiveTrackerWidgetSetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Example**

```lua
local setID = C_UIWidgetManager.GetObjectiveTrackerWidgetSetID()
```

### C_UIWidgetManager.GetPowerBarWidgetSetID

```lua
setID = C_UIWidgetManager.GetPowerBarWidgetSetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Example**

```lua
local setID = C_UIWidgetManager.GetPowerBarWidgetSetID()
```

### C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | PreyHuntProgressWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetPreyHuntProgressWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ScenarioHeaderDelvesWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetScenarioHeaderTimerWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetScenarioHeaderTimerWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ScenarioHeaderTimerWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetScenarioHeaderTimerWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetSpacerVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetSpacerVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | SpacerVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetSpacerVisualizationInfo(0)
```

### C_UIWidgetManager.GetSpellDisplayVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | SpellDisplayVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(0)
```

### C_UIWidgetManager.GetStackedResourceTrackerWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetStackedResourceTrackerWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | StackedResourceTrackerWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetStackedResourceTrackerWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | StatusBarWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextColumnRowVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextColumnRowVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextColumnRowVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextColumnRowVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextureAndTextRowVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextureAndTextVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextureAndTextVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextureAndTextVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextureAndTextVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextureWithAnimationVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextWithStateWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetTextWithSubtextWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTextWithSubtextWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TextWithSubtextWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTextWithSubtextWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetTopCenterWidgetSetID

```lua
setID = C_UIWidgetManager.GetTopCenterWidgetSetID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `setID` | number | no |  |

**Example**

```lua
local setID = C_UIWidgetManager.GetTopCenterWidgetSetID()
```

### C_UIWidgetManager.GetTugOfWarWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetTugOfWarWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | TugOfWarWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetTugOfWarWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetUnitPowerBarWidgetVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetUnitPowerBarWidgetVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | UnitPowerBarWidgetVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetUnitPowerBarWidgetVisualizationInfo(0)
```

### C_UIWidgetManager.GetWidgetSetInfo

```lua
widgetSetInfo = C_UIWidgetManager.GetWidgetSetInfo(widgetSetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetSetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetSetInfo` | UIWidgetSetInfo | no |  |

**Example**

```lua
local widgetSetInfo = C_UIWidgetManager.GetWidgetSetInfo(0)
```

### C_UIWidgetManager.GetZoneControlVisualizationInfo

```lua
widgetInfo = C_UIWidgetManager.GetZoneControlVisualizationInfo(widgetID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | ZoneControlVisualizationInfo | yes |  |

**Example**

```lua
local widgetInfo = C_UIWidgetManager.GetZoneControlVisualizationInfo(0)
```

### C_UIWidgetManager.RegisterUnitForWidgetUpdates

```lua
C_UIWidgetManager.RegisterUnitForWidgetUpdates(unitToken, isGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | string | no |  |
| `isGuid` | bool | no | (default: False) |

**Example**

```lua
C_UIWidgetManager.RegisterUnitForWidgetUpdates("player", "Creature-0-0000-0-0-0-0")
```

### C_UIWidgetManager.SetProcessingUnit

```lua
C_UIWidgetManager.SetProcessingUnit([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | UnitToken | yes |  |

**Example**

```lua
C_UIWidgetManager.SetProcessingUnit()
```

### C_UIWidgetManager.SetProcessingUnitGuid

```lua
C_UIWidgetManager.SetProcessingUnitGuid([unit])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unit` | WOWGUID | yes |  |

**Example**

```lua
C_UIWidgetManager.SetProcessingUnitGuid()
```

### C_UIWidgetManager.UnregisterUnitForWidgetUpdates

```lua
C_UIWidgetManager.UnregisterUnitForWidgetUpdates(unitToken, isGuid)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unitToken` | string | no |  |
| `isGuid` | bool | no | (default: False) |

**Example**

```lua
C_UIWidgetManager.UnregisterUnitForWidgetUpdates("player", "Creature-0-0000-0-0-0-0")
```

## Events

### UPDATE_ALL_UI_WIDGETS

### UPDATE_UI_WIDGET

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetInfo` | UIWidgetInfo | no |  |

## Types

### BulletTextListWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `lines` | string[] | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ButtonHeaderWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `headerText` | string | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `buttons` | UIWidgetSpellButtonInfo[] | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### CaptureBarWidgetFillDirectionType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `RightToLeft` | CaptureBarWidgetFillDirectionType | no |  |
| `LeftToRight` | CaptureBarWidgetFillDirectionType | no |  |

### CaptureBarWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `barValue` | number | no |  |
| `barMinValue` | number | no |  |
| `barMaxValue` | number | no |  |
| `neutralZoneSize` | number | no |  |
| `neutralZoneCenter` | number | no |  |
| `tooltip` | string | no |  |
| `glowAnimType` | WidgetGlowAnimType | no |  |
| `fillDirectionType` | CaptureBarWidgetFillDirectionType | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### CaptureZoneVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `mode` | ZoneControlMode | no |  |
| `leadingEdgeType` | ZoneControlLeadingEdgeType | no |  |
| `dangerFlashType` | ZoneControlDangerFlashType | no |  |
| `zoneInfo` | ZoneEntry | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### DiscreteProgressStepsVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `tooltip` | string | no |  |
| `progressMin` | number | no |  |
| `progressMax` | number | no |  |
| `progressVal` | number | no |  |
| `numSteps` | number | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### DoubleIconAndTextWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `label` | string | no |  |
| `leftText` | string | no |  |
| `leftTooltip` | string | no |  |
| `rightText` | string | no |  |
| `rightTooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### DoubleStateIconRowVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `leftIcons` | UIWidgetStateIconInfo[] | no |  |
| `rightIcons` | UIWidgetStateIconInfo[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### DoubleStatusBarWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `leftBarMin` | number | no |  |
| `leftBarMax` | number | no |  |
| `leftBarValue` | number | no |  |
| `leftBarTooltip` | string | no |  |
| `rightBarMin` | number | no |  |
| `rightBarMax` | number | no |  |
| `rightBarValue` | number | no |  |
| `rightBarTooltip` | string | no |  |
| `barValueTextType` | StatusBarValueTextType | no |  |
| `text` | string | no |  |
| `leftBarTooltipLoc` | UIWidgetTooltipLocation | no |  |
| `rightBarTooltipLoc` | UIWidgetTooltipLocation | no |  |
| `fillMotionType` | UIWidgetMotionType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### FillUpFramesWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `fillMin` | number | no |  |
| `fillMax` | number | no |  |
| `fillValue` | number | no |  |
| `numTotalFrames` | number | no |  |
| `numFullFrames` | number | no |  |
| `pulseFillingFrame` | bool | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### HorizontalCurrenciesWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `currencies` | UIWidgetCurrencyInfo[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### IconAndTextShiftTextType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | IconAndTextShiftTextType | no |  |
| `ShiftText` | IconAndTextShiftTextType | no |  |

### IconAndTextWidgetState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hidden` | IconAndTextWidgetState | no |  |
| `Shown` | IconAndTextWidgetState | no |  |
| `ShownWithDynamicIconFlashing` | IconAndTextWidgetState | no |  |
| `ShownWithDynamicIconNotFlashing` | IconAndTextWidgetState | no |  |

### IconAndTextWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | IconAndTextWidgetState | no |  |
| `text` | string | no |  |
| `tooltip` | string | no |  |
| `dynamicTooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `shiftTextType` | IconAndTextShiftTextType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### IconState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hidden` | IconState | no |  |
| `ShowState1` | IconState | no |  |
| `ShowState2` | IconState | no |  |

### IconTextAndBackgroundWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `text` | string | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### IconTextAndCurrenciesWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `descriptionShownState` | WidgetShownState | no |  |
| `descriptionEnabledState` | WidgetEnabledState | no |  |
| `text` | string | no |  |
| `description` | string | no |  |
| `currencies` | UIWidgetCurrencyInfo[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ItemDisplayTextDisplayStyle (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `WorldQuestReward` | ItemDisplayTextDisplayStyle | no |  |
| `ItemNameAndInfoText` | ItemDisplayTextDisplayStyle | no |  |
| `ItemNameOnlyCentered` | ItemDisplayTextDisplayStyle | no |  |
| `PlayerChoiceReward` | ItemDisplayTextDisplayStyle | no |  |

### ItemDisplayTooltipEnabledType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Enabled` | ItemDisplayTooltipEnabledType | no |  |
| `Disabled` | ItemDisplayTooltipEnabledType | no |  |

### ItemDisplayVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `itemInfo` | UIWidgetItemInfo | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### MapPinAnimationType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | MapPinAnimationType | no |  |
| `Pulse` | MapPinAnimationType | no |  |

### MapPinAnimationWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `animType` | MapPinAnimationType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### PreyHuntProgressState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Cold` | PreyHuntProgressState | no |  |
| `Warm` | PreyHuntProgressState | no |  |
| `Hot` | PreyHuntProgressState | no |  |
| `Final` | PreyHuntProgressState | no |  |

### PreyHuntProgressWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `progressState` | PreyHuntProgressState | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `currencies` | UIWidgetCurrencyInfo[] | no |  |
| `headerText` | string | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ScenarioHeaderDelvesWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `headerText` | string | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `tierText` | string | no |  |
| `tierTooltipSpellID` | number | yes |  |
| `currencies` | UIWidgetCurrencyInfo[] | no |  |
| `spells` | UIWidgetSpellInfo[] | no |  |
| `rewardInfo` | UIWidgetRewardInfo | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ScenarioHeaderTimerWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `timerMin` | number | no |  |
| `timerMax` | number | no |  |
| `timerValue` | number | no |  |
| `headerText` | string | no |  |
| `timerTooltip` | string | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### SpacerVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `widgetWidth` | number | no |  |
| `widgetHeight` | number | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### SpellDisplayIconDisplayType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Buff` | SpellDisplayIconDisplayType | no |  |
| `Debuff` | SpellDisplayIconDisplayType | no |  |
| `Circular` | SpellDisplayIconDisplayType | no |  |
| `NoBorder` | SpellDisplayIconDisplayType | no |  |

### SpellDisplayTextShownStateType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Shown` | SpellDisplayTextShownStateType | no |  |
| `Hidden` | SpellDisplayTextShownStateType | no |  |

### SpellDisplayTint (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | SpellDisplayTint | no |  |
| `Red` | SpellDisplayTint | no |  |

### SpellDisplayVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellInfo` | UIWidgetSpellInfo | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### StackedResourceTrackerWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `resources` | UIWidgetCurrencyInfo[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### StatusBarColorTintValue (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | StatusBarColorTintValue | no |  |
| `Black` | StatusBarColorTintValue | no |  |
| `White` | StatusBarColorTintValue | no |  |
| `Red` | StatusBarColorTintValue | no |  |
| `Yellow` | StatusBarColorTintValue | no |  |
| `Orange` | StatusBarColorTintValue | no |  |
| `Purple` | StatusBarColorTintValue | no |  |
| `Green` | StatusBarColorTintValue | no |  |
| `Blue` | StatusBarColorTintValue | no |  |

### StatusBarOverrideBarTextShownType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Never` | StatusBarOverrideBarTextShownType | no |  |
| `Always` | StatusBarOverrideBarTextShownType | no |  |
| `OnlyOnMouseover` | StatusBarOverrideBarTextShownType | no |  |
| `OnlyNotOnMouseover` | StatusBarOverrideBarTextShownType | no |  |

### StatusBarValueTextType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hidden` | StatusBarValueTextType | no |  |
| `Percentage` | StatusBarValueTextType | no |  |
| `Value` | StatusBarValueTextType | no |  |
| `Time` | StatusBarValueTextType | no |  |
| `TimeShowOneLevelOnly` | StatusBarValueTextType | no |  |
| `ValueOverMax` | StatusBarValueTextType | no |  |
| `ValueOverMaxNormalized` | StatusBarValueTextType | no |  |

### StatusBarWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `barMin` | number | no |  |
| `barMax` | number | no |  |
| `barValue` | number | no |  |
| `text` | string | no |  |
| `tooltip` | string | no |  |
| `barValueTextType` | StatusBarValueTextType | no |  |
| `overrideBarText` | string | no |  |
| `overrideBarTextShownType` | StatusBarOverrideBarTextShownType | no |  |
| `colorTint` | StatusBarColorTintValue | no |  |
| `partitionValues` | number[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `fillMotionType` | UIWidgetMotionType | no |  |
| `barTextEnabledState` | WidgetEnabledState | no |  |
| `barTextFontType` | UIWidgetFontType | no |  |
| `barTextSizeType` | UIWidgetTextSizeType | no |  |
| `textEnabledState` | WidgetEnabledState | no |  |
| `textFontType` | UIWidgetFontType | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `glowAnimType` | WidgetGlowAnimType | no |  |
| `showGlowState` | WidgetShowGlowState | no |  |
| `fillMinOpacity` | WidgetOpacityType | no |  |
| `fillMaxOpacity` | WidgetOpacityType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextColumnRowEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `hAlign` | WidgetTextHorizontalAlignmentType | no |  |
| `columnWidth` | number | no |  |

### TextColumnRowVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `entries` | TextColumnRowEntryInfo[] | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `fontType` | UIWidgetFontType | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `bottomPadding` | number | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextureAndTextEntryInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `tooltip` | string | no |  |

### TextureAndTextRowVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `entries` | TextureAndTextEntryInfo[] | no |  |
| `textSizeType` | UIWidgetTextureAndTextSizeType | no |  |
| `groupAlignment` | UIWidgetHorizontalDirection | no |  |
| `fixedWidth` | number | yes |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextureAndTextVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `text` | string | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `textSizeType` | UIWidgetTextureAndTextSizeType | no |  |
| `textFormatType` | UIWidgetTextFormatType | no |  |
| `updateAnimType` | UIWidgetUpdateAnimType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextureWithAnimationVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextWithStateWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `text` | string | no |  |
| `tooltip` | string | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `fontType` | UIWidgetFontType | no |  |
| `bottomPadding` | number | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `hAlign` | WidgetTextHorizontalAlignmentType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### TextWithSubtextWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `text` | string | no |  |
| `widgetWidth` | number | no |  |
| `tooltip` | string | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `fontType` | UIWidgetFontType | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `hAlign` | WidgetTextHorizontalAlignmentType | no |  |
| `subText` | string | no |  |
| `subTextSizeType` | UIWidgetTextSizeType | no |  |
| `subTextFontType` | UIWidgetFontType | no |  |
| `subTextHAlign` | WidgetTextHorizontalAlignmentType | no |  |
| `subTextEnabledState` | WidgetEnabledState | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |
| `spacing` | number | no |  |

### TugOfWarMarkerArrowShownState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Never` | TugOfWarMarkerArrowShownState | no |  |
| `Always` | TugOfWarMarkerArrowShownState | no |  |
| `FlashOnMove` | TugOfWarMarkerArrowShownState | no |  |

### TugOfWarStyleValue (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `DefaultYellow` | TugOfWarStyleValue | no |  |
| `ArchaeologyBrown` | TugOfWarStyleValue | no |  |

### TugOfWarWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `minValue` | number | no |  |
| `maxValue` | number | no |  |
| `currentValue` | number | no |  |
| `neutralZoneCenter` | number | no |  |
| `neutralZoneSize` | number | no |  |
| `leftIconInfo` | UIWidgetIconInfo | no |  |
| `rightIconInfo` | UIWidgetIconInfo | no |  |
| `glowAnimType` | WidgetGlowAnimType | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `neutralFillStyle` | TugOfWarStyleValue | no |  |
| `markerArrowShownState` | TugOfWarMarkerArrowShownState | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### UIWidgetBlendModeType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Opaque` | UIWidgetBlendModeType | no |  |
| `Additive` | UIWidgetBlendModeType | no |  |

### UIWidgetButtonEnabledState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Disabled` | UIWidgetButtonEnabledState | no |  |
| `Enabled` | UIWidgetButtonEnabledState | no |  |

### UIWidgetButtonIconType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Exit` | UIWidgetButtonIconType | no |  |
| `Speak` | UIWidgetButtonIconType | no |  |
| `Undo` | UIWidgetButtonIconType | no |  |
| `Checkmark` | UIWidgetButtonIconType | no |  |
| `RedX` | UIWidgetButtonIconType | no |  |

### UIWidgetCurrencyInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconFileID` | fileID | no |  |
| `leadingText` | string | no |  |
| `text` | string | no |  |
| `tooltip` | string | no |  |
| `isCurrencyMaxed` | bool | no |  |
| `textFontType` | UIWidgetFontType | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `textEnabledState` | WidgetEnabledState | no |  |
| `iconSizeType` | WidgetIconSizeType | no |  |
| `updateAnimType` | UIWidgetUpdateAnimType | no |  |

### UIWidgetFontType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Normal` | UIWidgetFontType | no |  |
| `Shadow` | UIWidgetFontType | no |  |
| `Outline` | UIWidgetFontType | no |  |

### UIWidgetIconInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `sourceType` | WidgetIconSourceType | no |  |
| `sourceID` | number | no |  |
| `sizeType` | WidgetIconSizeType | no |  |
| `tooltip` | string | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |

### UIWidgetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `widgetID` | number | no |  |
| `widgetSetID` | number | no |  |
| `widgetType` | UIWidgetVisualizationType | no |  |
| `unitToken` | string | yes |  |

### UIWidgetItemInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `itemID` | number | no |  |
| `stackCount` | number | yes |  |
| `overrideItemName` | string | yes |  |
| `infoText` | string | yes |  |
| `overrideTooltip` | string | yes |  |
| `textDisplayStyle` | ItemDisplayTextDisplayStyle | no |  |
| `tooltipEnabled` | bool | no |  |
| `iconSizeType` | WidgetIconSizeType | no |  |
| `infoTextEnabledState` | WidgetEnabledState | no |  |
| `showAsEarned` | bool | no |  |
| `itemNameTextFontType` | UIWidgetFontType | no |  |
| `itemNameTextSizeType` | UIWidgetTextSizeType | no |  |
| `infoTextFontType` | UIWidgetFontType | no |  |
| `infoTextSizeType` | UIWidgetTextSizeType | no |  |
| `itemNameCustomColor` | WidgetEnabledState | no |  |
| `itemNameCustomColorOverrideState` | UIWidgetOverrideState | no |  |

### UIWidgetMotionType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Instant` | UIWidgetMotionType | no |  |
| `Smooth` | UIWidgetMotionType | no |  |

### UIWidgetOverrideState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Inactive` | UIWidgetOverrideState | no |  |
| `Active` | UIWidgetOverrideState | no |  |

### UIWidgetRewardInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | UIWidgetRewardShownState | no |  |
| `earnedTooltip` | string | no |  |
| `unearnedTooltip` | string | no |  |

### UIWidgetRewardShownState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hidden` | UIWidgetRewardShownState | no |  |
| `ShownEarned` | UIWidgetRewardShownState | no |  |
| `ShownUnearned` | UIWidgetRewardShownState | no |  |

### UIWidgetSetInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `layoutDirection` | UIWidgetSetLayoutDirection | no |  |
| `verticalPadding` | number | no |  |

### UIWidgetSpellButtonCooldownType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `HideCooldown` | UIWidgetSpellButtonCooldownType | no |  |
| `ShowCooldown` | UIWidgetSpellButtonCooldownType | no |  |
| `ShowCooldownAndDisableOnCooldown` | UIWidgetSpellButtonCooldownType | no |  |

### UIWidgetSpellButtonInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `tooltip` | string | no |  |
| `icon` | UIWidgetButtonIconType | no |  |
| `enabledState` | UIWidgetButtonEnabledState | no |  |
| `cooldownType` | UIWidgetSpellButtonCooldownType | no |  |

### UIWidgetSpellInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `spellID` | number | no |  |
| `shownState` | WidgetShownState | no |  |
| `enabledState` | WidgetEnabledState | no |  |
| `tooltip` | string | no |  |
| `text` | string | no |  |
| `stackDisplay` | number | no |  |
| `iconSizeType` | WidgetIconSizeType | no |  |
| `iconDisplayType` | SpellDisplayIconDisplayType | no |  |
| `textShownState` | SpellDisplayTextShownStateType | no |  |
| `borderColor` | SpellDisplayBorderColor | no |  |
| `textFontType` | UIWidgetFontType | no |  |
| `textSizeType` | UIWidgetTextSizeType | no |  |
| `hAlignType` | WidgetTextHorizontalAlignmentType | no |  |
| `tint` | SpellDisplayTint | no |  |
| `showGlowState` | WidgetShowGlowState | no |  |
| `showAsEarned` | bool | no |  |

### UIWidgetStateIconInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `iconState` | IconState | no |  |
| `state1Tooltip` | string | no |  |
| `state2Tooltip` | string | no |  |

### UIWidgetTextFormatType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | UIWidgetTextFormatType | no |  |
| `TimeOneLevel` | UIWidgetTextFormatType | no |  |
| `TimeTwoLevel` | UIWidgetTextFormatType | no |  |
| `LeadingZeroesWithSixDigits` | UIWidgetTextFormatType | no |  |

### UIWidgetTextSizeType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Small12Pt` | UIWidgetTextSizeType | no |  |
| `Medium16Pt` | UIWidgetTextSizeType | no |  |
| `Large24Pt` | UIWidgetTextSizeType | no |  |
| `Huge27Pt` | UIWidgetTextSizeType | no |  |
| `Standard14Pt` | UIWidgetTextSizeType | no |  |
| `Small10Pt` | UIWidgetTextSizeType | no |  |
| `Small11Pt` | UIWidgetTextSizeType | no |  |
| `Medium18Pt` | UIWidgetTextSizeType | no |  |
| `Large20Pt` | UIWidgetTextSizeType | no |  |

### UIWidgetTextTooltipPair (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | string | no |  |
| `tooltip` | string | no |  |

### UIWidgetTextureAndTextSizeType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Small` | UIWidgetTextureAndTextSizeType | no |  |
| `Medium` | UIWidgetTextureAndTextSizeType | no |  |
| `Large` | UIWidgetTextureAndTextSizeType | no |  |
| `Huge` | UIWidgetTextureAndTextSizeType | no |  |
| `Standard` | UIWidgetTextureAndTextSizeType | no |  |
| `Medium2` | UIWidgetTextureAndTextSizeType | no |  |

### UIWidgetTooltipLocation (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Default` | UIWidgetTooltipLocation | no |  |
| `BottomLeft` | UIWidgetTooltipLocation | no |  |
| `Left` | UIWidgetTooltipLocation | no |  |
| `TopLeft` | UIWidgetTooltipLocation | no |  |
| `Top` | UIWidgetTooltipLocation | no |  |
| `TopRight` | UIWidgetTooltipLocation | no |  |
| `Right` | UIWidgetTooltipLocation | no |  |
| `BottomRight` | UIWidgetTooltipLocation | no |  |
| `Bottom` | UIWidgetTooltipLocation | no |  |

### UIWidgetUpdateAnimType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | UIWidgetUpdateAnimType | no |  |
| `Flash` | UIWidgetUpdateAnimType | no |  |
| `FlashAndAnimateNumber` | UIWidgetUpdateAnimType | no |  |

### UnitPowerBarWidgetVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `barMin` | number | no |  |
| `barMax` | number | no |  |
| `barValue` | number | no |  |
| `tooltip` | string | no |  |
| `barValueTextType` | StatusBarValueTextType | no |  |
| `overrideBarText` | string | no |  |
| `overrideBarTextShownType` | StatusBarOverrideBarTextShownType | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `fillMotionType` | UIWidgetMotionType | no |  |
| `flashBlendModeType` | UIWidgetBlendModeType | no |  |
| `sparkBlendModeType` | UIWidgetBlendModeType | no |  |
| `flashMomentType` | WidgetUnitPowerBarFlashMomentType | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### WidgetAnimationType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | WidgetAnimationType | no |  |
| `Fade` | WidgetAnimationType | no |  |

### WidgetCurrencyClass (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Currency` | WidgetCurrencyClass | no |  |
| `Item` | WidgetCurrencyClass | no |  |

### WidgetEnabledState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Disabled` | WidgetEnabledState | no |  |
| `Yellow` | WidgetEnabledState | no |  |
| `Red` | WidgetEnabledState | no |  |
| `White` | WidgetEnabledState | no |  |
| `Green` | WidgetEnabledState | no |  |
| `Artifact` | WidgetEnabledState | no |  |
| `Black` | WidgetEnabledState | no |  |
| `BrightBlue` | WidgetEnabledState | no |  |

### WidgetGlowAnimType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `None` | WidgetGlowAnimType | no |  |
| `Pulse` | WidgetGlowAnimType | no |  |

### WidgetIconSizeType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Small` | WidgetIconSizeType | no |  |
| `Medium` | WidgetIconSizeType | no |  |
| `Large` | WidgetIconSizeType | no |  |
| `Standard` | WidgetIconSizeType | no |  |

### WidgetIconSourceType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Spell` | WidgetIconSourceType | no |  |
| `Item` | WidgetIconSourceType | no |  |

### WidgetOpacityType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `OneHundred` | WidgetOpacityType | no |  |
| `Ninety` | WidgetOpacityType | no |  |
| `Eighty` | WidgetOpacityType | no |  |
| `Seventy` | WidgetOpacityType | no |  |
| `Sixty` | WidgetOpacityType | no |  |
| `Fifty` | WidgetOpacityType | no |  |
| `Forty` | WidgetOpacityType | no |  |
| `Thirty` | WidgetOpacityType | no |  |
| `Twenty` | WidgetOpacityType | no |  |
| `Ten` | WidgetOpacityType | no |  |
| `Zero` | WidgetOpacityType | no |  |

### WidgetShowGlowState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `HideGlow` | WidgetShowGlowState | no |  |
| `ShowGlow` | WidgetShowGlowState | no |  |

### WidgetShownState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Hidden` | WidgetShownState | no |  |
| `Shown` | WidgetShownState | no |  |

### WidgetTextHorizontalAlignmentType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Left` | WidgetTextHorizontalAlignmentType | no |  |
| `Center` | WidgetTextHorizontalAlignmentType | no |  |
| `Right` | WidgetTextHorizontalAlignmentType | no |  |

### WidgetUnitPowerBarFlashMomentType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `FlashWhenMax` | WidgetUnitPowerBarFlashMomentType | no |  |
| `FlashWhenMin` | WidgetUnitPowerBarFlashMomentType | no |  |
| `NeverFlash` | WidgetUnitPowerBarFlashMomentType | no |  |

### ZoneControlActiveState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `Inactive` | ZoneControlActiveState | no |  |
| `Active` | ZoneControlActiveState | no |  |

### ZoneControlDangerFlashType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `ShowOnGoodStates` | ZoneControlDangerFlashType | no |  |
| `ShowOnBadStates` | ZoneControlDangerFlashType | no |  |
| `ShowOnBoth` | ZoneControlDangerFlashType | no |  |
| `ShowOnNeither` | ZoneControlDangerFlashType | no |  |

### ZoneControlFillType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `SingleFillClockwise` | ZoneControlFillType | no |  |
| `SingleFillCounterClockwise` | ZoneControlFillType | no |  |
| `DoubleFillClockwise` | ZoneControlFillType | no |  |
| `DoubleFillCounterClockwise` | ZoneControlFillType | no |  |

### ZoneControlLeadingEdgeType (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `NoLeadingEdge` | ZoneControlLeadingEdgeType | no |  |
| `UseLeadingEdge` | ZoneControlLeadingEdgeType | no |  |

### ZoneControlMode (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `BothStatesAreGood` | ZoneControlMode | no |  |
| `State1IsGood` | ZoneControlMode | no |  |
| `State2IsGood` | ZoneControlMode | no |  |
| `NeitherStateIsGood` | ZoneControlMode | no |  |

### ZoneControlState (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `State1` | ZoneControlState | no |  |
| `State2` | ZoneControlState | no |  |

### ZoneControlVisualizationInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `shownState` | WidgetShownState | no |  |
| `mode` | ZoneControlMode | no |  |
| `leadingEdgeType` | ZoneControlLeadingEdgeType | no |  |
| `dangerFlashType` | ZoneControlDangerFlashType | no |  |
| `zoneEntries` | ZoneEntry[] | no |  |
| `tooltipLoc` | UIWidgetTooltipLocation | no |  |
| `widgetSizeSetting` | number | no |  |
| `textureKit` | textureKit | no |  |
| `frameTextureKit` | textureKit | no |  |
| `hasTimer` | bool | no |  |
| `orderIndex` | number | no |  |
| `widgetTag` | string | no |  |
| `inAnimType` | WidgetAnimationType | no |  |
| `outAnimType` | WidgetAnimationType | no |  |
| `widgetScale` | UIWidgetScale | no |  |
| `layoutDirection` | UIWidgetLayoutDirection | no |  |
| `modelSceneLayer` | UIWidgetModelSceneLayer | no |  |
| `scriptedAnimationEffectID` | number | no |  |

### ZoneEntry (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `state` | ZoneControlState | no |  |
| `activeState` | ZoneControlActiveState | no |  |
| `fillType` | ZoneControlFillType | no |  |
| `min` | number | no |  |
| `max` | number | no |  |
| `current` | number | no |  |
| `capturePoint` | number | no |  |
| `tooltip` | string | no |  |

