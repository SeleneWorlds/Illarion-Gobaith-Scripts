local class = require("base.class")

local M = {}

M.sendMessage = class.class(function(sndMsg, posi, msg, rad)
    sndMsg.pos=posi;
    sndMsg.message=msg;
    sndMsg.radius=rad;
end);

function M.sendMessage:execute()
    plyList=world:getPlayerInRangeOf(self.pos, self.radius);
    for i, player in pairs(plyList) do
        player:inform(self.msg)
    end
end

return M
