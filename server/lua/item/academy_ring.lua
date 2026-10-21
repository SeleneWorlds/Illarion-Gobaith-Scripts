local parent = require("item.rings")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.LookAtItem(user, item)
    world:itemInform(user, item, common.GetNLS(user,
        "Ring mit dem Wappen der magischen Akademie Gobaiths.",
        "Ring with the emblem of the magical academy Gobaith."))
end

function M.MoveItemBeforeMove(user, sourceItem, targetItem)
    if targetItem:getType() ~= scriptItem.inventory
        or (targetItem.itempos ~= 7 and targetItem.itempos ~= 8) then return true end
    local attributes = user:increaseAttrib("essence", 0)
        + user:increaseAttrib("willpower", 0) + user:increaseAttrib("intelligence", 0)
    if attributes > 29 then return true end
    common.InformNLS(user,
        "Ein warnendes Kribbeln durchströhmt deinen Arm als du den Ring berührst. Du willst ihn lieber nicht anlegen.",
        "A warning prickle travels through your arm as you touch the ring. You seems, it is better to let them lay.")
    return false
end

return M
