local M = {}

-- data values in use: 101, 102, 103, 700, 10000

local base_lookat = require("base.lookat")
local common = require("base.common")
local jewelbonus = require("content.jewelbonus")

function M.LookAtItem(User,Item)

    --------------------------------- SPIELERRINGE [ Data 100 - 500 ] --------------------------------------------------------------------------------
    if ( Item.data == 101) then -- Trauring von Roveig
        if (User:getPlayerLanguage()==0) then
            world:itemInform(User,Item,"Du siehst einen goldenen Trauring mit der Gravur: Katarine und Roveig, 7.Tag des Eldas im 23.Jahr")
        else
            world:itemInform(User,Item,"You see a golden wedding ring with the gravure: Katarine and Roveig, 7.Day of Eldas in the 23.Year")
        end
    elseif ( Item.data == 102) then -- Trauring von Katarine
        if (User:getPlayerLanguage()==0) then
            world:itemInform(User,Item,"Du siehst einen goldenen Trauring mit der Gravur: Roveig und Katarine, 7.Tag des Eldas im 23.Jahr")
        else
            world:itemInform(User,Item,"You see a golden wedding ring with the gravure: Roveig and Katarine, 7.Day of Eldas in the 23.Year")
        end
	elseif ( Item.data == 103) then -- Dajmaél's Ring
        if (User:getPlayerLanguage()==0) then
            world:itemInform(User,Item,"Du siehst einen goldenen Ring mit der Gravur: Dajmaél und Nordwind")
        else
            world:itemInform(User,Item,"You see a golden ring with the gravure: Dajmaél and Northwind")
        end

        -------------------------------- QUESTRINGE [ Data > 500 ] ------------------------------------------------------------------------------------
    elseif ( Item.data == 10000) then
        if (User:getPlayerLanguage()==0) then
            world:itemInform(User,Item,"Du siehst einen auffälligen Ring.");
        else
            world:itemInform(User,Item,"You see a peculiar dagger.");
        end
    else
        world:itemInform(User,Item,base_lookat.GetItemDescription(User,Item,4,false,false ));
    end
end

function M.MoveItemAfterMove( User, SourceItem, TargetItem )
    --anlegen des einen rings
    stoneNr,stoneStr=jewelbonus.getBonus(TargetItem);
    if stoneNr>0 then                                                   -- obviously a gem was inserted!
        if ((TargetItem.itempos==7) or (TargetItem.itempos==8)) then    -- put on a finger
            jewelbonus.giveBonus(User,TargetItem);                      -- now raise corresponding attribute(s) and start LTE
        elseif ((SourceItem.itempos==7) or (SourceItem.itempos==8)) then  -- taken off of a finger
            jewelbonus.takeBonus(User,SourceItem,stoneNr,stoneStr);     -- now lower corresponding attribute(s) and remove/change LTE
        end
    end
end

    function M.MoveItemBeforeMove( Character, SourceItem, TargetItem)
        if ( SourceItem.data == 700 ) then
            if ( (TargetItem.itempos == 7) or (TargetItem.itempos == 8) ) then -- Wenn versucht wird den Ring anzulegen.
                if ( Character.id == 489898022) then
                    return true;
                else
                    common.InformNLS( Character,"Ein warnendes Kribbeln durchströhmt deinen Arm als du den Ring berührst. Du willst ihn lieber nicht anlegen.","A warning prickle travels through your arm as you touch the ring. You seems, it is better to let them lay.");
                    return false;
                end
            end
        end
        return true;
    end

return M
