-- Run from the bundle root: lua tests/chat_trade_test.lua
package.path = 'server/lua/?.lua;' .. package.path
package.loaded['base.common'] = {InformNLS=function(_, _, message) error(message) end}
package.loaded['base.lookat'] = {hasSocketedGems=function() return false end}
Character = {say=1, whisper=2, yell=3}

local ChatTrade = require('npc.chat_trade')
local offer = {_itemId=1, _nameDe='Schinken', _nameEn='ham'}
local sold, bought
local trader = {
    _sellItems={offer}, _buyPrimaryItems={offer}, _buySecondaryItems={},
    buyItemFromPlayer=function(_, _, _, item) sold = sold + item.number end,
    sellItemToPlayer=function(_, _, _, index, amount)
        assert(index == 0)
        bought = bought + amount
    end,
}
local inventory = {id=1, number=10, getData=function() return nil end}
local player = {getItemList=function() return {inventory} end}
local receiver = ChatTrade.new(trader)
for _, text in ipairs({
    'I sell 6 ham.', 'I sell 6 ham', 'sell 6 ham.',
    'I want to sell 6 ham!', '[hum] I sell 6 ham.',
    'Ich möchte 6 Schinken verkaufen.', 'Ich will 6 Schinken verkaufen?',
    '  I sell 6 ham.  ',
}) do
    sold, bought = 0, 0
    assert(receiver:receiveText({}, Character.say, player, text), text)
    assert(sold == 6 and bought == 0, text)
    assert(inventory.number == 10, 'Inventory wrapper was modified')
end
for _, text in ipairs({'I buy 6 ham.', 'buy 6 ham', 'I want to buy 6 ham?'}) do
    sold, bought = 0, 0
    assert(receiver:receiveText({}, Character.say, player, text), text)
    assert(bought == 6 and sold == 0, text)
end
assert(not receiver:receiveText({}, Character.say, player, 'I like ham.'))
print('Chat trade tests passed')
