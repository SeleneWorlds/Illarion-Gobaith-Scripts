local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local content_emerald = require("druid.content.emerald")
-- UPDATE common SET com_script='item.book.id_115_green_book' WHERE com_itemid = 115;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            content_emerald.loadBook(1);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        content_emerald.loadTitle(1);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
