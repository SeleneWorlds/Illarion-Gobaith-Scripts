dofile("base_class.lua")

local M = {}

M.spawnMonster = class(function(spwnMon, posi, monId)
    spwnMon.pos=posi;
    spwnMon.id=monId;
end);

function M.spawnMonster:execute()
    world:createMonster(self.id, self.pos, 100); 
end

return M
