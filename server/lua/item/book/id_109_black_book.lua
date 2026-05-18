local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local content_druids = require("druid.content.druids")
-- UPDATE common SET com_script='item.book.id_109_black_book' WHERE com_itemid = 109;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            druid.content.druid.loadBook(0);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        druid.content.druid.loadTitle(0);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
