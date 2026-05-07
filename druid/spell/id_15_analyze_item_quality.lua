--ds_druidspell_15.lua / 1. Rune des Meisters
--Druidensystem
--Falk

require("base.common")

local M = {}
-- INSERT INTO spells VALUES (2^14,3,'druid.spell.id_15_analyze_item_quality');

function M.unitDecleration()
  if firsttime == nil then
    ListDE = {}
    ListEN = {}
    ListDE ={"marode", "schlechte", "m��ige", "unauff�llige", "brauchbare", "gute", "sehr gute", "hervorragende", "�berragende"}
    ListEN ={"ramshackle","bad","undistinguished","modest","usable","good", "very good","excellent","superior" }
    firsttime = 1
  end
end

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #15.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #15.2")
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #15.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param,ltstate)
--Caster:inform("debug #15.4")
  --Quality eines Items feststellen
  M.unitDecleration()
  ergebnis = math.floor(TargetItem.quality/100)
  base.common.InformNLS( Caster,
                "#b|0|0|die Pr�fung ergibt eine "..ListDE[ergebnis].." Qualit�t",
                "#b|0|0|this inspection results a "..ListEN[ergebnis].." quality" )
end

return M
