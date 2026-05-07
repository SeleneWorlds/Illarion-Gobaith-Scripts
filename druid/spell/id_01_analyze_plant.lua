--ds_druidspell_01.lua / 1. Rune des Lehrlings
--Druidensystem
--Falk

require("base.common")
local alchemy = require("druid.base.alchemy")
local plants = require("druid.base.plants")

local M = {}
-- INSERT INTO spells VALUES (2^0,3,'druid.spell.id_01_analyze_plant');

function M.CastMagic(Caster,counter,param,ltstate)
	--Caster:inform("debug #01.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
	--Caster:inform("debug #01.2")
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
	--Caster:inform("debug #01.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param)
	--Caster:inform("debug #01.4")
	--Analyse einer Pflanze

	if (alchemy.IsThatAPlant(TargetItem) == true) then

		language = Caster:getPlayerLanguage()
		pflanzenname = world:getItemName(TargetItem.id,language)

		-- Manche Pflanzen haben Doppelfunktionen und bekommen eine neue ID
		if TargetItem.data >9000 and TargetItem.data < 9017 then
			dummy = TargetItem.data

			for i=1,16 do
				if plants.dummyIDList[i] == dummy then
					if language == 0 then
						pflanzenname = plants.dummyNameListDE[i]
					else
						pflanzenname = plants.dummyNameListEN[i]
					end
				end
			end
		else
			dummy =TargetItem.id
		end

		plusWertPos,minusWertPos = alchemy.SplitPlantData(dummy)

		textDE= pflanzenname.." hat Einfluss auf den Gehalt an "..alchemy.wirkstoff[plusWertPos].." und "..alchemy.wirkstoff[minusWertPos].." eines Trankes"
		textEN= pflanzenname.." exert influence to the assay of "..alchemy.wirkstoff[plusWertPos].." and "..alchemy.wirkstoff[minusWertPos].." of a potion"

		if Caster:getPlayerLanguage() == 0 then
			Caster:inform("#b|0|0|"..textDE)
		else
			Caster:inform("#b|0|0|"..textEN)
		end

		Caster:learn(6,"vegetabilistia",3,100)

	else
		base.common.InformNLS(Caster,
		"Das ist keine Heilpflanze","This is not a medicinal plant")
	end
end

return M
