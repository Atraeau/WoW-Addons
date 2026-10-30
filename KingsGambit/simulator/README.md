# King's Gambit simulator

A browser page that runs the **real** King's Gambit loot engine over a simulated raid, so
people can practice being the Master Looter before the addon is playable in the game.

**Play it online: <https://atraeau.github.io/WoW-Addons/kings-gambit/>**

Or open `simulator/index.html` in a browser. It is one self-contained file with no network needs: the engine is
inlined, and so is [fengari](https://fengari.io) (Lua running in JavaScript), kept in `vendor/` (see its README).
The page runs the addon's own Lua source: the same files, on a Lua 5.3 VM in the browser instead of the game's.

## What it is, and is not

- **Is:** the actual rules, the actual ledger and the actual loot session, running on a
  `MockClient` with bot raiders. The nine training scenarios in `src/Scenarios.lua` (simple first, in teaching order; the two full raid nights come after them)
  are also tests: the suite runs each one against the engine, and the page can re-run them in
  the browser (`KG('selftest')` in the console).
- **Is not:** the WoW user interface, and it cannot validate anything about the real client
  (Secret Values, addon-message restrictions, Master Looter indexing). That is what the in-game
  `/gambit check` and the dungeon field test are for.

## Rebuilding

The page is generated; edit the sources, then rebuild from the KingsGambit folder (needs Lua 5.4):

```
lua scripts/build-simulator.lua
```

- `src/template.html`: the page (HTML, CSS, JavaScript)
- `src/api.lua`: the JSON bridge between the page and the engine
- the engine modules come straight from `src/`

## Publishing

GitHub Pages serves the repository's `docs/` folder, so the build also writes the page to
`docs/kings-gambit/index.html` (when this folder sits inside the WoW-Addons repository), which is the URL above.
Commit both copies together; CI (`.github/workflows/tests.yml`) fails if either is out of date. If King's Gambit moves
to its own repository, give the build the folder to publish into: `lua scripts/build-simulator.lua <folder>`.
