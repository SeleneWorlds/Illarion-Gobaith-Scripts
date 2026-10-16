local Breath = require("gm.items.dragon_breath")
local M = {}

function M.LookAtItem(user, item)
    if not user:isAdmin() then return end
    world:itemInform(user, item, user:getPlayerLanguage() == Player.german and "Ring des Feuers" or "Ring of fire")
end

function M.UseItem(user)
    if user:isAdmin() and user:get_race() == 33 then Breath.perform(user, 9, 359) end
end

M.UseItemWithField = M.UseItem
return M
