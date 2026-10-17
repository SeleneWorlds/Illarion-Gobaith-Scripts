local Common = require("base.common")
local Areas = require("base.areas")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local Registries = require("selene.registries")

local M = {}
local seasons = { "spring", "summer", "autumn", "winter" }
local herbRolls = Rolls:new()

herbRolls:registerCondition("is_season", function(condition, context)
    return context.season == condition.data
end, { type = "enum", values = {
    { value = "spring", label = "Spring" }, { value = "summer", label = "Summer" },
    { value = "autumn", label = "Autumn" }, { value = "winter", label = "Winter" }
} })

herbRolls:registerCondition("ground_is_any_of", function(condition, context)
    for _, reference in ipairs(condition.data) do
        local tile = assert(Registries.findByName("selene:tiles", reference),
            "Unknown Gaia ground tile: " .. tostring(reference))
        local tileId = assert(tile:getMetadata("tileId"), "Missing tile ID: " .. reference)
        if tileId == context.tileId then return true end
    end
    return false
end, { type = "array", valueType = { type = "registry", registry = "selene:tiles" } })

herbRolls:registerType("herb", function(entry, context)
    local herb = entry.data
    local item = assert(Registries.findByName("illarion:items", herb.item),
        "Unknown Gaia herb item: " .. tostring(herb.item))
    local itemId = assert(item:getMetadata("id"), "Missing item ID: " .. herb.item)
    world:createItemFromId(itemId, 1, context.position, false,
        math.random(111, 999), herb.data or 0)
end, { type = "object", properties = {
    item = { type = "registry", registry = "illarion:items" },
    data = { type = "integer", optional = true }
} })

function M.schema()
    return {
        area = { type = "registry", registry = "illarion:areas" },
        rolls = "number",
        herbs = herbRolls:schema()
    }
end

function M.spawnHerbs(ScheduledScript)
    local data = assert(ScheduledScript:getField("data"), "Missing Gaia roll data")
    local area = assert(data.area, "Missing Gaia area")
    local rolls = assert(tonumber(data.rolls), "Missing Gaia rolls count")
    local herbs = assert(data.herbs, "Missing Gaia herbs roll definition")
    local season = seasons[Common.Limit(math.ceil(world:getTime("month") / 4), 1, 4)]
    for i = 1, rolls do
        local position = Areas.randomPosition(area)
        if not position then return end
        local field = world:getField(position)
        if field:countItems() == 0 then
            herbRolls:roll(herbs, {
                season = season,
                position = position,
                tileId = field:tile()
            })
        end
    end
end

return M
