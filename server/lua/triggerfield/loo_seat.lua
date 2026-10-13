-- warps you downstairs with the keyword and opens the door / empties the bucket
-- position: -72, -67, 0
-- author: vilarion

local base_doors = require("base.doors")
local base_keys = require("base.keys")
local M = {}

function M.schema()
    return {
        bucket = "coordinate",
        door = "coordinate",
        target = "coordinate",
        password = "string"
    }
end

function M.CharacterOnField(Character, TriggerField)
    local data = TriggerField:getField("data")
    if string.find(Character.lastSpokenText:lower(), data.password:lower()) ~= nil then
        local bucket = world:getItemOnField(data.bucket)
        local door = world:getItemOnField(data.door)
        if bucket.id == 52 and door.quality == 333 and base_doors.CheckClosedDoor(door.id) then
            base_keys.UnlockDoor(door)
            door = world:getItemOnField(data.door)
            base_doors.OpenDoor(door)
            bucket.id = 51
            world:changeItem(bucket)
            Character:warp(data.target)
        end
    end
end

return M
