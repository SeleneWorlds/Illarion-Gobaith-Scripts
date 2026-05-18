-- GM Rune 31 /1073741824 /
local M = {}
local log = require("gm.base.log")

--[[
INSERT INTO spells VALUES (2^30,0,'gm.spells.31_runes');
INSERT INTO spells VALUES (2^30,1,'gm.spells.31_runes');
INSERT INTO spells VALUES (2^30,2,'gm.spells.31_runes');
INSERT INTO spells VALUES (2^30,3,'gm.spells.31_runes');
]]

function M.CastMagic(User,Counter,Param)
    local magictype = User:getMagicType()
    for i = 1,32 do
        User:teachMagic(magictype,i-1)
    end;
    log.Write(User, User.name .. "(" .. User.id .. ") gave himself all runes.");
end

return M
