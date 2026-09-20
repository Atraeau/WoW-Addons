# C_XMLUtil

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**2** functions · **0** events · **3** types

## Functions

### C_XMLUtil.GetTemplateInfo

```lua
info = C_XMLUtil.GetTemplateInfo(name)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `info` | XMLTemplateInfo | no |  |

**Example**

```lua
local info = C_XMLUtil.GetTemplateInfo("")
```

### C_XMLUtil.GetTemplates

```lua
templates = C_XMLUtil.GetTemplates()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `templates` | XMLTemplateListInfo[] | no |  |

**Example**

```lua
local templates = C_XMLUtil.GetTemplates()
```

## Types

### XMLTemplateInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `type` | cstring | no |  |
| `width` | number | no |  |
| `height` | number | no |  |
| `keyValues` | XMLTemplateKeyValue[] | no |  |
| `inherits` | cstring | yes |  |
| `sourceLocation` | string | no |  |

### XMLTemplateKeyValue (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `key` | cstring | no |  |
| `keyType` | cstring | no |  |
| `type` | cstring | no |  |
| `value` | cstring | no |  |

### XMLTemplateListInfo (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | no |  |
| `type` | cstring | no |  |

