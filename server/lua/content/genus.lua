local Registries = require("selene.registries")

local M = {}
local genders = { male = 0, female = 1, neuter = 2 }

-- Keep the numeric interface used by look-at text and custom gender overrides.
function M.GenusData(ItemID)
    local item = Registries.findByMetadata("illarion:items", "id", ItemID)
    return item and genders[item:getField("genus")] or 1
end

return M
