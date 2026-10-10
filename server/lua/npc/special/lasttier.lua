-- Gobaith pack animals: following, temporary cargo depots and abandoned carriers.
local areas = require('base.areas')
local M = {}
local FOLLOW_RANGE, STEP_CYCLES, LOST_STEPS = 5, 8, 880
local STATE_KEY = 'illarion-gobaith:lasttier'
local tileDelay = {[4]=2, [6]=3, [9]=4, [3]=3, [11]=1, [2]=3, [15]=3, [8]=2}
local blockedItems = {}
for _,id in ipairs({10,86,87,317,484,485,596,597,598,599,712,713,714,715,923,924,927,928}) do
    blockedItems[id] = true
end

local function state(npc)
    local data = npc.SeleneEntity:getRuntimeData(STATE_KEY)
    if not data.initialized then
        npc:increaseSkill(1, 'common language', 100)
        data.initialized, data.moving, data.lost = true, true, false
        data.cycles, data.lostSteps, data.blocked = 0, 0, false
    end
    return data
end

local function ownership(npc)
    local found, effect = npc.effects:find(10)
    if not found then return end
    local hasOwner, owner = effect:findValue('owner')
    if hasOwner then return effect, owner end
end

local function complain(npc)
    if npc:get_race() == 30 then
        npc:talk(Character.say, 'Meister warten...ich nicht so schnell sein.', "Master wait...I'm not that fast.")
    else
        npc:talk(Character.say, 'IIIAAAAAAAA')
    end
end

local function depotItem(data)
    if not data.depotpos or not world:isItemOnField(data.depotpos) then return end
    local item = world:getItemOnField(data.depotpos)
    -- Never erase or refresh an unrelated depot that replaced our temporary one.
    if item.id == 321 and item.quality == 1111 and item.data == data.depotOwner then return item end
end

function M.removeDepot(npc)
    local data = state(npc)
    local item = depotItem(data)
    if item then world:erase(item, 1) end
    data.depotpos, data.depotOwner = nil, nil
end

local function depotPosition(npc)
    local facing = npc:get_face_to()
    if facing == 0 then return position(npc.pos.x+1, npc.pos.y, npc.pos.z) end
    if facing == 2 then return position(npc.pos.x, npc.pos.y+1, npc.pos.z) end
    if facing == 4 then return position(npc.pos.x-1, npc.pos.y, npc.pos.z) end
    if facing == 6 then return position(npc.pos.x, npc.pos.y-1, npc.pos.z) end
    -- Diagonal facings use the east side rather than the old absolute (1,0,0).
    return position(npc.pos.x+1, npc.pos.y, npc.pos.z)
end

local function stop(npc, player, data)
    if not data.moving then return end
    local pos = depotPosition(npc)
    if not world:isCharacterOnField(pos) and not world:isItemOnField(pos)
            and world:getField(pos):isPassable() then
        world:createItemFromId(321, 1, pos, true, 1111, player.id)
        data.depotpos, data.depotOwner = pos, player.id
        local item = depotItem(data)
        if item then item.wear = 2; world:changeItem(item)
        else data.depotpos, data.depotOwner = nil, nil end
    end
    data.moving = false
end

function M.receiveText(npc, texttype, message, player)
    -- Both loader callback modes are supported; the Gobaith configuration is legacy.
    if player == nil then player, message, texttype, npc = message, texttype, npc, thisNPC end
    if player:getQuestProgress(8) == 0 then return end
    local effect, owner = ownership(npc)
    if not effect or owner ~= player.id or not npc:isInRange(player, FOLLOW_RANGE) then return end
    local data = state(npc)
    message = string.lower(message)
    if message:find('komm.+mit') or message:find('weiter') or message:find('follow.+me') then
        M.removeDepot(npc)
        data.moving = true
    elseif message:find('bleib.+stehen') or message:find('stay') or message:find('stop') then
        stop(npc, player, data)
    elseif message:find('beweg') or message:find('move') then
        M.removeDepot(npc)
        data.moving = true
        if npc:isInRange(player, 1) then npc:move(player:get_face_to(), true)
        else complain(npc) end
    end
end

local function onlinePlayer(id)
    for _,player in ipairs(world:getPlayersOnline()) do
        if player.id == id then return player end
    end
end

function M.useNPC(npc, player)
    local data = state(npc)
    if not data.lost or not npc:isInRange(player, 2) then return end
    local effect, owner = ownership(npc)
    if not effect then return end
    if owner == 0 then
        local found, oldOwner = effect:findValue('old_owner')
        if not found then return end
        owner = oldOwner
    end
    if player.id ~= owner and player:getQuestProgress(8) ~= 0 then return end
    if player.id ~= owner then
        if not player:moveDepotContentFrom(owner, player.id, owner) then return end
        local previous = onlinePlayer(owner)
        if previous then previous:setQuestProgress(8, 0) end
    end
    M.removeDepot(npc)
    effect:addValue('owner', player.id)
    player:setQuestProgress(8, 1)
    data.lost, data.moving, data.lostSteps = false, true, 0
end

local function moveAxis(npc, axis, offset, forced)
    if offset == 0 and not forced then return false end
    local direction = axis == 'x' and (offset > 0 and 6 or 2) or (offset > 0 and 0 or 4)
    local function attempt(dir)
        local dx = dir == 2 and 1 or dir == 6 and -1 or 0
        local dy = dir == 4 and 1 or dir == 0 and -1 or 0
        local pos = position(npc.pos.x+dx, npc.pos.y+dy, npc.pos.z)
        local field = world:getField(pos)
        if not field:isPassable() then return false end
        for index=0,field:countItems()-1 do
            if blockedItems[field:getStackItem(index).id] then return false end
        end
        local old = position(npc.pos.x, npc.pos.y, npc.pos.z)
        npc:move(dir, true)
        return not equapos(old, npc.pos)
    end
    if attempt(direction) then return true end
    return forced and offset == 0 and attempt(axis == 'x' and 6 or 0) or false
end

local function findOwner(npc, owner, effect, data, pos, range)
    for _,player in ipairs(world:getPlayersInRangeOf(pos, range)) do
        if player.id == owner then
            if player:increaseAttrib('hitpoints', 0) > 0 then
                player:setQuestProgress(8, 1)
                data.lost, data.lostSteps = false, 0
                return player
            end
            effect:addValue('old_owner', owner)
            effect:addValue('owner', 0)
            player:setQuestProgress(8, 0)
            return nil
        end
    end
end

function M.nextCycle(npc)
    npc = npc or thisNPC
    local data = state(npc)
    data.cycles = data.cycles+1
    if data.cycles < STEP_CYCLES+(tileDelay[world:getField(npc.pos):tile()] or 0) then return end
    data.cycles = 0
    local item = depotItem(data)
    if item then item.wear = 2; world:changeItem(item)
    else data.depotpos, data.depotOwner = nil, nil end
    local effect, owner = ownership(npc)
    if not effect then return end
    local target
    if owner ~= 0 then
        target = findOwner(npc, owner, effect, data, npc.pos, FOLLOW_RANGE)
        local _, currentOwner = ownership(npc)
        if not target and currentOwner ~= 0 then
            local destination
            if areas.contains('transporter_destination_west', npc.pos) then destination = position(302,229,0)
            elseif areas.contains('transporter_destination_vanima', npc.pos) then destination = position(-285,49,0) end
            if destination then
                target = findOwner(npc, owner, effect, data, destination, 12)
                if target then M.removeDepot(npc); npc:warp(destination); return end
            end
        end
    end
    if not target then
        if not data.lost then complain(npc); M.removeDepot(npc); data.lostSteps = 0 end
        data.lost, data.lostSteps = true, data.lostSteps+1
        if data.lostSteps > LOST_STEPS then
            local player = onlinePlayer(owner)
            if player then player:setQuestProgress(8, 0) end
            M.removeDepot(npc)
            world:deleteNPC(npc.id)
        end
        return
    end
    if not data.moving then return end
    local x, y = npc.pos.x-target.pos.x, npc.pos.y-target.pos.y
    if x*x+y*y <= 4 then return end
    local first, second, a, b = 'y', 'x', y, x
    if (math.abs(x) < math.abs(y) and not data.blocked)
            or (math.abs(x) > math.abs(y) and data.blocked) then
        first, second, a, b = 'x', 'y', x, y
    end
    if moveAxis(npc, first, a, false) or moveAxis(npc, second, b, false) then data.blocked = false
    else moveAxis(npc, first, a, true); data.blocked = true end
end

return M
