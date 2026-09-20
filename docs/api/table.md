# table

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 09:09:13.

**12** functions · **0** events · **0** types

## Functions

### table.contains

Returns true if any value in the table compares equal to the specified value.

```lua
containsValue = table.contains(table, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table to search. |
| `value` | any | yes | The value for which to search. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `containsValue` | bool | no | True if any entry in the table has the specified value. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local containsValue = table.contains(table)
```

### table.count

Returns the number of entries in the table.

```lua
count = table.count(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table whose entries will be counted. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `count` | number | no | The number of entries in the table. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local count = table.count(table)
```

### table.create

Creates an empty table with storage preallocated for the specified number of array and non-array entries.

```lua
table = table.create(arraySizeHint, nodeSizeHint)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `arraySizeHint` | number | no | The number of array entries for which to preallocate storage. |
| `nodeSizeHint` | number | no | The number of non-array entries for which to preallocate storage. (default: 0) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local table = table.create(0, 0)
```

### table.freeze

Marks a supplied table as frozen, preventing any modifications to its contents, or replacement of its metatable. If the table has a pre-existing metatable with a '__newindex' table or function, assignments will pass through without raising errors. For tainted code, only tables created by the same addon making this function call are permitted to be frozen.

```lua
frozen = table.freeze(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table to freeze. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frozen` | table | no | The supplied table, passed through. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frozen = table.freeze(table)
```

### table.getcountinfo

Returns detailed information about the number and distribution of entries in the table.

```lua
numEntries, numPositiveIntegerKeys, maxPositiveIntegerKey = table.getcountinfo(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table to inspect. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `numEntries` | number | no | The total number of entries in the table. |
| `numPositiveIntegerKeys` | number | no | The number of entries with positive integral keys. |
| `maxPositiveIntegerKey` | number | no | The largest positive integral key in the table, or zero if no such keys were found. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local numEntries, numPositiveIntegerKeys, maxPositiveIntegerKey = table.getcountinfo(table)
```

### table.indexof

Returns the first integer index whose value compares equal to the specified value, searching consecutively from index 1 until the first nil value.

```lua
index = table.indexof(table, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table to search. |
| `value` | any | yes | The value for which to search. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `index` | number | yes | The first matching index, or nil if no match is found. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local index = table.indexof(table)
```

### table.isempty

Returns true if the table contains no entries.

```lua
empty = table.isempty(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `empty` | bool | no | True if the table contains no entries; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local empty = table.isempty(table)
```

### table.isfrozen

Returns true if a table has been marked as frozen.

```lua
frozen = table.isfrozen(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table to inspect. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frozen` | bool | no | True if the table has been made read-only; otherwise false. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frozen = table.isfrozen(table)
```

### table.keys

Returns an array containing the keys of the specified table.

```lua
keys = table.keys(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table whose keys will be returned. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `keys` | any | no | An array containing the table's keys. The order of the returned keys is unspecified. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local keys = table.keys(table)
```

### table.removeunordered

Removes the value at the specified integer index by replacing it with the last value in the array and shortening the array by one element. The order of values in the array is not preserved.

```lua
value = table.removeunordered(table, [index])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table from which to remove a value. |
| `index` | number | yes | The integer index of the value to remove. If omitted, the last value is removed. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | any | yes | The removed value, or nil if the index is outside the array bounds. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local value = table.removeunordered(table)
```

### table.removevalue

Removes all values equal to the specified value from the array portion of a table.

```lua
removedCount = table.removevalue(table, [value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table from which to remove values. |
| `value` | any | yes | The value to remove. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `removedCount` | number | no | The number of values removed. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local removedCount = table.removevalue(table)
```

### table.values

Returns an array containing the values of the specified table.

```lua
values = table.values(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | table | no | The table whose values will be returned. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | any | no | An array containing the table's values. The order of the returned values is unspecified. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local values = table.values(table)
```

