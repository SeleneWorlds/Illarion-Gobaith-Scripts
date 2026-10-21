local parent = require("item.id_222_amulett")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.LookAtItem(user, item)
    world:itemInform(user, item, common.GetNLS(user, "sternförmiges Amulett in dessen Mitte eine stilisierte Eisflamme eingelassen ist, die sich um eine ebenso stilisierte Feuerflamme windet.", "star-shaped amulet with a stylized iceflame in the middle, which twines about an equal stylized fireflame."))
end

return M
