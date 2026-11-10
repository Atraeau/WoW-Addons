-- King's Gambit: the look of the addon's own controls. A flat, dark button with a thin muted-gold edge in place of the stock red one: the same scheme the game's own
-- polished interfaces use (dark face, gold when it matters, a brighter edge for the chosen one, a plain gray when it is unavailable). Plain frames and
-- textures only, no templates, so it looks the same on every client and nothing in the game's art can reappear under it. Keep this file Lua 5.1-safe.
local _, SK = ...
local M = SK:NewModule("UISkin")

local WHITE = "Interface\\Buttons\\WHITE8X8"

-- face, edge: normal, chosen (marked), unavailable
M.COLORS = {
    face = { 0.11, 0.11, 0.13, 0.95 }, edge = { 0.50, 0.42, 0.22, 1 },
    faceOn = { 0.30, 0.23, 0.05, 0.98 }, edgeOn = { 1.00, 0.82, 0.00, 1 },
    faceOff = { 0.09, 0.09, 0.10, 0.70 }, edgeOff = { 0.26, 0.26, 0.28, 1 },
}

local function paint(b)
    local S = b.skin
    if not S then return end
    local c = M.COLORS
    local enabled = true
    if b.IsEnabled then enabled = b:IsEnabled() and true or false end
    local face, edge = c.face, c.edge
    if not enabled then face, edge = c.faceOff, c.edgeOff
    elseif b.skinMarked then face, edge = c.faceOn, c.edgeOn end
    if S.face.SetColorTexture then S.face:SetColorTexture(face[1], face[2], face[3], face[4]) end
    for _, e in ipairs(S.edges) do if e.SetColorTexture then e:SetColorTexture(edge[1], edge[2], edge[3], edge[4]) end end
end

-- Make a button of this look. `b` is a plain Button frame.
function M.Style(b)
    if b.skin or not b.CreateTexture then return b end
    pcall(function()
        local face = b:CreateTexture(nil, "BACKGROUND")
        face:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1); face:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
        local edges = {}
        local function edge(p1, p2, w, h)
            local t = b:CreateTexture(nil, "BORDER")
            t:SetPoint(p1, b, p1, 0, 0); t:SetPoint(p2, b, p2, 0, 0)
            if w then t:SetWidth(w) end
            if h then t:SetHeight(h) end
            edges[#edges + 1] = t
        end
        edge("TOPLEFT", "TOPRIGHT", nil, 1); edge("BOTTOMLEFT", "BOTTOMRIGHT", nil, 1)
        edge("TOPLEFT", "BOTTOMLEFT", 1, nil); edge("TOPRIGHT", "BOTTOMRIGHT", 1, nil)
        b.skin = { face = face, edges = edges }
        -- under the pointer a little gold shows through, and while it is held down it darkens
        if b.SetHighlightTexture then
            b:SetHighlightTexture(WHITE)
            local h = b.GetHighlightTexture and b:GetHighlightTexture()
            if h then
                if h.SetVertexColor then h:SetVertexColor(1, 0.82, 0, 0.16) end
                if h.ClearAllPoints then h:ClearAllPoints(); h:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1); h:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1) end
            end
        end
        if b.SetPushedTexture then
            b:SetPushedTexture(WHITE)
            local p = b.GetPushedTexture and b:GetPushedTexture()
            if p then
                if p.SetVertexColor then p:SetVertexColor(0, 0, 0, 0.35) end
                if p.ClearAllPoints then p:ClearAllPoints(); p:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1); p:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1) end
            end
        end
        -- the game nudges a pressed button's label down and right; the chosen answer is held pressed, so keep the label where it is
        if b.SetPushedTextOffset then b:SetPushedTextOffset(0, 0) end
        if b.SetNormalFontObject then b:SetNormalFontObject(GameFontNormal or "GameFontNormal") end
        if b.SetHighlightFontObject then b:SetHighlightFontObject(GameFontHighlight or "GameFontHighlight") end
        if b.SetDisabledFontObject then b:SetDisabledFontObject(GameFontDisable or "GameFontDisable") end
        -- the face follows whether it is enabled
        local setEnabled = b.SetEnabled
        if setEnabled then b.SetEnabled = function(self, on) setEnabled(self, on); paint(self) end end
        local enable, disable = b.Enable, b.Disable
        if enable then b.Enable = function(self) enable(self); paint(self) end end
        if disable then b.Disable = function(self) disable(self); paint(self) end end
    end)
    paint(b)
    return b
end

-- The chosen answer: a gold edge and a warm face (the button is also held pushed in by its owner).
function M.Mark(b, on)
    b.skinMarked = on and true or false
    paint(b)
end

-- A new styled button.
function M.Button(parent, text, w, h)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(w, h or 22)
    M.Style(b)
    b:SetText(text)
    return b
end
