local common = require("base.common")
local M = {}

function M.onOpenDepot( User, Depot )
    if ( ( Depot.quality == 1111 ) and not ( Depot.data == User.id ) ) then
        common.InformNLS(User,
        "Ihr schafft es nicht diese Kiste zu �ffnen.",
        "You fail to open this depot.");
        return false;
    end
    return true;
end 

return M
