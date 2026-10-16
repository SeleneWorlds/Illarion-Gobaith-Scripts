local Breath = require("gm.items.dragon_breath")
local M = {}

function M.LookAtItem(user, item)
    if not user:isAdmin() then return end
    world:itemInform(user, item, user:getPlayerLanguage() == Player.german and "Ring des Eises" or "Ring of ice")
end

function M.UseItem(user)
    if user:isAdmin() and user:get_race() == 53 then Breath.perform(user, 4, 360) end
end

M.UseItemWithField = M.UseItem
return M
