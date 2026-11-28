# Warrior macros: next steps

All warriors share one set, `warrior.md` (W1 to W10 and WQ). It replaced the separate protection, Arms and Fury sets.

## Next

- The set is in the game and tested. Check each talent press as that talent is learned (list in the Status section of `warrior.md`).
- Paladin set (`paladin.md`, character macros on Bastian): in game, being tested while leveling.
- Once dual spec is available: switch to a spec without a talent and check `[known:]` follows it. `/run print(SecureCmdOptionParse("[known:Concussion Blow] yes; no"))` on Atraeau should print no in a spec without Concussion Blow. Already confirmed: learned spells and learned talents are known, unlearned talents are not.

## Decided

- One set for every spec. Talents belong to a tree, not a spec, so every talent ability gets its own press, the same in every build; only the bottom talents (Shield Slam, Mortal Strike, Bloodthirst) share plain 2.
- Ctrl+Shift is for situational abilities only: Death Wish, Spearing Strike, Piercing Howl, Victory Rush, Slam, Last Stand, Challenging Shout.
- Every warrior tanks, so the Defensive tools stay in the set.
- Trainer abilities past the current level are checked at the trainer, not dumped; only talents are tracked here.

## Active talents (from the in-game dump, all 53 talents described)

Ten talents give a button, and all ten are placed (table in `warrior.md`): Shield Slam, Mortal Strike, Bloodthirst, Sweeping Strikes, Death Wish, Spearing Strike (new in Forever), Concussion Blow, Piercing Howl, Last Stand, Reckless Swings (new in Forever).

Every other talent is passive, including the Forever additions (Bloodthrill, Weaponmaster, Gore Drinker, Furious Precision, Lingering Rage, Vanguard, Bastion, Focused Rage, Improved Tactical Mastery). Vanguard makes Charge usable in Defensive Stance, which plain 9 already covers.

The dump tool is `src/SpellDump` (`/spelldump`, wait for the second message, then `/reload`; read `WTF/Account/<acct>/SavedVariables/SpellDump.lua`).
