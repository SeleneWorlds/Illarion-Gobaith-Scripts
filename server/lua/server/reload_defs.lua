-- called after every !rd command and !fr command
-- note that !rd is a !fr without npc and spawn reloading
-- note further that reload_tables will be called after this if and only if the !rd was successful and the !rd was issued by a !fr

local signpost = require("content.signpost")
local M = {}

local InitWegweiser = signpost.InitWegweiser

function M.onReload()
    InitWegweiser();
    return true;
end

return M