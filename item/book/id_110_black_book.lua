local M = {}
local UseItem, LookAtItem

-- BIG THIN BLACK BOOK

local base_books = require("base.books")
local books_guidingtruths = require("content.books.guidingtruths")
-- UPDATE common SET com_script='item.book.id_110_black_book' WHERE com_itemid = 110;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            books_guidingtruths.loadBook(0);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        books_guidingtruths.loadTitle(0);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
