local M = {}
local LookAtItem, UseItem

-- UPDATE common SET com_script='item.id_2830_chest' WHERE com_itemid=2830;

local common = require("base.common")
local base_treasure = require("base.treasure")
function M.LookAtItem(User, Item)
    local TreasureName = base_treasure.GetTreasureName( Item.data, User:getPlayerLanguage(), false );
    world:itemInform( User, Item, common.GetNLS( User,"Du siehst "..TreasureName..".","You see "..TreasureName.."." ) );
end

function M.UseItem(User,SourceItem)

    level=SourceItem.data;
    posi=SourceItem.pos;

    common.TempInformNLS(User, "Du �ffnest die Schatzkiste...", "You open the treasure chest...");
	world:erase(SourceItem,1);
	if SourceItem.data ~= 0 and SourceItem.data < 10 then
        world:gfx(16,posi);
        world:makeSound(13,posi);
        base_treasure.SpawnTreasure( level, posi );
	else	
        common.TempInformNLS(User, "...sie ist leer!", "...it is empty!");
    end

end

return M
