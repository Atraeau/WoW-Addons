# SimpleAnimatableObjectAPI

[← API index](../README.md) · group: [Achievements & Progression](README.md)

> Generated from the WoW: Forever client (build 70790, interface 16001) on 2026-11-05 05:23:47.

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

**Example** _(auto-generated from the signature — illustrative)_

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

**Example** _(auto-generated from the signature — illustrative)_

```lua
local groups = GetAnimationGroups()
```

### SimpleAnimatableObjectAPI.StopAnimating

```lua
StopAnimating()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
StopAnimating()
```
