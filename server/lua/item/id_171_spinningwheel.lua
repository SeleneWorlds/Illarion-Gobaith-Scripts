local M = {}

-- Spinnrad ( 270 )

-- Wolle  --> Wollkneul
-- Sibanac --> Garn

-- Arbeitscyclus: 1s - 4s
-- Zusätzliches Werkzeug: Schere ( 6 )

-- UPDATE common SET com_script='item.id_171_spinningwheel' WHERE com_itemid IN (171);

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
    for _, recipe in pairs(Registries.findAll("illarion:spinning_recipes")) do
        local input = recipe:getField("input")
        if user:countItemAt(input.location, input.id) >= input.quantity
            and (not selected or recipe:getField("priority") < selected:getField("priority")) then
            selected = recipe
        end
    end
    return selected
end


function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption( User, ltstate );
    if ( ltstate == Action.abort ) then
        if (User:increaseAttrib("sex",0) == 0) then
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
    
    if not common.CheckItem( User, SourceItem ) then
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim spinnen.",
        "Your armor disturbes you while spinning." );
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then
        common.TurnTo( User, SourceItem.pos );
    end
    
    if (User:countItemAt("body",6)==0) then -- Schere
        common.InformNLS( User,
        "Du benötigst eine Schere um die Wolle oder Sibanac zu spinnen.",
        "You need scissors to spin the wool or sibanac." );
        return
    end
    
    local Tool = User:getItemAt(CCharacter.left_tool); -- Item in Linker Hand auslesen
    if ((Tool == nil) or (Tool.id ~= 6)) then -- Wenn das Item nicht die Zange ist
        Tool = User:getItemAt(CCharacter.right_tool); -- In anderer Hand nachsehen
    end
    
    if common.ToolBreaks( User, Tool, true) then -- Schere beschädigen
        common.InformNLS( User, 
        "Die Schere wird stumpf.", 
        "The scissors went blunt." );
        return
    end
    
    local recipe = findRecipe(User)
    if not recipe then
        if (ltstate ~= Action.success) then
            common.InformNLS( User, 
            "Du benötigst Wolle oder Sibanac um am Spinnrad zu arbeiten.", 
            "You need some wool or sibanac to work at the spinning wheel." );
        end
        return
    end
    
    if ( ltstate == Action.none ) then
        User:startAction( M.GenWorkTime(User), 0, 0, 0, 0);
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt zu spinnen.");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to spin.");
        return
    end
    
	if not work.check(User, "woolcutting") then
		return false;
	end
	
    local yield = recipe:getField("yield")
    yields:validate(yield)
    local input = recipe:getField("input")
    User:eraseItem(input.id, input.quantity)
    local output = { user = User }
    yields:roll(yield, output)
    if not output.overflow then
        User:startAction(M.GenWorkTime(User), 0, 0, 0, 0)
    end

    User:learn( 2, "tailoring", 2, 10 );
    
end -- function

-- Arbeitszeit generieren
function M.GenWorkTime(User)
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
    local Skill  = math.min(100,User:getSkill("tailoring")*10);     -- Schneidern: 0 - 100
    
    return math.floor(-0.25 * (Attrib + Skill) + 40);
end

return M
