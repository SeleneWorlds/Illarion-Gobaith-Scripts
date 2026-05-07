local M = {}
local UseItem, LookAtItem

require("base.books")
require("druid.content.ruby")

-- UPDATE common SET com_script='item.book.id_107_brown_book' WHERE com_itemid = 107;

function M.UseItem(User, SourceItem, TargetItem, Counter, Param)
    if ( TargetItem.id == 266 ) or ( TargetItem.id == 267 ) then
        world:erase(SourceItem,1);
    else
        if base.books.InitBook() then
            druid.content.ruby.loadBook(1);
        end
    end
	base.books.SendBookPage(User,SourceItem.data,Counter);
end  -- function


function M.LookAtItem( User, Item )
	if base.books.InitTitle() then
    	druid.content.ruby.loadTitle(1);
    end
    base.books.GetBookItemInform(User,Item);
end

return M
