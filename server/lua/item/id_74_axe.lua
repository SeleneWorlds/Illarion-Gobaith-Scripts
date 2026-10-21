local parent = require("item.general.metal")
local M = {}

-----------------------------------
----------- HOLZ FÄLLEN -----------
-----------------------------------

-- UPDATE common SET com_script='item.id_74_axe' WHERE com_itemid IN (74,2946);

local common = require("base.common")
local general_metal = require("item.general.metal")
local work = require("base.gathering")
local Registries = require("selene.registries")
local Rolls = require("moonlight-rolls.server.lua.rolls")
local items = require("base.roll_items")

local timber = Rolls:new()
timber:registerType("item", items.item)
timber:registerType("nothing", items.nothing)
timber:registerCondition("woodcutting_success", function(condition, context)
    local attempts = math.max(1, math.ceil(condition.data.base + condition.data.perSkill * context.skill))
    return math.random(attempts) == 1
end)
local trees, logs

function M.initLists()
    trees, logs = {}, {}
    for _, tree in pairs(Registries.findAll("illarion:trees")) do
        local fallen = tree:getField("fallenLogs")
        for _, id in ipairs(tree:getField("items")) do
            trees[id] = tree
        end
        for _, id in pairs(fallen) do logs[id] = tree end
    end
end

function M.createdeathtree(Tree,User,Qual)
    local fallen = trees[Tree.id]:getField("fallenLogs")
    local DiffX=false;
    local DiffY=false;
    local createpos=nil;
    if (Tree.pos.x~=User.pos.x) then DiffX=true end
    if (Tree.pos.y~=User.pos.y) then DiffY=true end
    if DiffX and DiffY then
        local LookAt=User:get_face_to();
        if (LookAt==0 or LookAt==4) then
            if (User.pos.x<Tree.pos.x) then
                local createpos=position(Tree.pos.x-1,Tree.pos.y,Tree.pos.z)
                M.CheckAndHit(position(Tree.pos.x-1,Tree.pos.y,Tree.pos.z));
                M.CheckAndHit(createpos);
                world:createItemFromId(fallen.west,1,createpos,true,3,{logCount = Qual});
            elseif (User.pos.x>Tree.pos.x) then
                local createpos=position(Tree.pos.x+1,Tree.pos.y,Tree.pos.z);
                M.CheckAndHit(createpos);
                M.CheckAndHit(position(Tree.pos.x+2,Tree.pos.y,Tree.pos.z));
                world:createItemFromId(fallen.east,1,createpos,true,3,{logCount = Qual});
            end
        else
            if (User.pos.y<Tree.pos.y) then
                local createpos=position(Tree.pos.x,Tree.pos.y-1,Tree.pos.z)
                M.CheckAndHit(createpos);
                M.CheckAndHit(position(Tree.pos.x,Tree.pos.y-2,Tree.pos.z));
                world:createItemFromId(fallen.north,1,createpos,true,3,{logCount = Qual});
            elseif (User.pos.y>Tree.pos.y) then
                local createpos=position(Tree.pos.x,Tree.pos.y+1,Tree.pos.z)
                M.CheckAndHit(position(Tree.pos.x,Tree.pos.y+1,Tree.pos.z));
                M.CheckAndHit(createpos);
                world:createItemFromId(fallen.south,1,createpos,true,3,{logCount = Qual});
            end
        end
    elseif DiffX then
        local Choose=math.random(0,1);
        local createpos=position(Tree.pos.x,Tree.pos.y+(3*Choose-1),Tree.pos.z);
        M.CheckAndHit(createpos);
        M.CheckAndHit(position(createpos.x,createpos.y-1,createpos.z));
        if (Choose==0) then
            world:createItemFromId(fallen.north,1,createpos,true,3,{logCount = Qual});
        else
            world:createItemFromId(fallen.south,1,createpos,true,3,{logCount = Qual});
        end
    else
        local Choose=math.random(0,1);
        local createpos=position(Tree.pos.x+(3*Choose-2),Tree.pos.y,Tree.pos.z);
        M.CheckAndHit(createpos);
        M.CheckAndHit(position(createpos.x+1,createpos.y,createpos.z));
        if (Choose==1) then
            world:createItemFromId(fallen.east,1,createpos,true,3,{logCount = Qual});
        else
            world:createItemFromId(fallen.west,1,createpos,true,3,{logCount = Qual});
        end
    end
end

function M.CheckAndHit(TargetPos)
    if world:isCharacterOnField(TargetPos) then
        local Char=world:getCharacterOnField(TargetPos);
        common.InformNLS( Char,
        "Der Baum fällt und trifft dich hart",
        "The tree falls and hits you hard");
        Char:increaseAttrib("hitpoints",-7000);
    end
end

-- ************************************************************************************

--Hauptfunktion / Einsprung
function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
    M.initLists(  );
    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if not common.CheckItem( User, SourceItem ) then
        return
    end

    if common.Encumbrence(User) then
        if (User.pos.z == 100) then
            common.InformNLS( User,
            "Deine Rüstung behindert Dich beim Holz schlagen. Wenn du arbeiten willst kannst du keine schwere Rüstungen tragen. Lege deine Rüstung und deinen Helm in deine Tasche. Dann kannst du arbeiten.",
            "Your armor disturbes you when chopping trees. If you want to work you must not carry heavy armors. Put your armor and your helmet into your bag. Then you can work." );
        else
            common.InformNLS( User,
            "Deine Rüstung behindert Dich beim Holz schlagen.",
            "Your armor disturbes you when chopping trees" );
        end
        return
    end

    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        TargetItem = common.GetFrontItem( User );
    else
        TargetItem = world:getItemOnField(TargetItem.pos);
    end

    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        M.UseItemWithField( User, SourceItem, common.GetFrontPosition( User ), Counter, Param, ltstate );
        return
    end

    if ((trees[ TargetItem.id ] == nil) and (logs[ TargetItem.id ] == nil)) then
        M.UseItemWithField( User, SourceItem, TargetItem.pos, Counter, Param, ltstate );
        return
    end

    if ((logs[ TargetItem.id ] ~= nil) and (TargetItem.wear == 255)) then
        common.InformNLS( User,
        "Dieser Baum ist zu alt um noch verwertbar zu sein.",
        "This tree is too old." );
        return
    end

    if not common.IsLookingAt( User, TargetItem.pos ) then
        common.TurnTo( User, TargetItem.pos );
    end

    if ( ltstate == Action.none ) then
        User:startAction( 12, 0, 0, 6, 15);
        if (logs[ TargetItem.id ] == nil) then
            User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt den Baum zu fällen.");
            User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to cut down a tree.");
        else
            User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Holz aus dem Baumstamm zu schlagen.");
            User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to cut wood from the log.");
        end
    elseif ( ltstate == nil or ltstate == Action.success ) then
        if M.Lumberjack( User, SourceItem, TargetItem, Counter, Param, ltstate ) then
            if common.ToolBreaks( User, SourceItem ) then
                common.InformNLS(User,
                "Die alte und abgenutzt Axt in deinen Händen zerbricht.",
                "The old and used axe in your hands breaks.");
            else
                User:startAction( 12, 0, 0, 6, 15);
            end
            if (User:getSkill("lumberjacking") < 100) then
                User:learn( 2, "lumberjacking", 2, 100 );
            end
        else
            if common.ToolBreaks( User, SourceItem ) then
                common.InformNLS(User,
                "Die alte und abgenutzte Axt in deinen Händen zerbricht.",
                "The old and used axe in your hands breaks.");
            end
            --if (User:getSkill("lumberjacking") < 100) then
                User:learn( 2, "lumberjacking", 2, 100 );
           -- end
        end
    elseif ( ltstate == Action.abort ) then
        if (User:increaseAttrib("sex",0) == 0) then
            gText = "seine";
            eText = "his";
        else
            gText = "ihre";
            eText = "her";
        end
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.");
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.");
    end
end

function M.UseItemWithField( User, SourceItem, TargetPos, Counter, Param, ltstate )
    M.initLists(  );
    if world:isItemOnField( position( TargetPos.x, TargetPos.y+1, TargetPos.z ) ) then
        local testitem = world:getItemOnField( position( TargetPos.x, TargetPos.y+1, TargetPos.z ) );
        for _, tree in pairs(trees) do
            local fallen = tree:getField("fallenLogs")
            if (fallen.south == testitem.id) or (fallen.north == testitem.id) then
                M.UseItem( User, SourceItem, testitem, Counter, Param, ltstate );
                return;
            end
        end
    end
    if world:isItemOnField( position( TargetPos.x+1, TargetPos.y, TargetPos.z ) ) then
        local testitem = world:getItemOnField( position( TargetPos.x+1, TargetPos.y, TargetPos.z ) );
        for _, tree in pairs(trees) do
            local fallen = tree:getField("fallenLogs")
            if (fallen.west == testitem.id) or (fallen.east == testitem.id) then
                M.UseItem( User, SourceItem, testitem, Counter, Param, ltstate );
                return;
            end
        end
    end
    common.InformNLS( User,
    "Hier ist nichts was du mit der Axt bearbeiten könntest.",
    "Here is nothing you could work at with your axe." );
end

function M.Lumberjack( User, SourceItem, TargetItem, Counter, Param, ltstate )
    local Skill = User:getSkill("lumberjacking");
	-- Random Events
	if (not work.check(User, "woodchopping")) then
		return;
	end
    if (logs[ TargetItem.id ] == nil) then
	    --if TargetItem.quality < 999 then
        --    TargetItem.quality = 9
		--    world:changeItem(TargetItem);
        --end
        local Strength=User:increaseAttrib("strength",0);
        local DecreaseQual=math.floor((0.6*(Skill+Strength)+37)*math.random(8,12)/10);
        local NewBaumQual=(tonumber(TargetItem:getData("treeHealth")) or 333)-DecreaseQual;
        if (NewBaumQual<=100) then
            local GenericQual=math.max(1,math.ceil((Skill/100)*trees[TargetItem.id]:getField("maxLogs")));
            M.createdeathtree(TargetItem,User,GenericQual);
            world:erase(TargetItem,1);
            if (math.random(100)>5) or User.pos.z == 100 or User.pos.z == 101 then -- no dying trees on Noobia!
                world:createItemFromId(trees[TargetItem.id]:getField("stump"),1,TargetItem.pos,true,3,0, 33)
            else
                common.InformNLS( User,
                "Der Baum ist zu schwach um erneut zu wachsen. Er stirbt.",
                "The tree is too weak to grow again. It dies." );
            end
            return false;
        else
            TargetItem:setData("treeHealth", NewBaumQual);
            world:changeItem(TargetItem);
            return true;
        end
    else
        local logCount = tonumber(TargetItem:getData("logCount")) or 1;
        if logCount > 0 then
            local output = { user = User, skill = Skill }
            timber:roll(logs[TargetItem.id]:getField("timber"), output)
            if output.produced then
                local retVal = not output.overflow
                if logCount <= 1 then
                    world:erase(TargetItem,1);
                    retVal = false;
                else
                    TargetItem:setData("logCount", logCount - 1);
                    world:changeItem(TargetItem);
                end
                return retVal;
            end
            return true;
        else
            world:erase(TargetItem,1);
            return false;
        end
    end
end -- main function UseItem(  )

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
