# King's Gambit: code map

Where each component lives, so a person or an AI can find it without reading the sources. One line per folder and file: what it owns, and the main
names to start from. Keep it in step with the TOC (the checks below say when it is not).

## How the addon is put together

- **One module per file, or a module in a few files.** A file calls `SK:NewModule(name, { deps }, inject)` ([`core/Registry.lua`](../src/core/Registry.lua)). Files load in any order
  (the registry first); after every file has loaded, `SK:Resolve()` hands each module the modules it declared, each after the ones it depends on. A `?` after a
  dependency makes it optional. **A module never looks other modules up itself** (a test enforces it); the composition roots do: [`core/Core.lua`](../src/core/Core.lua) at login, the
  test harness, the simulator build.
- **Big modules are split into parts.** The main file keeps the module's table or class and its shared helpers; the parts add to it when the module is
  resolved, through `Install(...)` (the Loot session, the commands, the Guild book panes, the Real client). A part's file starts with a line saying what it adds and where
  it is installed. Flat tables of functions (GuildBook) are merged from their parts instead, so callers still write `GuildBook.History(...)`.
- **The TOC is the list of files.** `src/KingsGambit.toc` and `src/KingsGambit_Camelot.toc` list the same files (a test checks this and that every file
  exists). The build ships exactly what the TOC lists. The test harness loads every file the TOC lists (except `Core` and `SelfCheck`, which need the game).
- **The ledger is frozen by rule.** Event types, schemas, migrations and the golden ledgers are never removed or rewritten (`docs/ledger-format.md`,
  [`ledger/Schemas.lua`](../src/ledger/Schemas.lua), [`ledger/Migrations.lua`](../src/ledger/Migrations.lua), `tests/ledgers/`).
- **Pure versus game.** Everything outside `client/RealClient*`, [`client/SelfCheck.lua`](../src/client/SelfCheck.lua), [`core/Core.lua`](../src/core/Core.lua) and the frame-building files of `ui/` runs without the
  game, in the tests and in the browser simulator. The window code is split the same way: a pure model (what to show) feeds the frames and the web page.

## `src/` (what the game loads)

### `core/`: startup and the module system
| File | Owns | Start from |
|---|---|---|
| [`Registry.lua`](../src/core/Registry.lua) | the module registry and dependency injection; loaded first | `SK:NewModule`, `SK:Resolve` |
| [`Core.lua`](../src/core/Core.lua) | the composition root: builds everything at login, `/gambit` and `/kg` slash entry, the welcome and window shortcuts | `Start`, `SlashCmdList.KINGSGAMBIT` |
| [`Emitter.lua`](../src/core/Emitter.lua) | a small event emitter used by `LootNet` and `Requests` | `Emitter.New` |

### `ledger/`: the record, its rules and keeping it in sync (pure Lua)
| File | Owns | Start from |
|---|---|---|
| [`Hash.lua`](../src/ledger/Hash.lua) | the hash and the canonical text it hashes | `Hash.Sum`, `Hash.Canon` |
| [`Identity.lua`](../src/ledger/Identity.lua) | who a character is: `First_Last`, display names, joining two-word names | `Identity.Normalize`, `Display`, `JoinNames` |
| [`Version.lua`](../src/ledger/Version.lua) | Semantic Versioning, who may work with whom (compatibility lines) | `Version.Parse`, `Line`, `Relation` |
| [`Schemas.lua`](../src/ledger/Schemas.lua) | the schema of every event type in every published format (frozen) | `Schemas.Get`, `Validate` |
| [`Migrations.lua`](../src/ledger/Migrations.lua) | moving the ledger between formats: upcasters, the cut | `Migrations.Up`, `Check`, `FormatFor` |
| [`Standings.lua`](../src/ledger/Standings.lua) | the rules of one list: places, anchors, wins, the per-event handlers | `Standings.New`, `Apply`, `Anchor` |
| [`Ledger.lua`](../src/ledger/Ledger.lua) | the store of per-writer chains, the deterministic merge, authority and the replayed view | `Ledger.NewStore`, `Receive`, `Build`, `View`, `ApplyToView`, `MayWrite` |
| [`Ledgers.lua`](../src/ledger/Ledgers.lua) | the ledgers stored on this account: listing, retiring, restoring, expiry | `Ledgers.Stored`, `Retire`, `Sweep` |
| [`Engine.lua`](../src/ledger/Engine.lua) | an engine owns a ledger over a client: writes, persistence, verification, the queries everyone asks | `Engine.New`, `engine:Write`, `Append`, `Get`, `MayWrite` |
| [`Sync.lua`](../src/ledger/Sync.lua) | ledger sync over addon messages: gossip, catch-up, version notices | `Sync.New`, `sync:start`, `on` |
| [`Requests.lua`](../src/ledger/Requests.lua) | the dispute path: requests to the Master Looter and their answers | `Requests.New`, `Requests.KINDS` |
| [`Guard.lua`](../src/ledger/Guard.lua) | tells the officers when someone who is not an officer writes | `Guard.New` |

### `client/`: the game behind one contract
| File | Owns | Start from |
|---|---|---|
| [`Client.lua`](../src/client/Client.lua) | the Client contract: required methods, event names, the event bus | `Client.METHODS`, `EVENTS`, `NewBus` |
| [`MockClient.lua`](../src/client/MockClient.lua) | a headless fake of the game (tests, simulator, practice mode) | `MockClient.New` |
| [`RealClient.lua`](../src/client/RealClient.lua) | the client backed by the WoW API: names, time, roster, guild, officers, storage, the raw-event frame | `RealClient.New` |
| [`RealLoot.lua`](../src/client/RealLoot.lua) | part of RealClient: the loot window, loot method, Master Looter, candidates, handing out; the loot events | `c:lootMethod`, `c:give`, `c:candidates` |
| [`RealChat.lua`](../src/client/RealChat.lua) | part of RealClient: addon messages and whispers, the chat filter | `c:send`, `c:whisper`, `c:registerPrefix` |
| [`RealTrade.lua`](../src/client/RealTrade.lua) | part of RealClient: the trade window and its events | `c:trade`, `c:tradeableItems` |
| [`SelfCheck.lua`](../src/client/SelfCheck.lua) | `/gambit check`: probes the real client and reports | `SelfCheck.Run` |

### `loot/`: a loot session
| File | Owns | Start from |
|---|---|---|
| [`ItemFit.lua`](../src/loot/ItemFit.lua) | which classes may take an item and which specs it suits, from its stats; rules and overrides | `ItemFit.Describe`, `Allowed`, `NeedOk` |
| [`Loot.lua`](../src/loot/Loot.lua) | the Session class: bidding, eligibility, timers, events; installs the parts below | `Loot.NewSession`, `Session:start`, `bid`, `MayHave` |
| [`LootWhispers.lua`](../src/loot/LootWhispers.lua) | part of Loot: players without the addon answer by whisper: parsing, menus, one item at a time | `Loot.ParseWhisper`, `Session:handleWhisper` |
| [`LootDraft.lua`](../src/loot/LootDraft.lua) | part of Loot: the main, off-spec and gift drafts, picks, skips, the winner's choices | `Session:runDraft`, `pick`, `skip`, `award` |
| [`LootFinish.lua`](../src/loot/LootFinish.lua) | part of Loot: salvage and disenchant, review, confirm (hand-out and recording), cancel, status | `Session:confirm`, `cancel`, `status` |
| [`LootNet.lua`](../src/loot/LootNet.lua) | the live protocol: the Master Looter's host and each player's side | `LootNet.NewHost`, `NewPlayer` |
| [`Tokens.lua`](../src/loot/Tokens.lua) | class tokens and readiness hints | `Tokens.Find`, `Check` |
| [`Attendance.lua`](../src/loot/Attendance.lua) | the Master Looter's addon writes down who is in the raid | `Attendance.New` |

### `commands/`: the text interface (`/gambit <command>`)
`Commands.lua` builds what the commands share (output, the working list, `append`, hosting a session), dispatches (`c.handle`) and installs the files below;
each adds its commands to `cmds`. The help text and the reasons table (`WHY`) are in `Commands.lua`.
| File | Commands |
|---|---|
| [`Commands.lua`](../src/commands/Commands.lua) | `help`, `handle`, `where`, the shared helpers |
| [`CmdLists.lua`](../src/commands/CmdLists.lua) | `standings`, `list`, `create`, `newlist`, `add`, `addall`, `remove`, `move`, `undo`, `award`, `trade` |
| [`CmdSession.lua`](../src/commands/CmdSession.lua) | `masterloot`, `loot`, `announce`, `resolve`, `extend`, `confirm`, `cancel`, `disenchanted`, `salvaged` |
| [`CmdAnswer.lua`](../src/commands/CmdAnswer.lua) | `need`, `off`, `pass`, `gift`, `bid`, `rank`, `pick`, `skip`, `claim`, `keep`, `withdraw`, `recipient`, `override`, `ready` |
| [`CmdRaids.lua`](../src/commands/CmdRaids.lua) | `raid ...`, `disenchanter` |
| [`CmdRequests.lua`](../src/commands/CmdRequests.lua) | `request`, `requests`, `accept`, `decline`, `history`, and `c.describe` (a ledger event in words) |
| [`CmdRules.lua`](../src/commands/CmdRules.lua) | `eligible`, `suits`, `spec`, `hints` |
| [`CmdLedger.lua`](../src/commands/CmdLedger.lua) | `migrate`, `version`, `ledgers`, `officers`, `disregard`, `regard`, `sync`, `check` |
| [`CmdEvents.lua`](../src/commands/CmdEvents.lua) | what the addon says on its own from protocol events |

### `data/`: generated raid data
`MoltenCore.lua`, `AQ40.lua`: bosses, drops and officer calls for the practice raids. **Generated** by `scripts/build-mc-data.ps1` and `scripts/build-aq-data.ps1`; do not edit.

### `sim/`: practice raids and lessons (also run by the browser simulator)
| File | Owns | Start from |
|---|---|---|
| [`Sim.lua`](../src/sim/Sim.lua) | a simulated raid with bot raiders: roster, raids, scenarios, lessons, the raid leader | `Sim.NewRaid`, `RunScenario`, `NewLesson` |
| [`SimBots.lua`](../src/sim/SimBots.lua) | part of Sim: what each bot answers and how it acts on a session | `Sim:wireBots`, `drop`, `policyFor` |
| [`SimNights.lua`](../src/sim/SimNights.lua) | part of Sim: Molten Core and Ahn'Qiraj nights, free play, practice, killing a boss, handing out | `Sim.NewMoltenCore`, `NewAQ40`, `FreePlay`, `Sim:killBoss` |
| [`Scenarios.lua`](../src/sim/Scenarios.lua) | the lessons' shared raid, their order, and finding one | `Scenarios.list`, `find` |
| `ScenarioBasics.lua`, `ScenarioDraft.lua`, `ScenarioHandout.lua` | the lessons themselves (data plus a check each) | `M.Lessons` |
| [`SimNetwork.lua`](../src/sim/SimNetwork.lua) | a simulated addon-message network joining several mock clients | `SimNetwork.New` |

### `ui/`: the windows
The pure models (what to show) and the frames (how it is drawn) are separate files. The game's frames are the only code that needs the game's API.
| File | Owns | Start from |
|---|---|---|
| [`UI.lua`](../src/ui/UI.lua) | the Guild book window: model, frame, refresh, open/toggle; installs the panes | `UI.Toggle`, `Open`, `Model`, `Refresh` |
| [`panes/UIPractice.lua`](../src/ui/panes/UIPractice.lua) | part of UI: practice mode, the whisper window, spec choice, lesson controls | `UI:StartPractice`, `SetWhisperMode` |
| [`panes/UIStandings.lua`](../src/ui/panes/UIStandings.lua) | part of UI: the Lists section: rows, staging, dragging | `UI.FillRows`, `Stage`, `ApplyStaged` |
| [`panes/UILedger.lua`](../src/ui/panes/UILedger.lua) | part of UI: the Ledger section and the stored-ledger panel | `UI:BuildHistory`, `RefreshHistory` |
| [`panes/UIRaidPanes.lua`](../src/ui/panes/UIRaidPanes.lua) | part of UI: This raid and the raid start-time panel | `UI:BuildThisRaid`, `BuildRaidStart` |
| [`panes/UIStats.lua`](../src/ui/panes/UIStats.lua) | part of UI: the Stats section | `UI:BuildStats` |
| [`panes/UIWelcome.lua`](../src/ui/panes/UIWelcome.lua) | part of UI: the Welcome pages | `UI:BuildWelcome`, `RenderWelcome` |
| [`GuildBook.lua`](../src/ui/GuildBook.lua) | what the Guild book shows, as tables; merges the parts in `guildbook/` | `GuildBook.SECTIONS`, `History`, `Stats`, `RaidNow` |
| [`guildbook/GuildBookPages.lua`](../src/ui/guildbook/GuildBookPages.lua) | sections, Welcome copy, first-run setting | `SECTIONS`, `WELCOME_PAGES`, `StartTab` |
| [`guildbook/GuildBookHistory.lua`](../src/ui/guildbook/GuildBookHistory.lua) | the record in words: kinds, filters, entry detail, stored-ledger rows | `History`, `Detail`, `Segments`, `Ledgers` |
| [`guildbook/GuildBookStats.lua`](../src/ui/guildbook/GuildBookStats.lua) | stats per player, sorting, place history, attendance | `Stats`, `SortStats`, `Attendance` |
| [`guildbook/GuildBookRaid.lua`](../src/ui/guildbook/GuildBookRaid.lua) | the open raid and when the next one starts | `RaidNow`, `RaidStart` |
| [`guildbook/GuildBookStage.lua`](../src/ui/guildbook/GuildBookStage.lua) | staged list changes and the commands they become | `Simulate`, `StageMove`, `Commands` |
| [`LootWindow.lua`](../src/ui/LootWindow.lua) | the small Loot window: layout, building; installs the live part | `LootWindow.Build`, `Movable`, `Rich` |
| [`lootwindow/LootWindowLive.lua`](../src/ui/lootwindow/LootWindowLive.lua) | part of LootWindow: running a button, refreshing, keys | `LootWindow.Run`, `Refresh`, `Key` |
| [`UILoot.lua`](../src/ui/UILoot.lua) | what the Loot window reads from a session (pure) | `UILoot.Model` |
| [`LootView.lua`](../src/ui/LootView.lua) | what the Loot window shows, as a table (pure; the page draws it too) | `LootView.Build`, `ANSWERS` |
| [`UITools.lua`](../src/ui/UITools.lua) | the forms of the Guild book (a form for every command that needs input) | `UITools.GROUPS`, `Compose`, `Find` |
| [`tools/UIToolsFrames.lua`](../src/ui/tools/UIToolsFrames.lua) | part of UITools: building and refreshing the forms | `UITools.Build`, `Goto`, `Refresh` |
| [`UITips.lua`](../src/ui/UITips.lua) | every button's tooltip text | `UITips.TEXT`, `Attach` |
| [`UISkin.lua`](../src/ui/UISkin.lua) | the look of the addon's own buttons | `UISkin.Button`, `Style`, `Mark` |
| [`UIButton.lua`](../src/ui/UIButton.lua) | one button helper (skin or the game's stock button) | `UIButton.New` |

## Outside `src/`

| Path | What it is |
|---|---|
| [`tests/`](../tests/) | the suite: `lua tests/run.lua` (from `src/KingsGambit`). `harness.lua` loads the modules by the TOC; one `test_<area>.lua` per area (see below); `ledgers/` and `schema_baseline.lua`, `compat_baseline.lua` are frozen records; `lua51_golden.lua` is the ledger under the game's Lua 5.1 (run in CI) |
| [`simulator/`](../simulator/) | the real engine in a browser page. `src/template.html` (page), `src/api.lua` (JSON layer over the engine), `src/migration_lab.lua`; `index.html` is built from them by CI (do not edit); `test/smoke.mjs` plays every lesson in a real browser; `vendor/` is fengari |
| [`scripts/`](../scripts/) | `build-simulator.lua` (lists the engine modules it inlines), `check-simulator.mjs`, the raid-data generators (`build-mc-data.ps1`, `build-aq-data.ps1`, `extract-cmangos.lua`) |
| [`tools/`](../tools/) | `kg.lua` and `kgaudit.lua`: verify a saved ledger and print standings and history without the game |
| `docs/` | the manifesto, the player guide (`rationale.md`), the design journal, ledger format and owner guide, UI design, the client interface, this map and the audit |
| [`build.lua`](../build.lua) | tells the repository build (`scripts/build-addons.lua`) that the TOCs are in `src/` |

### Which test covers what
`test_ledger`, `test_schemas`, `test_migration`, `test_compat`, `test_versions`, `test_identity`, `test_ledgers`: the ledger, its frozen shape, migration, compatibility.
`test_engine`, `test_sync`, `test_requests`, `test_lists`: writing, syncing, requests, which list a raid plays on. `test_loot`, `test_lootnet`, `test_mistakes`,
`test_itemfit`, `test_tokens`: the loot session, the live protocol, fixing mistakes, who may bid. `test_commands`: the text interface. `test_ui`, `test_lootview`,
`test_guildbook`: the windows' models. `test_client`, `test_realclient`: the client contract and the real client over a stub game. `test_sim`: practice raids and every lesson.
`test_fuzz*`: randomized convergence, loot and rules. `test_modules`, `test_boot`: the module system and booting the addon from the TOC. `test_tools`: the audit tool.

## Adding or moving a file

1. Put the file in the folder of its component and add it to **both** TOC files (same line, same order).
2. If the simulator page needs it, add it to `MODULES` in `scripts/build-simulator.lua`; if the audit tool needs it, to [`tools/kgaudit.lua`](../tools/kgaudit.lua).
3. A new module declares its dependencies in `SK:NewModule`; a part of a split module is installed from its main file's inject function.
4. Run `lua tests/run.lua`; update this map and, for a design decision, `docs/design-journal.md`.
