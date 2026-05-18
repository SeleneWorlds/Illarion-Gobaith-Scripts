local class = require("base.class")

local M = {}

M.moveLever = class.class(function(mvLev, lev)
    mvLev.lever=lev;
end);

function M.moveLever:execute()
    self.lever:switchLever(nil);
end

return M
