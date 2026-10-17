local M = {}

function M.data(destination)
    local coordinate = destination:getField("coordinate")
    return {
        x = coordinate.x, y = coordinate.y, z = coordinate.z,
        CustomName = destination:getField("name")
    }
end

return M
