--ds_druidspell_03.lua / 3. Rune des Lehrlings
--Druidensystem
--Falk

local common = require("base.common")
local alchemy = require("druid.base.alchemy")

local M = {}
-- INSERT INTO spells VALUES (2^2,3,'druid.spell.id_03_quality_plant');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #03.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #03.2")

end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #03.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param)
--Caster:inform("debug #03.4")
--Analyse einer Pflanze (Qualit�t)

  if (alchemy.IsThatAPlant(TargetItem) == true) then
    qualstat = math.floor(TargetItem.quality/100)

    textDE= "Diese Pflanze hat eine "..alchemy.qListDe[qualstat].." Qualit�t"
    textEN= "This plant has a "..alchemy.qListEn[qualstat].." quality"

    if Caster:getPlayerLanguage() == 0 then
		Caster:inform("#b|0|0|"..textDE)
	else
		Caster:inform("#b|0|0|"..textEN)
	end

	Caster:learn(6,"vegetabilistia",3,100)

  else
    common.InformNLS(Caster,
        "Das ist keine Heilpflanze",
        "This is not a medicinal plant")
  end
end

return M
