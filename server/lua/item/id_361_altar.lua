local gods = require("content.gods")
local M = {}

function M.LookAtItem(user, item)
    local german = user:getPlayerLanguage() == 0
    local names = german and gods.GOD_DE or gods.GOD_EN
    local deity = names[item.data]
    local description
    if item.data > 0 and deity then
        description = "Altar " .. deity
        if user:get_race() == 5 then
            description = description:gsub("Tanora", "Zshhel-pheey-arrr")
        end
    else
        description = german and "Ungeweihter Altar" or "Undedicated altar"
    end
    world:itemInform(user, item, description)
end

return M
