-- The ledger-facing surface of the addon at the version line below. tests/test_compat.lua compares the code against this and
-- explains what to do when it differs. Edit it on purpose, in the same commit as the change (and the TOC version, if the
-- change starts a new line).
return {
    line = "0.1", -- the compatibility line: 0.1.x (MINOR is the line while MAJOR is 0; from 1.0.0 it is MAJOR)
    surface = {
        ledgerFormat = 2,
        listEvents = { "AddMember", "Award", "CreateList", "Disenchant", "MovePlayer", "Pass", "RemoveMember", "Revert", "Salvage", "Transfer" },
        globalEvents = { "Declined", "Elevate", "Genesis", "ItemClasses", "ItemSuits", "RaidClose", "Revoke", "SetDisenchanter", "SetGuildMaster", "SetOfficers" },
        requestKinds = { "add", "award", "eligible", "gift", "move", "remove", "trade", "undo" },
        messages = { "E", "H", "LB", "LK", "LP", "LR", "LS", "LT", "LX", "LY", "QK", "QR", "R" },
    },
}
