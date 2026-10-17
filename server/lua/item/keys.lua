local M = {}

local base_keys = require("base.keys")
local common = require("base.common")

-- UPDATE common SET com_script='item.keys' WHERE com_itemid IN (2121,2122,2123,2124,2141,2144,2145,2161,2556,2558,3054,3055,3056);

function M.UseItem(User,SourceItem,TargetItem,counter,param)
    local DoorItem = TargetItem;
    if DoorItem.id == 0 then
        DoorItem = common.GetFrontItem( User );
    end;

    if DoorItem == nil then
        return;
    end

    if base_keys.CheckKey(SourceItem,DoorItem) then
        if base_keys.LockDoor(DoorItem) then
            common.InformNLS(User,"Du sperrst die Tür ab.","You lock the door.");
        elseif base_keys.UnlockDoor(DoorItem,User) then             -- User eingefuegt
            common.InformNLS(User,"Du sperrst die Tür auf.","You unlock the door.");
        end
    else
        common.InformNLS(User,"Der Schlüssel passt hier nicht.","The key doesn't fit here.");
    end
end

function M.LookAtItem(User, Item)
    local lang = User:getPlayerLanguage()
    local description = world:getItemName(Item.id, lang)
    local name = I18n.get("lock." .. Item.data .. ".name", lang == 0 and "de" or "en")
    if name and name ~= "" then
        description = description .. ' "' .. name .. '"'
    end
    world:itemInform(User, Item, (lang == 0 and "Du siehst " or "You see ") .. description)
end

function M.MoveItemBeforeMove(User, SourceItem, TargetItem)
    if ((TargetItem.data~=3001) and (TargetItem.data~=3002)) then
        return true;
    end

    if (User:get_race() == 1) then
        return true;
    end

    if User:isAdmin() then
        return true;
    end

    if (TargetItem:getType()~=3) then
        common.InformNLS(User,
        "Der Schlüssel rutscht dir seltsamer Weise aus der Hand.",
        "The key slips out of your hand for a strange reason.");
        return false;
    end
    return true;
end

function M.MoveItemAfterMove( User, SourceItem, TargetItem )
    return true;
end

return M
