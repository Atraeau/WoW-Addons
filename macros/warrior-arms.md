# Arms warrior macros (WoW Forever)

Written for the spec, not a character. Same rules and layout as [warrior-protection.md](warrior-protection.md); only the lines that differ are explained here.

## Rules

- Unmodified press is the primary ability. `[mod:ctrl]` is the secondary.
- Slots 1, 2 and 3 are the Battle, Defensive and Berserker slots. Ctrl switches into that slot's stance, except when already in it.
- When already in that stance, Ctrl fires an ability unique to that stance.
- Slot 4 is always Sunder Armor unmodified.
- Each ability lives on one button only (Whirlwind is on Q).
- Macro names are 16 characters or fewer. Use the `?` icon so `#showtooltip` picks the icon.
- Macros are account-wide (the warriors are on separate servers). Every name starts with the spec letter (P, A or F) so the three sets can sit side by side in the macro list. Arms is A.

## What changed from protection

- Slot 2: Shield Slam, Concussion Blow and Last Stand are prot talents, so they are gone. Mortal Strike is the primary, and Revenge moved here from slot 4 (Defensive press).
- Slot 3: the Battle press is Sweeping Strikes (an Arms talent).
- Slot 6: no Concussion Blow clause.
- Slot 9: no Last Stand clause.
- Slot 10: Spearing Strike on Ctrl.
- Slot 4: keeps the racial lines (Eureka! for Atraeau, Blood Fury for Morla); a line for a racial the character lacks does nothing.

## Macros

### A1 Battle
```
#showtooltip
/cast [stance:1,mod:ctrl] Mocking Blow; [mod:ctrl] Battle Stance; [stance:2] Taunt; Execute
```

### A2 Defensive
```
#showtooltip
/cast [stance:2,mod:ctrl] Disarm; [mod:ctrl] Defensive Stance; [stance:2] Revenge; Mortal Strike
```

### A3 Berserker
```
#showtooltip
/cast [nostance:3,mod:ctrl] Berserker Stance; [stance:2] Shield Block; [stance:1] Sweeping Strikes; Berserker Rage
```

### A4 Sunder
```
#showtooltip [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:3] Slam; Sunder Armor
/cast [mod:ctrl] Eureka!
/cast [mod:ctrl] Blood Fury
/cast [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:3] Slam; Sunder Armor
```

### A5 Interrupt
```
#showtooltip
/cast [mod:ctrl] Intimidating Shout; [stance:3] Pummel; Shield Bash
```

### A6 Demo Shout
```
#showtooltip
/cast [stance:1,mod:ctrl] Rend; Demoralizing Shout
```

### A7 Cleave
```
#showtooltip
/cast [mod:ctrl] Victory Rush; Cleave
```

### A8 Heroic Strike
```
#showtooltip
/cast [mod:ctrl] Battle Shout; Heroic Strike
```

### A9 Charge
```
#showtooltip
/cast [mod:ctrl] Hamstring; [stance:3] Intercept; Charge
```

### A10 Bloodrage
```
#showtooltip
/cast [mod:ctrl] Spearing Strike; Bloodrage
```

### AQ AoE
```
#showtooltip
/cast [mod:ctrl,stance:1] Retaliation; [mod:ctrl,stance:2] Shield Wall; [mod:ctrl,stance:3] Recklessness; [stance:3] Whirlwind; Thunder Clap
```

## Status

Drafted from the in-game spellbook and talent dump of a level 32 warrior. Not tested in game. To check:

- Mortal Strike, Sweeping Strikes and Spearing Strike need their talent points, and Pummel, Whirlwind and Recklessness need a higher level, so those spots do nothing until learned.
- Sweeping Strikes may or may not need Battle Stance on Forever.
- Spearing Strike's behavior is unconfirmed.
