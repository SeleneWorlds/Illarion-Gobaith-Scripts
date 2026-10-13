local M = {}

function M.schema()
    return {
        password = "string",
        door = "coordinate"
    }
end

function M.CharacterOnField(Character, TriggerField)
    local data = TriggerField:getField("data")
    if data.password ~= nil and data.password ~= "" then
        if not (string.find(Character.lastSpokenText:lower(), data.password:lower(), 1, true) ~= nil) then
            return
        end

        if (Character.activeLanguage ~= 10) then
            return
        end
    end
    if (world:isItemOnField(data.door)) then
        local Item = world:getItemOnField(data.door);
        world:erase(Item,1);
        CharsInRange = world:getPlayersInRangeOf(data.door,15);
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
