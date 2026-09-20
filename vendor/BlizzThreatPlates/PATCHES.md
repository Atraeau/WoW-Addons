# BlizzThreatPlates — WoW: Forever (Camelot) compatibility patches

This is a tracked copy of the third-party addon **BlizzThreatPlates** with local
fixes applied for the **WoW: Forever** client (product `wow_classic_beta`, codename
*Camelot*, interface `16001`). WoW: Forever runs on the **modern retail engine**, so
the addon's retail-era assumptions mostly hold — but a handful of APIs that were
removed/renamed in recent retail patches also break here.

The live copy lives at:
`C:\Program Files (x86)\World of Warcraft\_classic_beta_\Interface\AddOns\BlizzThreatPlates`

⚠️ Updating/reinstalling the addon will overwrite these fixes. Re-apply the changes
below (or copy this folder back over the install).

> Note on verification: the Blizzard UI source is not extracted to disk on a normal
> install (it's packed in the CASC `Data/` archives), so the replacement APIs were
> confirmed against the **running client** using the `BTPCompatCheck` addon
> (`/btpcheck`) in this repo rather than assumed. Run it in game to re-verify.

## Changes

### 1. `BlizzThreatPlates.lua` — removed `UNIT_HEALTH_FREQUENT` registration
`UNIT_HEALTH_FREQUENT` was removed from the engine (folded into `UNIT_HEALTH`).
Registering it throws `Attempt to register unknown event`.

```lua
-- before
eventFrame:RegisterEvent("UNIT_HEALTH")
eventFrame:RegisterEvent("UNIT_HEALTH_FREQUENT")   -- removed
-- after
eventFrame:RegisterEvent("UNIT_HEALTH")
```
The handler already routed both events to the same code, and `UNIT_HEALTH` now fires
at the frequent rate, so nothing is lost. (The harmless `or event == "UNIT_HEALTH_FREQUENT"`
comparison in the handler was left in place.)

### 2. `BlizzThreatPlates.lua:222` — `PixelUtil.SetStatusBarValue` → `:SetValue`
`PixelUtil.SetStatusBarValue` is not present on this client (nil), so the call errored.
The StatusBar's own method is the direct equivalent and also accepts the protected
("secret") value that `UnitHealth` now returns.

```lua
-- before
PixelUtil.SetStatusBarValue(unitFrame.healthBarReplica, UnitHealth(unit))
-- after
unitFrame.healthBarReplica:SetValue(UnitHealth(unit))
```

### 3. `Roles.lua` — `UnitBuff` → `C_UnitAuras.GetBuffDataByIndex`
`UnitBuff` was removed in the 11.0 aura API overhaul. Used by Paladin-tank detection.

```lua
-- before: local name, _, ..., id = UnitBuff(unit, i); if not name then break elseif id == spellId ...
-- after:
for i = 1, 40 do
    local aura = C_UnitAuras.GetBuffDataByIndex(unit, i)
    if not aura then break
    elseif aura.spellId == spellId then return true end
end
```

### 4. `Spells.lua` — `UnitDebuff` → `C_UnitAuras.GetDebuffDataByIndex`
Same removal as `UnitBuff`. Used by `addon.UnitIsIncapacitated`.

```lua
-- after:
for i = 1, 40 do
    local aura = C_UnitAuras.GetDebuffDataByIndex(unit, i)
    if not aura then break
    elseif INCAPACITATE_SPELLS[aura.spellId] then return true end
end
```

### 5. `Config.lua` — ColorPicker migrated to the 10.2.5+ API
The pre-Dragonflight ColorPicker flow (`OpacitySliderFrame`, `ColorPickerFrame.swatchFunc`
/`cancelFunc`/`opacityFunc` fields, `:SetColorRGB`, `.opacity`) is gone. `OpacitySliderFrame`
is nil, so opening the Priority Marker color picker crashed.

- Opening the picker now uses `ColorPickerFrame:SetupColorPickerAndShow({ r, g, b, opacity, hasOpacity, swatchFunc, opacityFunc, cancelFunc })` (two call sites).
- Reading the chosen color uses `ColorPickerFrame:GetColorRGB()` + `ColorPickerFrame:GetColorAlpha()`.
- Alpha semantics flipped: the old API stored transparency (`1 - a`); the new one stores
  alpha directly, so the `1 - a` conversions were removed.
- `cancelFunc` now receives a `{ r, g, b, a }` table (was a positional array via `unpack`).

### 6. `BlizzThreatPlates.lua` — guard threat reads against WoW 12.0 Secret Values
`UnitDetailedThreatSituation` now returns **secret values** for enemy units. Addon
("tainted") code cannot compare or do arithmetic on a secret value, so
`if threatPct > 100` at line ~243 crashed with:
`attempt to compare local 'threatPct' (a secret number value ...)`.

Added an `issecretvalue()` guard right after the call that falls back to the default
visual when the data is secret:

```lua
local isTanking, status, threatPct, rawThreatPct, threatValue = UnitDetailedThreatSituation("player", unit)
if issecretvalue(status) or issecretvalue(threatPct) or issecretvalue(threatValue) then
    ShowDefaultVisual(unitFrame)
    return
end
```

## Known limitation — the addon's core feature is engine-restricted now
WoW 12.0 **Secret Values** + secure-action protection curtail what BlizzThreatPlates
was built to do:
- **Threat data is secret** for enemy units, so the threat indicator / threat-based
  coloring cannot be computed in addon code. The guard above stops the crash but those
  units just get the default visual.
- **"Blocked from an action only available to the Blizzard UI"** — recoloring/replicating
  the protected nameplate health bar is now a Blizzard-UI-only (secure) action.

Making these features work again is an **upstream redesign**, not a local patch — likely
impossible for the parts that read threat. Treat BlizzThreatPlates as *loads without
errors but threat features are largely inert* on this client. See the `WowApiExport`
addon in this repo to enumerate which APIs are available/secret, and Warcraft Wiki's
[Secret Values](https://warcraft.wiki.gg/wiki/Secret_Values) page for the rules
(`issecretvalue()`, secret-safe APIs).
