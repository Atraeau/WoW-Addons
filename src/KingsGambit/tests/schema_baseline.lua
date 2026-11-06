-- The frozen record of every published (format, event type) schema: a hash of each. tests/test_schemas.lua fails if a published
-- one changes or disappears (make a new format and an upcaster instead: see src/Migrations.lua), and when a type is ADDED so its
-- hash is recorded here on purpose. Edit only to record a new event type or a new format.
return {
    [2] = {
        envelope = "e524744b30e6859f",
        types = {
            AddMember = "b297ce8f7bbdc76b",
            Award = "41dad160b9a33c4c",
            CreateList = "2c34514465856bc8",
            Declined = "63b0c9c95c2cdcfd",
            Disenchant = "40afbd53c984fc2f",
            DisenchantResult = "bcd7a7785414d50c",
            Elevate = "74e77bc883162c0c",
            Genesis = "3c0e0dfa1147aa7e",
            ItemClasses = "9745cf890ddd000d",
            ItemSuits = "eb898766f3dbb6da",
            Migrate = "3f39d363856d4aaf",
            MovePlayer = "e630ff1ca350ddf8",
            Pass = "985a69f66e841882",
            RaidClose = "3b62ebbba90329bf",
            RemoveMember = "14922b9d46adfd59",
            Revert = "af4d6526737d3e0a",
            Revoke = "3b62ebbba90329bf",
            Salvage = "a7e46e00bf9d840c",
            SetDisenchanter = "7e448b4ca737a918",
            SetGuildMaster = "3c0e0dfa1147aa7e",
            SetListPolicy = "cf2e25c217604b4e",
            SetOfficers = "8075563460935228",
            SetRaidList = "5895642b8c4c802f",
            Transfer = "15f195a8bd1bda7c",
        },
    },
}
