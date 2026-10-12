-- Gobaith chat trading, attached through the VBU receive-text extension point.
local Common = require('base.common')
local LookAt = require('base.lookat')
local ChatTrade = {}
local MAX_AMOUNT = 1000
local languagePrefixes = {hum=true, dwa=true, elf=true, liz=true, orc=true,
    hal=true, fai=true, gno=true, gob=true, anc=true}

local function normalize(text)
    return text:lower():gsub('%s+', ' '):match('^%s*(.-)%s*$')
end

local function parse(text)
    text = normalize(text):gsub('[.!?]+$', ''):match('^%s*(.-)%s*$')
    -- The script loader prefixes non-common speech for display. Language
    -- permission and comprehension have already been checked by the base.
    local language, speech = text:match('^%[(%a+)%] (.+)$')
    if languagePrefixes[language] then text = speech end
    local action, rest = text:match('^(%a+) (.+)$')
    if action ~= 'buy' and action ~= 'sell' and action ~= 'kaufe' and action ~= 'verkaufe' then
        action, rest = text:match('^i (%a+) (.+)$')
    end
    if action ~= 'buy' and action ~= 'sell' and action ~= 'kaufe' and action ~= 'verkaufe' then
        action, rest = text:match('^i want to (%a+) (.+)$')
    end
    if action ~= 'buy' and action ~= 'sell' and action ~= 'kaufe' and action ~= 'verkaufe' then
        rest, action = text:match('^ich möchte (.+) (%a+)$')
        if not action then rest, action = text:match('^ich will (.+) (%a+)$') end
    end
    if action == 'kaufen' or action == 'kaufe' then action = 'buy' end
    if action == 'verkaufen' or action == 'verkaufe' then action = 'sell' end
    if action ~= 'buy' and action ~= 'sell' then return nil end
    local quantity, name = rest:match('^(%S+) (.+)$')
    local articles = {a=true, an=true, ein=true, eine=true, einen=true}
    local amount = articles[quantity] and 1 or tonumber(quantity)
    if not amount then
        amount, name = 1, rest
    end
    return action, amount, normalize(name)
end

local function matchedNameLength(text, name)
    name = normalize(name)
    if name == '' or text:sub(1, #name) ~= name then return 0 end
    local suffix = text:sub(#name + 1, #name + 1)
    if suffix == '' or suffix:match('[%s%p]') then return #name end
    return 0
end

local function findOffer(lists, name)
    local found, index, ambiguous
    local longest = 0
    for _, list in ipairs(lists) do
        for i, offer in ipairs(list) do
            local length = math.max(matchedNameLength(name, offer._nameDe),
                matchedNameLength(name, offer._nameEn))
            if length > longest then
                found, index, ambiguous = nil, nil, false
                longest = length
            end
            if length > 0 and length == longest then
                -- Primary requests take precedence over secondary requests for the same ID.
                if found and (found._itemId ~= offer._itemId or found._type == 'sell') then
                    ambiguous = true
                end
                if not found then found, index = offer, i - 1 end
            end
        end
    end
    if ambiguous then return nil, nil, true end
    return found, index
end

local function eligible(offer, item)
    local glyph = tonumber(item:getData('glyphEffNo'))
    return item.id == offer._itemId and (offer._data == nil or offer._data == item.data)
        and not (glyph and glyph > 0) and not LookAt.hasSocketedGems(item)
end

-- A quantity-limited view retains the live item's ownership, slot and data.
-- The VBU transaction erases and pays for view.number without changing the
-- original wrapper or inventory count before the transaction runs.
local function portion(item, amount)
    return setmetatable({number=amount}, {__index=function(_, key)
        local value = item[key]
        if type(value) == 'function' then
            return function(_, ...) return value(item, ...) end
        end
        return value
    end})
end

function ChatTrade.new(trader)
    local receiver = {}
    function receiver:receiveText(npc, mode, player, text)
        if mode ~= Character.say and mode ~= Character.whisper and mode ~= Character.yell then return false end
        local action, amount, name = parse(text)
        if not action then return false end
        if amount < 1 or amount > MAX_AMOUNT or amount ~= math.floor(amount) then
            Common.InformNLS(player, 'Bitte gib eine ganze Anzahl von 1 bis 1000 an.',
                'Please specify a whole quantity from 1 to 1000.')
            return true
        end
        local lists = action == 'buy' and {trader._sellItems}
            or {trader._buyPrimaryItems, trader._buySecondaryItems}
        local offer, index, ambiguous = findOffer(lists, name)
        if not offer then
            if ambiguous then
                Common.InformNLS(player, 'Diese Ware ist nicht eindeutig. Bitte benutze das Handelsmenü.',
                    'That item name is ambiguous. Please use the trade menu.')
            else
                Common.InformNLS(player, 'Diese Ware wird hier nicht gehandelt. Bitte benutze den Namen aus dem Handelsmenü.',
                    'That item is not traded here. Please use its name from the trade menu.')
            end
            return true
        end
        if action == 'buy' then
            trader:sellItemToPlayer(npc, player, index, amount)
        else
            local items, total = {}, 0
            for _, item in ipairs(player:getItemList(offer._itemId)) do
                if item.number > 0 and eligible(offer, item) then
                    items[#items + 1] = item
                    total = total + item.number
                end
            end
            if total < amount then
                Common.InformNLS(player, 'Du hast nicht genügend geeignete Waren.',
                    'You do not have enough eligible items.')
                return true
            end
            for _, item in ipairs(items) do
                local count = math.min(amount, item.number)
                trader:buyItemFromPlayer(npc, player, portion(item, count))
                amount = amount - count
                if amount == 0 then break end
            end
        end
        return true
    end
    return receiver
end

return ChatTrade
