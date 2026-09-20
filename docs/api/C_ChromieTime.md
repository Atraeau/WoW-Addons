# C_ChromieTime

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**4** functions · **0** events · **1** types

## Functions

### C_ChromieTime.CloseUI

```lua
C_ChromieTime.CloseUI()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ChromieTime.CloseUI()
```

### C_ChromieTime.GetChromieTimeExpansionOption

```lua
info = C_ChromieTime.GetChromieTimeExpansionOption(expansionRecID)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionRecID` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | ChromieTimeExpansionInfo | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local info = C_ChromieTime.GetChromieTimeExpansionOption(0)
```

### C_ChromieTime.GetChromieTimeExpansionOptions

```lua
expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `expansionOptions` | ChromieTimeExpansionInfo[] | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
```

### C_ChromieTime.SelectChromieTimeOption

```lua
C_ChromieTime.SelectChromieTimeOption(chromieTimeExpansionInfoId)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `chromieTimeExpansionInfoId` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
C_ChromieTime.SelectChromieTimeOption(0)
```

## Types

### ChromieTimeExpansionInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `id` | number | no |  |
| `name` | cstring | no |  |
| `description` | cstring | no |  |
| `mapAtlas` | textureAtlas | no |  |
| `previewAtlas` | textureAtlas | no |  |
| `completed` | bool | no |  |
| `alreadyOn` | bool | no |  |
| `recommended` | bool | no |  |
| `sortPriority` | number | no |  |

