local regeneration = require("lte.chr_reg")
local M = {}

function M.playerDeath(player)
    regeneration.showResurrectionDirections(player);
end

return M
