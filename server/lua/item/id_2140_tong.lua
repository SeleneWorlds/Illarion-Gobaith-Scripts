local common = require("base.common")
local parent = require("item.general.metal")
local M = {}
local InitStartedOnce, InitDone, gemcutting, GemCutting
local gText, eText

-- Edelsteine schleifen + Edelsteinstaub herstellen

-- UPDATE common SET com_script='item.id_2140_tong' WHERE com_itemid=2140;

local general_metal = require("item.general.metal")
local base_crafts = require("item.base.crafts")
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;

        gemcutting = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                                  LeadSkill = "gemcutting",
                                  LeadSkillGroup = 2,
                                  DefaultFoodConsumption = 200,
                                  DefaultRepair = false
                                };
        
        gemcutting:AddTool( 270 );  -- Schleifstein

        gemcutting:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        gemcutting:AddInterruptMessage(
        "Der Edelstein rutscht dir aus der Hand und fällt zu Boden. Du musst kurz suchen, ehe du den Stein wieder findest.",
        "The gem slips out of your hand and falls down to the ground. You have to search for a moment to find it again.");
		
        ---------------- AMETHYST - 197 ----------------
        gemcutting:LoadRecipes("gemcutting")

        --------------- DIAMANTSTAUB - FERTIG -----------------
        
        InitDone = true;
    end
    return gemcutting;
end --function


function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    GemCutting = M.InitCraftingTool( );
    common.ResetInterruption( User, ltstate )
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
        GemCutting:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end
    
    if not GemCutting:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        GemCutting:SwapToInactiveItem( User );
        return
    end
    
    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim Edelstein schleifen.",
        "Your armor disturbes you while cutting gems." );
        GemCutting:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            GemCutting:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        GemCutting:GenerateItemList( User, Param, SourceItem );
        GemCutting:SwapToInactiveItem( User );
        return
    else
        GemCutting:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
    end
end --function

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
