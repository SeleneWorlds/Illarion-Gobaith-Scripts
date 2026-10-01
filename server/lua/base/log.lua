local M = {}
local logging = require("selene.logging")

function M.logToFile(theString)
    logging.info("[script] "..theString);
    return true;
end

return M
