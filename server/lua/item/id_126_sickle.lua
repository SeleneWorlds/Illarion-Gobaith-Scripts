local areas = require("base.areas")
local parent = require("item.general.metal")
local M = {}

-- Herblore mit Sichel und Ausbreitung der Pflanzen

-- UPDATE common SET com_script='item.id_126_sickle' WHERE com_itemid=126;

local general_metal = require("item.general.metal")
local common = require("base.common")
local scheduled_newgaia = require("scheduled.newgaia")
function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
	
	-- Krauterliste initialisieren
	scheduled_newgaia.initHerbs();
	
	-- wird die Arbeit durch andere aktion unterbrochen?
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
    
    -- Unterbrechungsmeldungen
	if ( ltstate == Action.success ) then
        if common.IsInterrupted( User ) then
            common.InformNLS( User,
            "Während du nach Kräutern suchst, verhakt sich deine Sichel und rutscht dir fast aus der Hand.",
            "While searching for herbs your sickle gets stuck and it nearly slides out of your hand.");
            return
        end
    end
    
     -- Sehr streife Rüstung?
    if common.Encumbrence(User) then
        common.InformNLS( User,
        "Deine Rüstung behindert dabei Kräuter zu sammeln.",
        "Your armor disturbes you collecting herbs." );
        return
    end
    
    -- Sicherheitscheck
    if not common.CheckItem( User, SourceItem ) then
        return
    end
    
    -- Ist ueberhaupt ein Item da, in dem gesucht wird?
    if ((TargetItem == nil) or (TargetItem.id == 0)) then
        TargetItem = common.GetFrontItem( User );
    end
    if not TargetItem then
        common.InformNLS( User,
        "Hier kannst du nicht finden.",
        "You can't find anything here.");
        return;
    end
    
    -- Zum Item drehen, falls dies nicht der Fall ist
    if not common.IsLookingAt( User, TargetItem.pos ) then
        common.TurnTo( User, TargetItem.pos );
    end

	-- ist die Sichel in der Hand?
    if ( SourceItem:getType() ~= 4 ) then
        common.InformNLS( User,
        "Du musst die Sichel in der Hand haben um damit zu arbeiten",
        "You have to hold the sickle in your hand to work with it.");
        return
    end
    
    -- Kraeuterkundeskill des Users laden
    local skill = User:getSkill( "herb lore" );

	-- Boni durch magische Edelsteine in der Sichel? Rubine modifizieren den skill!
    gem1, str1, gem2, str2=common.GetBonusFromTool(SourceItem);
    step=0;
    if gem1==3 then   
        step=str1;
    end
    if gem2==3 then
        step=step+str2;
    end
    skill=skill+step;
    
    -- Pruefen, ob man hier ueberhaupt was finden kann
	if not M.checkRegion(TargetItem) then
		User:inform("Hier kann man keine brauchbaren Kräuter finden");
		return;		
	end    
	
	User:inform("Hier kann man "..currentHerb.." finden");
	

end


function M.checkRegion(TargetItem)
    local TileID = world:getField(TargetItem.pos):tile()
    for _, herb in pairs(scheduled_newgaia.herbs) do
        if TileID == herb.ground then
            for _, item in pairs(herb.item) do
                if TargetItem.id == item then
                    for _, region in ipairs(herb.region) do
                        if areas.contains(region.area, TargetItem.pos) then
                            currentHerb = herb.id
                            return true
                        end
                    end
                end
            end
        end
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
