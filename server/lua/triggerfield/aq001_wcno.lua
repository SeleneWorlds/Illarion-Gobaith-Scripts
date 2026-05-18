-- Location: 33 185 -12
-- Purpose: switch for secret passage to well

local common = require("base.common")

module("triggerfield.aq001_wcno", package.seeall)

function MoveToField( user )

    user:inform("*click*");
    if( world:isCharacterOnField(position( 33, 195, -12)) ) then
        common.removeItemIdFromFieldStack( 287, position( 28, 190, -12) );
    end;

end


function MoveFromField( user )

    user:inform("*clack*");
    if( not common.isItemIdInFieldStack( 287, position( 28, 190, -12) ) ) then
        world:createItemFromId( 287, 1, position( 28, 190, -12), true, 333,0 );
    end;

end
