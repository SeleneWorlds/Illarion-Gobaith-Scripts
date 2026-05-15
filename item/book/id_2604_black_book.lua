local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local books_about_humans = require("content.books.about_humans")
local books_cultureorcs = require("content.books.cultureorcs")
local books_founding_silverbrand = require("content.books.founding_silverbrand")
-- UPDATE common SET com_script='item.book.id_2604_black_book' WHERE com_itemid = 2604;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            books_cultureorcs.loadBook(0);
            books_founding_silverbrand.loadBook(1);
            books_about_humans.loadBook(2);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        books_cultureorcs.loadTitle(0);
        books_founding_silverbrand.loadTitle(1);
        books_about_humans.loadTitle(2);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
