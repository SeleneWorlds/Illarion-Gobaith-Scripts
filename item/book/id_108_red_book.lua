local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local content_amethyst = require("druid.content.amethyst")
-- UPDATE common SET com_script='item.book.id_108_red_book' WHERE com_itemid = 108;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            content_amethyst.loadBook(1);
        end
    end
    base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
    if base_books.InitTitle() then
        content_amethyst.loadTitle(1);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
