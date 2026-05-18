local M = {}
local LookAtItem

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.priest.cloth' WHERE com_itemid IN ();

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,3,false,true ));
end

return M
