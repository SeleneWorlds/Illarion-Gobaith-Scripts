local M = {}
local permissions = {
    ["trollsbane"] = {[1781588520]=true},
    ["vanima"] = {[1750279883]=true, [1376856181]=true},
    ["varshikar"] = {[236680154]=true, [1861347947]=true},
    ["silverbrand"] = {[1323381921]=true},
    ["greenbriar"] = {[1737681585]=true, [2010588785]=true},
}

local function say(context, german, english)
    context.npc:talk(Character.say, context.player:getPlayerLanguage() == 0 and german or english)
end

function M.collect(context, account)
    local allowed = assert(permissions[account], 'Unknown tax account ' .. tostring(account))
    if not allowed[context.player.id] then
        say(context, 'Ja. Ich sammel die Steuern der Händler ein. Aber euch geb ich diese Gelder ganz sicher nicht.',
            "Indeed. I collect the money of the traders. But i won't give you these money.")
        return
    end
    local taxes = require('taxes')
    local amount = taxes.collect(account)
    if amount == 0 then
        say(context, 'Die Steuerkasse ist zur Zeit leider leer.', 'There is currently no tax money.')
        return
    end
    local money = require('base.money')
    local ok, paid = pcall(money.GiveMoneyToChar, context.player, amount)
    if not ok or not paid then
        taxes.add(account, amount)
        if not ok then error(paid) end
        say(context, 'Ihr habt keinen Platz für das Steuergeld. Macht Platz und kommt wieder.',
            'You have no room for the tax money. Make room and come back.')
        return
    end
    local german, english = money.MoneyToString(amount)
    say(context, 'Hier habt ihr die' .. german .. ' aus der Steuerkasse.',
        'There you got the' .. english .. ' from the tax money.')
end

return M
