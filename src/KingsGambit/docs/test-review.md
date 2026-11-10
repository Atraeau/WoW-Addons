# King's Gambit: test review (2026-11-09)

After the dead-code removal and the reorganization, every test file was reviewed for tests that cover removed code, duplicate others, or no longer guard real
behavior, and for gaps the reorganization opened. Result: 724 tests before, 728 after, all passing.

## How it was checked

- **No assertions**: every `test(...)` body was scanned for `assert`, `eq` and `error`. All have them (`modules load in any order` asserts through its `smoke` helper).
- **Duplicates**: test names are unique, and a line-overlap comparison of every pair of tests found only two that share a setup (both in `test_requests`, about undoing an award on request; one checks the success, the other the refusal), which is not duplication.
- **Covering removed code**: the tests were searched for every function the audit removed. Three test spots touched removed code (below).
- **Coverage of the rules that must not break** was checked by name (below).

## Changed

| Test | What changed | Why |
|---|---|---|
| `test_guildbook`: the Welcome tests | read the copy through a helper in the test (`welcomeText`) instead of `GuildBook.WelcomeText` | the function had no caller in the game; the tests still check every phrase, every section and the American-spelling rule |
| `test_guildbook`: staging a move | one line removed (`GuildBook.Unstage` for two players), and the check after it now expects the two staged operations that are still there | `Unstage` had no caller in the game; staging and `StageRemove` are still tested |
| `test_guildbook`: attendance | one line removed (`GuildBook.AttendanceLines`) | the function had no caller in the game; the attendance numbers (`Stats`, left early, percent, History) are still asserted |
| `test_modules`: raid data is optional | also leaves out the new part files (`SimBots`, `SimNights`, `Scenario*`) | they belong to the optional raid-data group |
| `harness.lua` | loads every file the TOC lists, by module name, instead of a hand-kept list | the old list was one of six copies of the file list and the one most likely to drift |

No test was deleted outright.

## Added (guards for the reorganization)

| Test | Guards against |
|---|---|
| every Lua file under `src/` is in the TOC, and `docs/code-map.md` names each one | a file left out of the game by mistake; a code map that falls behind |
| the simulator page inlines a dependency-complete set of real files, each in the TOC | a part file forgotten in `scripts/build-simulator.lua` (the page would break in the browser while every Lua test passed; checked by removing one) |
| the text interface installs every command | a command lost when `Commands` was split into files |
| `Emitter` listeners, stopping, and listeners added during an emit | the shared event emitter changing behavior |

## What protects the rules that matter

| Rule | Tests |
|---|---|
| ledger events, hashes, merge, authority | `test_ledger` (40), `test_fuzz` (random convergence), `test_fuzz_rules`, `tests/lua51_golden.lua` in CI (Lua 5.1 and LuaJIT) |
| frozen schemas, golden ledgers, no removed event type | `test_schemas` against `schema_baseline.lua` and `tests/ledgers/format_2.lua` |
| migration (cutover, rollback, lab) | `test_migration` (11) |
| compatibility lines and the TOC version | `test_compat`, `test_versions` |
| loot flow (bids, drafts, salvage, confirm) | `test_loot` (82), `test_fuzz_loot`, `test_lootnet`, `test_sim` (every lesson against the real engine) |
| whisper flow (parsing, one item at a time, menus) | `test_loot` (`ParseWhisper`, `handleWhisper`, `sendMenu`), `test_tokens`, `test_itemfit` |
| undo and mistakes | `test_mistakes` (18), `test_requests` (27), `test_commands`, `test_ledger` |
| text commands | `test_commands` (22), `test_identity` (commands with first and last names), the new every-command test |
| the windows' models | `test_ui`, `test_lootview`, `test_guildbook` (44) |
| the simulator page | the new page-module test; `simulator/test/smoke.mjs` plays every lesson in a real browser (pre-push hook and CI `page` job) |
| the real client | `test_realclient` (38) over a stub game; `/gambit check` in the game |

## Known gaps (not new)

- The frame-building code (`ui/UI.lua`, `ui/panes/`, `ui/lootwindow/`, `ui/tools/`, `client/RealLoot.lua` and friends) is exercised only as far as the stub game in `test_ui` and `test_realclient` reaches. Its layout, keyboard handling, skin, whispers and Master Looter detection have been verified headlessly, not in the game; this reorganization moved that code without changing it (checked by scanning every new file for stray global names, and by the unchanged test results).
