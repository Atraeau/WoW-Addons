# WoW-Addons

A local development environment for building **multiple** World of Warcraft addons
against **WoW: Forever** (beta codename *Camelot*, product `wow_classic_beta`,
**Interface `16001`**).

Each addon lives in its own folder under [`src/`](src). A single deploy script
links them all into the live game so you edit here and the game reads your source
directly — no copying after every change.

## Layout

```
WoW-Addons/
├─ wow-dev.config.json     # game path, flavor, interface version (single source of truth)
├─ src/                    # one folder per addon (this is your source)
│  └─ HelloForever/        # example addon — /hf in game
│     ├─ HelloForever.toc         # base TOC (loads on any flavor)
│     ├─ HelloForever_Camelot.toc # flavor TOC for WoW: Forever
│     └─ Core.lua
└─ scripts/
   ├─ new-addon.ps1        # scaffold a new addon
   └─ deploy.ps1           # link/copy addons into the game
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

Edit any `.lua`, then in game run `/reload` (or relog) to pick up changes —
no redeploy needed because the folders are linked.

## Scripts

| Command | What it does |
| --- | --- |
| `.\scripts\deploy.ps1` | Junction-link every addon under `src/` into the game |
| `.\scripts\deploy.ps1 -Name X` | Link only addon `X` |
| `.\scripts\deploy.ps1 -Copy` | Hard-copy instead of link (for packaging / other drives) |
| `.\scripts\deploy.ps1 -Clean` | Remove the deployed links (leaves your source untouched) |
| `.\scripts\new-addon.ps1 -Name X` | Scaffold `src/X/` with TOCs + `Core.lua` |

## Config — `wow-dev.config.json`

| Key | Value | Meaning |
| --- | --- | --- |
| `gamePath` | `C:\Program Files (x86)\World of Warcraft` | WoW install root |
| `flavorDir` | `_classic_beta_` | Flavor folder that holds `Interface\AddOns` |
| `interface` | `16001` | TOC interface version (patch 1.60.1 → `16001`) |
| `tocSuffix` | `Camelot` | Flavor TOC suffix the client prefers (`<Addon>_Camelot.toc`) |

Create `wow-dev.config.local.json` (gitignored) to override any of these on this
machine without touching the shared config.

### When the client updates

If a new build bumps the interface version, update `interface` in
`wow-dev.config.json`, then re-run `new-addon.ps1` for new addons or edit existing
`.toc` files. To confirm the live number in game: `/dump select(4, GetBuildInfo())`.

## Linting (optional)

Install [luacheck](https://github.com/lunarmodules/luacheck) via LuaRocks and run
`luacheck src`. Config is in [`.luacheckrc`](.luacheckrc). Recommended VS Code
extensions are listed in `.vscode/extensions.json` (sumneko Lua + a WoW API library).
