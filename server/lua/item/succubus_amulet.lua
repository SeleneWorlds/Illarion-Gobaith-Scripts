local parent = require("item.id_222_amulett")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.LookAtItem(user, item)
    world:itemInform(user, item, common.GetNLS(user, "Du siehst ein verfluchtes Amulett des Sukkubus", "You see the cursed amulet of the Succubus"))
end

function M.MoveItemBeforeMove(user, sourceItem, targetItem)
    local found = user.effects:find(9)
    if found then
        common.InformNLS(user,
            "Der Einfluss des Daemons hindert dich daran das Amulett ab zu nehmen",
            "the power of the demon hinders you to remove the amulet")
        return false
    end
    return true
end

return M
