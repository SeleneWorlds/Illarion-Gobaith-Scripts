-- Location: -29 195 -9
-- Purpose: react on by statue expandable ladder

local common = require("base.common")

module("triggerfield.aq001_statueladder", package.seeall)

function MoveToField( user )
    
    if( common.isItemIdInFieldStack( 35, position(-29, 195, -9) ) ) then
        user:warp( position( -30, 195, -8 ) );
        common.removeItemIdFromFieldStack( 35, position(-29, 195, -9) );
    end;
    
end