local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local books_dyer = require("content.books.dyer")
-- UPDATE common SET com_script='item.book.id_112_red_book' WHERE com_itemid = 112;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            books_dyer.loadBook(0);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        books_dyer.loadTitle(0);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
