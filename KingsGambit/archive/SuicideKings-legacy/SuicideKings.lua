-- Globals
SK_GUILDMEMBERS_TO_DISPLAY = 21;
SK_GUILDMEMBERS_TO_HEIGHT = SK_GUILDMEMBERS_TO_DISPLAY + 1;

SK_EVENT_NAME_ADDON_LOADED = "ADDON_LOADED"
SK_EVENT_NAME_PLAYER_LOGOUT = "PLAYER_LOGOUT"

ReconciledGuildMembers = {} -- fullname, guildIndex
SelectedGuildMember = nil
SelectedSkListMember = nil

TestGuildTable = {{"FirstName", 1}, {"SecondName", 2}, {"ThirdName", 3}}
TestSKListTable = {{"SecondName", 1}}

function SuicideKings_OnEvent(self, event, payload)
    if (event == SK_EVENT_NAME_ADDON_LOADED and payload == "SuicideKings") then
        if (SuicideKingsList == nil) then
            print("SK List not created yet")
        else
            ReadSuicideList(SuicideKingsList)
            ReconciledGuildMembers = ReconcileGuildWithList(SuicideKingsList, CreateGuildTable())
            --ReconciledGuildMembers = ReconcileGuildWithList(TestSKListTable, TestGuildTable)
            print("Reconciled Member Count: " .. GetTableLength(ReconciledGuildMembers))
            GuildMembers_Update();
            DisplayCurrentListMembers()
        end
    end
end

function SuicideKings_OnLoad(self)
    self:RegisterEvent(SK_EVENT_NAME_ADDON_LOADED); -- Fired when saved variables are loaded
    self:RegisterEvent(SK_EVENT_NAME_PLAYER_LOGOUT); -- Fired when about to log out
    RegisterSlashCommand()
    -- PanelTemplates_SetNumTabs(self, 2);
    -- PanelTemplates_SetTab(self, 1)
end

function RegisterSlashCommand()
    SlashCmdList["SUICIDEKINGS"] = HandleSlashCommand
    SLASH_SUICIDEKINGS1 = "/sk"
end

function HandleSlashCommand(arg)
    SuicideKingsFrame:Show()
end

function SuicideKings_OnShow()
    C_GuildInfo.GuildRoster();
end

function GuildMembers_Update()
    SuicideKingsFrameInset:SetPoint("TOPLEFT", 4, -80);
    PopulateGuildMembers();
end

function SuicideKingsListMembers_Update()
    DisplayCurrentListMembers()
end


function SKMember_OnClick(self, button)
    if (button == "LeftButton") then
        SelectedSkListMember = self.guildIndex
        print("Clicked SKMember: " .. self.guildIndex)
        GuildMembers_Update()
        DisplayCurrentListMembers()
    end
end

function GuildMember_OnClick(self, button)
    if (button == "LeftButton") then
        SelectedGuildMember = self.guildIndex
        print("Clicked GuildMember: " .. self.guildIndex)
        GuildMembers_Update()
        DisplayCurrentListMembers()
    end
end

function PopulateGuildMembers()
    local remainingMemberCount = GetTableLength(ReconciledGuildMembers)

    if remainingMemberCount > 0 then
        local remainingGuildOffset = SuicideKingsGuildListScrollFrame.offset or 0

        -- Go through the members to display, starting at the top person, to the end person
        for displayButtonIdx = 1, SK_GUILDMEMBERS_TO_DISPLAY, 1 do
            -- Determine who should be at the top of the list. The offset for the scroll bar would adjust who the top person
            -- should be provided the scroll bar has been adjusted and the top person in the guild is not the top person
            -- in the display list

            local button = getglobal("SKButtonGuildPlayerListItem" .. displayButtonIdx);

            if displayButtonIdx < remainingMemberCount then

                local reminingGuildIdx = remainingGuildOffset + displayButtonIdx;

                local _, guildIndex = unpack(ReconciledGuildMembers[reminingGuildIdx])
                button.guildIndex = guildIndex;

                local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(
                    guildIndex);
                if not IsEmpty(fullName) then
                    local displayedName = Ambiguate(fullName, "guild");
                    getglobal("SKButtonGuildPlayerListItem" .. displayButtonIdx .. "Name"):SetText(displayedName);
                    getglobal("SKButtonGuildPlayerListItem" .. displayButtonIdx .. "Rank"):SetText(rank);
                end

                -- Highlight the correct who
                if (SelectedGuildMember == guildIndex) then
                    button:LockHighlight();
                else
                    button:UnlockHighlight();
                end
            else
                button:Disable()
            end
        end

        local remainingMembers = GetTableLength(ReconciledGuildMembers);
        FauxScrollFrame_Update(SuicideKingsGuildListScrollFrame, remainingMembers, SK_GUILDMEMBERS_TO_DISPLAY,
            SK_GUILDMEMBERS_TO_HEIGHT);
    end
end

function DisplayCurrentListMembers()
    if (SuicideKingsList ~= nil) then
        local skListCount = GetTableLength(SuicideKingsList)
        local memberOffset = SuicideKingsListScrollFrame.offset or 0

        for displayButtonIdx = 1, SK_GUILDMEMBERS_TO_DISPLAY, 1 do
            local lookupOffset = memberOffset + displayButtonIdx
            local button = getglobal("SKButtonSuicideKingsListItem" .. displayButtonIdx);

            if displayButtonIdx < skListCount then
                local name, guildIdx = unpack(SuicideKingsList[lookupOffset])
                button.guildIndex = guildIdx;
    
                local displayedName = Ambiguate(name, "guild");
                getglobal("SKButtonSuicideKingsListItem" .. displayButtonIdx .. "Name"):SetText(displayedName);
    
                -- Highlight the correct who
                if (GetGuildRosterSelection() == lookupOffset) then
                    button:LockHighlight();
                else
                    button:UnlockHighlight();
                end
            else
                button:Disable()
            end
        end

        FauxScrollFrame_Update(SuicideKingsListScrollFrame, skListCount, SK_GUILDMEMBERS_TO_DISPLAY, SK_GUILDMEMBERS_TO_HEIGHT);
    end
end

-- Statefull function to assign the new list to the shared variable "SuicideKingsList"
function SuicideKings_CreateList()
    print("Create")
    SuicideKingsList = CreateSuicideList()
end

function SuicideKings_DeleteList()
    SuicideKingsList = nil
end

-- Static function to create list and return (stateless)
function CreateSuicideList()
    local suicideList = {}

    for idx = 1, 23, 1 do
        local fullName = GetGuildRosterInfo(idx);
        table.insert(suicideList, {fullName, idx})
    end

    return suicideList
end

function IsEmpty(s)
    return s == nil or s == ''
end

function ReadSuicideList(list)
    for i, v in ipairs(list) do
        local name, idx = unpack(v)
        print(" name: " .. name)
    end
end

function SuicideKingsGuildListColumn_SetWidth(frame, width)
    frame:SetWidth(width);
    local name = frame:GetName() .. "Middle";
    local middleFrame = _G[name];
    if middleFrame then
        middleFrame:SetWidth(width - 9);
    end
end

function ReconcileGuildWithList(sk_list, guild_list)
    -- Instead of providing the actual guild list, we need a remaining guild list which is based on the currently selected list
    -- Go through the current list and remove them from the remaining guild

    local reconciledGuildMembers = {}
    if (sk_list ~= nil) then
        for _, guild_list_member in ipairs(guild_list) do
            local found = false
            for _, suicide_list_member_name in ipairs(sk_list) do
                local guild_name, guild_idx = unpack(guild_list_member)
                local sk_name, guild_idx = unpack(suicide_list_member_name)

                if guild_name == sk_name then
                    found = true
                end
            end
            if not found then
                table.insert(reconciledGuildMembers, guild_list_member)
            end
        end
    end
    return reconciledGuildMembers
end

function CreateGuildTable()
    local guildTable = {}
    local numMembers = GetNumGuildMembers();

    for guildIdx = 1, numMembers, 1 do
        local fullName = GetGuildRosterInfo(guildIdx);
        table.insert(guildTable, {fullName, guildIdx})
    end
    return guildTable
end
