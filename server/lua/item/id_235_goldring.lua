local M = {}
local base_lookat = require("base.lookat")
local jewelbonus = require("content.jewelbonus")

function M.LookAtItem(user, item)
    world:itemInform(user, item, base_lookat.GetItemDescription(user, item, 4, false, false))
end

function M.MoveItemAfterMove( User, SourceItem, TargetItem )
    local stoneNr,stoneStr=jewelbonus.getBonus(TargetItem);
    if stoneNr>0 then                                                   -- obviously a gem was inserted!
        if ((TargetItem.itempos==7) or (TargetItem.itempos==8)) then    -- put on a finger
            jewelbonus.giveBonus(User,TargetItem);                      -- now raise corresponding attribute(s) and start LTE
        elseif ((SourceItem.itempos==7) or (SourceItem.itempos==8)) then  -- taken off of a finger
            jewelbonus.takeBonus(User,SourceItem,stoneNr,stoneStr);     -- now lower corresponding attribute(s) and remove/change LTE
        end
    end
end

return M
