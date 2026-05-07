require("base.common")
local M = {}

---------------------------
---- Long time effect for each magic char
-----------------------------
function M.addEffect(magicEffect, Character)
    magicEffect:addValue("magicWater",50);
    magicEffect:addValue("magicFire",50);
--    magicEffect:addValue("magicAir",50);
--    magicEffect:addValue("magicEarth",50);
--    magicEffect:addValue("magicSpirit",50);
--    magicEffect:addValue("magicEvil",50);
end

-----------------------------------------------
---- Character is affected by the effect --
-------------------------------------------------
function M.callEffect(magicEffect, Character)    -- Effekt wird ausgeführt
return true;
end


function M.removeEffect( Effect, Character )

end

function M.loadEffect(Effect, Character)

end


return M
