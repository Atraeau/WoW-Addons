local function readf(p) local f=assert(io.open(p,"rb")); local s=f:read("a"); f:close(); return s end
local function writef(p,s) local f=assert(io.open(p,"wb")); f:write(s); f:close() end
local function patch(path, a, b)
  local s=readf(path); local x,y=s:find(a,1,true); assert(x,path..": "..a:sub(1,50)); writef(path, s:sub(1,x-1)..b..s:sub(y+1))
end
local s = readf("src/LootWindow.lua")
local a = s:find("local BEVEL_INSET = 3", 1, true)
local b = s:find("function M.Mark(b, on)", 1, true)
assert(a and b)
local new = [=[local BEVEL_INSET = 3
local function bevel(b)
    if b.bevel then return b.bevel end
    if not b.CreateTexture then return nil end
    local I = BEVEL_INSET
    local list = {}
    local function layer(r, g, bl, a)
        local t = b:CreateTexture(nil, "OVERLAY")
        if t.SetColorTexture then t:SetColorTexture(r, g, bl, a) end
        list[#list + 1] = t
        return t
    end
    -- An inset reads as pressed in when the light falls from above-left: the top and left inner edges are in shadow, fading inward, and the bottom and right inner
    -- edges catch the light. So the shading is mirrored, not one dark top: a shadow that fades over a few pixels along the top and left, and a light that fades
    -- over a few along the bottom and right, each with its crisp outermost line; under it a body only a little darker than the button.
    local body = layer(0, 0, 0, 0.20)
    body:SetPoint("TOPLEFT", b, "TOPLEFT", I, -I); body:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -I, I)
    for i, a in ipairs { 0.42, 0.26, 0.14, 0.06 } do -- shadow, top
        local t = layer(0, 0, 0, a); t:SetHeight(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I, -(I + i - 1)); t:SetPoint("TOPRIGHT", b, "TOPRIGHT", -I, -(I + i - 1))
    end
    for i, a in ipairs { 0.30, 0.15, 0.06 } do -- shadow, left
        local t = layer(0, 0, 0, a); t:SetWidth(1)
        t:SetPoint("TOPLEFT", b, "TOPLEFT", I + i - 1, -I); t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", I + i - 1, I)
    end
    for i, a in ipairs { 0.42, 0.20, 0.10, 0.04 } do -- light, bottom
        local t = layer(1, 1, 1, a); t:SetHeight(1)
        t:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", I, I + i - 1); t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -I, I + i - 1)
    end
    for i, a in ipairs { 0.30, 0.14, 0.05 } do -- light, right
        local t = layer(1, 1, 1, a); t:SetWidth(1)
        t:SetPoint("TOPRIGHT", b, "TOPRIGHT", -(I + i - 1), -I); t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -(I + i - 1), I)
    end
    b.bevel = list
    return b.bevel
end

]=]
writef("src/LootWindow.lua", s:sub(1, a - 1) .. new .. s:sub(b))
patch("src/LootWindow.lua", [=[on the red buttons, so the pushed-in look is reinforced with an inset bevel drawn on top: a darker body, a shadow along the top and left edges and a light
-- edge along the bottom, which reads]=], [=[on the red buttons, so the pushed-in look is reinforced with an inset bevel drawn on top: a slightly darker body, a shadow fading inward along the top and left
-- edges and a light fading inward along the bottom and right (mirrored, so it isn't just a button that is darker at the top), which reads]=])
patch("tests/test_lootview.lua", [=[    eq(made, 4, "an inset bevel: body, top shadow, left shadow, bottom edge")
    for _, t in ipairs(b.bevel) do eq(t.on, true) end]=], [=[    local layers = made
    assert(layers >= 10, "an inset bevel: a body, a shadow fading along the top and left, a light fading along the bottom and right")
    eq(#b.bevel, layers)
    for _, t in ipairs(b.bevel) do eq(t.on, true) end]=])
patch("tests/test_lootview.lua", [=[    eq(made, 4, "marking again does not build another bevel")]=], [=[    eq(made, layers, "marking again does not build another bevel")]=])
print("ok")
