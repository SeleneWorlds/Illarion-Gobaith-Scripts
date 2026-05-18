local M = {}
local LookAtItem

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.general.cloth' WHERE com_itemid IN (34,48,53,55,180,181,182,183,193,195,196,326,356,357,358,362,363,364,365,366,367,368,369,370,371,385,457,458,459,460,461,547,548,558,2295,2377,2378,2380,2384,2416,2418,2419,2420,2421);

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,3,false,false ));
end;

return M
