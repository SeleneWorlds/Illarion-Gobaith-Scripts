-- warps upstairs if the loo is not occupied
-- position: -72, -67, -3
-- author: vilarion

local base_doors = require("base.doors")
local base_keys = require("base.keys")
local M = {}

function M.schema()
    return {
        bucket = "coordinate",
        door = "coordinate",
        target = "coordinate"
    }
end

function M.MoveToField(User, TriggerField)
    local data = TriggerField:getField("data")
    local bucket = world:getItemOnField(data.bucket);
    local door = world:getItemOnField(data.door);
    if not (bucket.id == 52 and door.quality == 333 and base_doors.CheckClosedDoor(door.id )) then
        User:warp(data.target)
    else
        User:inform((User:getPlayerLanguage() == 0 and "Der Ort, zu dem diese Leiter reicht, scheint besetzt zu sein." or "The place where this ladder leads to seems to be occupied."))
    end
end

return M
