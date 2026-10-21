local areas = require("base.areas")
local parent = require("item.general.metal")
local M = {}

-- mining mit Schaufel

-- Arbeitscyclus: 1s - 4s

-- UPDATE common SET com_script='item.id_24_shovel' WHERE com_itemid=24;

local common = require("base.common")
local general_metal = require("item.general.metal")
local base_treasure = require("base.treasure")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")
local digging = Rolls:new()
digging:registerType("nothing", items.nothing)
digging:registerType("material", function(entry, context)
    local data = entry.data
    local maximum = math.max(1, math.ceil(context.skill * data.perSkill
        + context.user:increaseAttrib("perception", 0) * data.perPerception))
    local item = {}
    for key, value in pairs(data) do item[key] = value end
    item.quantity = math.random(maximum)
    items.item({ data = item }, context)
end)
digging:registerCondition("digging_success", function(condition, context)
    local data = condition.data
    local threshold = data.base + data.perSkill * context.skill
        + data.perDexterity * context.user:increaseAttrib("dexterity", 0)
    return math.random(0, 100) < threshold
end)
local roots = Rolls:new()
roots:registerType("nothing", items.nothing)
roots:registerType("root", function(entry, context)
    local data = entry.data
    local quality = data.qualityMin and math.random(data.qualityMin, data.qualityMax) or data.quality
    local durability = data.durabilityMin and math.random(data.durabilityMin, data.durabilityMax) or data.durability or 99
    world:createItemFromId(data.id, data.quantity, context.target.pos, true, quality, data.data, durability)
    if data.message then common.InformNLS(context.user, data.message.de, data.message.en) end
    context.produced = true
end)
roots:registerCondition("uprooting_success", function(condition, context)
    local data = condition.data
    return math.random(100) < context.user:getSkill("lumberjacking") * data.perSkill
        + context.user:increaseAttrib("strength", 0) * data.perStrength
end)

local function findStump(id)
    for _, tree in pairs(Registries.findAll("illarion:trees")) do
        if tree:getField("stump") == id then return tree end
    end
end


function M.UseItemWithField( User, SourceItem, TargetPos, Counter, Param, ltstate )
    common.ResetInterruption( User, ltstate );
    if (StoneList==nil) then
        StoneList={ 914, 915, 1245, 1246, 1273, 1276 };
        foundTreasureAt = {};
    end

    local groundTile = world:getField( TargetPos ):tile();
    local GroundType = common.GetGroundType( groundTile );

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

    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if not common.CheckItem( User, SourceItem ) then
        return
    end

    if (GroundType ~= 5) and base_treasure.DigForTreasure( User, TargetPos, (User:getSkill("mining")/10)+1,
                                                common.GetNLS( User,
                                                    "Du gräbst mit deiner Schaufel in den Boden und stößt auf etwas hartes, von dem ein hölzerner Klang ausgeht. Noch einmal graben und du hältst den Schatz in deinen Händen.",
                                                    "You dig with your shovel into the ground and hit suddenly something hard and wooden sounding. You only have to dig another time to get the treasure." ), false ) then
        return;
    end

    if (( groundTile ~= 3 ) and ( groundTile ~= 8 )) then
        if ( GroundType == 1 ) then
            common.InformNLS( User,
            "Du gräbst ein kleines Loch in den Ackerboden doch findest du hier gar nichts.",
            "You dig a small hole into the farming ground. But you find nothing.");
        elseif ( GroundType == 2 ) then
            common.InformNLS( User,
            "Du gräbst ein kleines Loch in den Waldboden doch findest du hier gar nichts.",
            "You dig a small hole into the forest ground. But you find nothing.");
        elseif ( GroundType == 4 ) then
            common.InformNLS( User,
            "Du gräbst ein kleines Loch in die Wiese doch findest du hier gar nichts.",
            "You dig a small hole into the grass. But you find nothing.");
        elseif ( GroundType == 5 ) then
            common.InformNLS( User,
            "Der Boden besteht hier aus solidem Stein. Mit einer Schaufel hast du eindeutig das falsche Werkzeug.",
            "The ground here is heavy stone. With a shovel you have the wrong tool here for sure.");
        elseif ( GroundType == 6 ) then
            common.InformNLS( User,
            "Im Wasser mit einer Schaufel zu graben geht zwar relativ leicht, doch der Effekt ist recht gering.",
            "To dig with a shovel in the water is pretty easy. But sadly there is no effect in doing this.");
        else
            common.InformNLS(User,
            "Du versuchst an dieser Stelle zu graben, findest aber nichts.",
            "You attempt to dig here, but you don't find anything.");
        end
        return
    end

    if common.ToolBreaks( User, SourceItem, true) then
        common.InformNLS(User,
        "Die alte und abgenutzte Schaufel in deinen Händen zerbricht.",
        "The old and used shovel in your hands breaks.");
        return
    end

    if not common.IsLookingAt( User, TargetPos ) then
        common.TurnTo( User, TargetPos );
    end
    if not M.LocationCheck(TargetPos,groundTile) then
        if ( groundTile == 3 ) then
            common.InformNLS( User,
            "Der Wind hat hier allen Sand fortgeweht.",
            "The wind has blown away the whole sand." );
            return
        else
            common.InformNLS( User,
            "Der Boden ist hier nicht feucht genug.",
            "The ground is not wet enough here." );
            return
        end
    end
    if ( ltstate == Action.none ) then
        User:startAction( M.GenWorkTime(User,SourceItem), 0, 0, 0, 0);
        if ( world:getField( TargetPos ):tile() == 3 ) then
            User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt nach Sand zu graben.");
            User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to dig for sand.");
        else
            User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt nach Lehm zu graben.");
            User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to dig for clay.");
        end
        return
    end

	if ( groundTile == 3 ) then
		if not work.check(User, "sanddigging") then
			return;
		end
	else
		if not work.check(User, "claydigging") then
			return;
		end
	end

    User:learn( 2, "mining", 2, 50 );
    local Skill = User:getSkill( "mining" );
    gem1, str1, gem2, str2=common.GetBonusFromTool(SourceItem);
    step=0;
    if gem1==3 then     --ruby gives skill
        step=str1;
    end
    if gem2==3 then
        step=step+str2;
    end
    Skill=Skill+step;
    local definition = assert(Registries.findByName("illarion:digging",
        groundTile == 3 and "illarion:sand" or "illarion:clay"))
    digging:roll(definition:getField("yield"), { user = User, skill = Skill })
    User:startAction( M.GenWorkTime(User,SourceItem), 0, 0, 0, 0);
end

-- dig out a tree stump
function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        TargetItem = common.GetFrontItem( User );
    end

    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        M.UseItemWithField( User, SourceItem, common.GetFrontPosition( User ), Counter, Param, ltstate );
        return
    end

    local tree = findStump(TargetItem.id)
    if not tree then
        M.UseItemWithField(User, SourceItem, TargetItem.pos, Counter, Param, ltstate)
        return
    end

    if not common.FitForWork( User ) then
        common.InformNLS( User, "Du bist zu hungrig um jetzt große Arbeit zu verrichten.", "You are too hungry to do heavy work. " );
        return
    end

    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if not common.IsLookingAt( User, TargetItem.pos ) then
        common.TurnTo( User, TargetItem.pos );
    end

    local output = { user = User, target = TargetItem }
    roots:roll(tree:getField("roots"), output)
    if output.produced then
        world:erase(TargetItem, 1)
    else
        common.InformNLS(User, "Die Wurzeln sind stark und tief und halten deiner Kraft stand.",
            "This roots are deep and strong. They resist you strength.")
    end
    User:learn( 2, "lumberjacking", 2, 50 )
    common.GetHungry( User, 200 );
end

-- Arbeitszeit generieren
function M.GenWorkTime(User,toolItem)
    local Attrib = User:increaseAttrib("constitution",0); -- Geschicklichkeit: 0 - 20
    local Skill  = math.min(100,User:getSkill("mining")*5);     -- Schneidern: 0 - 100

    gem1, str1, gem2, str2=common.GetBonusFromTool(toolItem);
    step=0;
    if gem1==3 then     -- ruby modifies skill!
        step=str1;
    end
    if gem2==3 then
        step=step+str2;
    end
    Skill=Skill+step;
    step=0;
    if gem1==6 then     -- amethyst modifies time needed
        step=str1;
    end
    if gem2==6 then
        step=step+str2;
    end
    step=step*1.75;
    return math.floor((-0.25 * (Attrib + Skill) + 40)*(100-step)/100);
end

function M.LocationCheck(TargetPos,DigginType)
    if (DigginType == 3) then -- sand
        local testPos;
        local foundStone = false;
        for Xoff=-1, 1 do
            for Yoff=-1, 1 do
                testPos=position( TargetPos.x+Xoff, TargetPos.y+Yoff, TargetPos.z );
                if world:isItemOnField( testPos ) then
                    for i, stoneID in pairs(StoneList) do
                        if ( stoneID == world:getItemOnField( testPos ).id ) then
                            return true;
                        end
                    end
                end
            end
        end
        return false;
    else -- Lehm
        return areas.contains("clay_digging", TargetPos)
    end
    return false
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
