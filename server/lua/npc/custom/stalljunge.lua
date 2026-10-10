-- Rental bookkeeping only. The carrier deliberately has no lasttier script yet.
local Money = require('base.money')
local M = {}
local FEE, DEPOSIT, QUEST = 50, 200, 8
local offsets = {0, 1, -1, 2, -2}
local blockedTiles = {[0]=true, [5]=true, [6]=true, [42]=true}

local function say(context, german, english)
    context.npc:talk(Character.say, context.player:getPlayerLanguage() == 0 and german or english)
end

local function spawn(player, race)
    for _,x in ipairs(offsets) do
        for _,y in ipairs(offsets) do
            local pos = position(player.pos.x+x, player.pos.y+y, player.pos.z)
            local field = world:getField(pos)
            if not world:isCharacterOnField(pos) and not world:isItemOnField(pos)
                    and field:isPassable() and not blockedTiles[field:tile()] then
                local called, ok, carrier = pcall(world.createDynamicNPC, world, 'Lasttier', race, pos, 0, '')
                if not called then
                    print('Failed to spawn rental carrier: ' .. tostring(ok))
                    return nil
                end
                if ok then return carrier end
                return nil
            end
        end
    end
end

function M.rent(context, race)
    local player = context.player
    local effect = LongTimeEffect(10, 500000)
    effect:addValue('owner', player.id)
    local carrier = spawn(player, race or 50)
    if not carrier then
        say(context, 'Hier ist kein Platz für ein Lasttier. Versucht es später wieder.', 'There is no room for a pack animal here. Please try again later.')
        return
    end
    -- Keep the legacy ownership format for the future lasttier implementation.
    carrier.effects:addEffect(effect)
    Money.TakeMoneyFromChar(player, FEE+DEPOSIT)
    player:setQuestProgress(QUEST, 1)
    say(context, 'Hier ist euer Lasttier. Bei Rückgabe bekommt ihr 2 Silberstücke Kaution zurück.',
        'Here is your pack animal. Return it to get your deposit of 2 silver coins back.')
end

function M.returnAnimal(context)
    local player = context.player
    for _,carrier in ipairs(world:getNPCSInRangeOf(context.npc.pos, 8)) do
        local found, effect = carrier.effects:find(10)
        if found then
            local hasOwner, owner = effect:findValue('owner')
            if hasOwner and owner == player.id and world:deleteNPC(carrier.id) then
                -- Despawning is deferred until the next cycle. Invalidate ownership
                -- immediately so another request cannot refund this carrier again.
                effect:addValue('owner', 0)
                player:setQuestProgress(QUEST, 0)
                if not Money.GiveMoneyToChar(player, DEPOSIT) then
                    Money.GiveMoneyToPosition(player.pos, DEPOSIT)
                end
                say(context, 'Danke für das Lasttier. Hier sind eure 2 Silberstücke Kaution.',
                    'Thanks for the pack animal. Here is your deposit of 2 silver coins.')
                return
            end
        end
    end
    say(context, 'Wo ist euer Lasttier? Bringt es zu mir zurück.', 'Where is your pack animal? Bring it back to me.')
end

return M
