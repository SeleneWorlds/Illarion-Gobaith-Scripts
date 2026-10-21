local parent = require("item.general.metal")
local M = {}

-- mining mit Spitzhacke

-- UPDATE common SET com_script='item.id_2763_pickaxe' WHERE com_itemid=2763;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 1246 WHERE com_itemid = 1246;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 1246 WHERE com_itemid = 915;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 1245 WHERE com_itemid = 1245;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 1245 WHERE com_itemid = 1254;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 232  WHERE com_itemid = 232;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 232  WHERE com_itemid = 233;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 914  WHERE com_itemid = 914;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 914  WHERE com_itemid = 1265;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 1273 WHERE com_itemid = 1273;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 1273 WHERE com_itemid = 1257;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 1276 WHERE com_itemid = 1276;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 1276 WHERE com_itemid = 1278;

-- UPDATE common SET com_agingspeed = 255, com_objectafterrot = 1250 WHERE com_itemid = 1250;
-- UPDATE common SET com_agingspeed =  10, com_objectafterrot = 1250 WHERE com_itemid = 1251;

local general_metal = require("item.general.metal")
local common = require("base.common")
local base_treasure = require("base.treasure")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local areas = require("base.areas")
local yields = Rolls:new()
yields:registerType("item", items.item)
yields:registerType("nothing", items.nothing)
yields:registerCondition("minimum_skill", function(condition, context)
    return context.skill >= condition.data
end)
yields:registerCondition("mining_success", function(condition, context)
    return math.random(100) < condition.data.base + condition.data.perSkill * context.skill
end)

local function findDeposit(target)
    for _, deposit in pairs(Registries.findAll("illarion:mining_deposits")) do
        if deposit:getField("rock") == target.id and areas.contains(deposit:getField("area"), target.pos) then
            return deposit
        end
    end
end

function M.GetModifiedSkill(Char)
    local USkill=Char:getSkill("mining");
    local UStr=Char:increaseAttrib("strength",0);
    local UPerc=Char:increaseAttrib("perception",0);
    return math.max(0,math.min(100,(USkill * M.Scale(0.5,1.2,UStr*4 + UPerc))));
end

function M.breakRock(Rock, deposit)
    local RockPos=Rock.pos;
    local RockQual=tonumber(Rock:getData("rockHealth")) or 333;
    local HitDMG=math.random(6,8);
    if (RockQual<HitDMG) then
        world:swap(Rock,deposit:getField("depletedRock"),3);
        return true;
    else
        Rock:setData("rockHealth", RockQual-HitDMG)
    end
    return false;
end

function M.Scale(ScBegin, ScEnd, value)
    if (ScBegin < ScEnd) then
        return math.min(ScEnd,math.max(ScBegin,((ScEnd-ScBegin)/100)*value+ScBegin));
    else
        return math.max(ScEnd,math.min(ScBegin,((ScEnd-ScBegin)/100)*value+ScBegin));
    end
end

function M.UseItem(User, SourceItem, TargetItem, Counter, Param, ltstate)
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
    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        TargetItem = common.GetFrontItem( User );
    else
        TargetItem = world:getItemOnField(TargetItem.pos);
    end
    
    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        M.UseItemWithField(User,SourceItem,common.GetFrontPosition(User),Counter,Param);
        return;
    end

    if common.Encumbrence(User) then
        common.InformNLS( User,
        "Deine Rüstung behindert Dich Rohstoffe abzubauen.",
        "Your armor disturbes you when mining ores" );
        return
    end

    if (SourceItem:getType() ~= 4) then
        common.InformNLS( User,
        "Du musst eine Spitzhacke in der Hand haben!",
        "You need to hold the pick-axe in your hand!" );
        return
    end

    if not common.IsLookingAt( User, TargetItem.pos ) then
        common.TurnTo( User, TargetItem.pos );
    end

    local deposit = findDeposit(TargetItem)
    if not deposit then
        common.InformNLS(User, "Hier kannst du keine Rohstoffe abbauen.", "You can't mine resources here.")
        return
    end

    if (ltstate == Action.none) then
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt mit der Spitzhacke auf den Stein zu schlagen.");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to hit the stone with a pick axe.");
        User:startAction( M.GenWorkTime(User), 0, 0, 8, 15);
        return
    end

    if common.ToolBreaks( User, SourceItem, true ) then
        common.InformNLS(User,
        "Die alte und abgenutzte Spitzhacke in deinen Händen zerbricht.",
        "The old and used pick-axe in your hands breaks.");
        return
    end

    if M.breakRock(TargetItem, deposit) then
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me zertrümmert den Stein.");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me destroys the rock.");
        return
    end

    Skill = M.GetModifiedSkill(User);

	if not work.check(User, "mining") then
		return
	end
	
    local output = { user = User, skill = Skill }
    yields:roll(deposit:getField("yield"), output)
    User:learn(2, "mining", 1, 100)
    if not output.overflow then
        User:startAction(M.GenWorkTime(User), 0, 0, 8, 15)
    end

end

function M.UseItemWithField(User,SourceItem,TargetPos,counter,param)
    local groundTile = world:getField( TargetPos ):tile();
    local GroundType = common.GetGroundType( groundTile );
    
    if (GroundType ~= 5) and base_treasure.DigForTreasure( User, TargetPos, (User:getSkill("mining")/10)+1,
                                                common.GetNLS( User,
                                                    "Du schwingst deine Spitzhacke gegen den steinigen Boden und stößt auf etwas das noch härter ist als der Boden. Das muss er sein! Der Schatz. Noch einmal graben und der grenzenlose Reichtum ist dein!",
                                                    "You swing your pick-axe against the stony ground and hit something that is even harder then the ground. That must it be! The teasure! Digging another time and it yours!" ), false ) then
        return;
    end
    
    
    if (( groundTile ~= 3 ) and ( groundTile ~= 8 )) then
        if ( GroundType == 1 ) then
            common.InformNLS( User,
            "Du schwingst deine Spitzhacke schwungvoll gegen den Boden und sie gräbt sich tief in den Ackerboden.",
            "You swing your pick-axe towards the ground and it digs deeply into the farm land.");
        elseif ( GroundType == 2 ) then
            common.InformNLS( User,
            "Du schwingst deine Spitzhacke schwungvoll gegen den Boden und sie gräbt sich tief in den Waldboden.",
            "You swing your pick-axe towards the ground and it digs deeply into the forest ground.");
        elseif ( GroundType == 4 ) then
            common.InformNLS( User,
            "Du schwingst deine Spitzhacke schwungvoll gegen den Boden und sie gräbt sich tief in die Wiese.",
            "You swing your pick-axe towards the ground and it digs deeply into the gras.");
        elseif ( GroundType == 5 ) then
            common.InformNLS( User,
            "Du schwingst deine Spitzhacke schwungvoll gegen den Boden und lockerst du den festen Boden etwas",
            "You swing your pick-axe towards the ground and ease the stony ground slightly.");
        elseif ( GroundType == 6 ) then
            common.InformNLS( User,
            "Du schwingst deine Spitzhacke schwungvoll gegen den Boden und sie versinkt mit einem Platschen im Wasser.",
            "You swing your pick-axe towards the ground and it runs with a splash into the water.");
        else
            common.InformNLS(User,
            "Du versuchst an dieser Stelle zu graben",
            "This isn't a good place to dig.");
        end
        return
    end
end

function M.UseItemWithCharacter(User,SourceItem,TargetChar,counter,param)
    common.InformNLS(User,
    "Eine Spitzhacke ist nicht so sehr als Waffe geeignet.",
    "You shouldn't use a pick-axe as a weapon.");
end

-- Arbeitszeit generieren
-- 2s - 5.5s
function M.GenWorkTime(User)
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
    local Skill  = math.min(100,User:getSkill("mining")*10);    -- Schmieden: 0 - 100

    return math.floor(-0.3 * (Attrib + Skill) + 60);
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
