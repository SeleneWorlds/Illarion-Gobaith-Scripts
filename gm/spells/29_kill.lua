-- GM Rune 29 - Instant kill

local M = {}
local log = require("gm.base.log")

--[[
INSERT INTO spells VALUES (2^28,0,'gm.spells.29_kill');
INSERT INTO spells VALUES (2^28,1,'gm.spells.29_kill');
INSERT INTO spells VALUES (2^28,2,'gm.spells.29_kill');
INSERT INTO spells VALUES (2^28,3,'gm.spells.29_kill');
]]

function M.CastMagicOnCharacter(Caster, TargetCharacter, Counter, Param)
	TargetCharacter:increaseAttrib("hitpoints",-32767);
	log.Write(User, User.name .. "(" .. User.id .. ") killed " .. TargetCharacter.name .. "(" .. TargetCharacter.id .. ")");
end

return M
