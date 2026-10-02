# WoW: Forever compatibility patches (third-party addons)

Local fixes applied to installed third-party addons so they work on the **WoW: Forever**
client (codename *Camelot*, product `wow_classic_beta`, interface `16001`, 12.0-based engine
with **Secret Values**). These edits live in the game's `Interface\AddOns\<Addon>` folder and
are **overwritten whenever the addon updates** — re-apply from here if that happens.

Root cause for most of these: WoW: Forever runs the **modern (Midnight/12.0) engine** — removed
legacy globals, `C_Spell`/`C_UnitAuras`, and **Secret Values** (combat/threat/health values that
addon code can't read, compare, or do math on) — while reporting a **Classic** project id and a
Classic-era interface (`16001`). Addons that key "is this the modern engine?" off the project id
or interface number guess wrong.

Useful signals on this client:
- `issecretvalue(v)` — global; true for a protected "secret" value (present only on the modern engine, so also a handy "is this engine modern?" probe).
- `C_Secrets.Should*BeSecret(...)` — ask *before* reading whether a given value will be secret (threat state vs values, auras, cooldowns, power, health-max, …). See the API reference: https://atraeau.github.io/WoW-Addons/#C_Secrets

---

## TidyPlates_ThreatPlates

**Symptoms:** `Init.lua:283 attempt to call a nil value` (`_G.GetSpellInfo`),
`RegisterEvent ... unknown event "UNIT_HEALTH_FREQUENT"`, and secret-value compare errors in
`Elements/Healthbar.lua`.

**Cause:** the addon's own `Addon.IS_FOREVER` flag (which gates its modern/secret-safe branches
and `HAS_MIDNIGHT_API`) was computed wrongly — it required `WOW_PROJECT_ID == WOW_PROJECT_MAINLINE`,
but WoW: Forever uses the **Classic** project id, so `IS_FOREVER` was always `false` and the addon
fell back to legacy Classic code paths.

**Fix — one line in `Init.lua`** (detect the modern engine via `issecretvalue` instead of the
project id):

```lua
-- before
Addon.IS_FOREVER = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
  and (GetClassicExpansionLevel and type(GetClassicExpansionLevel()) == "number" and GetClassicExpansionLevel() <= LE_EXPANSION_MISTS_OF_PANDARIA)
  or false

-- after
Addon.IS_FOREVER = (issecretvalue ~= nil)
  and (GetClassicExpansionLevel and type(GetClassicExpansionLevel()) == "number" and GetClassicExpansionLevel() <= LE_EXPANSION_MISTS_OF_PANDARIA)
  or false
```

That single change cascades to the branches the author already wired correctly
(`GetSpellInfo = C_Spell.GetSpellInfo`, `UNIT_HEALTH_FREQUENT` no longer registered,
`HAS_MIDNIGHT_API` true → secret-safe health/absorb path), clearing all three errors.

> The author is actively adding Forever support, so an official build should supersede this.

---

## ThreatClassic2

**Symptom:** `core/core.lua:650 attempt to perform boolean test on local 'isTanking'
(a secret boolean value ...)`.

**Cause:** `UpdateThreatData` reads `UnitDetailedThreatSituation`, whose returns are **secret**
for group units in some content (Secret Values specifically restricts **threat meters**), then
tests/does math on them. Exact threat values cannot be read in addon code — a numeric meter can't
be restored. But the coarse **0–3 threat state** (`UnitThreatSituation`) usually stays readable,
so the addon can still show **aggro state by color**.

**Fix — `core/core.lua`, four edits.** When the detailed values come back secret, fall back to the
0–3 state and render color-only bars (no numbers).

1. Helper (near `GetColor`):

```lua
local THREAT_STATE_FILL = { [0] = 15, [1] = 45, [2] = 75, [3] = 100 }
local THREAT_STATE_FALLBACK_COLOR = { [0] = {0.6,0.6,0.6,1}, [1] = {1,1,0,1}, [2] = {1,0.6,0,1}, [3] = {1,0,0,1} }
local function GetThreatStateColor(state)
    if GetThreatStatusColor then
        local r, g, b = GetThreatStatusColor(state)
        if r then return { r, g, b, 1 } end
    end
    return THREAT_STATE_FALLBACK_COLOR[state] or { 1, 1, 1, 1 }
end
```

2. In `UpdateThreatData`, right after the `UnitDetailedThreatSituation` call — replace the
   secret check with a state fallback that inserts a `stateOnly` row:

```lua
if issecretvalue(isTanking) or issecretvalue(threatValue) or issecretvalue(threatPercent) or issecretvalue(rawThreatPercent) then
    local stateSecret = C_Secrets and C_Secrets.ShouldUnitThreatStateBeSecret
        and C_Secrets.ShouldUnitThreatStateBeSecret(unit, TC2.playerTarget)
    local state = (not stateSecret) and _G.UnitThreatSituation(unit, TC2.playerTarget) or nil
    if state == nil or issecretvalue(state) then return end
    tinsert(TC2.threatData, {
        unit = unit, isPlayer = UnitIsUnit(unit, "player"),
        threatPercent = THREAT_STATE_FILL[state] or 0, scaledPercent = nil, rawThreatPercent = nil,
        threatValue = state + 1, tps = nil, isTanking = state >= 2, outOfMeleeRange = false,
        stateOnly = true, threatState = state, stateColor = GetThreatStateColor(state),
    })
    return
end
```

3 & 4. In `TC2:UpdateThreatBars`, in **both** bar-render blocks (main loop and the player-fallback
   block), make the text/color honor `stateOnly`:

```lua
if data.stateOnly then
    bar.val:SetText(""); bar.perc:SetText(""); bar.tps:SetText("-")   -- values are secret; color conveys aggro
else
    bar.val:SetText(NumFormat(data.threatValue))
    bar.perc:SetText(floor(data.threatPercent + 0.5).."%")
    bar.tps:SetText(data.tps and NumFormat(floor(data.tps + 0.5)) or "-")
end
bar:SetValue(data.threatPercent)
local color = data.stateOnly and data.stateColor or GetColor(data.unit, data.isTanking, hasActiveIgnite)
```

**Behavior after patch:** threat readable → normal numeric meter; threat secret → bars show each
unit's aggro **state by color** (grey/yellow/orange/red), sized by state, no numbers; no errors and
no false pull warnings. A full numeric meter is not possible on this engine by design.
