local M = {}

local common = require("base.common")
local doors = require("base.doors")

-- UPDATE common SET com_script='item.doors' WHERE com_itemid IN (86, 87,927,317,476,477,478,479,499,900,901,902,484,485,924,923,668,669,660,661,684,685,664,665,670,666,671,667,662,686,663,687,715,714,712,713,497,922,925,926,480,481,482,483,903,904,905,906,486,487,496,920,656,657,648,649,652,653,644,645,658,654,659,655,650,646,651,647,711,710,708,709);

function M.UseItem(User,SourceItem,TargetItem,counter,param)
    if doors.CloseDoor(SourceItem) then
        common.InformNLS(User,"Du schließt die Tür","You close the door.");
    else
        local OpenDoor,OpenOK=doors.OpenDoor(SourceItem);
        if OpenOK then
            common.InformNLS(User,"Du öffnest die Tür.","You open the door.");
        elseif OpenDoor then
            common.InformNLS(User,"Du versuchst die Tür zu öffnen, doch sie ist verschlossen.","You try to open the door, but the door is locked.");
        end
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

return M
