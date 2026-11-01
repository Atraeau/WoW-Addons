# King's Gambit

Raid loot by King's Gambit (a Suicide Kings derivative) on a transparent, tamper-evident ledger, for
WoW: Forever (Interface 16001). Named for the chess gambit, a deliberate sacrifice of position for advantage.

Everything about King's Gambit lives in this folder, so it can move to its own repository unchanged
(`git subtree split --prefix=KingsGambit`).

| Path | What's there |
| --- | --- |
| [`src/`](src/) | The addon's game files (TOC and Lua): the build ships exactly the ones its TOC loads, as `AddOns/KingsGambit` (see `build.lua` here) |
| [`docs/`](docs/README.md) | Manifesto, player guide, design journal (every decision and why), client interface, ledger format |
| [`tests/`](tests/) | The test suite (pure Lua 5.4, no game needed) |
| [`simulator/`](simulator/README.md) | The real engine over a simulated raid, in a browser page, with training scenarios, a sync lab and a migration lab. **[Play it online](https://atraeau.github.io/WoW-Addons/kings-gambit/)** |
| [`tools/`](tools/README.md) | Verify a saved ledger and print standings and history, without the game |
| [`scripts/`](scripts/) | Build the simulator page; generate the raid training data; extract facts from the CMaNGOS database |
| [`archive/`](archive/) | The earlier SuicideKings prototype, kept for reference |

Run everything from this folder:

```bash
lua tests/run.lua
```

```bash
lua scripts/build-simulator.lua
```

To run the simulator, open the page it builds (it needs no network). It is also published at <https://atraeau.github.io/WoW-Addons/kings-gambit/>.
After changing the engine, rebuild it with the command above first:

```bash
start simulator/index.html
```

To play it in the game, deploy from the repository root with `scripts/deploy.ps1` (or `deploy.sh`), which builds
`AddOns/KingsGambit` (only what the TOC loads, so none of the tests, docs or simulator) and links it into the game's
AddOns folder. Every push to `main` that changes what ships also publishes a release zip (see the root README). The
WoW API reference it was written against is the repository's `docs/api.json`. In game, `/gambit version` shows the build and what
the other players run.
