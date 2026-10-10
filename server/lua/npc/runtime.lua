local Resources = require('selene.resources')
local Server = require('selene.server')
local Event = require('selene.event')
local Network = require('selene.network')
local Common = require('base.common')
local DataKeys = require('illarion-script-loader.server.lua.lib.datakeys')
local DataFields = require('illarion-script-loader.server.lua.lib.dataFields')

local Runtime = {}
local BUNDLE = 'illarion-gobaith'
local STATE_KEY = 'illarion-gobaith:npc-compiler'
local ENTITY_KEY = 'illarion-gobaith:compiled-npc'
local store = Server.getRuntimeData(STATE_KEY)
store.definitions = store.definitions or {}
store.failures = store.failures or {}
store.generation = store.generation or 0
local started = false

local function identifier(path)
    path = path:gsub('\\', '/')
    local prefix = BUNDLE .. '/'
    local relative = path:sub(1, #prefix) == prefix and path:sub(#prefix + 1) or path
    -- The historical npc/simple files use an older dialect and are not activated implicitly.
    local name = relative:match('^server/lua/npc/([^/]+)%.npc$')
    return name and (BUNDLE .. ':npc/' .. name) or nil
end

function Runtime.load(path, force)
    local id = identifier(path)
    if not id then return false end
    local ok, source = pcall(Resources.loadAsString, path)
    if not ok then print('Failed to read NPC ' .. path .. ': ' .. tostring(source)); return false end
    local old = store.definitions[id]
    if not force and old and old.source == source then return true end
    if not force and store.failures[path] == source then return false end
    local compiled, program = pcall(function()
        return require('npc.compiler').compile(source, {fileName=path})
    end)
    if not compiled then
        store.failures[path] = source
        print('Failed to compile NPC: ' .. tostring(program))
        return false
    end
    -- No live state or definition is touched until parsing and construction succeed.
    store.generation = store.generation + 1
    store.definitions[id] = {program=program, source=source, path=path, generation=store.generation}
    store.failures[path] = nil
    print('Compiled NPC ' .. path)
    return true
end

function Runtime.remove(path)
    local id = identifier(path)
    if not id then return end
    store.definitions[id] = nil
    store.failures[path] = nil
end

function Runtime.reloadAll(force)
    local present = {}
    local paths = Resources.listFiles(BUNDLE, 'server/lua/npc/*.npc')
    table.sort(paths)
    for _,path in ipairs(paths) do
        local id = identifier(path)
        if id then present[id] = true; Runtime.load(path, force) end
    end
    for id,record in pairs(store.definitions) do
        if not present[id] then Runtime.remove(record.path) end
    end
end

local function preserveState(old, new)
    new.talk._state = old.talk._state
    new.talk._saidNumber = old.talk._saidNumber
    new.talk._nextCycleText = old.talk._nextCycleText
    new.root.state = old.root.state
    new.root._luaHookState = old.root._luaHookState
    new.root._cycleCounter = old.root._cycleCounter
    new.root._nextCycleCalls = old.root._nextCycleCalls
    if old.root._equipmentList == nil then
        new.root._equipmentList = nil
        new.root.nextCycle = new.root.nextCycle2
    end
end

function Runtime.instance(entity)
    local characterData = entity:getRuntimeData(DataKeys.Character)
    local npc = characterData and characterData[DataFields.NPC]
    local id = npc and (npc:getField('npc') or npc:getField('script'))
    local record = id and store.definitions[id]
    if not record then return nil end
    local character = Character.fromSeleneEntity(entity)
    local state = entity:getRuntimeData(ENTITY_KEY)
    if not state.instance or state.id ~= id or state.generation ~= record.generation then
        local ok, instance = pcall(record.program.newInstance)
        if not ok then
            print('Failed to construct NPC ' .. id .. ': ' .. tostring(instance))
            return state.id == id and state.instance or nil, character
        end
        if state.id == id and state.instance then preserveState(state.instance, instance) end
        state.id, state.generation, state.instance = id, record.generation, instance
    end
    if type(state.instance.root.initLanguages) == 'function' then state.instance.root:initLanguages(character) end
    return state.instance, character
end

local function render(text, player, instance, npc)
    for _,processor in ipairs(require('npc.base.responses')) do
        if processor:check(text) then text = processor:process(player, instance.talk, npc, text) end
    end
    return text
end

function Runtime.start()
    Runtime.reloadAll(true)
    if started then return end
    started = true
    Server.serverReloaded:connect(function() Runtime.reloadAll(true) end)
    Server.bundleFilesChanged:connect(function(bundle, updated, deleted)
        if bundle ~= BUNDLE then return end
        local updatedPaths = {}
        for _,path in ipairs(updated) do
            updatedPaths[path] = true
            if identifier(path) then Runtime.load(BUNDLE .. '/' .. path) end
        end
        for _,path in ipairs(deleted) do
            if not updatedPaths[path] then Runtime.remove(BUNDLE .. '/' .. path) end
        end
    end)
    Event.of('illarion-script-loader:look_at_npc'):connect(function(event, entity, player)
        local instance, npc = Runtime.instance(entity)
        if not instance then return end
        local character = Character.fromSelenePlayer(player)
        local text = Common.GetNLS(character, instance.root._lookAtMsgDE, instance.root._lookAtMsgUS)
        text = render(text, character, instance, npc)
        Network.sendToPlayer(player, 'illarion:look_at_entity', {networkId=entity:getNetworkId(), tooltip={name=text ~= '' and text or npc.name}})
        event.cancel = true
    end)
    Event.of('illarion-script-loader:use_npc'):connect(function(event, entity, player)
        local instance, npc = Runtime.instance(entity)
        if not instance then return end
        local character = Character.fromSelenePlayer(player)
        if not npc:isInRange(character, 2) then return end
        local text = Common.GetNLS(character, instance.root._useMsgDE, instance.root._useMsgUS)
        if text ~= '' then
            npc.activeLanguage = instance.root._defaultLanguage
            npc:talk(Character.say, render(text, character, instance, npc))
        else instance.root:use(npc, character) end
        event.cancel = true
    end)
    Event.of('illarion-script-loader:talk_to_npc'):connect(function(event, entity, player, mode, text)
        local instance, npc = Runtime.instance(entity)
        if not instance then return end
        instance.root:receiveText(npc, mode, Character.fromSelenePlayer(player), text)
        event.cancel = true
    end)
    Event.of('illarion-script-loader:npc_cycle'):connect(function(event, entity)
        local instance, npc = Runtime.instance(entity)
        if not instance then return end
        instance.root:nextCycle(npc)
        event.cancel = true
    end)
end

return Runtime
