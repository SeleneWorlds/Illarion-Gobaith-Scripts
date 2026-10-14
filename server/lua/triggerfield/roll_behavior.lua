-- Run a registry-defined scenario roll when a character enters a trigger field.
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local Behaviors = require("moonlight-behaviors.server.lua.behaviors")
local ScenarioDefaults = require("illarion-script-loader.server.lua.lib.scenarioDefaults")

local M = {}
local events = Rolls:new()
local scenarios = ScenarioDefaults.registerScenarioDefaults(Behaviors:new())

events:registerType("scenario", function(entry, context)
    return scenarios:run(entry.data, context)
end, scenarios:schema())

function M.schema()
    return { events = { type = "registry", registry = "illarion:rolls" } }
end

function M.MoveToField(User, TriggerField)
    local data = assert(TriggerField:getField("data"), "Missing scenario roll trigger field data")
    local reference = assert(data.events, "Missing scenario roll reference")
    local roll = assert(Registries.findByName("illarion:rolls", reference),
        "Unknown scenario roll: " .. tostring(reference))
    events:roll(assert(roll:getField("definition"), "Missing scenario roll definition"), {
        character = User, triggerField = TriggerField
    })
end

return M
