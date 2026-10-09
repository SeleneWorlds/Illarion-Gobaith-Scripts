--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
--- Base NPC script for trader NPCs
--
-- This script offers the functions that are required to turn an NPC into a trader
--
-- Author: Martin Karing

local class = require("base.class").class
local common = require("base.common")
local lookat = require("base.lookat")
local messages = require("base.messages")
local money = require("base.money")
local baseNPC = require("npc.base.basic")

local isFittingItem
local tradeNPCItem

local tradeNPC = class(function(self, rootNPC)
    if rootNPC == nil or not rootNPC:is_a(baseNPC) then
        return
    end
    self["_parent"] = rootNPC

    self["_sellItems"] = {}

    self["_buyPrimaryItems"] = {}
    self["_buySecondaryItems"] = {}

    self["_wrongItemMsg"] = messages.Messages()
    self["_notEnoughMoneyMsg"] = messages.Messages()
    self["_dialogClosedMsg"] = messages.Messages()
    self["_dialogClosedNoTradeMsg"] = messages.Messages()
end)

function tradeNPC:addItem(item)
    if (item == nil or not item:is_a(tradeNPCItem)) then
        return
    end

    if (item._type == "sell") then
        table.insert(self._sellItems, item)
    else
        if (item._itemId == 97 or item._itemId == 320 or item._itemId == 321
            or item._itemId == 799 or item._itemId == 1367 or item._itemId == 2830) then
            print("NPC can't buy item " .. item._itemId .. " because its blacklisted (container).")
        else
            if item._type == "buyPrimary" then
                table.insert(self._buyPrimaryItems, item)
            elseif item._type == "buySecondary" then
                table.insert(self._buySecondaryItems, item)
            end
        end
    end
end

function tradeNPC:addWrongItemMsg(msgGerman, msgEnglish)
    self._wrongItemMsg:addMessage(msgGerman, msgEnglish)
end

function tradeNPC:addNotEnoughMoneyMsg(msgGerman, msgEnglish)
    self._notEnoughMoneyMsg:addMessage(msgGerman, msgEnglish)
end

function tradeNPC:addDialogClosedMsg(msgGerman, msgEnglish)
    self._dialogClosedMsg:addMessage(msgGerman, msgEnglish)
end

function tradeNPC:addDialogClosedNoTradeMsg(msgGerman, msgEnglish)
    self._dialogClosedNoTradeMsg:addMessage(msgGerman, msgEnglish)
end

-- MenuStruct has item slots and no quantity input: buy an offer stack or sell
-- an inventory stack. Map slots, rather than item IDs, so ticket variants work.
function tradeNPC:showDialog(npcChar, player)
    local entries = {}
    for index, item in ipairs(self._sellItems) do
        entries[#entries + 1] = {offer=item, index=index - 1, count=item._stack, buying=true}
    end
    local seen = {}
    for _, list in ipairs({self._buyPrimaryItems, self._buySecondaryItems}) do
        for _, offer in ipairs(list) do
            if not seen[offer._itemId] then
                seen[offer._itemId] = true
                for _, item in ipairs(player:getItemList(offer._itemId)) do
                    if isFittingItem(offer, item) then
                        entries[#entries + 1] = {offer=offer, item=item, count=item.number, buying=false}
                    end
                end
            end
        end
    end
    if #entries == 0 then return end
    local menu = MenuStruct(common.GetNLS(player, "Handel", "Trade"), function(dialog)
        if not dialog.success then
            if self._dialogClosedNoTradeMsg:hasMessages() then
                local de, en = self._dialogClosedNoTradeMsg:getRandomMessage()
                npcChar:talk(Character.say, common.GetNLS(player, de, en))
            end
            return
        end
        local entry = entries[dialog.selectedItemIndex]
        if not entry or not npcChar:isInRange(player, 2) then return end
        if entry.buying then
            self:sellItemToPlayer(npcChar, player, entry.index, entry.count)
        else
            -- Revalidate ownership after the menu was opened.
            for _, current in ipairs(player:getItemList(entry.offer._itemId)) do
                if current.SeleneInventoryItem ~= nil and current.SeleneInventoryItem == entry.item.SeleneInventoryItem then
                    self:buyItemFromPlayer(npcChar, player, current)
                    break
                end
            end
        end
    end)
    for _, entry in ipairs(entries) do
        local item = entry.offer
        local quality = entry.buying and item._quality or entry.item.quality
        local data = entry.buying and item._data or nil
        menu:addItem(item._itemId, quality, data and tonumber(data.data) or 0)
    end
    menu.lookAt = function(slot)
        local entry = entries[slot]
        if not entry then return nil end
        local item = entry.offer
        local action = entry.buying and common.GetNLS(player, "Kaufen", "Buy") or common.GetNLS(player, "Verkaufen", "Sell")
        local de, en = money.MoneyToString(item._price * entry.count)
        return {name=action .. " " .. entry.count .. " " .. common.GetNLS(player, item._nameDe, item._nameEn) .. " - " .. common.GetNLS(player, de, en)}
    end
    player:sendMenu(menu)
end

function isFittingItem(tradeItem, boughtItem)

    if (tradeItem._itemId ~= boughtItem.id) then
        return false
    end

    if (tradeItem._data ~= nil and tradeItem._data ~= boughtItem.data) then
        return false
    end

    return true
end

function tradeNPC:buyItemFromPlayer(npcChar, player, boughtItem)

    local glyphEff = tonumber(boughtItem:getData("glyphEffNo"))
    if nil~= glyphEff and glyphEff > 0 then
        player:inform("NPCs kaufen keine Gegenstände mit Glyphen.","NPCs do not buy glyphed items.", Character.highPriority)
        return
    end

    if lookat.hasSocketedGems(boughtItem) then
        player:inform("NPCs kaufen keine Gegestände mit gesockelten Edelsteinen.","NPCs don't buy gemmed items.", Character.highPriority)
        return
    end

    -- Buying at special price
    local item

    local primary = false

    for _, listItem in pairs(self._buyPrimaryItems) do
        if isFittingItem(listItem, boughtItem) then
            item = listItem
            primary = true
            break
        end
    end

    if item == nil then
        for _, listItem in pairs(self._buySecondaryItems) do
            if isFittingItem(listItem, boughtItem) then
                item = listItem
                break
            end
        end
    end

    local price

    if item then
        price = item._price
    end

    local customWorth = boughtItem:getData("remainingValue")



    if not common.IsNilOrEmpty(customWorth) and item then
        if primary then
            price = customWorth*0.1
        else
            price = customWorth*0.05
        end
    end

    if item then
        price = price * boughtItem.number
        local priceStringGerman, priceStringEnglish = money.MoneyToString(price)
        local itemName = common.GetNLS(player, world:getItemName(boughtItem.id,0), world:getItemName(boughtItem.id,1))
        local customName = common.GetNLS(player, boughtItem:getData("nameDe"), boughtItem:getData("nameEn"))

        if not common.IsNilOrEmpty(customName) then
            itemName = customName
        end

        if world:erase(boughtItem, boughtItem.number) then
            if (money.GiveMoneyToChar(player, price) == false) then
                money.GiveMoneyToPosition(player.pos, price)
            end

            common.InformNLS(player, "Du hast "..boughtItem.number.." "..itemName.." zu einem Preis von "..priceStringGerman.." verkauft.", "You sold "..boughtItem.number.." "..itemName.." at a price of "..priceStringEnglish..".")
            world:makeSound(24, player.pos)

        end

        return
    end

    -- Reject item
    if (self._wrongItemMsg:hasMessages()) then
        local msgGerman, msgEnglish = self._wrongItemMsg:getRandomMessage()
        npcChar:talk(Character.say, msgGerman, msgEnglish)
    end
end

function tradeNPC:sellItemToPlayer(npcChar, player, itemIndex, amount)
    local item = self._sellItems[itemIndex + 1]
    if (item == nil) then
        common.InformNLS(player, "Ein Fehler ist beim Kauf des Items aufgetreten.", "An error occurred while buying the item.")
        return
    end

    if (money.CharHasMoney(player, item._price * amount)) then
        money.TakeMoneyFromChar(player, item._price * amount)
        local priceStringGerman, priceStringEnglish = money.MoneyToString(item._price * amount)

        common.CreateItem(player, item._itemId, amount, item._quality, item._data)
        local itemName = common.GetNLS(player, world:getItemName(item._itemId, 0), world:getItemName(item._itemId, 1))
        common.InformNLS(player, "Du hast "..amount.." "..itemName.." zu einem Preis von"..priceStringGerman.." gekauft.", "You bought "..amount.." "..itemName.." at a price of"..priceStringEnglish..".")
        world:makeSound(24, player.pos)

    elseif (self._notEnoughMoneyMsg:hasMessages()) then
        local msgGerman, msgEnglish = self._notEnoughMoneyMsg:getRandomMessage()
        npcChar:talk(Character.say, msgGerman, msgEnglish)
    end
end


tradeNPCItem = class(function(self, id, itemType, nameDe, nameEn, price, stack, quality, data)
    if (id == nil or id <= 0) then
        error("Invalid ItemID for trade item")
    end

    if (itemType ~= "sell" and itemType ~= "buyPrimary" and itemType ~= "buySecondary") then
        error("Invalid type for trade item")
    end

    self["_itemId"] = id
    self["_type"] = itemType

    if (nameDe == nil or nameEn == nil) then
        self["_nameDe"] = world:getItemName(id, Player.german)
        self["_nameEn"] = world:getItemName(id, Player.english)
    else
        self["_nameDe"] = nameDe
        self["_nameEn"] = nameEn
    end

    if (price == nil) then
        if (itemType == "sell") then
            self["_price"] = world:getItemStatsFromId(id).Worth
        elseif (itemType == "buyPrimary") then
            self["_price"] = world:getItemStatsFromId(id).Worth * 0.1
        elseif (itemType == "buySecondary") then
            self["_price"] = world:getItemStatsFromId(id).Worth * 0.05
        end
    else
        self["_price"] = price
    end

    if (itemType == "sell" and stack ~= nil) then
        self["_stack"] = stack
    else
        self["_stack"] = world:getItemStatsFromId(id).BuyStack
        if (self["_stack"] == nil) then
            print("_stack is NIL, the server failed! Hard.")
            self["_stack"] = 1
        end
    end

    if (itemType == "sell" and quality ~= nil) then
        self["_quality"] = quality
    else
        self["_quality"] = 580
    end

    if (itemType == "sell") then
        self["_data"] = data
    else
        self["_data"] = nil
    end
end)


tradeNPC["tradeNPCItem"] = tradeNPCItem
return tradeNPC
