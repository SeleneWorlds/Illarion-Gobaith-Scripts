local M = {}

-- I_92 Oel-Lampe

-- UPDATE common SET com_script='item.id_92_oillamp' WHERE com_itemid=92;

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    x=math.random(99);
    if x < 6 then
        common.InformNLS(User,"Du bist nicht sicher, aber es scheint als würde die Lampe etwas leuchten","You are not sure, but it seems the lamp starts to glow a little.");
    elseif x < 16 then
        common.InformNLS(User,"Du glaubst zu fühlen, dass die Lampe wärmer wird","You think the lamp gets warmer!");
    else
        common.InformNLS(User,"Du reibst an der Lampe, doch nichts passiert.","You rub the lamp but nothing happens.");
    end
end

return M
