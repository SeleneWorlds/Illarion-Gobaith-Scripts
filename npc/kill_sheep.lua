local M = {}
npc = npc or {}
npc.kill_sheep = M
local _ENV = setmetatable(M, { __index = _G })

-- Skript f&uuml;r das Schlachten eines Schafes
function M.onDeath(monster)

        pos = monster.pos;
        --world:createMonster(1,pos,10);
        world:createItemFromId(173,1,pos,true,333,0)
end

return M
