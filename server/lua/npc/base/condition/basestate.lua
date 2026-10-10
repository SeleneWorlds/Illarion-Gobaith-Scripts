--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
local class = require("base.class").class
local condition = require("npc.base.condition.condition")

local _basestate_helper_equal

local basestate = class(condition,
function(self, value)
    condition:init(self)
    if (value == "busy") then
        self["value"] = "stateBusyTalking"
    elseif (value == "idle") then
        self["value"] = "stateNormal"
    else
        self["value"] = "invalidState"
    end
    self["check"] = _basestate_helper_equal
end)

function _basestate_helper_equal(self, npcChar, texttype, player)
    local root = self.npc._parent
    local expected = root[self.value]
    return expected ~= nil and root.state == expected
end

return basestate