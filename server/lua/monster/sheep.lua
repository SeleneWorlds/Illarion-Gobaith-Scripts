local parent = require("monster.mon_29_animals")
local common = require("base.common")
local scissors = require("item.id_6_scissors")
local M = setmetatable({}, { __index = parent })

function M.useMonster(User, TargetPos, ltstate)
    if not world:isCharacterOnField(TargetPos) then
        return
    end
    local animal = world:getCharacterOnField(TargetPos)

    local tool = User:getItemAt(CCharacter.left_tool)
    if tool == nil or tool.id ~= 6 then
        tool = User:getItemAt(CCharacter.right_tool)
    end
    if tool == nil or tool.id ~= 6 then
        return
    end

    ltstate = ltstate or Action.none
    common.ResetInterruption(User, ltstate)
    scissors.UseItemWithCharacter(User, tool, animal, 1, 0, ltstate)
end

return M
