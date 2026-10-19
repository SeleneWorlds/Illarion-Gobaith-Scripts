local Registries = require("selene.registries")
local M = {}

local function getBooks(item)
    local books = {}
    for name in item:getData("books"):gmatch("%S+") do
        local book = Registries.findByName("illarion:books", name)
        if book then books[#books + 1] = book end
    end
    return books
end

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    local books = getBooks(SourceItem)
    if #books == 0 then return end

    if Param == 0 then
        local menu = MenuStruct()
        for _, book in ipairs(books) do
            menu:addItem(book:getField("itemId"), 333, book:getField("variant"))
        end
        User:sendMenu(menu)
    else
        if M.DistanceFromPosToPos(SourceItem.pos, User.pos) > 1 then return end
        local bookPos = M.getFreePosition(User, SourceItem)
        for _, book in ipairs(books) do
            if book:getField("itemId") == Param then
                world:createItemFromId(Param, 1, bookPos, true, 333, book:getField("variant"))
                return
            end
        end
    end
end

function M.getFreePosition( User, BS )

   if BS.id == 266 then
      return position( User.pos.x + 1, User.pos.y, User.pos.z );
   else
      return position( User.pos.x, User.pos.y + 1, User.pos.z );
   end;
end

function M.DistanceFromPosToPos(TargetA,TargetB)
    local LengthX=math.sqrt(math.pow(TargetA.x-TargetB.x,2));
    local LengthY=math.sqrt(math.pow(TargetA.y-TargetB.y,2));
    return math.ceil(math.sqrt(math.pow(LengthX,2)+math.pow(LengthY,2)))
end

function M.LookAtItem(User, Item)
    local books = getBooks(Item)
    local german = User:getPlayerLanguage() == 0
    if #books > 0 then
        local descriptions = {}
        for _, book in ipairs(books) do
            descriptions[#descriptions + 1] = book:getField(german and "de" or "en")
        end
        User:inform((german and "Du siehst verschiedene Bücher: " or "There are books: ") .. table.concat(descriptions, ", "))
        return
    end
    if german then
        world:itemInform(User, Item, "Du siehst " .. world:getItemName(Item.id, 0))
    else
        world:itemInform(User, Item, "You see " .. world:getItemName(Item.id, 1))
    end
end

return M
