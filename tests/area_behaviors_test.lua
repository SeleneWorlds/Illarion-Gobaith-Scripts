-- Run from the bundle root: lua tests/area_behaviors_test.lua
package.path = 'server/lua/?.lua;' .. package.path
package.loaded['moonlight-behaviors.server.lua.behaviors'] = dofile('../moonlight/moonlight-behaviors/server/lua/behaviors.lua')
package.loaded['illarion-script-loader.server.lua.lib.inventoryManager'] = {}
local calls, unlocked = {}, false
local bucketId = 52
position = function(x,y,z) return {x=x,y=y,z=z} end
world = {
    getItemOnField = function(_, pos) return {pos=pos, unlocked=unlocked, id=bucketId} end,
    changeItem = function(_, item)
        assert(item.id == 51 and item.pos.x == -72 and item.pos.y == -69)
        calls[#calls+1] = 'bucket'
    end,
}
package.loaded['base.keys'] = { UnlockDoor = function(item)
    assert(item.pos.x == -74 and item.pos.y == -68)
    unlocked = true; calls[#calls+1] = 'unlock'
end }
package.loaded['base.doors'] = { OpenDoor = function(item)
    assert(item.unlocked, 'Opening must fetch the updated door')
    calls[#calls+1] = 'open'
end }
local definition = {
    enabled=true,
    area={include={{type='rectangle',x=-73,y=-68,z=0,width=2,height=2}},exclude={}},
    behaviors={{event='logout',actions={
        {type='unlock_door',data={position=position(-74,-68,0)}},
        {type='open_door',data={position=position(-74,-68,0)}},
        {type='swap_item',data={position=position(-72,-69,0),oldItem='illarion:item_52',item='illarion:item_51'}},
    }}},
}
local function signal() return {connect=function() end} end
package.loaded['selene.server'] = {serverReloaded=signal()}
package.loaded['selene.registries'] = {
    entryAdded=signal, entryChanged=signal, entryRemoved=signal, reloaded=signal,
    findAll=function(registry)
        assert(registry == 'illarion:areas')
        return {{getField=function(_, key) return definition[key] end}}
    end,
    findByName=function(registry, name)
        assert(registry == 'illarion:items')
        local id = assert(tonumber(name:match('^illarion:item_(%d+)$')))
        return {getMetadata=function(_,key) assert(key=='id'); return id end}
    end,
}
package.loaded['illarion-script-loader.server.lua.lib.behaviorDefaults'] = dofile('../illarion-script-loader/server/lua/lib/behaviorDefaults.lua')
local defaults = package.loaded['illarion-script-loader.server.lua.lib.behaviorDefaults']
local schema = defaults.schema()
local actionSchema = schema.actions.valueType.properties
local foundSwap = false
for _, option in ipairs(actionSchema.type.values) do
    if option.value == 'swap_item' then foundSwap = true end
end
assert(foundSwap, 'Default actions must appear in the editor dropdown')
local swapSchema = actionSchema.data.variants.swap_item.properties
assert(swapSchema.position == 'coordinate')
assert(swapSchema.oldItem.registry == 'illarion:items' and not swapSchema.oldItem.optional)
assert(swapSchema.item.registry == 'illarion:items')
assert(schema.conditions.valueType.properties.type.type == 'enum')
local areas = require('base.areas')
local context = {character={pos=position(-73,-68,0)}}
areas.emit('logout',context)
assert(table.concat(calls,',') == 'unlock,open,bucket')
calls = {}
bucketId = 99
areas.emit('logout',context)
assert(table.concat(calls,',') == 'unlock,open', 'Unexpected items must not be swapped')
bucketId = 52
calls = {}
local swap = definition.behaviors[1].actions[3]
swap.data.oldItem = nil
assert(not pcall(areas.emit, 'logout', context), 'The old item reference is required')
swap.data.oldItem = 'illarion:item_52'
calls = {}
areas.emit('login',context)
context.character.pos.z = 1
areas.emit('logout',context)
context.character.pos = position(-74,-68,0)
areas.emit('logout',context)
context.character.pos = position(-73,-68,0)
definition.enabled = false
areas.emit('logout',context)
definition.enabled = true
definition.area.exclude = {{type='rectangle',x=-73,y=-68,z=0,width=1,height=1}}
areas.emit('logout',context)
assert(#calls==0, 'Unmatched events and excluded, disabled, or outside areas must not execute')
print('area behavior tests passed')
