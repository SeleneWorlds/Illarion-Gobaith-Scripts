local Books = require("illarion-script-loader.server.lua.lib.books")
--ds_druidspell_9.lua / 2. Rune des Gesellen
--Druidensystem
--Falk

local common = require("base.common")

local M = {}
-- INSERT INTO spells VALUES (2^8,3,'druid.spell.id_09_analyze_char_poison');

function M.CastMagic(Caster,counter,param,ltstate)
--Caster:inform("debug #09.1")
			end

function M.CastMagicOnCharacter(Caster,TargetCharacter,counter,param,ltstate)
--Caster:inform("debug #09.2")
	if Caster:getSkill("exquirere")>math.random(100) then
		--TargetChar auf "PoisonValue" abprüfen
	  if TargetCharacter:getPoisonValue() ~= 0 then

	    textDE="Der Patient hat eine Vergiftung, wovon auch immer"
	    textEN="The patient has an intoxication, whatever about"
		if Caster:getPlayerLanguage() == 0 then
			Books.show(Caster, textDE, 0)
		else
			Books.show(Caster, textEN, 0)
		end

	  else

	textDE="Keine Vergiftung, offenbar bumperlg'sund"
	textEN="Intoxication undiscernible"
	if Caster:getPlayerLanguage() == 0 then
		Books.show(Caster, textDE, 0)
	else
		Books.show(Caster, textEN, 0)
	end

	  end
    Caster:learn(6,"sanitas",3,100)
	else
    common.InformNLS( Caster,
        "Deine Fähigkeiten reichen noch nicht aus.",
        "Your abilities do not last out yet."
    );
	end
end

function M.CastMagicOnField(Caster,Targetpos,counter,param,ltstate)
--Caster:inform("debug #09.3")
end

function M.CastMagicOnItem(Caster,TargetItem,counter,param,ltstate)
--Caster:inform("debug #09.4")
end

return M
