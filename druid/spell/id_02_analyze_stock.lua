-- ds_druidspell_02.lua / 2. Rune des Lehrlings
--Druidensystem
--Falk

local common = require("base.common")
local alchemy = require("druid.base.alchemy")

local M = {}
-- INSERT INTO spells VALUES (2^1,3,'druid.spell.id_01_analyze_plant');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #02.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #02.2")

end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #02.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param)
  --Analyse eines Sudes (nur 1 Wert)
  --Caster:inform("debug #02.4")

  if TargetItem.id == 331 then
    dataZList = alchemy.SplitBottleData(Caster,TargetItem.data)
    i = math.random(#dataZList)
    textDE= "Dieser Sud enth�lt "..alchemy.wirkung_de[dataZList[i]].." "..alchemy.wirkstoff[i]
    textEN= "This stock contains "..alchemy.wirkung_en[dataZList[i]].." "..alchemy.wirkstoff[i]

    if Caster:getPlayerLanguage() == 0 then
      Caster:inform("#b|0|0|"..textDE)
    else
      Caster:inform("#b|0|0|"..textEN)
    end
      Caster:learn(6,"exquirere",3,100)

  else
    common.InformNLS(Caster,
    "Das ist kein Kr�utersud","This is not a stock")
  end
end

return M
