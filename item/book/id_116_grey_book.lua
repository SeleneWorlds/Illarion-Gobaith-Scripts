local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local books_history = require("content.books.history")
local books_magestones = require("content.books.magestones")
-- UPDATE common SET com_script='item.book.id_116_grey_book' WHERE com_itemid = 116;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            books_history.loadBook(0);
            books_magestones.loadBook(1);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        books_history.loadTitle(0);
        books_magestones.loadTitle(1);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
