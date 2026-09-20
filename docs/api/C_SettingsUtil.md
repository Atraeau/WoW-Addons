# C_SettingsUtil

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **2** events · **0** types

## Functions

### C_SettingsUtil.NotifySettingsLoaded

```lua
C_SettingsUtil.NotifySettingsLoaded()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SettingsUtil.NotifySettingsLoaded()
```

### C_SettingsUtil.OpenSettingsPanel

```lua
C_SettingsUtil.OpenSettingsPanel([openToCategoryID], [scrollToElementName])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `openToCategoryID` | number | yes |  |
| `scrollToElementName` | stringView | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_SettingsUtil.OpenSettingsPanel()
```

## Events

### SETTINGS_LOADED

### SETTINGS_PANEL_OPEN

**Payload**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `openToCategoryID` | number | yes |  |
| `scrollToElementName` | stringView | yes |  |

