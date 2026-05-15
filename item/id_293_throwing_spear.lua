local M = {}
local LookAtItem

-- UPDATE common SET com_script='item.id_293_throwing_spear' WHERE com_itemid IN (293);

local base_lookat = require("base.lookat")
function M.LookAtItem(User, Item)
	
	local customText = base_lookat.GetItemDescription(User,Item,2,false,false);
	if Item.data > 2^30 then
		world:itemInform( User, Item, customText );
	else
		world:itemInform( User, Item, User:getPlayerLanguage()==0 and
			"Du siehst "..world:getItemName(Item.id,0) or
			"You see "..world:getItemName(Item.id,1) );
	end
end

return M
