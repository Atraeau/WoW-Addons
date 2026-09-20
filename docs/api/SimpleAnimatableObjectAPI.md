# SimpleAnimatableObjectAPI

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**3** functions · **0** events · **0** types

## Functions

### SimpleAnimatableObjectAPI.CreateAnimationGroup

```lua
group = CreateAnimationGroup([name], [templateName])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `name` | cstring | yes |  |
| `templateName` | cstring | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `group` | SimpleAnimGroup | no |  |

**Example**

```lua
local group = CreateAnimationGroup()
```

### SimpleAnimatableObjectAPI.GetAnimationGroups

```lua
groups = GetAnimationGroups()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `groups` | SimpleAnimGroup | no |  |

**Example**

```lua
local groups = GetAnimationGroups()
```

### SimpleAnimatableObjectAPI.StopAnimating

```lua
StopAnimating()
```

**Example**

```lua
StopAnimating()
```

