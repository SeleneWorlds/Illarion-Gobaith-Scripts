local common = require("base.common")
local parent = require("item.general.wood")
local M = {}
local InitStartedOnce, InitDone, tailoring, Tailoring, menstate
local gText, eText

-- Schneidern mit Nadel, Schneidertisch

-- UPDATE common SET com_script='item.id_47_needle' WHERE com_itemid IN (47);

local general_wood = require("item.general.wood")
local base_crafts = require("item.base.crafts")
-- Schneiderprodukte Initieren
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;
        
        tailoring = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                              LeadSkill = "tailoring",
                              LeadSkillGroup = 2,
                              DefaultFoodConsumption = 300,
                              DefaultRepair = true
                            };
                            
        tailoring:AddTool( 102 ); -- Schneidertisch
        tailoring:AddTool( 103 ); -- Schneidertisch
        
        tailoring:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        tailoring:AddInterruptMessage(
        "Du stichst dir mit der Nadel in den Finger.",
        "You sting yourself with the needle into your finger.");
        
        tailoring:AddInterruptMessage(
        "Du überprüfst kurz die Maße deiner Arbeit.",
        "You check some of your work's fine details.");
        
        tailoring:AddInterruptMessage(
        "Du bist dir einen Moment unschlüssig mit der Wahl des Materials, aber nach kurzer Überlegung entscheidest du dich doch das Material weiter zu benutzen.",
        "You think a moment about the material you use but then you decide to continue with your current materials.");
        
        tailoring:AddInterruptMessage(
        "Dir fällt die Nadel zu Boden und du musst sie kurz suchen.",
        "The needle falls to the floor and you need a while to find it again.");
        
        tailoring:AddInterruptMessage(
        "Du musst kurz unter den Stoffen nach der Schere suchen um den Faden abschneiden zu können.",
        "You search for a pair of scissors under the cloth.");
        
        tailoring:AddInterruptMessage(
        "Dir rutscht der Faden aus der Nadel, du benötigst einen Augenblick um ihn wieder einzufädeln.",
        "The thread slips out of the needle. You need a while to thread it again.");
        
        --------------------------------------------------------------------------------------------
        tailoring:LoadRecipes("tailoring")

		
        
        InitDone = true;
    end
    return tailoring;
end

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    common.ResetInterruption( User, ltstate );
    Tailoring = M.InitCraftingTool( );
    if not menstate then
        menstate = { };
    end
    
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
        Tailoring:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end
    
    if not Tailoring:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        Tailoring:SwapToInactiveItem( User );
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim schneidern.",
        "Your armor disturbes you while tailoring." );
        Tailoring:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            Tailoring:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        menstate[ User.id ]=1;
        if ( Tailoring:GenerateMenu( User, SourceItem ) ) then
            Tailoring:SwapToInactiveItem( User );
            return
        end
    end
    if (menstate[ User.id ] == 1) then
        Tailoring:GenerateItemList( User, Param , SourceItem);
        menstate[ User.id ] = 2;
        Tailoring:SwapToInactiveItem( User );
        return
    elseif (menstate[ User.id ] == 2) then
        if (Param == 97) then
            if (User:countItemAt("all",50) < 2) then
                common.InformNLS( User,
                "Du braucht mehr Garn um eine Tasche zu fertigen.",
                "You need more yarn to make a bag.");
                return
            end
        end
        Tailoring:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
        if ((Param == 97) and (ltstate == Action.success)) then
            User:eraseItem(50,2);
        end
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
