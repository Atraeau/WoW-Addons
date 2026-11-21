# Protection warrior macros (WoW Forever)

## Rules

- Unmodified press is the primary ability. `[mod:ctrl]` is the secondary.
- Slots 1, 2 and 3 are the Battle, Defensive and Berserker slots. Ctrl switches into that slot's stance, except when already in it.
- When already in that stance, Ctrl fires an ability unique to that stance.
- Slot 4 is always Sunder Armor unmodified.
- Each ability lives on one button only (Whirlwind is on Q).
- Macro names are 16 characters or fewer. Use the `?` icon so `#showtooltip` picks the icon.

## Macros

### 1 Battle
```
#showtooltip
/cast [stance:1,mod:ctrl] Mocking Blow; [mod:ctrl] Battle Stance; [stance:2] Taunt; Execute
```

### 2 Defensive
```
#showtooltip
/cast [stance:2,mod:ctrl] Disarm; [mod:ctrl] Defensive Stance; Shield Slam
```

### 3 Berserker
```
#showtooltip
/cast [nostance:3,mod:ctrl] Berserker Stance; [stance:1] Sweeping Strikes; [stance:2] Shield Block; Berserker Rage
```
Berserker Rage stays unmodified so it is quick when stance dancing to avoid fear.

### 4 Sunder
```
#showtooltip [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:2] Revenge; [mod:ctrl,stance:3] Slam; Sunder Armor
/cast [mod:ctrl] Eureka!
/cast [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:2] Revenge; [mod:ctrl,stance:3] Slam; Sunder Armor
```

### 5 Interrupt
```
#showtooltip
/cast [mod:ctrl] Intimidating Shout; [stance:3] Pummel; Shield Bash
```

### 6 Demo Shout
```
#showtooltip
/cast [stance:1,mod:ctrl] Rend; [stance:2,mod:ctrl] Concussion Blow; Demoralizing Shout
```
Rend works only in Battle and Defensive on Forever, so there is no Berserker Ctrl clause.

### 7 Cleave
```
#showtooltip
/cast [mod:ctrl] Victory Rush; Cleave
```

### 8 Heroic Strike
```
#showtooltip
/cast [mod:ctrl] Battle Shout; Heroic Strike
```

### 9 Charge
```
#showtooltip
/cast [stance:2,mod:ctrl] Last Stand; [mod:ctrl] Hamstring; [stance:3] Intercept; Charge
```

### 10 Bloodrage
```
#showtooltip
/cast Bloodrage
```

### Q AoE
```
#showtooltip
/cast [mod:ctrl,stance:1] Retaliation; [mod:ctrl,stance:2] Shield Wall; [mod:ctrl,stance:3] Recklessness; [stance:3] Whirlwind; Thunder Clap
```

## Unconfirmed

- Eureka! on slot 4's Ctrl press is carried over from the original macro.
- Last Stand on slot 9 (Defensive) is a placeholder.
- Spell names and stance restrictions are from Classic knowledge. Check them against the Forever spellbook.
