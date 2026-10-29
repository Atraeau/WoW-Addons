# King's Gambit audit tool

Check the loot record **without the game**. It loads the same engine code the addon uses, reads the
addon's saved data, re-verifies every event's hash and every rule, and prints the standings and history.
Anyone in the guild can run it, which is the point: the record is only trustworthy if people can check it.

Needs Lua 5.4 (on Windows: `winget install DEVCOM.Lua`).

```
lua tools/kg.lua verify    <KingsGambit.lua>             check every hash and rule
lua tools/kg.lua standings <KingsGambit.lua> [list]      standings as a Markdown table
lua tools/kg.lua history   <KingsGambit.lua> [list] [N]  the last N events (default 20)
```

`<KingsGambit.lua>` is the addon's saved-variables file, for example
`World of Warcraft\_forever_\WTF\Account\<ACCOUNT>\SavedVariables\KingsGambit.lua`.
It is written when you log out or `/reload`.

- `verify` prints one line per list and exits with status 1 if any list fails, naming the first bad
  event. A tampered or damaged ledger can't pass: each event includes the hash of the one before it.
- `standings` prints a Markdown table you can paste into Discord or a forum post. It refuses to print
  standings for a ledger that doesn't verify.
- `history` shows what was recorded, in plain language.

Two guild members whose `verify` output shows the same `head` hash for a list have, provably, the
same history.

The library behind it is `kgaudit.lua`; it is also what a future Discord or web publisher will use.
