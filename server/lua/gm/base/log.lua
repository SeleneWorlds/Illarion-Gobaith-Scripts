-- Log System von GM Actionen

local M = {}
local logging = require("selene.logging")

function M.Write(User, Text)
    if (Text~=nil and Text~="") then
        logging.info("[gm] "..Text);
    else
        User:inform("Error while generating log text");
    end
    return
end

return M
