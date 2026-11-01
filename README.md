# WoW-Addons

A development environment for building **multiple** World of Warcraft addons against
**WoW: Forever** (codename *Camelot*, product `wow_classic_beta`, **Interface `16001`** —
a modern **12.0**-based engine), plus a generated reference for that client's whole API.

Each addon lives under [`src/`](src); one deploy script junction-links them into the live
game, so you edit here and the game reads your source directly — no copying per change.

**📖 Live API reference:** https://atraeau.github.io/WoW-Addons/ — searchable, browsable, and
machine-readable (tools can fetch [`api.json`](https://atraeau.github.io/WoW-Addons/api.json)).

## Repository map

| Path | What's there |
| --- | --- |
| [`src/`](src) | Your addons — one folder each, holding **everything** about that addon: game code, tests, simulators, docs (source of truth) |
| `AddOns/` | **Build output** (gitignored): `src/<Addon>` built into exactly the files the client loads, mirroring the game's `Interface/AddOns` folder. See [Building and releases](#building-and-releases) |
| [`vendor/`](vendor) | Tracked third-party addons (patched for this client) |
| [`docs/api/`](docs/api/README.md) | **Generated API reference** — 405 namespaces in 19 category folders |
| [`docs/README.md`](docs/README.md) | How the API docs + LSP definitions are generated |
| [`scripts/`](scripts) | Build, deploy, scaffold, and doc/definition generators |
| [`types/`](types/WowForeverAPI.lua) | Lua Language Server definitions (client-accurate autocomplete) |
| [`wow-dev.config.json`](wow-dev.config.json) | Game path, flavor, interface version (shared config) |
| [`.vscode/`](.vscode) | Recommended extensions + Lua LSP settings |

## Addons

| Addon | Location | What it is |
| --- | --- | --- |
| HelloForever | [`src/HelloForever`](src/HelloForever) | Example addon produced by the scaffolder (`/hf`) |
| WowBagSorter | [`src/WowBagSorter`](src/WowBagSorter) | Bag/bank sorter (originally Classic 1.13; may need 12.0 fixes) |
| KingsGambit | [`src/KingsGambit`](src/KingsGambit/README.md) | King's Gambit raid loot ledger (derived from Suicide Kings); the addon itself is in its `src/` |
| WowApiExport | [`src/WowApiExport`](src/WowApiExport) | Dev tool — dumps the client's own API docs (`/apiexport`) |
| BTPCompatCheck | [`src/BTPCompatCheck`](src/BTPCompatCheck) | Dev tool — probes which APIs exist on the client (`/btpcheck`) |
| BlizzThreatPlates | [`vendor/BlizzThreatPlates`](vendor/BlizzThreatPlates) | Patched third-party addon (MIT) — see [PATCHES.md](vendor/BlizzThreatPlates/PATCHES.md) |

### King's Gambit

A full-featured raid loot system (Suicide Kings–derived) with a tamper-evident shared ledger. The
engine is plain Lua with no game dependency, so it is fully tested outside WoW.

Everything about it lives in [`src/KingsGambit/`](src/KingsGambit/README.md): the addon (its `src/`, with the training and
simulation code the game uses too), plus its docs, tests, simulator, tools and data scripts. The build ships only what
its TOC loads.

- Design: [manifesto](src/KingsGambit/docs/manifesto.md), [player guide](src/KingsGambit/docs/rationale.md),
  [design journal](src/KingsGambit/docs/design-journal.md) (every decision and why),
  [client interface](src/KingsGambit/docs/client-interface.md), [ledger format](src/KingsGambit/docs/ledger-format.md),
  [UI sketch](src/KingsGambit/docs/ui-sketch.html)
- Try it: the [live simulator](https://atraeau.github.io/WoW-Addons/kings-gambit/) (or open
  [`src/KingsGambit/simulator/index.html`](src/KingsGambit/simulator/README.md)): the real engine over a simulated raid, with
  training scenarios and a sync lab
- Audit: [`src/KingsGambit/tools/`](src/KingsGambit/tools/README.md): verify a saved ledger and print standings/history without the game
- Tests: `cd src/KingsGambit && lua tests/run.lua` (Lua 5.4); CI runs them on every push
- In game: `/gambit check` probes the live client and saves the results for review

## Building and releases

`src/<Addon>/` is the whole project for an addon. `scripts/build-addons.lua` turns it into `AddOns/<Addon>/`: the TOC
files, every file they list (following XML includes), assets the code names by their `Interface\AddOns\<Addon>\` path,
and a license file; nothing else. An addon can add a `build.lua` (`root = "src"` if its TOC is in a subfolder; `extra = {...}`).

```
lua scripts/build-addons.lua --check          # build everything into AddOns/ and verify what ships
lua scripts/test-build-addons.lua             # the build tool's own tests
.\scripts\deploy.ps1 [-Name X] [-Watch]       # build, then junction AddOns/<Addon> into the game (-Watch rebuilds on save)
```

**Releases come from CI.** Every push to `main` that changes what an addon ships publishes a GitHub pre-release
`<Addon>-v<version>` with `<Addon>-<version>.zip` (the addon folder at the top, ready to upload to CurseForge). The
version is the TOC's `## Version:` plus the run number (`0.0.1.57`); change the TOC version for a bigger step. Pushes
that only touch tests, docs or the simulator publish nothing. The newest 30 per addon are kept.

## API reference

The client documents its own API (the `/api` system). [`docs/api/`](docs/api/README.md)
is that surface turned into browsable Markdown — **6,577 functions, 1,802 events, 792
types** across 405 namespaces, grouped into 19 folders (Units & Combat, Items & Inventory,
Spells/Auras/Talents, UI Widgets & Frames, Core & Shared Libraries, …). Each function page
has its signature, typed argument/return tables, description, and an example.

Regenerate it (and the LSP definitions) any time — see [`docs/README.md`](docs/README.md):

```powershell
# In game: /apiexport  then  /reload   (writes the dump to SavedVariables)
.\scripts\generate-api-docs.ps1          # -> docs/api/
.\scripts\generate-lua-definitions.ps1   # -> types/WowForeverAPI.lua
```

## Quick start

```powershell
# 1. Link every addon in src/ into the game's AddOns folder (junctions, no admin needed)
.\scripts\deploy.ps1

# 2. Launch WoW: Forever. On character select, enable "Load out of date AddOns"
#    if anything is greyed out. In game, type:  /hf

# 3. Create a new addon
.\scripts\new-addon.ps1 -Name MyAddon -Title "My Addon" -Notes "What it does"
.\scripts\deploy.ps1 -Name MyAddon
```

Edit any `.lua`, then `/reload` in game to pick up changes — no redeploy needed, the
folders are linked.

On macOS or Linux, `scripts/deploy.sh` does the same job with symlinks and takes the
same options (`--name X`, `--copy`, `--clean`). Point it at the game with a local
override, which is gitignored:

```bash
echo '{ "gamePath": "/Applications/World of Warcraft" }' > wow-dev.config.local.json
scripts/deploy.sh
```

## Scripts

| Command | What it does |
| --- | --- |
| [`deploy.ps1`](scripts/deploy.ps1) | Junction-link every addon under `src/` (and `<project>/src/`) into the game |
| `deploy.ps1 -Name X` | Link only addon `X` |
| `deploy.ps1 -Copy` | Hard-copy instead of link (packaging / other drives) |
| `deploy.ps1 -Clean` | Remove the deployed links (source untouched) |
| [`deploy.sh`](scripts/deploy.sh) | macOS/Linux counterpart: symlinks, same options as `deploy.ps1` |
| [`new-addon.ps1 -Name X`](scripts/new-addon.ps1) | Scaffold `src/X/` with TOCs + `Core.lua` |
| [`generate-api-docs.ps1`](scripts/generate-api-docs.ps1) | Build the Markdown API reference from a dump |
| [`generate-lua-definitions.ps1`](scripts/generate-lua-definitions.ps1) | Build `types/` LSP definitions from a dump |
| [`generate-luacheck-globals.ps1`](scripts/generate-luacheck-globals.ps1) | Build `types/luacheck-globals.lua` (every client global, for luacheck) from `docs/api.json` |

Grouping rules for the docs live in [`scripts/api-categories.psd1`](scripts/api-categories.psd1);
curated examples in [`scripts/api-examples.psd1`](scripts/api-examples.psd1).

## Editor setup

Open the folder in VS Code and install the recommended extensions
([`.vscode/extensions.json`](.vscode/extensions.json): sumneko Lua + WoW API). The Lua
Language Server is pointed at [`types/WowForeverAPI.lua`](types/WowForeverAPI.lua) via
[`.vscode/settings.json`](.vscode/settings.json), so completion and hover match this
client's actual API.

## Config — [`wow-dev.config.json`](wow-dev.config.json)

| Key | Value | Meaning |
| --- | --- | --- |
| `gamePath` | `C:\Program Files (x86)\World of Warcraft` | WoW install root |
| `flavorDir` | `_classic_beta_` | Flavor folder that holds `Interface\AddOns` |
| `interface` | `16001` | TOC interface version (patch 1.60.1 → `16001`) |
| `tocSuffix` | `Camelot` | Flavor TOC suffix the client prefers (`<Addon>_Camelot.toc`) |

Create `wow-dev.config.local.json` (gitignored) to override any of these locally.

**When the client updates:** bump `interface` in the config, then edit `.toc` files (or
re-scaffold) and re-run the export + generators. Confirm the live number in game with
`/dump select(4, GetBuildInfo())`.

## Linting

Install [luacheck](https://github.com/lunarmodules/luacheck) and run `luacheck src` from
the repo root. Config: [`.luacheckrc`](.luacheckrc). It merges
[`types/luacheck-globals.lua`](types/luacheck-globals.lua), generated from this client's
`docs/api.json`, into `read_globals`, so an "undefined variable" warning means either a
typo or a function this client no longer has (`GetContainerItemInfo`, `UnitAura`, ...),
which is the signal a port needs. Regenerate it with
`generate-luacheck-globals.ps1` after a client update; CI does the same on push.
