local common = require("base.common")
local parent = require("item.general.wood")
local M = {}
local InitStartedOnce, InitDone, carpentry, menstate
local gText, eText

-- Holzarbeiten mit dem Hobel

-- UPDATE common SET com_script='item.id_2715_plane' WHERE com_itemid IN (2715);

local general_wood = require("item.general.wood")
local base_crafts = require("item.base.crafts")
-- Holzarbeiten mit dem Hobel
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;
        
        carpentry = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                              LeadSkill = "carpentry",
                              LeadSkillGroup = 2,
                              DefaultFoodConsumption = 200,
                              DefaultRepair = false,
                              DefaultSfx = { 14, 17 }
                            };
                            
        carpentry:AddTool( 724 ); -- Werkbank
        carpentry:AddTool( 725 ); -- Werkbank
        
        carpentry:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        carpentry:AddInterruptMessage(
        "Du pustest kurz die Sägespäne von deiner Kleidung.",
        "You blow some sawdust off your clothes.");
        
        carpentry:AddInterruptMessage(
        "Du schleifst kurz eine raue Stelle nach.",
        "You smooth out a rough area.");
        
        carpentry:AddInterruptMessage(
        "Du stellst die Abfallholzteile zur Seite um wieder mehr Platz auf der Werkbank zu haben.",
        "You throw away some rubbish to get more working space.");
        
        carpentry:AddInterruptMessage(
        "Du bekommst einige Späne in den Mund und musst husten.",
        "Sawdust finds its way into your mouth, causing you to cough loudly.");
        
        carpentry:AddInterruptMessage(
        "Du bekommst einen Holzsplitter in den Finger und musst Pause machen um ihn zu entfernen.",
        "You get a splinter of wood in your finger and have to take a break to pull it out.");
        
        carpentry:AddInterruptMessage(
        "Du überprüfst kurz die Maße des Werkstücks.",
        "You check the fine details of your work.");

        --------------------------------------------------------------------------------------------
        carpentry:LoadRecipes("carpentry")

        
        InitDone = true;
    end
    return carpentry;
end

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!

    local carpenter = M.InitCraftingTool( );
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
        carpenter:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end
    
    if not carpenter:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        carpenter:SwapToInactiveItem( User );
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim Hobeln.",
        "Your armor disturbs you while slicing." );
        carpenter:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            carpenter:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        menstate[ User.id ]=1;
        if ( carpenter:GenerateMenu( User, SourceItem ) ) then
            carpenter:SwapToInactiveItem( User );
            return
        end
    end
    if (menstate[ User.id ] == 1) then
        carpenter:GenerateItemList( User, Param , SourceItem);
        menstate[ User.id ] = 2;
        carpenter:SwapToInactiveItem( User );
        return
    elseif (menstate[ User.id ] == 2) then
        carpenter:ToolCreateItem( User, Param, nil, ltstate,SourceItem );
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
