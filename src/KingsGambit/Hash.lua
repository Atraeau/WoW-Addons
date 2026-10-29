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

-- 64 bits as 16 hex chars (two FNV-1a passes with different seeds).
function M.Sum(str)
    return ("%08x%08x"):format(fnv(str, 2166136261), fnv(str, 2654435761))
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
            return ("n%d"):format(v)
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
