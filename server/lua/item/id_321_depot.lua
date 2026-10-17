local I18n = require("selene.i18n")

local M = {}

-- Depots

-- UPDATE common SET com_script='item.id_321_depot' WHERE com_itemid=321;

function M.LookAtItem(User, Item)
    local lang = User:getPlayerLanguage()
    local locale = lang == 0 and "de" or "en"
    local name = I18n.get("depot." .. Item.data .. ".name", locale)
    if not name then
        local owner = getCharForId(Item.data)
        name = owner and owner.name or I18n.get("depot.unknown", locale)
    end
    world:itemInform(User, Item, world:getItemName(321, lang) .. " (" .. name .. ")")
end

return M
