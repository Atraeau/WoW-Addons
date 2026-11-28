# Paladin macros (WoW Forever)

One set for every paladin and every spec, built for holy healing. Laid out like [warrior.md](warrior.md) where a warrior ability has a match (stun on Ctrl+6, AoE on Q, Lay on Hands where Shield Wall is), and by how often each ability is pressed where it does not.

## Rules

- Unmodified press is the primary ability. `[mod:ctrl]` is the secondary. On a heal, Ctrl casts a lower rank to save mana.
- Ctrl+Shift (`[mod:ctrl,mod:shift]`) is for situational abilities only (big cooldowns and emergencies). Put it first in the `/cast` line, or the plain Ctrl clause will catch it.
- The more often an ability is pressed, the better its key: plain 1 to 4, then plain 5 to Q, then Ctrl, then Ctrl+Shift.
- Heals use the mouseover template: mouseover if it is a living friend, else the target if it is a living friend, else yourself: `[@mouseover,help,nodead][@target,help,nodead][@player]`. Where that does not fit in 255 characters, the short form `[@mouseover,help,nodead][]` does the same job: the empty `[]` casts on a friendly target, or on yourself (auto self-cast) when the target is not friendly.
- Each ability lives on one button only.
- Talents belong to a tree, not a spec, so every talent ability gets its own press; a key does nothing until that talent is learned. Spells learned later replace earlier ones with `[known:]` (Cleanse over Purify, Divine Shield over Divine Protection).
- Buffs set up before a fight are clicked, not keyed: auras (set and forget; unlike stances they limit nothing), the long blessings (Might, Wisdom, Kings), Oath of Light, Redemption. Seals last 30 seconds and are recast in combat, so every seal in use gets a key; seals not in use (Seal of Light, Seal of Justice) are clicked.
- A macro body is 255 characters at most; the game cuts off anything past that.
- Macro names are 16 characters or fewer. Use the `?` icon so `#showtooltip` picks the icon.
- Macros are character macros on Bastian (not account-wide). Every name starts with P.
- Shift+1 to Shift+6 must be unbound (see [warrior.md](warrior.md#key-bindings)), or Ctrl+Shift+1 to 6 flip the action bar page.

## Layout

| Key | Plain | Ctrl | Ctrl+Shift |
|---|---|---|---|
| 1 | Holy Light | Holy Light, lower rank | |
| 2 | Flash of Light | Flash of Light, lower rank | |
| 3 | Holy Shock (heals a friend, hits an enemy) | Light's Vigil | |
| 4 | Judgement | Swift Judgement | Stoneform |
| 5 | Purify, later Cleanse | Blessing of Freedom | Turn Undead |
| 6 | Seal of the Crusader | Hammer of Justice | Blessing of Protection |
| 7 | Holy Strike | Repentance | Seal of Wisdom |
| 8 | Seal of Righteousness (Seal of Command if talented) | Seal of Fury | Righteous Fury |
| 9 | Exorcism | Hammer of Wrath | Templar's Bulwark |
| 10 | Divine Favor | Holy Shield | Divine Protection, later Divine Shield |
| Q | Consecration | Lay on Hands | Holy Wrath |

## Talent abilities

| Talent | Tree | Press |
|---|---|---|
| Holy Shock | Holy | 3 |
| Light's Vigil | Holy (bottom) | Ctrl+3 |
| Divine Favor | Holy | 10 |
| Oath of Light | Holy | clicked (lasts an hour) |
| Swift Judgement | Prot | Ctrl+4 |
| Templar's Bulwark | Prot | Ctrl+Shift+9 |
| Holy Shield | Prot | Ctrl+10 |
| Repentance | Ret | Ctrl+7 |
| Seal of Command | Ret | 8, in place of Seal of Righteousness |

## Macros

### P1 Holy Light
```
#showtooltip
/cast [mod:ctrl,@mouseover,help,nodead][mod:ctrl,@target,help,nodead][mod:ctrl,@player] Holy Light(Rank 2); [@mouseover,help,nodead][@target,help,nodead][@player] Holy Light
```

### P2 Flash
```
#showtooltip
/cast [mod:ctrl,@mouseover,help,nodead][mod:ctrl,@target,help,nodead][mod:ctrl,@player] Flash of Light(Rank 1); [@mouseover,help,nodead][@target,help,nodead][@player] Flash of Light
```

### P3 Holy Shock
```
#showtooltip
/cast [mod:ctrl,@mouseover,help,nodead][mod:ctrl,@target,help,nodead][mod:ctrl,@player] Light's Vigil; [@mouseover,exists,nodead][@target,exists,nodead][@player] Holy Shock
```
Holy Shock goes to the mouseover or target whether friend or enemy, so it heals or hits. Light's Vigil is pressed just before it.

### P4 Judgement
```
#showtooltip
/cast [mod:ctrl,mod:shift] Stoneform; [mod:ctrl] Swift Judgement; Judgement
```
Stoneform has a long cooldown and is saved for poison and bleeds, so it is on Ctrl+Shift rather than fired with every Ctrl press.

### P5 Cleanse
```
#showtooltip
/cast [mod:ctrl,mod:shift] Turn Undead; [mod:ctrl,@mouseover,help,nodead][mod:ctrl] Blessing of Freedom; [@mouseover,help,nodead,known:Cleanse][known:Cleanse] Cleanse; [@mouseover,help,nodead][] Purify
```
Blessing of Freedom is rarely used and works like a cleanse, so it sits on Ctrl next to the dispel.

### P6 Crusader
```
#showtooltip
/cast [mod:ctrl,mod:shift,@mouseover,help,nodead][mod:ctrl,mod:shift] Blessing of Protection; [mod:ctrl] Hammer of Justice; Seal of the Crusader
```
Seal of the Crusader opens most pulls while leveling, so it is a plain press. Hammer of Justice is on Ctrl in every spec, like Concussion Blow on the warrior. Blessing of Protection is an emergency, so it is on Ctrl+Shift.

### P7 Holy Strike
```
#showtooltip
/cast [mod:ctrl,mod:shift] Seal of Wisdom; [mod:ctrl] Repentance; Holy Strike
```
Seal of Wisdom is for a long fight when mana runs low, so it is on Ctrl+Shift, next to the other seals on 8.

### P8 Seal
```
#showtooltip
/cast [mod:ctrl,mod:shift] Righteous Fury; [mod:ctrl] Seal of Fury; [known:Seal of Command] Seal of Command; Seal of Righteousness
```
Seal of Command (a Retribution talent) replaces Seal of Righteousness on the plain press when learned, since a build that takes it uses it instead. With dual spec, `[known:]` follows the active spec, so the holy spec keeps Seal of Righteousness.
Seal of Fury (new in Forever) is for leveling with a shield: hits add Holy damage and a small absorb, and its Judgement taunts. Every spec has it, so it keeps Ctrl+8 for good. Righteous Fury (more threat, 30 minutes) goes with Seal of Fury when soloing or tanking.

### P9 Exorcism
```
#showtooltip
/cast [mod:ctrl,mod:shift] Templar's Bulwark; [mod:ctrl] Hammer of Wrath; Exorcism
```
The ranged openers, like Charge on the warrior. Templar's Bulwark is where Last Stand is.

### P10 Divine
```
#showtooltip
/cast [mod:ctrl,mod:shift,known:Divine Shield] Divine Shield; [mod:ctrl,mod:shift] Divine Protection; [mod:ctrl] Holy Shield; Divine Favor
```
Divine Favor is pressed every couple of minutes when healing, so it gets the plain press. Divine Protection and Divine Shield are emergencies, so they are on Ctrl+Shift.

### PQ AoE
```
#showtooltip
/cast [mod:ctrl,mod:shift] Holy Wrath; [mod:ctrl,@mouseover,help,nodead][mod:ctrl] Lay on Hands; Consecration
```
Lay on Hands is where Shield Wall is on the warrior.

## Status

Drafted from the in-game dump of a level 20 Dwarf paladin and the Wowhead holy raid build (31/7/13). In game on Bastian and being tested while leveling (Divine Protection on Ctrl+Shift+10 confirmed). `[known:]` sees learned talents; whether it follows a dual spec switch is not yet tested. To check:

- Whether the rank syntax `Holy Light(Rank 2)` still works (it is copied from the existing Holy Light macro). Update the Ctrl ranks as new ranks are learned.
- Holy Shock on an enemy mouseover.
- Spells not yet learned (Holy Shock, Light's Vigil, Divine Favor, Seal of Wisdom, Divine Shield, Cleanse, Hammer of Wrath, Holy Wrath, Turn Undead) do nothing until learned. Plain 10 is empty until Divine Favor is learned.
