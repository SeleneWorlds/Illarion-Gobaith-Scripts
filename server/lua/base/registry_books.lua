local Registries = require("selene.registries")
local Books = require("illarion-script-loader.server.lua.lib.books")
local books = require("base.books")
local M = {}

local function findBook(item)
    return Registries.findByName("illarion:books", "illarion:book_" .. item.id .. "_" .. item.data)
end

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if TargetItem.id == 266 or TargetItem.id == 267 then
        world:erase(SourceItem, 1)
        return
    end

    local book = findBook(SourceItem)
    if not book then
        Books.show(User, " ")
        return
    end

    local sections = book:getField(User:getPlayerLanguage() == 0 and "pagesDe" or "pagesEn")
    local pages = {}
    for _, section in ipairs(sections) do
        books.AddToTable(pages, section.text, section.image, section.difficulty)
    end
    if #pages == 0 then
        Books.show(User, " ")
        return
    end
    Books.open(User, #pages, function(pageNumber)
        local page = pages[pageNumber]
        local text = books.ModifyText(User, page[1], page[3], book:getField("language"))
        User:learn(4, "library research", 2, 100)
        return { text = text, itemId = page[2] or 0 }
    end)
end

function M.LookAtItem(User, Item)
    local book = findBook(Item)
    local german = User:getPlayerLanguage() == 0
    local description = book and book:getField(german and "de" or "en")
        or world:getItemName(Item.id, german and 0 or 1)
    world:itemInform(User, Item, description)
end

return M
