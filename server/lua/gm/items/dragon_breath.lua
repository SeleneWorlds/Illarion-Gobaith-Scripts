local M = {}

local function rotate(shape)
    local result = {}
    for i = 1, 5 do
        result[i] = { shape[5][i], shape[4][i], shape[3][i], shape[2][i], shape[1][i] }
    end
    return result
end

function M.perform(user, gfxId, itemId)
    local direction = user:get_face_to()
    if direction ~= Character.north and direction ~= Character.east
        and direction ~= Character.south and direction ~= Character.west then return end
    local shape = {
        {true,true,true,true,true}, {false,true,true,true,false},
        {false,true,true,true,false}, {false,false,true,false,false},
        {false,false,true,false,false}
    }
    local rotations = ({ [Character.north]=0, [Character.east]=1, [Character.south]=2, [Character.west]=3 })[direction]
    for _ = 1, rotations do shape = rotate(shape) end
    for i = 1, 5 do
        for k = 1, 5 do
            if shape[i][k] then
                local x, y
                if direction == Character.north then x, y = user.pos.x-3+k, user.pos.y-7+i
                elseif direction == Character.east then x, y = user.pos.x+k, user.pos.y-3+i
                elseif direction == Character.south then x, y = user.pos.x-3+k, user.pos.y+i
                else x, y = user.pos.x-7+k, user.pos.y-3+i end
                local coordinate = position(x, y, user.pos.z)
                world:gfx(gfxId, coordinate)
                if math.random(1, 5) == 1 then
                    world:createItemFromId(itemId, 1, coordinate, true, math.random(200, 600), 0)
                    world:makeSound(5, coordinate)
                end
                if world:isCharacterOnField(coordinate) then
                    world:getCharacterOnField(coordinate):increaseAttrib("hitpoints", -2000)
                end
            end
        end
    end
end

return M
