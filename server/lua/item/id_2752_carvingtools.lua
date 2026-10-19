local common = require("base.common")
local parent = require("item.general.metal")
local M = {}
local InitStartedOnce, InitDone, carpentery, carpenter, menstate
local gText, eText

-- Working with carving tools

-- UPDATE common SET com_script='item.id_2752_carvingtools' WHERE com_itemid IN (2752);

local general_metal = require("item.general.metal")
local base_crafts = require("item.base.crafts")
-- Holzarbeiten mit dem Schnitzmesser
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;

        carpentery = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                              LeadSkill = "carpentry",
                              LeadSkillGroup = 2,
                              DefaultFoodConsumption = 200,
                              DefaultRepair = false,
                              DefaultSfx = { 14, 17 }
                            };

        carpentery:AddTool( 724 ); -- Werkbank
        carpentery:AddTool( 725 ); -- Werkbank

        carpentery:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");

        carpentery:AddInterruptMessage(
        "Du pustest kurz die Sägespäne von deiner Kleidung.",
        "You blow some sawdust off your clothes.");

        carpentery:AddInterruptMessage(
        "Du schleifst kurz eine raue Stelle nach.",
        "You smooth out a rough area.");

        carpentery:AddInterruptMessage(
        "Du Stellst die Abfallholzteile zur Seite um wieder mehr Platz auf der Werkbank zu haben.",
        "You throw away some rubbish to get more working space.");

        carpentery:AddInterruptMessage(
        "Du bekommst einige Späne in den Mund und mußt husten.",
        "Sawdust finds its way into your mouth, causing you to cough loudly.");

        carpentery:AddInterruptMessage(
        "Du bekommst einen Holzsplitter in den Finger und mußt Pause machen um ihn zu entfernen.",
        "You get a splinter of wood in your finger and have to take a break to pull it out.");

        carpentery:AddInterruptMessage(
        "Du überprüfst kurz die Maße des Werkstücks.",
        "You check the fine details of your work.");

        --------------------------------------------------------------------------------------------
        carpentery:LoadRecipes("carving")


        InitDone = true;
    end
    return carpentery;
end



function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    common.ResetInterruption( User, ltstate )
    carpenter = M.InitCraftingTool( );
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
        User:inform("Error while loading values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end

    if not carpenter:LocationFine( User ) then
        return
    end

    if not common.CheckItem( User, SourceItem ) then
        carpenter:SwapToInactiveItem( User );
        return
    end

    if ( SourceItem:getType() ~= 4 ) then -- Schnitzmesser in der Hand
        common.InformNLS( User,
        "Du mußt die Schnitzmesser in die Hand nehmen um damit zu arbeiten.",
        "You have to take the carving tools in your hand, to work with it." )
        return
    end

    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim schnitzen.",
        "Your armor disturbes you while carve." );
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
        carpenter:GenerateItemList( User, Param, SourceItem );
        menstate[ User.id ] = 2;
        carpenter:SwapToInactiveItem( User );
        return
    elseif (menstate[ User.id ] == 2) then
        carpenter:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
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
