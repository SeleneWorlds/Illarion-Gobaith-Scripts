local common = require("base.common")
local parent = require("item.general.jewel")
local M = {}
local InitStartedOnce, InitDone, mortar, Mortar
local gText, eText

-- Farben herstellen

-- UPDATE common SET com_script='item.id_58_mortar' WHERE com_itemid=58;

local general_jewel = require("item.general.jewel")
local base_crafts = require("item.base.crafts")
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;

        mortar = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                            LeadSkill = "tailoring",
                            LeadSkillGroup = 2,
                            DefaultFoodConsumption = 300,
                            DefaultRepair = false
                          };
        
        mortar:AddTool( 12 ); -- Lagerfeuer
        
        mortar:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        mortar:AddInterruptMessage(
        "Dir fällt der Mörser aus der Hand. Zum Glück ist er ganz geblieben.",
        "You drop your mortar. Luckily it didn't break.");
        
        mortar:AddInterruptMessage(
        "Du überlegst ob du die Farbe noch intensiver machen solltest, aber entscheidest dich dagegen.",
        "You evaluate whether you should deepen the colour, deciding against doing so.");
        
        mortar:AddInterruptMessage(
        "Ein großer dicker Käfer ist irgendwie in die Zutaten gelangt. Du benötigst eine Weile ihn zu fangen und mit ihm das zu machen was er verdient hat.",
        "A big, fat bug has found its way into your ingredients. It takes a while to catch it and seal its fate.");
        
        --Red Dye
        mortar:LoadRecipes("dye_making")

        
        InitDone = true;
    end
    return mortar;
end --function


function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    Mortar = M.InitCraftingTool( );
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
        Mortar:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end
    
    if not Mortar:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        Mortar:SwapToInactiveItem( User );
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim Farben herstellen.",
        "Your armor disturbes you while creating dyes." );
        Tailoring:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            Mortar:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        Mortar:GenerateItemList( User, Param, SourceItem );
        Mortar:SwapToInactiveItem( User );
        return
    else
        Mortar:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
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
