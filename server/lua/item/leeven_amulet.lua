local parent = require("item.id_222_amulett")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.LookAtItem(user, item)
    world:itemInform(user, item, common.GetNLS(user, "Du siehst Leeven's Amulett", "You see Leeven's amulet"))
end

function M.MoveItemBeforeMove(user, sourceItem, targetItem)
    if sourceItem:getType() == scriptItem.inventory and sourceItem.itempos == 2 then
        common.InformNLS(user, "Du kannst das Amulett nicht abnehmen.", "You cannot remove the amulet.")
        return false
    end
    return true
end

return M
