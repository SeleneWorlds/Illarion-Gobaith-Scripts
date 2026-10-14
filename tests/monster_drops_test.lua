-- Run from the bundle root: lua tests/monster_drops_test.lua
package.path = 'server/lua/?.lua;' .. package.path
package.loaded['base.common'] = {}
package.loaded['monster.base.lookat'] = {}
package.loaded['base.messages'] = {}
package.loaded['moonlight-rolls.server.lua.rolls'] = dofile('../moonlight/moonlight-rolls/server/lua/rolls.lua')
package.loaded['illarion-script-loader.server.lua.lib.datakeys'] = {}
package.loaded['illarion-script-loader.server.lua.lib.dataFields'] = {Monster='monster'}
package.loaded['selene.registries'] = {
    findByName = function(registry, identifier)
        assert(registry == 'illarion:items')
        local id = assert(tonumber(identifier:match('item_(%d+)$')))
        return {getMetadata=function(_, key) assert(key == 'id'); return id end}
    end,
}
Character = {SeleneMethods={}}
dofile('../illarion-script-loader/server/lua/impl/character/monsters.lua')
local drops = {pools={
    {entries={{type='item', weight=1, data={item='illarion:item_71',
        count={min=1,max=1}, quality={min=5,max=5}, durability={min=42,max=42}, data={test='pig'}}}}},
    {entries={{type='nothing', weight=1}}},
}}
-- An optional fixture allows exercising an actual registry file exported as Lua.
if arg[1] then drops = dofile(arg[1]).drops end
local created = {}
world = {createItemFromId=function(_, id, amount, pos, always, quality, data)
    created[#created + 1] = {id=id,amount=amount,pos=pos,always=always,quality=quality,data=data}
end}
local pig = {
    id=292, pos={x=1,y=2,z=0},
    SeleneCharacterData={monster={getField=function(_, key) assert(key == 'drops'); return drops end}},
    get_mon_type=function() return 292 end,
    countItem=function(_, id) return id == 61 and 2 or 0 end,
    getLoot=Character.SeleneMethods.getLoot,
}
local animals = require('monster.mon_29_animals')
animals.ini(pig)
animals.onDeath(pig)
local found = false
for _, item in ipairs(created) do
    assert(item.pos == pig.pos and item.always)
    assert(item.id ~= 69, 'Legacy pig leather must not supplement registry loot')
    if item.id == 71 then
        assert(item.amount == 1)
        if not arg[1] then assert(item.quality == 542 and item.data.test == 'pig') end
        found = true
    end
end
assert(found, 'Pig death did not create the configured item_71 drop')
assert(created[#created].id == 61 and created[#created].amount == 2, 'Carried coins were lost')
local count = #created
animals.onDeath(pig)
assert(#created == count, 'Repeated death callback duplicated drops')
-- Empty registry loot must not revive the hardcoded drops.
pig.id = 293
drops = {pools={}}
created = {}
animals.onDeath(pig)
assert(#created == 1 and created[1].id == 61, 'Empty registry spawned legacy drops')
print('Monster death registry drops tests passed')
