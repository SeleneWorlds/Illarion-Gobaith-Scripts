require("base.orders")

local M = {}

--[[
    Sperrfristeffekt: Falls ein Char zu viele offene Auftr�ge hat ohne diese zu erf�llen
    wird eine Sperrfrist angelegt. Innerhalb dieser Zeit kann der Char
    keine neuen Auftr�ge annehmen
    ]]--



function M.callEffect(eff, User)
   --nach dem ersten Aufruf entfernen
   return false;
end

function M.addEffect(eff, User)
    --eff.nextCalled = OrderRetentationPeriod * 600;
end

function M.removeEffect(eff,User)
    --beim entfernen die Vertrauensw�rdigkeit erh�hen aber wert f�r gute Auftr�ge senken
    base.orders.setThrustWorthyness(User,
        base.orders.ThrustworthynessChangeAfterRetentionPeriod,
        base.orders.GoodOrderChangeAfterRetentionPeriod);
end

function M.loadEffect(eff, User)
end


return M
