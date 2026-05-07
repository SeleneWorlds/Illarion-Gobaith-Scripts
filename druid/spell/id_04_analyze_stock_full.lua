--ds_druidspell_04.lua / 4. Rune des Lehrlings
--Druidensystem
--Falk

require("base.common")
local alchemy = require("druid.base.alchemy")

local M = {}
-- INSERT INTO spells VALUES (2^3,3,'druid.spell.id_04_analyze_stock_full');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #04.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #04.2")
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #04.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param)
--Caster:inform("debug #04.4")
--Analyse eines Sudes (komplett)
  if TargetItem.id == 331 then
    dataZList = alchemy.SplitBottleData(Caster,TargetItem.data)
    local TextDE = "Diese Flasche enth�lt:\n";
	  local TextEN = "This bottle contains:\n";
	  local anySubstance = false;
    for i = 1,#dataZList do
      if dataZList[i]~= 5 then
		    anySubstance = true;
		  TextDE = TextDE.."\n"..alchemy.wirkung_de[dataZList[i]].." "..alchemy.wirkstoff[i];
		  TextEN = TextEN.."\n"..alchemy.wirkung_en[dataZList[i]].." "..alchemy.wirkstoff[i];
      end
    end

	  if not anySubstance then
	    TextDE = TextDE.."\n".."nichts";
		  TextEN = TextEN.."\n".."nothing";
	  end

	Caster:learn(6,"exquirere",3,100)

	  if Caster:getPlayerLanguage() == 0 then
		Caster:inform("#b|0|0|"..TextDE)
	else
		Caster:inform("#b|0|0|"..TextEN)
	end

  end
end

return M
