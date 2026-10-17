local common = require("base.common")
local M = {}

function M.LookAtItemIdent(User, Item)
    local name = Item:getData("CustomName")
    local perception = tonumber(Item:getData("perception")) or 0
    if type(name) == "string" and name ~= "" and User:increaseAttrib("perception", 0) >= perception then
        local nameDe = Item:getData("CustomNameDe")
        if type(nameDe) ~= "string" or nameDe == "" then nameDe = name end
        local text = common.GetNLS(User, nameDe, name)
        world:itemInform(User, Item, (text:gsub("currentChar", function() return User.name end)))
    else
        world:itemInform(User, Item, common.GetNLS(User, "Du siehst ", "You see ") .. world:getItemName(Item.id, User:getPlayerLanguage()))
    end
end

M.LookAtItem = M.LookAtItemIdent
return M
