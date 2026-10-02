-- Location: -32 193 -8
-- Purpose: react on by mirror expandable ladder

local common = require("base.common")

local M = {}

function M.MoveToField( user )

    if( common.isItemIdInFieldStack( 35, position(-32, 193, -8) ) ) then
        user:warp( position( -31, 193, -7 ) );
    end;

end

return M
