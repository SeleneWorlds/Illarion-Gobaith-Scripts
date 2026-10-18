local common = require("base.common")
local treasure = require("base.treasure")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local M = {}
local events = Rolls:new()

events:registerType("nothing", items.nothing)
events:registerType("item", items.item)
events:registerType("treasure", function(entry, context)
    if treasure.createMap(context.user) then
        local message = entry.data.message
        common.InformNLS(context.user, message.de, message.en)
        context.stopped = true
    end
end)
events:registerType("monster", function(entry, context)
    local data = entry.data
    local position = common.GetFrontPosition(context.user)
    world:createMonster(data.id, position, 20)
    for _, gfx in ipairs(data.gfx or {}) do world:gfx(gfx, position) end
    if data.sound then world:makeSound(data.sound, position) end
    common.InformNLS(context.user, data.message.de, data.message.en)
    context.stopped = true
end)

local function definition(name)
    return assert(Registries.findByName("illarion:gathering", "illarion:" .. name),
        "Unknown gathering profile: " .. name)
end

function M.check(user, name)
    local profile = definition(name)
    local interruptions = profile:getField("interruptions") or {}
    if common.IsInterrupted(user) and #interruptions > 0 then
        local message = interruptions[math.random(#interruptions)]
        common.InformNLS(user, message.de, message.en)
        return false
    end
    if not common.FitForWork(user) then return false end
    common.GetHungry(user, profile:getField("food"))
    -- Only special encounters are excluded on Noobia. Domain consumers always
    -- execute their normal yield rolls after this check succeeds.
    if user.pos.z == 100 or user.pos.z == 101 then return true end
    local rolls = assert(profile:getField("events"), "Missing gathering events: " .. name)
    events:validate(rolls)
    local context = { user = user }
    for _, pool in ipairs(rolls.pools) do
        events:roll({ conditions = rolls.conditions, pools = { pool } }, context)
        if context.stopped or context.overflow then return false end
    end
    return true
end

function M.time(user, name, tool)
    local profile = definition(name)
    local skill = user:getSkill(profile:getField("skill"))
    local attribute = user:increaseAttrib(profile:getField("attribute"), 0)
    if tool then
        local gem1, strength1, gem2, strength2 = common.GetBonusFromTool(tool)
        if gem1 == 3 then skill = skill + strength1 end
        if gem2 == 3 then skill = skill + strength2 end
        local speed = 0
        if gem1 == 6 then speed = speed + strength1 end
        if gem2 == 6 then speed = speed + strength2 end
        return math.floor((-0.2 * (skill * 1.2 + attribute) + 50 + math.random(0, 40))
            * (100 - speed * 1.75) / 100)
    end
    return math.floor(-0.4 * (skill * 1.2 + attribute) + 70)
end

return M
