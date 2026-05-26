local Consequence = require("consequence.server.lua.consequence")
local DataKeys = require("illarion-script-loader.server.lua.lib.datakeys")
local DataFields = require("illarion-script-loader.server.lua.lib.dataFields")
local Event = require("selene.event")
local Registries = require("selene.registries")
local Resources = require("selene.resources")

local BUNDLE_NAME = "illarion-gobaith"
local INTERACTIONS_REGISTRY = "consequence:interactions"
local CSQN_GLOB = "server/lua/*.csqn"
local DEFAULT_NAMESPACES = { "illarion_gobaith", "consequence" }

local function playerUsesLanguage(context, language)
    local player = context and context.player
    if player == nil or type(player.getPlayerLanguage) ~= "function" then
        return false
    end
    return player:getPlayerLanguage() == language
end

local function registerLanguageEffect(effectName, language)
    local handler = function(_, context)
        return playerUsesLanguage(context, language)
    end

    Consequence.registerEffectType("illarion_gobaith:" .. effectName, handler)
end

local function loadInteractionFile(path)
    local source = Resources.loadAsString(path)
    local definition = Consequence.parseScript(source, {
        fileName = path,
        defaultNamespaces = DEFAULT_NAMESPACES
    })

    local relativePath = path
    local bundlePrefix = BUNDLE_NAME .. "/"
    if relativePath:sub(1, #bundlePrefix) == bundlePrefix then
        relativePath = relativePath:sub(#bundlePrefix + 1)
    end
    relativePath = relativePath:gsub("^server/lua/", "")
    relativePath = relativePath:gsub("%.csqn$", "")
    relativePath = relativePath:gsub("\\", "/")

    local identifier = BUNDLE_NAME .. ":" .. relativePath
    Registries.add(INTERACTIONS_REGISTRY, identifier, definition)
    print("Loaded " .. path .. " into " .. INTERACTIONS_REGISTRY .. " as " .. identifier)
end

local function getNpcDefinition(npc)
    local charData = npc
        and npc.SeleneEntity
        and npc.SeleneEntity:getRuntimeData(DataKeys.Character)
    return charData and charData[DataFields.NPC] or nil
end

local function resolveInteractionDefinition(identifier)
    if type(identifier) ~= "string" or identifier == "" then
        return nil
    end
    return Registries.findByName(INTERACTIONS_REGISTRY, identifier)
end

Consequence.registerPositionalArguments("showTrades", { "trade" })
Consequence.registerPositionalArguments("chatTrading", { "trade" })

registerLanguageEffect("german", Player.german)
registerLanguageEffect("english", Player.english)

Event.of("illarion-script-loader:look_at_npc"):connect(function(npc, player)
    local npcDefinition = getNpcDefinition(npc)
    local consequenceId = npcDefinition and npcDefinition:getField("consequence") or nil
    local definition = resolveInteractionDefinition(consequenceId)
    if definition == nil then
        return
    end

    Consequence.fireDefinitions({
        definition
    }, "lookat", {
        npc = npc,
        player = player
    }, {}, {
        defaultNamespaces = DEFAULT_NAMESPACES,
        textHandler = function(text)
            player:sendCharDescription(npc, text)
        end
    })
end)

Event.of("illarion-script-loader:use_npc"):connect(function(npc, player)
    local npcDefinition = getNpcDefinition(npc)
    local consequenceId = npcDefinition and npcDefinition:getField("consequence") or nil
    local definition = resolveInteractionDefinition(consequenceId)
    if definition == nil then
        return
    end

    Consequence.fireDefinitions({
        definition
    }, "use", {
        npc = npc,
        player = player
    }, {}, {
        defaultNamespaces = DEFAULT_NAMESPACES,
        textHandler = function(text)
            npc:talk(Character.say, text)
        end
    })
end)

for _, path in ipairs(Resources.listFiles(BUNDLE_NAME, CSQN_GLOB)) do
    local ok, err = pcall(loadInteractionFile, path)
    if not ok then
        print("Failed to load " .. path .. ": " .. tostring(err))
    end
end
