local base_orders = require("base.orders")
local M = {}

--[[
    Sperrfristeffekt: Falls ein Char zu viele offene Aufträge hat ohne diese zu erfüllen
    wird eine Sperrfrist angelegt. Innerhalb dieser Zeit kann der Char
    keine neuen Aufträge annehmen
    ]]--



function M.callEffect(eff, User)
   --nach dem ersten Aufruf entfernen
   return false;
end

function M.addEffect(eff, User)
    --eff.nextCalled = OrderRetentationPeriod * 600;
end

function M.removeEffect(eff,User)
    --beim entfernen die Vertrauenswürdigkeit erhöhen aber wert für gute Aufträge senken
    base_orders.setThrustWorthyness(User,
        base_orders.ThrustworthynessChangeAfterRetentionPeriod,
        base_orders.GoodOrderChangeAfterRetentionPeriod);
end

function M.loadEffect(eff, User)
end


return M
