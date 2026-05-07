local M = {}
local LookAtItem

require("base.lookat")

-- UPDATE common SET com_script='item.weapon.jewel' WHERE com_itemid IN ();

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base.lookat.GetItemDescription(User,Item,4,true,false ));
end

return M
