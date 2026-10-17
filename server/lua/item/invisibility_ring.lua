local parent = require("item.rings")
local M = setmetatable({}, { __index = parent })

local function isWorn(item)
    return item:getType() == scriptItem.inventory and (item.itempos == 7 or item.itempos == 8)
end

function M.MoveItemAfterMove(user, sourceItem, targetItem)
    parent.MoveItemAfterMove(user, sourceItem, targetItem)
    if isWorn(targetItem) then
        user.effects:addEffect(CLongTimeEffect(11, 10))
    elseif isWorn(sourceItem) then
        local left, right = user:getItemAt(7), user:getItemAt(8)
        if left.id ~= 3128 and right.id ~= 3128 then
            local found = user.effects:find(11)
            if found then user.effects:removeEffect(11) end
        end
    end
end

function M.UseItem(user, sourceItem, targetItem)
    if not targetItem then return end
    local fires = { [12]=true, [119]=true, [120]=true, [268]=true, [269]=true,
        [304]=true, [305]=true, [313]=true, [359]=true }
    if fires[targetItem.id] then
        user:inform("you can read on the ring: Ash nazg durbatuluk, Ash nazg gimbatul, Ash nazg thrakatuluk, Agh burzum-ishi krimpatul.")
    end
end

return M
