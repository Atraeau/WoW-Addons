local _, addon = ...

--------------------------------------------------------------------------------
-- Spells management
--------------------------------------------------------------------------------

-- Spell ids
local DEFENSIVE_STANCE = 71
local BEAR_FORM        = 5487
local DIRE_BEAR_FORM   = 9634
local RIGHTEOUS_FURY   = 25780

local TANK_SPELLS_BY_CLASS = {
    WARRIOR = {
        -- DEFENSIVE STANCE-EXCLUSIVE (tanking = true)

        -- Taunt
        [355] = true,

        -- Shield Block
        [2565] = true,

        -- Revenge (all ranks)
        [6572] = true, [6574] = true, [7379] = true, [11600] = true, [11601] = true, [25288] = true,

        -- Shield Wall
        [871] = true,

        -- Disarm
        [676] = true,

        -- BATTLE AND BERSERKER STANCE-EXCLUSIVE (non-tanking = false)

        -- Charge (all ranks)
        [100] = false, [6178] = false, [11578] = false,

        -- Overpower (all ranks)
        [7384] = false, [7887] = false, [11584] = false, [11585] = false,

        -- Mocking Blow (all ranks)
        [694] = false, [7400] = false, [7402] = false, [20559] = false, [20560] = false,

        -- Sweeping Strikes
        [12292] = false,

        -- Retaliation
        [20230] = false,

        -- Berserker Rage
        [18499] = false,

        -- Intercept (all ranks)
        [20252] = false, [20616] = false, [20617] = false,

        -- Whirlwind
        [1680] = false,

        -- Recklessness
        [1719] = false,

        -- Pummel (all ranks)
        [6552] = false, [6554] = false,
    },

    DRUID = {
        -- BEAR / DIRE BEAR–EXCLUSIVE (tanking = true)

        -- Maul (all ranks)
        [6807] = true, [6808] = true, [6809] = true, [8972] = true, [9745] = true, [9880] = true, [9881] = true,

        -- Swipe (Bear) (all ranks)
        [779] = true, [780] = true, [769] = true, [9754] = true, [9908] = true,

        -- Bash (all ranks)
        [5211] = true, [6798] = true, [8983] = true,

        -- Growl
        [6795] = true,

        -- Challenging Roar
        [5209] = true,

        -- Frenzied Regeneration (all ranks)
        [22842] = true, [22895] = true, [22896] = true,

        -- Enrage
        [5229] = true,

        -- Demoralizing Roar (all ranks)
        [99] = true, [1735] = true, [9490] = true, [9747] = true, [9898] = true,

        -- Feral Charge
        [16979] = true,

        -- NON-TANKING FORM-EXCLUSIVE (any form other than Bear/Dire Bear)

        -- Claw (all ranks)
        [1082] = false, [3029] = false, [5201] = false, [9849] = false, [9850] = false,

        -- Shred (all ranks)
        [5221] = false, [6800] = false, [8992] = false, [9829] = false, [9830] = false,

        -- Rake (all ranks)
        [1822] = false, [1823] = false, [1824] = false, [9904] = false,

        -- Cower (all ranks)
        [8998] = false, [9000] = false, [9892] = false,

        -- Ravage (all ranks)
        [6785] = false, [6787] = false, [9866] = false, [9867] = false,

        -- Pounce (all ranks)
        [9005] = false, [9823] = false, [9827] = false,

        -- Rip (all ranks)
        [1079] = false, [9492] = false, [9493] = false, [9752] = false, [9894] = false, [9896] = false,

        -- Dash (all ranks)
        [1850] = false, [9821] = false,

        -- Tiger's Fury (all ranks)
        [5217] = false, [6793] = false, [9845] = false, [9846] = false,

        -- Prowl (all ranks)
        [5215] = false, [6783] = false, [9913] = false,

        -- Ferocious Bite (all ranks)
        [22568] = false, [22827] = false, [22828] = false, [22829] = false, [31018] = false,

        -- Track Humanoids
        [5225] = false,

        -- Healing Touch (all ranks)
        [5185] = false, [5186] = false, [5187] = false, [5188] = false, [5189] = false, [6778] = false, [8903] = false,
        [9758] = false, [9888] = false, [9889] = false, [25297] = false,

        -- Regrowth
        [8936] = false, [8938] = false, [8939] = false, [8940] = false, [8941] = false,
        [9750] = false, [9856] = false, [9857] = false, [9858] = false,

        -- Rejuvenation
        [774] = false, [1058] = false, [1430] = false, [2090] = false, [2091] = false,
        [3627] = false, [8910] = false, [9839] = false, [9840] = false, [9841] = false,
        [25299] = false,

        -- Moonfire
        [8921] = false, [8924] = false, [8925] = false, [8926] = false, [8927] = false,
        [8928] = false, [8929] = false, [9833] = false, [9834] = false, [9835] = false,

        -- Starfire
        [2912] = false, [8949] = false, [8950] = false, [8951] = false, [9875] = false,
        [9876] = false, [25298] = false,

        -- Wrath
        [5176] = false, [5177] = false, [5178] = false, [5179] = false, [5180] = false,
        [6780] = false, [8905] = false, [9912] = false,

        -- Thorns
        [467] = false, [782] = false, [1075] = false, [8914] = false, [9756] = false,
        [9910] = false,

        -- Entangling Roots
        [339] = false, [1062] = false, [5195] = false, [5196] = false, [9852] = false,
        [9853] = false,

        -- Teleport: Moonglade
        [18960] = false,
    },
}

local NO_THREAT_DEBUFFS = {
    -- Hunter's Mark
    [1130] = true, [14323] = true, [14324] = true, [14325] = true,
}

local INCAPACITATE_SPELLS = {
    -- Polymorph: Sheep (all ranks)
    [118] = true, [12824] = true, [12825] = true, [12826] = true,

    -- Polymorph: Turtle
    [28271] = true,

    -- Polymorph: Pig
    [28272] = true,

    -- Hibernate (all ranks)
    [2637] = true, [18657] = true, [18658] = true,

    -- Repentance
    [20066] = true,

    -- Shackle Undead (all ranks)
    [9484] = true, [9485] = true, [10955] = true,

    -- Blind
    [2094] = true,

    -- Seduction
    [6358] = true,

    -- Freezing Trap Effect (all ranks)
    [3355] = true, [14308] = true, [14309] = true,

    -- Wyvern Sting (all ranks)
    [19386] = true, [24132] = true, [24133] = true,

    -- Turn Undead
    [2878] = true, [5627] = true, [10326] = true,
}

function addon.IsTankStanceOrForm(spellId)
    return spellId == DEFENSIVE_STANCE or spellId == BEAR_FORM or spellId == DIRE_BEAR_FORM
end

function addon.GetRighteousFurySpellId()
    return RIGHTEOUS_FURY
end

-- Return true if it is a tank spell, false if it is not a tank spell and nil if the tank status cannot be determined
function addon.IsTankSpell(class, spellId)
    return TANK_SPELLS_BY_CLASS[class][spellId]
end

function addon.IsNoThreatDebuff(spellId)
    return NO_THREAT_DEBUFFS[spellId]
end

-- Return true if unit is incapacitated, false otherwise
function addon.UnitIsIncapacitated(unit)
    for i = 1, 40 do
        local aura = C_UnitAuras.GetDebuffDataByIndex(unit, i)
        if not aura then
            break
        elseif INCAPACITATE_SPELLS[aura.spellId] then
            return true
        end
    end
    return false
end