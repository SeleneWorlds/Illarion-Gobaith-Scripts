local Registries = require("selene.registries")
local M = {}

function M.cookie(User)
    local fortunes = {}
    for _, entry in pairs(Registries.findAll("illarion:fortune_cookies")) do
        fortunes[#fortunes + 1] = entry
    end
    assert(#fortunes > 0, "No fortune cookie messages registered")
    table.sort(fortunes, function(a, b) return a:getName() < b:getName() end)
    local fortune = fortunes[math.random(1, #fortunes)]
    return fortune:getField("de"), fortune:getField("en")
end

return M
