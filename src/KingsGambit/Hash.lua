-- King's Gambit: deterministic hashing and canonical serialization (Phase 1).
-- Pure Lua (no WoW API) so the ledger can be tested outside the game.
--
-- Not cryptographic: the trust model is trusted officers + a hash chain that
-- catches mistakes, dropped messages and desync (see docs/kings-gambit/).
local _, SK = ...
local M = SK:NewModule("Hash")

local TWO32 = 4294967296
local PRIME = 16777619 -- FNV-1a 32-bit prime

local bxor = (bit and bit.bxor) or (bit32 and bit32.bxor)

-- h XOR b for a 32-bit h and a byte b.
local function xorByte(h, b)
    if bxor then
        local r = bxor(h, b)
        if r < 0 then r = r + TWO32 end
        return r
    end
    local lo = h % 256
    local r, p, a, c = 0, 1, lo, b
    for _ = 1, 8 do
        local x, y = a % 2, c % 2
        if x ~= y then r = r + p end
        a, c, p = (a - x) / 2, (c - y) / 2, p * 2
    end
    return h - lo + r
end

-- h * PRIME mod 2^32 without exceeding double precision (split into 16-bit halves).
local function mul32(h)
    local lo = h % 65536
    local hi = (h - lo) / 65536
    return (((hi * PRIME) % 65536) * 65536 + lo * PRIME) % TWO32
end

local function fnv(str, h)
    for i = 1, #str do
        h = mul32(xorByte(h, str:byte(i)))
    end
    return h
end

-- 8 hex digits of a 32-bit value held in a float. string.format("%x") is avoided on purpose:
-- some Lua runtimes (e.g. fengari, which runs in browsers) have 32-bit integers and refuse
-- values of 2^31 and above.
local HEX = "0123456789abcdef"
local function hex8(n)
    local out = {}
    for i = 8, 1, -1 do
        local d = n % 16
        out[i] = HEX:sub(d + 1, d + 1)
        n = (n - d) / 16
    end
    return table.concat(out)
end

-- 64 bits as 16 hex chars (two FNV-1a passes with different seeds).
function M.Sum(str)
    return hex8(fnv(str, 2166136261.0)) .. hex8(fnv(str, 2654435761.0))
end

local function keyLess(a, b)
    local ta, tb = type(a), type(b)
    if ta ~= tb then return ta < tb end
    return a < b
end

-- Canonical string for a value: same data => same string, regardless of key order.
function M.Canon(v)
    local t = type(v)
    if t == "string" then
        return "s" .. #v .. ":" .. v
    elseif t == "number" then
        if v ~= v or v == math.huge or v == -math.huge then error("Canon: non-finite number") end
        if v == math.floor(v) and v > -9007199254740992 and v < 9007199254740992 then
            if v == 0 then return "n0" end
            return ("n%.0f"):format(v) -- same text as %d, but safe for values beyond 32 bits
        end
        return ("n%.17g"):format(v)
    elseif t == "boolean" then
        return v and "T" or "F"
    elseif t == "nil" then
        return "~"
    elseif t == "table" then
        local keys = {}
        for k in pairs(v) do
            local kt = type(k)
            if kt ~= "string" and kt ~= "number" then error("Canon: bad key type " .. kt) end
            keys[#keys + 1] = k
        end
        table.sort(keys, keyLess)
        local out = { "{" }
        for _, k in ipairs(keys) do
            out[#out + 1] = M.Canon(k) .. "=" .. M.Canon(v[k]) .. ","
        end
        out[#out + 1] = "}"
        return table.concat(out)
    end
    error("Canon: unsupported type " .. t)
end

-- Inverse of Canon. Returns the value, or nil + "malformed".
function M.Decode(s)
    if type(s) ~= "string" then return nil, "malformed" end
    local pos = 1
    local function value()
        local c = s:sub(pos, pos)
        if c == "s" then
            local colon = s:find(":", pos, true)
            local len = colon and tonumber(s:sub(pos + 1, colon - 1))
            if not len or colon + len > #s then error("bad string") end
            local str = s:sub(colon + 1, colon + len)
            pos = colon + len + 1
            return str
        elseif c == "n" then
            local e = s:find("[=,}]", pos) or (#s + 1)
            local n = tonumber(s:sub(pos + 1, e - 1))
            if not n then error("bad number") end
            pos = e
            return n
        elseif c == "T" then pos = pos + 1; return true
        elseif c == "F" then pos = pos + 1; return false
        elseif c == "~" then pos = pos + 1; return nil
        elseif c == "{" then
            pos = pos + 1
            local t = {}
            while s:sub(pos, pos) ~= "}" do
                local k = value()
                if k == nil or s:sub(pos, pos) ~= "=" then error("bad key") end
                pos = pos + 1
                t[k] = value()
                if s:sub(pos, pos) ~= "," then error("bad separator") end
                pos = pos + 1
            end
            pos = pos + 1
            return t
        end
        error("bad token")
    end
    local ok, v = pcall(value)
    if not ok or pos ~= #s + 1 then return nil, "malformed" end
    return v
end
