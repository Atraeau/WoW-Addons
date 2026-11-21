# Warrior macros: next steps

Protection is done and tested (`warrior-protection.md`), except that the slot 3 Sweeping Strikes removal is not yet re-tested in game.

`warrior-arms.md` and `warrior-fury.md` are drafted (not tested in game). Macros are per spec, not per character, and every warrior tanks, so the Defensive slot 2 stays on all of them. The same rules apply to every warrior.

## Next

- Test both drafts in game and fix what misfires. The lists of things to check are in each file's Status section.
- Decide whether to run `/spelldump` on a higher-level warrior to see Pummel, Whirlwind, Recklessness and the later abilities.
- Slot 4 carries each character's racial as its own line (`Eureka!` for Atraeau, `Blood Fury` for Morla). A racial the character lacks does nothing. Add a new racial the same way.

## Decided

- Protection rules carry over unchanged to Arms and Fury (Ctrl = secondary, slots 1 to 3 = Battle/Defensive/Berserker, slot 4 = Sunder Armor, one button per ability, stance-unique abilities on Ctrl).
- Separate macro sets per spec, no `[spec:n]` conditional.
- Slot 3's Battle press: Sweeping Strikes on Arms, empty on Fury and protection.

## New Forever warrior abilities (from the in-game dump of a level 32 warrior)

- Baseline: Victory Rush (on slot 7 Ctrl), Tactical Mastery (passive).
- Talents, not buttons: Spearing Strike (Arms, 1 point), Bloodthrill, Weaponmaster, Improved Tactical Mastery, Improved Slam, Gore Drinker, Reckless Swings, Vanguard, Bastion, Focused Rage, Lingering Rage. Descriptions were not captured, so what they do is unconfirmed.
- Spearing Strike is placed on Arms slot 10 Ctrl. The rest are passive or unconfirmed, so they have no button.
- The dump tool is `src/SpellDump` (`/spelldump`, then `/reload`; read `WTF/Account/<acct>/SavedVariables/SpellDump.lua`).
