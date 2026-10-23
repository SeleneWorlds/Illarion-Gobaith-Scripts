local M = {}

-- UPDATE common SET com_script='item.id_12_campfire' where com_itemid=12;

local common = require("base.common")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local yields = Rolls:new()
yields:registerType("item", items.item)
yields:registerType("nothing", items.nothing)

local function findRecipe(user)
    local selected
    for _, recipe in pairs(Registries.findAll("illarion:potash_recipes")) do
        local input = recipe:getField("input")
        if user:countItemAt(input.location, input.id) >= input.quantity
            and (not selected or recipe:getField("priority") < selected:getField("priority")) then
            selected = recipe
        end
    end
    return selected
end


function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    if ( ltstate == Action.abort ) then
        if (User:increaseAttrib("sex",0) == 0) then
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
    
    if not common.CheckItem( User, SourceItem, {12} ) then
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim Asche herstellen.",
        "Your armor disturbes you while producing potash." );
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then
        common.TurnTo( User, SourceItem.pos );
    end

    if not common.FitForWork( User ) then
        return
    end
    
    local recipe = findRecipe(User)
    if not recipe then
        if (ltstate ~= Action.success) then
            common.InformNLS(User,
            "Du benötigst Holz um daraus Asche herzustellen.",
            "You need wood to produce potash.");
        end
        return
    end
    
    if ( ltstate == Action.none ) then
        User:startAction(work.time(User, "potashproducing"), 0, 0, 7, 15);
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me beginnt Asche herzustellen.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english, "#me starts to produce potash.", { showInChat = false });
        return
    end
    
    if not work.check(User, "potashproducing") then
		return
	end
    
    local yield = recipe:getField("yield")
    yields:validate(yield)
    local input = recipe:getField("input")
    User:eraseItem(input.id, input.quantity)
    local output = { user = User }
    yields:roll(yield, output)
    if not output.overflow then
        User:startAction(work.time(User, "potashproducing"), 0, 0, 7, 15)
    end
    common.GetHungry( User, 200 );
end -- function

function M.CharacterOnField(User)
    common.InformNLS( User,
      "Du fühlst Schmerzen vom brennenden Feuer.",
      "You can feel the pain from the burning fire." );
    if not (User:getQuestProgress(2) > 0) and not (User:increaseAttrib("hitpoints",0) < 2000) then
		User:increaseAttrib("hitpoints",-math.random(200,400));
	end
end

return M
