local M = {}
local months = {'Elos','Tanos','Zhas','Ushos','Siros','Ronas','Bras','Eldas','Irmas','Malas','Findos','Olos','Adras','Naras','Chos','Mas'}

function M.date(context)
    local day, month, year = world:getTime('day'), world:getTime('month'), world:getTime('year')
    local name = months[month] or tostring(month)
    local text = context.player:getPlayerLanguage() == 0
        and ('Es ist der ' .. day .. '. Tag des Monates ' .. name .. ' im Jahre ' .. year .. '.')
        or ("It's day " .. day .. ' of ' .. name .. ' of the year ' .. year .. '.')
    context.npc:talk(Character.say, text)
end

return M
