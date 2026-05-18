-- LTE f�r das Druidensystem
-- by Falk
-- immunity. Has actually nothing to do with healing potion 328 orange bottle

local M = {}
-- INSERT INTO longtimeeffects VALUES (328, 'druids_immunity', 'druid.lte.id_328_immunity');

function M.getAction(Character,Effect,Runde)
--Hier die eigentlichen Aktionen eintragen
end

function M.addEffect(Effect, Character)               -- Nur beim ersten Aufruf
--Character:inform("debug func M.addEffect")
end

function M.callEffect(Effect,Character)                  -- Effect wird ausgef�hrt

	local foundImmunity, immunity, retVal = nil,nil,false;
	for i=1,8 do
		foundImmunity, immunity = Effect:findValue("immunity_"..i);
		if foundImmunity then
			if immunity == 0 then
				Effect:removeValue("immunity_"..i);
			else
				Effect:addValue("immunity_"..i,immunity-1);
				retVal = true;
			end
		end
	end
	Effect.nextCalled = 10;
	return retVal;
end

function M.removeEffect(Effect,Character)
--Character:inform("debug func M.removeEffect")
end

function M.loadEffect(Effect,Character)                  -- wenn der Charakter erneut einloggt
--Character:inform("debug func M.loadEffect")
end

return M
