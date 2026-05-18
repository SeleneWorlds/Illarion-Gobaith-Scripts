-- Gras tiles are shown as snow tiles at winter. Copy the function of the snow
-- tiles during this time.

-- UPDATE tiles SET til_script='tile.id_11_gras' WHERE til_id = 11;
local snowTile = require("tile.id_10_snow")

local M = {}

function M.useTile(User,Position,counter,param)
	if (world:getTime("month") <= 13) then
		snowTile.useTile(User, Position, counter, param)
		return;
	end;
end

return M
