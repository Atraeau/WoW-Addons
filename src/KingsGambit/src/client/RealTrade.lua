-- King's Gambit: RealClient (the Client for the actual game), the trade window: what is offered, and the trade events. Keep this file Lua 5.1-safe.
-- RealClient.New builds the shared pieces (see client/RealClient.lua) and calls Install here, which adds these to the client `c`.
local _, SK = ...
local M = SK:NewModule("RealTrade")

-- c: the client being built; h: the helpers RealClient.New shares (and what the earlier files exported).
function M.Install(c, h)
    local E, bus, safe, fromGame, unitName, handlers = h.E, h.bus, h.safe, h.fromGame, h.unitName, h.handlers

    ---------------------------------------------------------------- trade
    local tradeActive, tradePartner, tradeCompleted = false, nil, false

    local function tradeLinks(fn)
        local out = {}
        for i = 1, 6 do
            local link = fn and safe(fn(i))
            if link then out[#out + 1] = link end
        end
        return out
    end

    local function snapshotTrade()
        local give = (E.C_TradeInfo and E.C_TradeInfo.GetTradePlayerItemLink) or E.GetTradePlayerItemLink
        local get = (E.C_TradeInfo and E.C_TradeInfo.GetTradeTargetItemLink) or E.GetTradeTargetItemLink
        return { partner = tradePartner, give = tradeLinks(give), get = tradeLinks(get), accepted = false }
    end

    function c:trade()
        if not tradeActive then return nil end
        return snapshotTrade()
    end

    -- FIELD: needs a tooltip scan ("You may trade this item ... within the next X"); not yet implemented.
    function c:tradeableUntil(_) return nil end

    -- The bind-on-pickup items in the bags that can still be traded to the players who were eligible to loot them: { { link, seconds } } (seconds is nil if
    -- the tooltip's time can't be read), soonest to close first. The window is told by the item's tooltip (BIND_TRADE_TIME_REMAINING, "... for the next
    -- 1 hour 59 min"). FIELD: confirm the tooltip text and that C_TooltipInfo.GetBagItem carries it on this client.
    function c:tradeableItems()
        local out = {}
        local C = E.C_Container
        if not (C and C.GetContainerNumSlots and C.GetContainerItemInfo and E.C_TooltipInfo and E.C_TooltipInfo.GetBagItem and E.BIND_TRADE_TIME_REMAINING) then return out end
        -- (the "%" of the %s is escaped too, so the placeholder can be found and made a capture)
        local pattern = "^" .. E.BIND_TRADE_TIME_REMAINING:gsub("([%%%(%)%.%+%-%*%?%[%]%^%$])", "%%%1"):gsub("%%%%s", "(.+)") .. "$"
        for bag = 0, 5 do
            for slot = 1, (C.GetContainerNumSlots(bag) or 0) do
                local info = C.GetContainerItemInfo(bag, slot)
                if info and info.hyperlink and info.isBound then
                    local ok, data = pcall(E.C_TooltipInfo.GetBagItem, bag, slot)
                    if ok and data and data.lines then
                        for _, line in ipairs(data.lines) do
                            local left = safe(line.leftText)
                            local rest = type(left) == "string" and left:match(pattern)
                            if rest then
                                local h = tonumber(rest:match("(%d+)%s*[Hh]our")) or 0
                                local m = tonumber(rest:match("(%d+)%s*[Mm]in")) or 0
                                local s = tonumber(rest:match("(%d+)%s*[Ss]ec")) or 0
                                local seconds = (h > 0 or m > 0 or s > 0) and (h * 3600 + m * 60 + s) or nil
                                out[#out + 1] = { link = info.hyperlink, seconds = seconds }
                                break
                            end
                        end
                    end
                end
            end
        end
        table.sort(out, function(a, b)
            if (a.seconds or math.huge) ~= (b.seconds or math.huge) then return (a.seconds or math.huge) < (b.seconds or math.huge) end
            return a.link < b.link
        end)
        return out
    end


    -- FIELD: confirm trade event order and that UI_INFO_MESSAGE reports completion.
    function handlers.TRADE_SHOW()
        tradeActive, tradeCompleted = true, false
        tradePartner = fromGame(unitName("NPC"))
    end
    function handlers.TRADE_ACCEPT_UPDATE() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.TRADE_PLAYER_ITEM_CHANGED() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.TRADE_TARGET_ITEM_CHANGED() bus.emit("trade.changed", { trade = c:trade() }) end
    function handlers.UI_INFO_MESSAGE(_, message)
        if tradeActive and message ~= nil and message == E.ERR_TRADE_COMPLETE then tradeCompleted = true end
    end
    function handlers.TRADE_CLOSED()
        local snap = tradeActive and snapshotTrade() or { partner = tradePartner, give = {}, get = {} }
        tradeActive = false
        bus.emit("trade.closed", { completed = tradeCompleted, partner = snap.partner, gave = snap.give, got = snap.get })
        tradeCompleted = false
    end
end
