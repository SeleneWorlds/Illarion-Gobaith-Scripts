local M = {}
local CheckStone, WriteStone, LookAtItem

-- UPDATE common SET com_script='item.id_1272_markerstone' WHERE com_itemid IN (1272);

local common = require("base.common")

function M.CheckStone(Char,StoneNumber)
    retVal=false;
    StoneBase=math.floor((StoneNumber-1)/32);  -- Stone 0 to 31 -> 0, 32-.. ->2 etc.
    StoneBaseOffset=(StoneNumber-1 % 32);  -- StoneNr inside range
    HasStones=Char:getQuestProgress(10+StoneBase);
    GotStone=LuaAnd(2^(StoneNumber-1),HasStones);
    if GotStone>0 then
        retVal=true;
    end
    return retVal;
end

function M.WriteStone(Char,StoneNumber)
    StoneBase=math.floor(StoneNumber/32);  -- Stone 0 to 31 -> 0, 32-.. ->2 etc.
    StoneBaseOffset=(StoneNumber % 32);  -- StoneNr inside range
    --Char:inform("Base offset: " .. StoneBase .. " Stone Nr "..StoneBaseOffset .. " for stone "..StoneNumber);
    currentStones=Char:getQuestProgress(1001+StoneBase);
    Char:setQuestProgress(1001+StoneBase,LuaOr(2^StoneBaseOffset,currentStones));
end

function M.LookAtItem(User,Item)
    if (Item.data~=0) then
        DisplayText = common.GetNLS( User, "Ein Markierungsstein der Abenteurer Gilde; er tr�gt die Nummer "..Item.data,"A marker stone of the Explorers Guild; it has the number "..Item.data);
        WriteStone(User,Item.data, Item.quality);
    else
        DisplayText = common.GetNLS( User, "Stein", "stone");
    end
    world:itemInform(User,Item, DisplayText );
end

return M
