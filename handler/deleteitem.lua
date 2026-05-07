local class = require("base.class")

local M = {}

M.deleteItem = class.class(function(delitem, posi, delID)
    delitem.pos=posi;
    delitem.deleteItemId=delID;
end);

function M.deleteItem:execute()
    if (world:isItemOnField(self.pos)==true) then
        item=world:getItemOnField(self.pos);
        if (item.id==self.deleteItemId or self.deleteItemId==0) then
            world:erase(item,1);
            return 1;
        else
            return -2;
        end
    else
        return -1;
    end
end

return M
