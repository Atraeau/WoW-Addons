# King's Gambit: release checklist

What remains before the addon is published. The automated tests cover the rules, the ledger, the loot session and the window models, but most of the game-facing
behavior has been checked only against a stand-in for the game. Steps 1 to 4 exist to close that gap; steps 5 and 6 are packaging. Tick items as they are done and
note what was found.

A guild beta (steps 1 to 4 with real raiders) should come before any public listing.

## 1. In-game verification

Run each in the game and record the result. `/gambit check` saves its findings to the saved variables; paste the "loot", "name", "comms" and "guild" blocks when
reporting.

- [ ] **Master Looter detection**, with you as Master Looter in a party (confirmed once: the game's enum is `Masterlooter`, party id 0)
- [ ] **Master Looter detection with someone else as Master Looter**, and **in a raid** (the raid-index lookup is unconfirmed)
- [ ] **Loot window:** button skin and label alignment, dense one-line rows, no auto-scroll, answered and open markers, the progress line
- [ ] **Loot window keyboard:** N, O, G, P answer; Up, Down and Tab move; every other key and modifier combination still reaches the game
- [ ] **Whispers to a raider without the addon:** the lead-in, one item per whisper with a hoverable link, bare-letter answers, numbered answers, "pass all", the
      ten-second reminder
- [ ] **Spec detection** for every class (Feral in particular: the bear and cat mapping is unchecked), and typing a spec by whisper
- [ ] **Disenchant result capture:** the cast's spell id and whether the result arrives as a loot window; the typed `disenchanted` fallback
- [ ] **After-the-fact trade detection** (the regret-trade path)
- [ ] **Item hand-over** by the Master Looter, including a full bag and an item that is no longer tradeable
- [ ] **Window layout:** the Admin forms (the "Do it" button), the Create a list form, the Welcome pages (length and scrolling), the Ledger pane's "Undo this award"
- [ ] **Officer permission** read from the game's rank flag, and what a non-officer sees
- [ ] **Window position** on a large screen (the lesson window may open off screen)

## 2. A real multi-player test

- [ ] Two characters, on different machines: ledger sync, catch-up after one was offline, version notices
- [ ] Sync inside a raid instance and in combat (the game can block addon messages; `/gambit check` reports the state but only a real raid shows the effect)
- [ ] A raider with an older addon version in the group (the compatibility rule: same line, not same version)

## 3. One real dry run

A small group with a Master Looter and real drops, end to end.

- [ ] Open a raid, start a session, bid, draft, hand out, review and confirm
- [ ] Undo an award from the Ledger pane, and make a correction
- [ ] Reload mid-session; the Master Looter disconnecting; a late bid
- [ ] Everyone's list agrees at the end

## 4. Upgrade safety

- [ ] Load the addon over a saved ledger from an earlier version and confirm nothing is lost
- [ ] Confirm the saved variables survive a crash or a forced close (a ledger that fails verification is reported, not silently dropped)

## 5. Packaging and release

- [ ] Choose a version (a 0.x beta is treated as unstable by the compatibility rules) and write the changelog
- [ ] Confirm the `## Interface` number in both TOC files against the live client
- [ ] Decide the `## Author` line in both TOC files (it currently holds an email address)
- [ ] README: installation, requirements (Master Looter, who needs the addon), a first-run walk-through for officers
- [ ] Screenshots of the Loot window, the Guild book and the Welcome page
- [ ] A license
- [ ] A GitHub release with the packaged addon; CurseForge or WoWInterface if it is to be listed there
- [ ] Both TOC files list the same files (a test checks this) and the packaged zip loads from a clean install

## 6. Support

- [ ] "How to report a problem": run `/gambit check`, attach the saved results and describe what happened
- [ ] A known-issues list (seed it from anything left unticked above)
- [ ] A place for feedback (the repository's issues, or the guild's channel)

## Known gaps carried over from development

- `/gambit rank` and `/gambit bid` work but are missing from the help text
- The Guild book's history lines do not show a player's spec; there is no officer command to correct a spec
- The window frames and dropdowns are still the game's own look; only the buttons are skinned
- Lesson 7 "Undo the last award" once failed in the game and could not be reproduced headlessly (undo from the Ledger pane is the supported route)
