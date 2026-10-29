# King's Gambit: documentation

A raid loot system for WoW: Forever, derived from Suicide Kings, with a shared ledger anyone can verify.

| Read this | If you want to know |
|---|---|
| [manifesto.md](manifesto.md) | What we value, and what we chose over what. Start here. |
| [rationale.md](rationale.md) | The player guide: how loot works, every rule and why, and a walkthrough for the Master Looter. |
| [design-journal.md](design-journal.md) | Every design decision, the alternatives we weighed, and the open questions. The audit trail. |
| [ledger-format.md](ledger-format.md) | The exact record format, precise enough to verify a ledger with your own code. |
| [client-interface.md](client-interface.md) | How the engine talks to the game (and how we fake the game for tests and training). |
| [ui-sketch.html](ui-sketch.html) | A rough sketch of the planned screens. Open it in a browser. |

Also in the repository:

- [`simulator/`](../../simulator/README.md): the real engine over a simulated raid, in a browser, with training scenarios and a sync lab.
- [`tools/`](../../tools/README.md): verify a saved ledger and print standings and history, without the game.
- [`tests/kings-gambit/`](../../tests/kings-gambit/): the test suite (`lua tests/kings-gambit/run.lua`).
- [`src/KingsGambit/`](../../src/KingsGambit/): the addon.
