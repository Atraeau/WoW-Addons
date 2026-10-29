# King's Gambit

Raid loot via King's Gambit on a transparent, tamper-evident ledger, for WoW: Forever.

Derived from the classic Suicide Kings strategy; named for the chess gambit, a deliberate
sacrifice of position for advantage. Status: **Phase 0 scaffold** (module stubs only). Design lives in
[`docs/kings-gambit/`](../../docs/kings-gambit/): manifesto, rationale, design journal.

The previous prototype is kept in `archive/SuicideKings-legacy/` for reference.

## Tests

The ledger modules are pure Lua. From the repo root, with Lua 5.4 installed:

```
lua tests/kings-gambit/run.lua
```
