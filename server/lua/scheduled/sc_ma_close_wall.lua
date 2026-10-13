local Registries = require("selene.registries")
local M = {}

function M.schema()
    return {
        wall = {
            type = "registry",
            registry = "illarion:items"
        },
        door = "coordinate"
    }
end

function M.CloseSecretWall(ScheduledScript)
    local data = ScheduledScript:getField("data")
    if not data.door then
        return
    end

    local wallItem = Registries.findByName("illarion:items", data.wall)
    local wallItemId = wallItem and wallItem:getMetadata("id") or 0
    if not wallItemId then
        return
    end

    if (world:isItemOnField(data.door)) then
        local Item = world:getItemOnField(data.door);
        if (Item.id == wallItemId) then
            return
        end
    end

    CharsInRange = world:getPlayersInRangeOf(data.door, 5)
    if (#CharsInRange == 0) then
        world:createItemFromId(wallItemId, 1, data.door, true, 1, 0);
        CharsInRange = world:getPlayersInRangeOf(data.door, 15);
        for i, Chara in pairs(CharsInRange) do
            if (Chara:getPlayerLanguage() == 0) then
                Chara:inform("Du hörst das Geräusch von sich verschiebendem Stein");
            else
                Chara:inform("You hear the sound of moving stone");
            end
        end
    end
end

return M
