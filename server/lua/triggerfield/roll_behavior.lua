-- Run a registry-defined behavior roll when a character enters a trigger field.
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local Behaviors = require("moonlight-behaviors.server.lua.behaviors")
local BehaviorDefaults = require("illarion-script-loader.server.lua.lib.behaviorDefaults")

local M = {}
local events = Rolls:new()
local behaviors = BehaviorDefaults.registerBehaviorDefaults(Behaviors:new())

events:registerType("behavior", function(entry, context)
    return behaviors:run(entry.data, context)
end, behaviors:schema())

function M.schema()
    return { events = { type = "registry", registry = "illarion:rolls" } }
end

function M.MoveToField(User, TriggerField)
    local data = assert(TriggerField:getField("data"), "Missing behavior roll trigger field data")
    local reference = assert(data.events, "Missing behavior roll reference")
    local roll = assert(Registries.findByName("illarion:rolls", reference),
        "Unknown behavior roll: " .. tostring(reference))
    events:roll(assert(roll:getField("definition"), "Missing behavior roll definition"), {
        character = User, triggerField = TriggerField
    })
end

return M
