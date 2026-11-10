# King's Gambit: documentation

A raid loot system for WoW: Forever, inspired by Suicide Kings (it keeps what works and fixes what does not), with a shared ledger anyone can verify.

| Read this | If you want to know |
|---|---|
| [manifesto.md](manifesto.md) | What we value, and what we chose over what. Start here. |
| [rationale.md](rationale.md) | The player guide: how loot works, every rule and why, and a walkthrough for the Master Looter. |
| [design-journal.md](design-journal.md) | Every design decision, the alternatives we weighed, and the open questions. The audit trail. |
| [ledger-format.md](ledger-format.md) | The exact record format, precise enough to verify a ledger with your own code. |
| [ledger-v2-design.md](ledger-v2-design.md) | Why the ledger is one chain per writer, so two raids can run at once (built). |
| [ledger-owner.md](ledger-owner.md) | Everything the ledger owner configures, what it is for, and the commands to use it. |
| [client-interface.md](client-interface.md) | How the engine talks to the game (and how we fake the game for tests and training). |
| [ui-design.md](ui-design.md) | How people meet the rules on screen: the Loot window and the Guild book (proposal and layout rules). |
| [ui-sketch.html](ui-sketch.html) | The rough sketch the windows were designed from (2026-11-01, before any frames). Open it in a browser. |
| [code-map.md](code-map.md) | Where each component lives in the source: one line per folder and file. Start here to find code. |
| [test-review.md](test-review.md) | The 2026-11-09 review of the tests: what changed, what was added, and what protects each rule that must not break. |
| [audit.md](audit.md) | The 2026-11-09 audit for dead and stale code: what was removed and what was kept, and why. |

Also in the repository:

- [`simulator/`](../simulator/README.md): the real engine over a simulated raid, in a browser, with training scenarios, a sync lab and a migration lab.
- [`tools/`](../tools/README.md): verify a saved ledger and print standings and history, without the game.
- [`tests/`](../tests/): the test suite (`lua tests/run.lua`).
- [`src/`](../src/): the addon's game files.
