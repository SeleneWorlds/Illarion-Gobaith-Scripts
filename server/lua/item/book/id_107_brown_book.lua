local M = {}
local UseItem, LookAtItem

local base_books = require("base.books")
local content_ruby = require("druid.content.ruby")
-- UPDATE common SET com_script='item.book.id_107_brown_book' WHERE com_itemid = 107;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base_books.InitBook() then
            content_ruby.loadBook(1);
        end
    end
	base_books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
	if base_books.InitTitle() then
    	content_ruby.loadTitle(1);
    end
    base_books.GetBookItemInform(User,Item);
end

return M
