# Warrior macros (WoW Forever)

One set for every warrior and every spec. A talent ability has its own press in every spec and does nothing until that talent is learned, so the same macros work for any build and either dual spec.

## Rules

- Unmodified press is the primary ability. `[mod:ctrl]` is the secondary.
- Ctrl+Shift (`[mod:ctrl,mod:shift]`) is a third press, for situational abilities only (big cooldowns and emergencies). Put it first in the `/cast` line, or the plain Ctrl clause will catch it.
- Slots 1, 2 and 3 are the Battle, Defensive and Berserker slots. Ctrl switches into that slot's stance, except when already in it.
- When already in that stance, Ctrl fires an ability unique to that stance.
- Slot 4 is always Sunder Armor unmodified.
- Each ability lives on one button only (Whirlwind is on Q).
- Talents belong to a tree, not a spec: any build can take the upper talents of another tree. So every talent ability gets its own press, the same for all builds. Only the bottom talents of each tree (Shield Slam, Mortal Strike, Bloodthirst) can never be taken together, so they share plain 2, picked with `[known:]`.
- A macro body is 255 characters at most; the game cuts off anything past that. Check with a character count when adding lines.
- Macro names are 16 characters or fewer. Use the `?` icon so `#showtooltip` picks the icon.
- Macros are account-wide (the warriors are on separate servers). Every name starts with W.

## Talent abilities

| Talent | Tree | Press |
|---|---|---|
| Shield Slam / Mortal Strike / Bloodthirst | Prot / Arms / Fury (bottom) | 2 |
| Sweeping Strikes | Arms | 3 in Battle |
| Death Wish | Fury | Ctrl+Shift+3 |
| Spearing Strike | Arms | Ctrl+Shift+5 |
| Concussion Blow | Prot | Ctrl+6 |
| Piercing Howl | Fury | Ctrl+Shift+6 |
| Last Stand | Prot | Ctrl+Shift+9 |
| Reckless Swings | Fury | Ctrl+10 |

## Macros

### W1 Battle
```
#showtooltip
/cast [stance:1,mod:ctrl] Mocking Blow; [mod:ctrl] Battle Stance; [stance:2] Taunt; Execute
```

### W2 Defensive
```
#showtooltip
/cast [stance:2,mod:ctrl] Disarm; [mod:ctrl] Defensive Stance; [known:Shield Slam] Shield Slam; [known:Mortal Strike] Mortal Strike; Bloodthirst
```
Plain 2 is whichever bottom talent the build has.

### W3 Berserker
```
#showtooltip
/cast [mod:ctrl,mod:shift] Death Wish; [nostance:3,mod:ctrl] Berserker Stance; [stance:2] Shield Block; [stance:1,known:Sweeping Strikes] Sweeping Strikes; [stance:3] Berserker Rage
```
Berserker Rage stays unmodified so it is quick when stance dancing to avoid fear. Death Wish also grants fear immunity, so it sits on the same button. The Battle press is Sweeping Strikes when learned, otherwise empty (Berserker Rage is limited to `[stance:3]` so its icon does not show in Battle).

### W4 Sunder
```
#showtooltip [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:2] Revenge; Sunder Armor
/cast [mod:ctrl] Eureka!
/cast [mod:ctrl] Blood Fury
/cast [mod:ctrl,stance:1] Overpower; [mod:ctrl,stance:2] Revenge; Sunder Armor
```
Each racial is its own line (`Eureka!` for Atraeau, `Blood Fury` for Morla). A racial the character lacks does nothing.

### W5 Interrupt
```
#showtooltip
/cast [mod:ctrl,mod:shift] Spearing Strike; [mod:ctrl] Intimidating Shout; [stance:3] Pummel; Shield Bash
```

### W6 Demo Shout
```
#showtooltip
/cast [mod:ctrl,mod:shift] Piercing Howl; [mod:ctrl] Concussion Blow; Demoralizing Shout
```
Concussion Blow is on Ctrl in every stance.

### W7 Cleave
```
#showtooltip
/cast [mod:ctrl,mod:shift] Victory Rush; [nostance:3,mod:ctrl] Rend; Cleave
```
Ctrl+Shift casts Victory Rush in every stance. Rend works only in Battle and Defensive on Forever, so Ctrl casts nothing extra in Berserker (it falls through to Cleave).

### W8 Heroic Strike
```
#showtooltip
/cast [mod:ctrl,mod:shift] Slam; [mod:ctrl] Battle Shout; Heroic Strike
```

### W9 Charge
```
#showtooltip
/cast [mod:ctrl,mod:shift] Last Stand; [mod:ctrl] Hamstring; [stance:3] Intercept; Charge
```
With the Vanguard talent, Charge works in Defensive Stance too.

### W10 Bloodrage
```
#showtooltip
/cast [mod:ctrl,mod:shift] Challenging Shout; [mod:ctrl] Reckless Swings; Bloodrage
```
Challenging Shout is an emergency taunt, so it is on Ctrl+Shift.

### WQ AoE
```
#showtooltip
/cast [mod:ctrl,stance:1] Retaliation; [mod:ctrl,stance:2] Shield Wall; [mod:ctrl,stance:3] Recklessness; [stance:3] Whirlwind; Thunder Clap
```

## Status

Tested in game on WoW Forever and working. `[known:]` works on Forever. Still to see once learned:

- The talent presses for talents not yet taken (Mortal Strike, Bloodthirst, Sweeping Strikes, Death Wish, Spearing Strike, Piercing Howl, Last Stand, Reckless Swings), including whether Sweeping Strikes needs Battle Stance.
- Pummel, Whirlwind and Recklessness need a higher level, so those spots do nothing until learned.
