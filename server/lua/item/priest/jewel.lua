local M = {}
local LookAtItem

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.priest.jewel' WHERE com_itemid IN (62,67,71,82,83,334,463,465);

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,4,false,true ));
end

return M
