local M = {}

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.general.jewel' WHERE com_itemid IN (225, 1840, 1858);

function M.LookAtItem(User,Item)
    local desc = base_lookat.GetItemDescription(User,Item,4,false,false );
    world:itemInform(User,Item,desc);
end

return M
