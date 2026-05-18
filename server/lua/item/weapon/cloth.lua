local M = {}
local LookAtItem

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.weapon.cloth' WHERE com_itemid IN (89);

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,3,true,false));
end

return M
