local M = {}
local UseItem

-- General Testscript

-- UPDATE common SET com_script='item.id_2_flour' WHERE com_itemid IN (2);

require "bla.blubb"

function M.UseItem( User, SourceItem, TargetItem, counter, Param, ltstate )
    User:inform("package.cpath: "..package.cpath);
    User:inform("package.path: "..package.path);
    bla.blubb.Success(User);
end

return M
