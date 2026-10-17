local M = {}

local base_lookat = require("base.lookat")
-- UPDATE common SET com_script='item.weapon.metal' WHERE com_itemid IN (25,27,77,78,88,91,188,189,190,204,205,206,226,230,231,283,2626,2627,2629,2635,2636,2642,2645,2654,2655,2656,2658,2660,2662,2668,2671,2672,2675,2689,2693,2694,2701,2704,2705,2723,2725,2731,2737,2740,2742,2757,2775,2777,2778,2788);

function M.LookAtItem(User,Item)
    world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,1,true,false ));
end

return M
