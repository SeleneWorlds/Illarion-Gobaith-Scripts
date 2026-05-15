local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local books_cakebible = require("content.books.cakebible")
local books_dwarfpoems = require("content.books.dwarfpoems")
local books_culturegoblins = require("content.books.culturegoblins")
-- UPDATE common SET com_script='item.book.id_2598_blue_book' WHERE com_itemid = 2598;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            books_cakebible.loadBook(0);
            books_dwarfpoems.loadBook(1);
            books_culturegoblins.loadBook(2);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        books_cakebible.loadTitle(0);
        books_dwarfpoems.loadTitle(1);
        books_culturegoblins.loadTitle(2);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
