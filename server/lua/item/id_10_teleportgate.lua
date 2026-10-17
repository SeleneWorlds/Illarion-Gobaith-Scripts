local M = {}

-- teleporter gate
-- Nop

-- UPDATE common SET com_script='item.id_10_teleportgate' WHERE com_itemid = 10;

local common = require("base.common")

function M.CharacterOnField( User )
	if (User:get_type() ~= 0) then
        return
    end

    local SourceItem = world:getItemOnField( User.pos );

    if( SourceItem.id == 10 ) then
        local x = tonumber(SourceItem:getData("x"))
        local y = tonumber(SourceItem:getData("y"))
        local z = tonumber(SourceItem:getData("z"))

        --Vanima Magic Trap
        vanTrap = false;
        if (SourceItem.quality == 6) and (User:getQuestProgress(6) == 1) then
            vanTrap = true;
        end;

        if x ~= nil and y ~= nil and z ~= nil then
            local dest = position(x, y, z);
            if vanTrap then
                dest = position(405,207,0);
            end;

			-- Quest Special
            allOK = true;
            if (allOK) then

                if not (User:isAdmin()) then
                    -- check for newbie state
                    local newbieState = User:getQuestProgress(2);

                    if 0 < newbieState then
                        if  ( (newbieState == 100) and (User.effects:find(13)) )then
                                User.effects:removeEffect(13);
                        end
                    end
                end

				world:makeSound( 4, dest )
                --world:gfx( 41, dest )
                world:gfx( 41, User.pos )
                User:warp( dest );
                world:gfx( 41, User.pos )

                common.InformNLS( User,
                "Du machst eine magische Reise.",
                "You travel by the realm of magic." );
                if (vanTrap) then
                    common.InformNLS( User,
                    "Eine Stimme schallt: IHR WURDET GEWARNT NICHT UNGEBETEN IN UNSER LAND EINZUDRINGEN...WILLKOMMEN IN VANIMA",
                    "A voice booms: YOU HAVE BEEN WARNED NOT TO ENTER OUR LANDS UNINVITED...WELCOME TO VANIMA" );
                end;

                if ( SourceItem.wear ~= 255 ) then
                    if ( SourceItem.quality < 900 ) then
                        if ( SourceItem.quality > 200 ) then
                            SourceItem.quality = SourceItem.quality - 100;
                            world:changeItem( SourceItem );
                        else
                            world:erase( SourceItem, SourceItem.number );
                        end
                    end
                end
            end
        end
    else
        common.InformNLS( User,
        "Ein Gegenstand stört die Magie des Portals.",
        "Some item disturbs the magic of the portal." );
    end
end


function M.LookAtItem(User, Item)
    local name = Item:getData("CustomName")
    local text = common.GetNLS(User, "Magisches Portal", "Magical gate")
    if type(name) == "string" and name ~= "" then
        text = common.GetNLS(User, "Magisches Portal nach ", "Magical gate to ") .. name
    end
    world:itemInform(User, Item, text)
end

return M
