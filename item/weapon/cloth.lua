local M = {}
local LookAtItem

require("base.lookat")

-- UPDATE common SET com_script='item.weapon.cloth' WHERE com_itemid IN (89);

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base.lookat.GetItemDescription(User,Item,3,true,false));
end

return M
