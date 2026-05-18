local class = require("base.class")

local M = {}

M.createEffect = class.class(function(creff, posi, gfxid)
    creff.pos=posi;
    creff.effectId=gfxid;
end);

function M.createEffect:execute()
    world:gfx(self.effectId, self.pos);
end

return M
