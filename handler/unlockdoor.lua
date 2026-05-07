local class = require("base.class")
local keys = require("base.keys")

local M = {}

-- A door is locked if its quality is 333 and unlocked if it is 233. Data has to be ~=0.
-- it makes sound 19 (world:makeSound(19, Door.pos);) when the door locks.
-- A key with the same data than a door lock/unlocks it (not important here).

M.unlockDoor = class.class(function(door, posi)
    door.pos=posi;
end);

function M.unlockDoor:execute()
    --[[lst=world:getPlayersOnline();
    for i,ply in pairs(lst) do
        if ply.id==42 then
            char=ply;
        end
    end
    char:inform("in exe");--]]
    if (world:isItemOnField(self.pos)==true) then
        item=world:getItemOnField(self.pos);
        keys.UnlockDoor(item);
    else
        return -1;
    end
end

return M
