local M = {}

function M.LookAtItem(user, item)
    if user:isAdmin() then
        world:itemInform(user, item, "Give the crown! (Krone erscheint auf 370, 134, -10)")
    end
end

function M.UseItem(user)
    if not user:isAdmin() then return end
    for _, coordinate in ipairs({
        {370,134,-10}, {371,134,-10}, {369,134,-10}, {370,133,-10},
        {370,135,-10}, {371,131,-10}, {372,136,-10}, {366,134,-10}
    }) do
        world:gfx(7, position(coordinate[1], coordinate[2], coordinate[3]))
    end
    local center = position(370, 134, -10)
    for _, sound in ipairs({28, 4, 27, 9}) do world:makeSound(sound, center) end
    for _, coordinate in ipairs({{370,134,-10}, {371,134,-10}, {369,134,-10}, {370,133,-10}, {370,135,-10}}) do
        world:changeTile(55, position(coordinate[1], coordinate[2], coordinate[3]))
    end
    world:createItemFromId(3104, 1, center, true, 333, 0)
    world:createItemFromId(225, 1, center, true, 333, 666)
end

return M
