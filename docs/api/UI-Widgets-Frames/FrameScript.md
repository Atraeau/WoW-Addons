# FrameScript

[← API index](../README.md) · group: [UI Widgets & Frames](README.md)

> Generated from the WoW: Forever client (build 69913, interface 16001) on 2026-09-20 13:15:25.

**38** functions · **0** events · **6** types

## Functions

### FrameScript.AddSourceLocationExclude

```lua
AddSourceLocationExclude(fileName)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `fileName` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
AddSourceLocationExclude("")
```

### FrameScript.canaccessallvalues

Returns true if the immediate calling function has appropriate permissions to access and operate on all supplied values.

```lua
canAccessAllValues = canaccessallvalues(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccessAllValues` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccessAllValues = canaccessallvalues(values)
```

### FrameScript.canaccesssecrets

Returns true if the immediate calling function has appropriate permissions to access or operate on secret values.

```lua
canAccessSecrets = canaccesssecrets()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccessSecrets` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccessSecrets = canaccesssecrets()
```

### FrameScript.canaccesstable

Returns true if the immediate calling function has appropriate permissions to index secret tables. This will return false if the caller cannot access the table value itself, or if access to the table contents is disallowed by taint.

```lua
canAccessTable = canaccesstable(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccessTable` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccessTable = canaccesstable(table)
```

### FrameScript.canaccessvalue

Returns true if the immediate calling function has appropriate permissions to access and operate on a specific value.

```lua
canAccessValue = canaccessvalue(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `canAccessValue` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local canAccessValue = canaccessvalue(value)
```

### FrameScript.CreateFrameWithOptions

```lua
frame = CreateFrameWithOptions(options)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `options` | CreateFrameOptions | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frame` | SimpleFrame | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local frame = CreateFrameWithOptions(options)
```

### FrameScript.CreateFromMixins

```lua
object = CreateFromMixins(mixins)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mixins` | LuaValueVariant | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `object` | LuaValueVariant | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local object = CreateFromMixins(mixins)
```

### FrameScript.CreateSecureDelegate

Creates a secure delegate closure for a Lua function. The delegate invokes the original function in a protected call context with secure execution taint, and supports passing and returning values directly.

```lua
secureDelegateFunction = CreateSecureDelegate(luaFunction, [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `luaFunction` | LuaValueReference | no | The Lua function to invoke through the secure delegate. |
| `options` | SecureDelegateOptions | yes | Optional settings controlling secure delegate behavior. If omitted, default options are used. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `secureDelegateFunction` | LuaValueReference | no | A secure delegate function that calls through to the original Lua function. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local secureDelegateFunction = CreateSecureDelegate(luaFunction)
```

### FrameScript.CreateWindow

```lua
window = CreateWindow(popupStyle, topMost)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `popupStyle` | bool | no | (default: True) |
| `topMost` | bool | no | (default: False) |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `window` | SimpleWindow | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local window = CreateWindow(false, false)
```

### FrameScript.debugprofilestart

Starts a timer for profiling. The final time can be obtained by calling debugprofilestop.

```lua
debugprofilestart()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
debugprofilestart()
```

### FrameScript.debugprofilestop

Returns the time in milliseconds since the last debugprofilestart call.

```lua
elapsedMilliseconds = debugprofilestop()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `elapsedMilliseconds` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local elapsedMilliseconds = debugprofilestop()
```

### FrameScript.dropsecretaccess

Removes the ability for the immediate calling function to access secret values.

```lua
dropsecretaccess()
```

**Example** _(auto-generated from the signature — illustrative)_

```lua
dropsecretaccess()
```

### FrameScript.dumpobject

Invokes the '__dump' metamethod on any value (if present), returning its result.

```lua
result = dumpobject([value])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueReference | yes |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `result` | LuaValueReference | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local result = dumpobject()
```

### FrameScript.GetCallstackHeight

```lua
height = GetCallstackHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local height = GetCallstackHeight()
```

### FrameScript.GetCurrentEventID

```lua
eventID = GetCurrentEventID()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventID` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local eventID = GetCurrentEventID()
```

### FrameScript.GetErrorCallstackHeight

```lua
height = GetErrorCallstackHeight()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local height = GetErrorCallstackHeight()
```

### FrameScript.GetEventTime

```lua
totalElapsedTime, numExecutedHandlers, slowestHandlerName, slowestHandlerTime = GetEventTime(eventProfileIndex)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventProfileIndex` | number | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `totalElapsedTime` | number | no |  |
| `numExecutedHandlers` | number | no |  |
| `slowestHandlerName` | cstring | no |  |
| `slowestHandlerTime` | number | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local totalElapsedTime, numExecutedHandlers, slowestHandlerName, slowestHandlerTime = GetEventTime(1)
```

### FrameScript.GetForbiddenObjectTable

```lua
forbiddenTable = GetForbiddenObjectTable(object)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `object` | FrameScriptObject | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `forbiddenTable` | FrameScriptObject | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local forbiddenTable = GetForbiddenObjectTable(object)
```

### FrameScript.GetScriptBucketThrottleLimits

```lua
limits = GetScriptBucketThrottleLimits()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `limits` | ScriptBucketThrottleLimits | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local limits = GetScriptBucketThrottleLimits()
```

### FrameScript.GetSourceLocation

```lua
location = GetSourceLocation()
```

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `location` | string | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local location = GetSourceLocation()
```

### FrameScript.hasanysecretvalues

Returns true if a supplied value is a secret value.

```lua
isAnyValueSecret = hasanysecretvalues(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isAnyValueSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isAnyValueSecret = hasanysecretvalues(values)
```

### FrameScript.issecrettable

Returns true if a supplied value is a secret table. This function will return true if the table value itself is secret, or if flags on the table are set such that accesses of the table would produce secrets.

```lua
isSecretOrContentsSecret = issecrettable(table)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSecretOrContentsSecret` | bool | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local isSecretOrContentsSecret = issecrettable(table)
```

### FrameScript.issecretvalue

Returns true if a supplied value is a secret value.

```lua
isSecret = issecretvalue(value)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `isSecret` | bool | no |  |

**Example**

```lua
-- True if the value is a protected "secret" value (WoW 12.0). Safe on any value, incl. nil.
local threat = UnitThreatSituation("player", "target")
if issecretvalue(threat) then
    print("threat is secret in this context")
end
```

### FrameScript.mapvalues

Applies a given function over all supplied values individually, replacing the value with the result of the call.

```lua
mapped = mapvalues(func, values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `func` | LuaValueReference | no |  |
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `mapped` | LuaValueReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local mapped = mapvalues(func, values)
```

### FrameScript.Mixin

```lua
outObject = Mixin(object, mixins)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `object` | LuaValueVariant | no |  |
| `mixins` | LuaValueVariant | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `outObject` | LuaValueVariant | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local outObject = Mixin(object, mixins)
```

### FrameScript.RegisterEventCallback

```lua
RegisterEventCallback(eventName, callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `callback` | EventCallbackType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterEventCallback("", callback)
```

### FrameScript.RegisterUnitEventCallback

```lua
RegisterUnitEventCallback(eventName, callback, unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `callback` | EventCallbackType | no |  |
| `unit` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RegisterUnitEventCallback("", callback, "player")
```

### FrameScript.RunScript

```lua
RunScript(text)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `text` | cstring | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
RunScript("")
```

### FrameScript.scrub

Returns a transformed list of values with inputs that are either secret or are not string, number, or boolean type replaced by nil values.

```lua
scrubbed = scrub(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scrubbed` | LuaValueReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scrubbed = scrub(values)
```

### FrameScript.scrubsecretvalues

Returns a transformed list of values with inputs that are secret values replaced by nil values.

```lua
scrubbed = scrubsecretvalues(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `scrubbed` | LuaValueReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local scrubbed = scrubsecretvalues(values)
```

### FrameScript.secretunwrap

Unwraps all supplied secrets, converting them back to regular values.

```lua
unwrapped = secretunwrap(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `unwrapped` | LuaValueReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local unwrapped = secretunwrap(values)
```

### FrameScript.secretwrap

Converts all supplied values to secret values, preventing most operations on them from occurring on tainted code paths.

```lua
wrapped = secretwrap(values)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `values` | LuaValueReference | no |  |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrapped` | LuaValueReference | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local wrapped = secretwrap(values)
```

### FrameScript.securecallmethod

Invokes a named method on an object with a secure call barrier that prevents errors or taint from function lookup and execution from propagating to the caller.

```lua
results = securecallmethod(object, method, arguments)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `object` | LuaValueReference | no | The table on which to look up the named method from. Lookup of the method uses raw access and ignores any associated metatable. |
| `method` | cstring | no | The name of a method to retrieve. |
| `arguments` | LuaValueReference | no | Arguments to supply to the method. The initial 'object' parameter is always supplied as the first argument, followed by these values. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `results` | LuaValueReference | no | Results from the executed function. If an error occurred, this result list will be empty. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local results = securecallmethod(object, "", arguments)
```

### FrameScript.securecopy

Securely copies a Lua value. Tables are deep-copied with recursive and shared references preserved. Copied values receive the current execution taint.

```lua
copy = securecopy([value], [options])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `value` | LuaValueReference | yes | The Lua value to copy. |
| `options` | SecureCopyOptions | yes | Optional settings controlling value copying behavior. If omitted, default secure copy options are used. |

**Returns**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `copy` | LuaValueReference | no | The copied value. For tables, recursive and shared references within the copied graph are preserved. |

**Example** _(auto-generated from the signature — illustrative)_

```lua
local copy = securecopy()
```

### FrameScript.SetErrorCallstackHeight

```lua
SetErrorCallstackHeight([height])
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `height` | number | yes |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
SetErrorCallstackHeight()
```

### FrameScript.settablesecurity

```lua
settablesecurity(table, option)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `table` | LuaValueVariant | no |  |
| `option` | TableSecurityOption | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
settablesecurity(table, Enum.TableSecurityOption.DisallowTaintedAccess)
```

### FrameScript.UnregisterEventCallback

```lua
UnregisterEventCallback(eventName, callback)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `callback` | EventCallbackType | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UnregisterEventCallback("", callback)
```

### FrameScript.UnregisterUnitEventCallback

```lua
UnregisterUnitEventCallback(eventName, callback, unit)
```

**Arguments**

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `eventName` | cstring | no |  |
| `callback` | EventCallbackType | no |  |
| `unit` | UnitToken | no |  |

**Example** _(auto-generated from the signature — illustrative)_

```lua
UnregisterUnitEventCallback("", callback, "player")
```

## Types

### CreateFrameOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `frameType` | cstring | no |  |
| `name` | cstring | yes |  |
| `parent` | SimpleFrame | yes |  |
| `inherits` | cstring[] | yes |  |
| `id` | number | yes |  |
| `forbidden` | bool | no | (default: False) |
| `hidden` | bool | no | (default: False) |

### EventCallbackType (CallbackType)

### ScriptBucketThrottleLimits (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `luaScriptBucketThrottleMaxMsPerSecondNormal` | number | no |  |
| `luaScriptBucketThrottleMaxMsPerSecondRestricted` | number | no |  |
| `luaScriptBucketThrottleMaxMsBurstNormal` | number | no |  |
| `luaScriptBucketThrottleMaxMsBurstRestricted` | number | no |  |

### SecureCopyOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `maxTraversalDepth` | number | no | Maximum table nesting depth allowed during recursive copying. (default: 100) |
| `wrapUntrustedFunctions` | bool | no | Wrap function values in secure closures that call through using the original function taint. (default: True) |
| `permitScriptObjects` | bool | no | If true, preserve references to script objects in the copied output. By default, script objects will raise an error. (default: False) |

### SecureDelegateOptions (Structure)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `wrapUntrustedFunctions` | bool | no | Wrap function arguments in secure closures that call through using the original function taint. (default: True) |

### TableSecurityOption (Enumeration)

| Name | Type | Nilable | Description |
|------|------|---------|-------------|
| `DisallowTaintedAccess` | TableSecurityOption | no |  |
| `DisallowSecretKeys` | TableSecurityOption | no |  |
| `SecretWrapContents` | TableSecurityOption | no |  |

