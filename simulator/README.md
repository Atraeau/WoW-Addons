# King's Gambit simulator

A browser page that runs the **real** King's Gambit loot engine over a simulated raid, so
people can practice being the Master Looter before the addon is playable in the game.

Open `simulator/index.html` in a browser. It is one self-contained file (the engine is inlined);
the only outside resource is a pinned, integrity-checked copy of
[fengari](https://fengari.io) (Lua in JavaScript) from a CDN, so it needs an internet connection.

## What it is, and is not

- **Is:** the actual rules, the actual ledger and the actual loot session, running on a
  `MockClient` with bot raiders. The seven training scenarios in `src/KingsGambit/Scenarios.lua`
  are also tests: the suite runs each one against the engine, and the page can re-run them in
  the browser (`KG('selftest')` in the console).
- **Is not:** the WoW user interface, and it cannot validate anything about the real client
  (Secret Values, addon-message restrictions, Master Looter indexing). That is what the in-game
  `/gambit check` and the dungeon field test are for.

## Rebuilding

The page is generated; edit the sources, then rebuild from the repo root (needs Lua 5.4):

```
lua scripts/build-simulator.lua
```

- `src/template.html`: the page (HTML, CSS, JavaScript)
- `src/api.lua`: the JSON bridge between the page and the engine
- the engine modules come straight from `src/KingsGambit/`

## Publishing

Nothing here is published by GitHub Pages: only `docs/` is. To publish it, move or copy
`simulator/index.html` into `docs/` (and point `DIR` in `scripts/build-simulator.lua` there).
