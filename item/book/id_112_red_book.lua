local M = {}
local UseItem, LookAtItem

require("base.books")
require("content.books.dyer")

-- UPDATE common SET com_script='item.book.id_112_red_book' WHERE com_itemid = 112;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base.books.InitBook() then
            content.books.dyer.loadBook(0);
        end
    end
    base.books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base.books.InitTitle() then
        content.books.dyer.loadTitle(0);
    end
    base.books.GetBookItemInform(User,Item);
end

return M
