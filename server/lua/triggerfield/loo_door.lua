-- shuts the loo door on entering and fills the bucket with water
-- position: -73, -68, 0
-- author: vilarion

local base_doors = require("base.doors")
local base_keys = require("base.keys")
local M = {}

function M.schema()
    return {
        bucket = "coordinate",
        door = "coordinate"
    }
end

function M.MoveToField(User, TriggerField)
    local data = TriggerField:getField("data")
    if User:get_face_to() == 2 then -- looking east, probably walking inside
        local door = world:getItemOnField(data.door)
        base_doors.CloseDoor(door)
        door = world:getItemOnField(data.door)
        base_keys.LockDoor(door)
        door = world:getItemOnField(data.door)
        if door.quality == 333 and base_doors.CheckClosedDoor(door.id) then
            local bucket = world:getItemOnField(data.bucket)
            if bucket.id == 51 then
                bucket.id = 52
                world:changeItem(bucket)
            elseif bucket.id == 524 then
                bucket = world:createItemFromId(52, 1, data.bucket, true, 333, 0)
                bucket.wear = 255
                world:changeItem(bucket)
            end
        end
    end
end

return M
