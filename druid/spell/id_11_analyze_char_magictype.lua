--ds_druidspell_11.lua / 4. Rune des Gesellen
--Druidensystem
--Falk

require("base.common")

local M = {}
-- INSERT INTO spells VALUES (2^10,3,'druid.spell.id_11_analyze_char_magictype');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #11.1")
end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #11.2")
	if Caster:getSkill("exquirere")>math.random(100) then
		--Feststellung der Magieklasse von TI
		klassenDE = {"Magie","Priester","Barde","Druide"}
		klassenEN = {"mage","priest","bard","druid"}
		local magieklasse=TargetCharacter:getMagicType()
		textDE="Magiezugeh�rigkeit: "..klassenDE[magieklasse+1]
		textEN="Magic classification: "..klassenEN[magieklasse+1]
		if Caster:getPlayerLanguage() == 0 then
			Caster:inform("#b|0|0|"..textDE)
		else
			Caster:inform("#b|0|0|"..textEN)
		end

	Caster:learn(6,"ars magica",3,100)

	else
    base.common.InformNLS( Caster,
        "Deine F�higkeiten reichen noch nicht aus.",
        "Your abilities do not last out yet."
    );
	end

end

function M.CastMagicOnField(Caster,TargetPos,counter,param,ltstate)
--Caster:inform("debug #11.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param,ltstate)
--Caster:inform("debug #11.4")
end

return M
