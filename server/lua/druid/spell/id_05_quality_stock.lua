local Books = require("illarion-script-loader.server.lua.lib.books")
--ds_druidspell_05.lua / 5. Rune des Lehrlings
--Druidensystem
--Falk

local common = require("base.common")
local alchemy = require("druid.base.alchemy")

local M = {}
-- INSERT INTO spells VALUES (2^4,3,'druid.spell.id_05_quality_stock');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #05.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #05.2")
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #05.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param,ltstate)
--Caster:inform("debug #05.4")
--Analyse eines Sudes auf Quality
  if TargetItem.id == 331 and TargetItem.data ~=0 then
    qualstat = TargetItem.quality

--  common.InformNLS(Caster,
    textDE="Dieser Sud hat eine "..alchemy.qListDe[qualstat].." Qualität"
    textEN="This stock has a "..alchemy.qListEn[qualstat].." quality"
    if Caster:getPlayerLanguage() == 0 then
		Books.show(Caster, textDE, 0)
	else
		Books.show(Caster, textEN, 0)
	end

	Caster:learn(6,"exquirere",3,100)

  else
    common.InformNLS(Caster,
       "Das ist kein Pflanzensud",
       "This is no stock")
  end
end

return M
