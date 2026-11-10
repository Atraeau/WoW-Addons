-- King's Gambit: what the Guild book shows, as plain tables. Keep this file Lua 5.1-safe.
--
-- The Guild book is the larger, calmer window for the lists, the record of what happened, and the officers' tools (docs/ui-design.md, 5.2). Like the Loot
-- window, its screens are built here from the engine's state with no frames, so the game's window and the web simulator draw the same sections, the same
-- sentences and the same filters. Nothing here changes anything: a section's buttons run the same commands a player would type.
--
--   M.SECTIONS                            the navigation column, in order
--   M.History(ctx, filter)                the ledger as readable sentences, newest first, filtered (the Ledger section)
--   M.Detail(ctx, id)                     one entry as the raw record: kind, writer, time, id, chain and every field it carries
--   M.RaidNow(ctx)                        the open raid: how long, what has been handed out, what is held and for how long it can be traded
--   M.Stats(ctx, listId)                  who held which place for how long, wins and last win, by replaying the list with timestamps
--   M.Segments(text, people)              a sentence cut into plain words and people (a person carries their class color)
--   M.Ago(now, ts)                        "3 days ago"
--
-- The code is in ui/guildbook/: GuildBookPages (sections, Welcome copy), GuildBookHistory (the record in words), GuildBookStats (stats, attendance),
-- GuildBookRaid (the open raid) and GuildBookStage (staged list changes). This module merges what they export, so everything is GuildBook.<name>.
local _, SK = ...
local M
M = SK:NewModule("GuildBook", { "GuildBookPages", "GuildBookHistory", "GuildBookStats", "GuildBookRaid", "GuildBookStage" }, function(d)
    for _, part in ipairs({ d.GuildBookPages, d.GuildBookHistory, d.GuildBookStats, d.GuildBookRaid, d.GuildBookStage }) do
        for k, v in pairs(part) do
            if k ~= "name" then M[k] = v end
        end
    end
end)

return M
