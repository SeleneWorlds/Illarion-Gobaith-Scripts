local M = {}
local UseItem

-- Holz Aufstapeln

-- UPDATE common SET com_script='item.woodlogs' WHERE com_itemid IN (3,543,544,2560);

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    if (SourceItem:getType()~=3) then
        common.InformNLS( User,
        "Wenn du dich nicht selbst abfackeln willst, solltest du das Holz auf den Boden legen.",
        "If you don't want to burn down yourself, you should put the wood on the ground.");
        return
    end

    if (User:countItemAt( "body", 74 )==0) then
        common.InformNLS( User,
        "Du brauchst ein Beil zum Holz spalten.",
        "You need a hatchet for cutting wood.");
        return
    end

    if not common.IsLookingAt(User,SourceItem.pos) then
        common.TurnTo( User, SourceItem.pos ); -- Drehen wenn n�tig
    end

    -- Edit by abcfantasy: Unable to light fire if raining or snowing

    -- check wether user is under roof
    local potentialRoofPos=position(SourceItem.pos.x, SourceItem.pos.y, SourceItem.pos.z+1);
    local potRoof=world:getField(potentialRoofPos);

    local curWeather = world.weather;
    if ( ( ( curWeather.percipitation_type == 1 ) or ( curWeather.percipitation_type == 2 ) ) and ( curWeather.percipitation_strength > 20 ) and
       ( User.pos.z >= 0 ) and ( potRoof == nil ) ) then
        common.InformNLS( User, "Wegen dem Wetter w�rst du nicht der Lage, ein Feuer zu machen.", "You wouldn't be able to light a fire in this weather." );
        return
    end

    if (SourceItem.number == 1) then
        world:swap(SourceItem,298,333);
    else
        common.InformNLS( User,
        "Du kannst immer nur einen Stapel Holz aufschlichten.",
        "You can only pile up one pile of wood.");
    end
end -- function UseItem()

return M
