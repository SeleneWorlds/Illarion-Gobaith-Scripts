local class = require("base.class")

local M = {}

M.setTile = class.class(function(settl, posi, tlId)
    settl.pos=posi;
    settl.tileId=tlId;
end);

function M.setTile:execute()
    world:changeTile(self.tlId, self.pos);
end

return M
