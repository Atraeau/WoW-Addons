# King's Gambit: code audit (2026-11-09)

A look for dead and stale code after a fast stretch of work (spec typing, undo from the Ledger pane, stable item list, UISkin, whisper menu, Master
Looter detection, list creation from a name). Nothing was changed while writing this; "Action" says what the following commits do. The rules this audit
works under: ledger event types, schemas, frozen migrations and golden ledgers are never removed or rewritten; behavior does not change; anything
reachable only through the TOC, the simulator page or a `/gambit` command counts as used.

## How it was done

Throwaway Lua scripts (not kept) read every file and counted references:

1. every function/method/export defined in `src/`, counted across `src/`, `tests/`, `simulator/src/`, `tools/`, `scripts/` (comments stripped);
2. every `local` and every injected module dependency, counted inside its own file;
3. every key of the `WHY` table (rejection reasons), `UITips.TEXT` and `UISkin.COLORS`, searched as a string and as a field;
4. every `cmds.<name>` slash command against the help text and the docs, and every `/gambit <word>` in the docs against the real commands;
5. every file name the READMEs and docs mention, checked to exist.

Dynamic access (`Tips.Attach(b, "nav" .. id)`, `cmds[kind] = ...` for need/off/pass, WoW event handlers called by the game) is accounted for below.

## Result in one line

The code is tighter than feared: only a handful of functions are never called. The real clutter is a few leftover files, one duplicated table
key, one unused dependency, write-only frame fields, two copy-pasted helpers, and docs that fell behind.

## Findings

### A. Remove (proved unused)

| # | Item | Evidence | Action |
|---|---|---|---|
| A1 | `scratch_bevel.lua` (repo folder root) | A one-off script that patched `src/LootWindow.lua` (`patch(...)` of the bevel code, since moved to `UISkin`). Nothing runs it; last touched in the commit that added the bevel. | delete |
| A2 | `archive/SuicideKings-legacy/` | The earlier prototype. Referenced only by the README table and one journal line, never loaded, built or tested. Git history keeps it (`git log -- src/KingsGambit/archive`). | delete, drop the README row |
| A3 | `Commands.lua` `WHY.notml` defined twice | Lines 12 and 22 of the table; in Lua the later one wins, so the first text ("you are not the Master Looter") is dead. | remove the dead first line (the later text is what the game shows) |
| A4 | `Engine:AllItemSuits` | One definition, zero callers anywhere (src, tests, simulator). | delete |
| A5 | `Ledger.Disregarded` | Export with zero callers anywhere (`engine:IsDisregarded` and the view are what is used). | delete |
| A6 | `Ledger.ByWrite`, `Ledger.SeenOf`, `Standings.IndexOf` | Exported aliases of local functions; zero callers outside their own file. The locals stay. | drop the exports |
| A7 | `UI.lua` `p.barLabel = rl` | Frame field written once, never read (`rl` stays as the local used on the next lines). | drop the assignment |
| A8 | `UITools.lua` `f.groupDropNone = true` | Frame field written once, never read. | drop the assignment |
| A9 | `UILoot` dependency `UITips` (`Tips`) | Declared and injected, never used in the file (`Tips` occurs only in its declaration and injection). Dropping it removes a false dependency edge. | drop the dependency |
| A10 | `Sim.lua` local `ARMOR` table | Defined, never read (the fit heuristic in `ItemFit` decides armor now). | delete |
| A11 | `ItemFit.lua` local `MISC` | Declared with `ARMOR, WEAPON`, never read. | drop |
| A12 | `SelfCheck.lua` local `order` | `local results, order = {}, {}`; `order` never used. | drop |
| A13 | `GuildBook.AttendanceLines`, `GuildBook.Unstage` | No caller in the game, the page or the tools; one test line each. The UI builds attendance rows another way (`Stats`) and unstages through `StageMove`/`StageRemove`. | delete, with the test lines (see the test report) |
| A14 | `GuildBook.WelcomeText` | No caller in the game ("for the chat fallback" is not true: `Core.lua` prints its own sentence). Two tests use it to check the welcome copy. | move to the tests as a helper; delete from the addon |

### B. Duplicated helpers (consolidate, behavior identical)

| # | Item | Evidence | Action |
|---|---|---|---|
| B1 | `newEmitter` in `LootNet.lua` and `Requests.lua` | Same event-bus code written twice (same snapshot-then-call-if-active behavior). | one small module `Emitter` used by both |
| B2 | `button(parent, text, w, h)` in `UI.lua` and `LootWindow.lua` | Byte-for-byte the same function (skin if present, else the game's UIPanelButtonTemplate). | one copy in a new small module `UIButton` (not in `UISkin`, which both files treat as optional) |

### C. Duplicates deliberately left alone

| Item | Why it stays |
|---|---|
| `isName` in `Ledger`, `Requests`, `Schemas`, `Standings` | One-line predicates. `Schemas` and the `Ledger` validators are part of the frozen ledger surface; a shared module would put every format's validation behind a new dependency for no gain. |
| `indexOf` in `Loot`, `GuildBook`, `Standings` | Three different argument orders and return behaviors; each is three lines. |
| `plural` (two in `GuildBook`) | Different strings. |
| `setShown` in `UI.lua` and `LootWindow.lua` | They differ: the `LootWindow` one only calls `Show`/`Hide` when the state changes; the `UI` one always does. Unifying could change behavior (OnShow handlers firing). |
| `short`/`normalize`/`add`/`send` | Local, different bodies. |

### D. Looks unused but is NOT dead (keep, and why)

| Item | Why |
|---|---|
| `RealClient` handlers `TRADE_ACCEPT_UPDATE`, `TRADE_TARGET_ITEM_CHANGED`, `UNIT_SPELLCAST_SUCCEEDED`, `CHAT_MSG_ADDON`, `ENCOUNTER_END`, ... | Called by the game by event name through the frame's `OnEvent` (grep finds one occurrence). |
| `RealClient:fireRaw` | The client interface's documented "dispatch by hand" for tests and field tooling (`docs/client-interface.md`). |
| `MockClient` hooks `closeLoot`, `cancelTrade`, `endEncounter`, `setMyClass`, `setGuildName`, `clearSent` (no or one caller) | The mock mirrors every event of the client contract (`docs/client-interface.md`); the tests and simulator drive the ones they need, the rest keep the stand-in complete. Cheap, and removing them would make parts of the contract impossible to simulate. Owner's call if they would rather trim the mock to what is used today. |
| `Identity.Valid`, `Identity.Equal`, `Schemas.Formats/Types/EnvelopeHash`, `Ledger.EventId`, `Ledger.Merged` | Used by the tests that guard the ledger and identity rules; small public API. |
| All event types in `Schemas`, all handlers in `Ledger`, all `Migrations` | Frozen by the ledger rules. Even a type that no current code writes must stay: old ledgers contain it. |
| `UITips` keys `nav<section>` | Built dynamically by `Tips.Attach(b, "nav" .. s.id)` in `UI.lua`. |
| `cmds.need/off/pass/gift` | Assigned in a loop (`cmds[kind] = ...`). |
| `/gambit window`, `welcome`, `about`, `window reset`, `welcome on/off` | Handled in `Core.lua`'s slash handler before `Commands`. |
| `Tokens`, `AQ40`, `MoltenCore` data and loaders | Reachable from `Sim`, `Loot` (token rule) and the simulator page. |
| Every `WHY` key | Each is produced somewhere (all checked); only the duplicate in A3 is dead. |
| Every `UITips.TEXT` key | Used by `tip = "..."` or `Tips.Attach`. |
| `docs/ledger-*.md`, `docs/design-journal.md` | The record and the rules; never trimmed. |

### E. Things that look like bugs or gaps (nothing changed; for the owner to decide)

1. `/gambit rank` and `/gambit bid` exist (`Commands.lua`) but are not in the `/gambit help` text. `rank` is described in `docs/rationale.md` as the way to rank; `bid` is the generic form of need/off/gift. Adding them to the help changes visible text, so it is left for the owner.
2. `WHY.notml`: the surviving text is the later one, "you are not the raid's Master Looter" (see A3). Probably what was meant.

### F. Docs that no longer match

| Doc | Problem | Action |
|---|---|---|
| `docs/README.md` | `ui-design.md` (referenced from the journal) is not in the index. `ui-sketch.html` is described as "a rough sketch of the planned screens" but the screens exist now; the sketch dates from before any UI (2026-11-01). | add `ui-design.md`; say that the sketch is the pre-UI sketch (kept, since the journal discusses it). Owner may delete it. |
| `docs/design-journal.md` header | "570 tests passing ... no UI frames yet" is the 2026-11-04 status. | update the status line (new entries are appended as usual) |
| `README.md` | Lists `archive/` (removed by A2); describes `src/` as flat game files; no code map. | update, link the new `docs/code-map.md` |
| `src/README.md` | Fine, but points at the old layout only. | link the code map |
| `simulator/README.md`, `tools/README.md` | Names match the code. The simulator build and `tools/kgaudit.lua` hold their own module lists, which change with the move (below). | update with the move |

### G. Module lists that must be kept in step (the reason the reorganization is not trivial)

The same module list exists in five places, and they will drift unless they share a source:

- `KingsGambit.toc` and `KingsGambit_Camelot.toc` (identical, 38 files)
- `tests/harness.lua` (`H.MODULES`)
- `scripts/build-simulator.lua` (`MODULES`: the engine subset)
- `tools/kgaudit.lua` (`MODULES`: the ledger subset)
- the individual tests that `loadfile("src/X.lua")`

The reorganization adds a check that the two TOCs list the same files and that every shipped `src/**/*.lua` is in the TOC and in the harness (the existing `test_boot`/`test_modules` partly do this).
