local parent = require("item.general.wood")
local M = {}

-- Angeln mit neuem Collecting-System
-- Blay09

-- UPDATE common SET com_script='item.id_72_fishingrod' WHERE com_itemid=72;

local general_wood = require("item.general.wood")
local common = require("base.common")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local catches = Rolls:new()
catches:registerType("item", items.item)
catches:registerType("nothing", items.nothing)

local base_lookat = require("base.lookat")

function M.UseItemWithField(User, SourceItem, TargetPos, Counter, Param, ltstate)
    common.ResetInterruption(User, ltstate);
	if (ltstate == Action.abort) then -- Arbeit unterbrochen
        if (User:increaseAttrib("sex", 0) == 0) then
            gText = "seine";
            eText = "his";
        else
            gText = "ihre";
            eText = "her";
        end
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.");
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.");
        return
    end

    if not common.CheckItem(User, SourceItem) then -- Sicherheitscheck
        return
    end
	
	-- Angeln unterirdisch nicht möglich
    if (TargetPos.z < 0) then
    	common.InformNLS(User, "In unterirdischen Wasserlöchern wird das Angeln kaum erfolgreich sein.", "Fishing in underground waterholes wouldn't be successful.");
		return
    end
	
	if common.Encumbrence(User) then -- Behinderung
        common.InformNLS(User,
        "Deine Rüstung behindert dich beim Fischen.",
        "Your armor disturbes you while fishing.");
        return
    end
	
	if not common.AutoEquipTool(User, SourceItem) then
	    return
	end
	
	if not common.IsLookingAt(User, TargetPos) then -- Drehen wenn nötig
        common.TurnTo(User, TargetPos);
    end
	
	if (ltstate == Action.none) then -- Untätig: Starte Angeln!
        User:startAction(work.time(User, "fishing", SourceItem), 0, 0, 0, 0);
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me beginnt zu fischen.");
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me starts fishing.");
        return
    end
	
	if not work.check(User, "fishing") then
		return
	end
	
    local definition = assert(Registries.findByName("illarion:fishing", "illarion:default"))
    local output = { user = User }
    catches:roll(definition:getField("catch"), output)
    if output.overflow then return false end
    User:learn(2, "fishing", output.produced and 2 or 1, 100)

	-- GFX + Sound
	world:gfx(11,TargetPos);
    world:makeSound(9,TargetPos);
	
	if common.ToolBreaks(User, SourceItem, true) then -- Angel beschädigen
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me lässt die Angel aus den Händen rutschen und die Angel sinkt auf den Grund.");
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me lets the fishing rod slip out of the hands and it sinks to the ground.");
        return
    end
	
    User:startAction(work.time(User, "fishing", SourceItem), 0, 0, 0, 0);

end

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
    if (TargetItem.id == 0) then
        M.UseItemWithField(User,SourceItem,common.GetFrontPosition(User),counter,param, ltstate);
    else
        M.UseItemWithField(User,SourceItem,TargetItem.pos,counter,param, ltstate);
    end
end

function M.LookAtItem( User, Item )
    world:itemInform( User, Item, base_lookat.GetItemDescription( User, Item, 2, false, false ));
end

if M.UseItem == nil then M.UseItem = parent.UseItem end
if M.UseItemWithField == nil then M.UseItemWithField = parent.UseItemWithField end
if M.UseItemWithCharacter == nil then M.UseItemWithCharacter = parent.UseItemWithCharacter end
if M.LookAtItem == nil then M.LookAtItem = parent.LookAtItem end
if M.LookAtPaintingItem == nil then M.LookAtPaintingItem = parent.LookAtPaintingItem end
if M.MoveItemBeforeMove == nil then M.MoveItemBeforeMove = parent.MoveItemBeforeMove end
if M.MoveItemAfterMove == nil then M.MoveItemAfterMove = parent.MoveItemAfterMove end
if M.CharacterOnField == nil then M.CharacterOnField = parent.CharacterOnField end
if M.ItemRotsOnField == nil then M.ItemRotsOnField = parent.ItemRotsOnField end

return M
