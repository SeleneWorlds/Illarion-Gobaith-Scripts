local M = {}

-- Honig Sammeln mit neuem Collecting-System
-- Blay09

-- UPDATE common SET com_script='item.id_1005_beehive' WHERE com_itemid=1005;

local common = require("base.common")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local honey = Rolls:new()
honey:registerType("item", items.item)
honey:registerType("nothing", items.nothing)


function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption(User, ltstate);
	if (ltstate == Action.abort) then -- Arbeit unterbrochen
        if (User:increaseAttrib("sex", 0) == 0) then
            gText = "seine";
            eText = "his";
        else
            gText = "ihre";
            eText = "her";
        end
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.", { showInChat = false });
        return
    end
	
	if not common.CheckItem(User, SourceItem) then -- Sicherheitscheck
        return
    end
	
	if common.Encumbrence(User) then -- Behinderung
        common.InformNLS(User,
        "Deine Rüstung behindert dich beim Honig Sammeln.",
        "Your armor disturbs you while collecting honeycombs.");
        return
    end
	
	if (ltstate == Action.none) then -- Untätig: Starte Honig Sammeln!
        User:startAction(work.time(User, "honeygathering"), 0, 0, 0, 0);
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me beginnt nach Honig zu suchen.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me starts to search for honey.", { showInChat = false });
        return
    end
	
	if not work.check(User, "honeygathering") then
		return
	end
	
    local definition = assert(Registries.findByName("illarion:honey_harvests", "illarion:default"))
    local output = { user = User }
    honey:roll(definition:getField("yield"), output)
    if output.overflow then return false end
    User:learn(2, "peasantry", output.produced and 2 or 1, 100)

	User:startAction(work.time(User, "honeygathering", SourceItem), 0, 0, 0, 0);
end

return M
