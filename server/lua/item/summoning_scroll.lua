local M = {}
local common = require("base.common")
local creatures = { [101]=true, [111]=true, [171]=true, [211]=true, [231]=true }

function M.isCreature(id)
    return creatures[id] == true
end

function M.LookAtItem(user, item)
    common.InformNLS(user, "Die Pergamentrolle ist mit einem blutroten Siegel verschlossen.",
        "The scroll is sealed with a bloody red seal.")
end

function M.UseItem(user, item)
    if not M.isCreature(item.data) then return end
    local offsets = { [0]={0,-1}, [2]={1,0}, [4]={0,1}, [6]={-1,0} }
    local offset = offsets[user:get_face_to()]
    if not offset then return end
    local target = position(user.pos.x + offset[1], user.pos.y + offset[2], user.pos.z)
    if world:isCharacterOnField(target) then
        target = position(target.x - 1, target.y + 1, target.z)
    end
    world:createMonster(item.data, target, 10)
    world:gfx(8, target)
    world:makeSound(1, target)
    world:erase(item, 1)
end

return M
