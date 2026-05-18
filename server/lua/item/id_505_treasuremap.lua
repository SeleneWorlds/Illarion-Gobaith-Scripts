local M = {}
local LookAtItem

local common = require("base.common")
local base_treasure = require("base.treasure")
-- UPDATE common SET com_script='item.id_505_treasuremap' WHERE com_itemid IN (505);

function M.LookAtItem(User, Item)

    local dir = base_treasure.getDirection( User, Item );
    local distance = base_treasure.getDistance (User, Item );
    local TreasureName = base_treasure.GetTreasureName( math.floor(Item.quality/100), User:getPlayerLanguage(), not dir );

    if not dir then
        world:itemInform( User, Item, common.GetNLS( User,
            "Du siehst eine Karte mit einer Markierung auf einer Position irgendwo in deiner unmittelbaren N�he. Du vermutest, dass es sich um "..TreasureName.." handelt.",
            "You see a map that shows a position somewhere really close to your current position. You think it could be "..TreasureName.."." ) );
    else
        world:itemInform( User, Item, common.GetNLS( User,
            "Du siehst eine Karte mit einer Markierung, die sich wahrscheinlich von dir aus gesehen "..distance.." im "..dir.." befindet. Du vermutest, dass es sich um "..TreasureName.." handelt.",
            "You see a map that shows a mark that is probably located somewhere "..distance.." in the "..dir.." of your current position. You believe the map leads to "..TreasureName.."." ) );
    end;

end;

return M
