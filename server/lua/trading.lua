local Registries = require("selene.registries")

local Trading = {}

local INFINITE_STOCK = 4294967295
local COINS = {
    { id = 61, value = 10000, english = "gold", german = "Gold" },
    { id = 3077, value = 100, english = "silver", german = "Silber" },
    { id = 3076, value = 1, english = "copper", german = "Kupfer" }
}
local INITIAL_CASH = {
    borgate = 1000,
    eliza = 5000,
    onor = 0
}
local states = {}

local function field(value, name)
    if value ~= nil and type(value.getField) == "function" then
        return value:getField(name)
    end
    return type(value) == "table" and value[name] or nil
end

local function loadState(name)
    if states[name] ~= nil then
        return states[name]
    end

    local definition = Registries.findByName("illarion:trades", "illarion-gobaith:" .. name)
        or Registries.findByName("illarion:trades", name)
    if definition == nil then
        return nil
    end

    local state = { cash = INITIAL_CASH[name] or 0, stock = {} }
    for _, entry in ipairs(field(definition, "stock") or {}) do
        table.insert(state.stock, {
            name = field(entry, "name"),
            item = tonumber(field(entry, "item")),
            sellPrice = tonumber(field(entry, "sellToPlayerPrice")) or 0,
            buyPrice = tonumber(field(entry, "buyFromPlayerPrice")) or 0,
            amount = tonumber(field(entry, "initialStock")) or 0,
            defaultAmount = tonumber(field(entry, "defaultStock")) or 0,
            quality = field(entry, "quality") or { 3, 3 },
            durability = field(entry, "durability") or { 33, 33 },
            data = tonumber(field(entry, "data")) or 0
        })
    end
    states[name] = state
    return state
end

local function isGerman(player)
    return player:getPlayerLanguage() == Player.german
end

local function say(context, german, english)
    context.npc:talk(Character.say, isGerman(context.player) and german or english)
end

local function itemName(item, player)
    return world:getItemName(item.item, player:getPlayerLanguage())
end

local function findItem(state, message)
    local lowered = string.lower(message)
    for _, item in ipairs(state.stock) do
        local names = { item.name, world:getItemName(item.item, Player.english), world:getItemName(item.item, Player.german) }
        for _, name in ipairs(names) do
            if type(name) == "string" and name ~= "" and string.find(lowered, string.lower(name), 1, true) then
                return item
            end
        end
    end
    return nil
end

local function adjustedPrice(price, amount, defaultAmount)
    if defaultAmount == INFINITE_STOCK then
        return price
    elseif amount * 2 < defaultAmount then
        return math.floor(price * 1.5)
    elseif amount > defaultAmount * 2 then
        return math.floor(price * 0.75)
    end
    return price
end

local function moneyText(value, german)
    local parts = {}
    for _, coin in ipairs(COINS) do
        local count = math.floor(value / coin.value)
        value = value - count * coin.value
        if count > 0 then
            local suffix = german and (count == 1 and "stück" or "stücke") or (count == 1 and " piece" or " pieces")
            table.insert(parts, count .. " " .. (german and coin.german or coin.english) .. suffix)
        end
    end
    return table.concat(parts, german and " und " or " and ")
end

local function playerMoney(player)
    local result = 0
    for _, coin in ipairs(COINS) do
        result = result + player:countItem(coin.id) * coin.value
    end
    return result
end

local function takeMoney(player, value)
    local remaining = value
    local owned = {}
    local removed = {}
    for index, coin in ipairs(COINS) do
        owned[index] = player:countItem(coin.id)
        removed[index] = 0
    end

    local function remove(index, count)
        if count <= 0 then
            return true
        end
        local rest = player:eraseItem(COINS[index].id, count)
        removed[index] = removed[index] + count - rest
        return rest == 0
    end

    local function rollback()
        for index, count in ipairs(removed) do
            if count > 0 then
                player:createItem(COINS[index].id, count, 333, 0)
            end
        end
    end

    for index = #COINS, 1, -1 do
        local coin = COINS[index]
        local count = math.min(owned[index], math.floor(remaining / coin.value))
        if count > 0 then
            if not remove(index, count) then
                rollback()
                return false
            end
            remaining = remaining - count * coin.value
            owned[index] = owned[index] - count
        end
    end
    if remaining > 0 then
        for index, coin in ipairs(COINS) do
            if owned[index] > 0 and coin.value > remaining then
                if not remove(index, 1) then
                    rollback()
                    return false
                end
                local change = coin.value - remaining
                local changeCreated = {}
                for changeIndex, changeCoin in ipairs(COINS) do
                    local count = math.floor(change / changeCoin.value)
                    if count > 0 then
                        if player:createItem(changeCoin.id, count, 333, 0) ~= 0 then
                            for createdIndex, createdCount in pairs(changeCreated) do
                                player:eraseItem(COINS[createdIndex].id, createdCount)
                            end
                            rollback()
                            return false
                        end
                        changeCreated[changeIndex] = count
                        change = change - count * changeCoin.value
                    end
                end
                return true
            end
        end
    end
    return remaining == 0
end

local function giveMoney(player, value)
    local created = {}
    for _, coin in ipairs(COINS) do
        local count = math.floor(value / coin.value)
        value = value - count * coin.value
        local rest = count > 0 and player:createItem(coin.id, count, 333, 0) or 0
        table.insert(created, { coin = coin, count = count - rest })
        if rest > 0 then
            for _, result in ipairs(created) do
                if result.count > 0 then
                    player:eraseItem(result.coin.id, result.count)
                end
            end
            return false
        end
    end
    return true
end

local function requestedCount(message)
    local count = tonumber(string.match(message, "%d+")) or 1
    return math.max(1, math.floor(count))
end

local function showTradeMenu(state, context, buyingFromPlayer)
    local menu = MenuStruct()
    for _, item in ipairs(state.stock) do
        local price = buyingFromPlayer and item.buyPrice or item.sellPrice
        if price > 0 then
            menu:addItem(item.item)
        end
    end
    context.player:sendMenu(menu)
    context.player:changeSource(context.npc)
end

function Trading.showTrades(spec, context)
    local state = loadState(spec.trade)
    if state == nil then
        return false
    end
    showTradeMenu(state, context, false)
    return true
end

function Trading.chat(spec, context, payload)
    local state = loadState(spec.trade)
    local message = payload and payload.message
    if state == nil or type(message) ~= "string" then
        return false
    end

    local lowered = string.lower(message)
    local item = findItem(state, lowered)
    local count = requestedCount(lowered)

    local asksForPurchaseList = string.find(lowered, "what.+buy") or string.find(lowered, "was.*kauf")
        or string.find(lowered, "welch.+waren.*kauf")
    local asksForSaleList = string.find(lowered, "list.+your.+ware") or string.find(lowered, "welch.+waren.*verkauf")
    if asksForPurchaseList or asksForSaleList then
        showTradeMenu(state, context, asksForPurchaseList ~= nil)
        if asksForPurchaseList then
            say(context, "Diese Waren kaufe ich.", "These are the wares I buy.")
        else
            say(context, "Diese Waren verkaufe ich.", "These are the wares I sell.")
        end
        return true
    end

    if string.find(lowered, "price") or string.find(lowered, "what.+cost") or string.find(lowered, "preis")
        or string.find(lowered, "was.+kost") or string.find(lowered, "wieviel.+kost") then
        if item == nil or item.sellPrice == 0 then
            say(context, "Das verkaufe ich nicht.", "I do not sell that item.")
        else
            local price = adjustedPrice(item.sellPrice, item.amount, item.defaultAmount)
            say(context, itemName(item, context.player) .. " kostet " .. moneyText(price, true) .. ".",
                "The " .. itemName(item, context.player) .. " costs " .. moneyText(price, false) .. ".")
        end
        return true
    end

    if string.find(lowered, "you.+pay") or string.find(lowered, "how much.+for")
        or string.find(lowered, "wieviel.+zahl") or string.find(lowered, "was.+zahl") then
        if item == nil or item.buyPrice == 0 then
            say(context, "Das kaufe ich nicht.", "I do not buy that item.")
        else
            local price = adjustedPrice(item.buyPrice, item.amount, item.defaultAmount)
            say(context, "Dafür zahle ich " .. moneyText(price, true) .. ".",
                "I would pay " .. moneyText(price, false) .. " for that.")
        end
        return true
    end

    if string.find(lowered, "buy") or string.find(lowered, "kauf") then
        if item == nil or item.sellPrice == 0 then
            say(context, "Das verkaufe ich nicht.", "I do not sell that item.")
            return true
        end
        local unitPrice = adjustedPrice(item.sellPrice, item.amount + count, item.defaultAmount)
        local price = unitPrice * count
        if item.amount ~= INFINITE_STOCK and item.amount < count then
            say(context, "Das habe ich im Moment nicht in ausreichender Menge.", "I do not have enough of that in stock.")
        elseif playerMoney(context.player) < price then
            say(context, "Kommt wieder, wenn Ihr genug Geld habt!", "Come back when you have enough money!")
        else
            local quality = math.random(item.quality[1], item.quality[#item.quality]) * 100
                + math.random(item.durability[1], item.durability[#item.durability])
            local rest = context.player:createItem(item.item, count, quality, item.data)
            if rest ~= 0 then
                if rest < count then
                    context.player:eraseItem(item.item, count - rest)
                end
                say(context, "Ihr habt nicht genug Platz im Inventar.", "You do not have enough room in your inventory.")
            else
                if not takeMoney(context.player, price) then
                    context.player:eraseItem(item.item, count)
                    say(context, "Kommt wieder, wenn Ihr genug Geld habt!", "Come back when you have enough money!")
                else
                    if item.amount ~= INFINITE_STOCK then
                        item.amount = item.amount - count
                        state.cash = state.cash + price
                    end
                    say(context, "Bitte sehr. Das macht " .. moneyText(price, true) .. ".",
                        "Here you are. That makes " .. moneyText(price, false) .. ".")
                end
            end
        end
        return true
    end

    if string.find(lowered, "sell") or string.find(lowered, "verkauf") then
        if item == nil or item.buyPrice == 0 then
            say(context, "Das kaufe ich nicht.", "I do not buy that item.")
            return true
        end
        local unitPrice = adjustedPrice(item.buyPrice, item.amount - count, item.defaultAmount)
        local price = unitPrice * count
        if context.player:countItem(item.item) < count then
            say(context, "Kommt wieder, wenn Ihr das habt!", "Come back when you have that!")
        elseif state.cash < price then
            say(context, "Ich habe nicht genug Geld dafür.", "I do not have enough money for that.")
        else
            local rest = context.player:eraseItem(item.item, count)
            if rest ~= 0 then
                if rest < count then
                    context.player:createItem(item.item, count - rest, 333, item.data)
                end
                say(context, "Kommt wieder, wenn Ihr das habt!", "Come back when you have that!")
            elseif not giveMoney(context.player, price) then
                context.player:createItem(item.item, count, 333, item.data)
                say(context, "Ihr habt nicht genug Platz im Inventar.", "You do not have enough room in your inventory.")
            else
                if item.amount ~= INFINITE_STOCK then
                    item.amount = item.amount + count
                    state.cash = state.cash - price
                end
                say(context, "Dafür gebe ich Euch " .. moneyText(price, true) .. ".",
                    "I give you " .. moneyText(price, false) .. " for that.")
            end
        end
        return true
    end

    return false
end

return Trading
