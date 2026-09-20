# C_ReportSystem

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**12** functions · **2** events · **0** types

## Functions

### C_ReportSystem.CanReportPlayer

```lua
canReport = C_ReportSystem.CanReportPlayer(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canReport` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canReport = C_ReportSystem.CanReportPlayer(playerLocation)
```

### C_ReportSystem.CanReportPlayerForLanguage

```lua
canReport = C_ReportSystem.CanReportPlayerForLanguage(playerLocation)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `playerLocation` | PlayerLocation | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canReport` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canReport = C_ReportSystem.CanReportPlayerForLanguage(playerLocation)
```

### C_ReportSystem.GetMajorCategoriesForReportType

```lua
majorCategories = C_ReportSystem.GetMajorCategoriesForReportType(reportType)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reportType` | ReportType | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorCategories` | ReportMajorCategory[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local majorCategories = C_ReportSystem.GetMajorCategoriesForReportType(reportType)
```

### C_ReportSystem.GetMajorCategoryString

```lua
majorCategoryString = C_ReportSystem.GetMajorCategoryString(majorCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorCategory` | ReportMajorCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `majorCategoryString` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local majorCategoryString = C_ReportSystem.GetMajorCategoryString(majorCategory)
```

### C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory

```lua
minorCategories = C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory(reportType, majorCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reportType` | ReportType | no |  |
| `majorCategory` | ReportMajorCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minorCategories` | ReportMinorCategory[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minorCategories = C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory(reportType, majorCategory)
```

### C_ReportSystem.GetMinorCategoryString

```lua
minorCategoryString = C_ReportSystem.GetMinorCategoryString(minorCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minorCategory` | ReportMinorCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `minorCategoryString` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local minorCategoryString = C_ReportSystem.GetMinorCategoryString(minorCategory)
```

### C_ReportSystem.ReportServerLag

```lua
C_ReportSystem.ReportServerLag()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ReportSystem.ReportServerLag()
```

### C_ReportSystem.ReportStuckInCombat

```lua
C_ReportSystem.ReportStuckInCombat()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ReportSystem.ReportStuckInCombat()
```

### C_ReportSystem.RequiresScreenshotForReportType

```lua
requiresScreenshot = C_ReportSystem.RequiresScreenshotForReportType(reportType, majorCategory)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reportType` | ReportType | no |  |
| `majorCategory` | ReportMajorCategory | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `requiresScreenshot` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local requiresScreenshot = C_ReportSystem.RequiresScreenshotForReportType(reportType, majorCategory)
```

### C_ReportSystem.SendReport

Not allowed to be called by addons

```lua
C_ReportSystem.SendReport(reportInfo, [playerLocation])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `reportInfo` | ReportInfo | no |  |
| `playerLocation` | PlayerLocation | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ReportSystem.SendReport(reportInfo)
```

### C_ReportSystem.SetScreenshotPreviewTexture

```lua
C_ReportSystem.SetScreenshotPreviewTexture(textureObject)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `textureObject` | SimpleTexture | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ReportSystem.SetScreenshotPreviewTexture(textureObject)
```

### C_ReportSystem.TakeReportScreenshot

```lua
C_ReportSystem.TakeReportScreenshot()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ReportSystem.TakeReportScreenshot()
```

## Events

### REPORT_PLAYER_RESULT

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | SendReportResult | no |  |
| `reportType` | ReportType | no |  |

### REPORT_SCREENSHOT_READY

