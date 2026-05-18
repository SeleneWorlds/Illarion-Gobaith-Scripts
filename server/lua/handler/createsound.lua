local class = require("base.class")

local M = {}

M.createSound = class.class(function(crsnd, posi, sndid)
    crsnd.pos=posi;
    crsnd.soundId=sndid;
end);

function M.createSound:execute()
    world:makeSound(self.soundId, self.pos);
end

return M
