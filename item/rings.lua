local parent = require("item.general.jewel")
local M = {}
local MoveItemAfterMove

-- UPDATE common SET com_script = 'item.rings' WHERE com_itemid IN (68, 277, 278, 279, 280, 281, 282);

local general_jewel = require("item.general.jewel")
local jewelbonus = require("content.jewelbonus")

function M.MoveItemAfterMove( User, SourceItem, TargetItem )
    --User:inform("in move");
    stoneNr,stoneStr=jewelbonus.getBonus(TargetItem);
    --User:inform("bla");
    if stoneNr>0 then                                                   -- obviously a gem was inserted!
        if ((TargetItem.itempos==7) or (TargetItem.itempos==8)) then    -- put on a finger
            jewelbonus.giveBonus(User,TargetItem);                                 -- now raise corresponding attribute(s) and start LTE
        elseif ((SourceItem.itempos==7) or (SourceItem.itempos==8)) then  -- taken off of a finger
            jewelbonus.takeBonus(User,SourceItem,stoneNr,stoneStr);                -- now lower corresponding attribute(s) and remove/change LTE
        end
        --User:inform("blubb");
    end
end

if M.UseItem == nil then M.UseItem = parent.UseItem end
if M.UseItemWithField == nil then M.UseItemWithField = parent.UseItemWithField end
if M.UseItemWithCharacter == nil then M.UseItemWithCharacter = parent.UseItemWithCharacter end
if M.LookAtItem == nil then M.LookAtItem = parent.LookAtItem end
if M.LookAtPaintingItem == nil then M.LookAtPaintingItem = parent.LookAtPaintingItem end
if M.MoveItemBeforeMove == nil then M.MoveItemBeforeMove = parent.MoveItemBeforeMove end
if M.MoveItemAfterMove == nil then M.MoveItemAfterMove = parent.MoveItemAfterMove end
if M.CharacterOnField == nil then M.CharacterOnField = parent.CharacterOnField end
if M.ItemRotsOnField == nil then M.ItemRotsOnField = parent.ItemRotsOnField end

return M
