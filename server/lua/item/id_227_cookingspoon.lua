local common = require("base.common")
local parent = require("item.general.wood")
local M = {}
local InitStartedOnce, InitDone, cooking, brewing, Cooking, Brewing, menstate
local gText, eText, cookstatus, cookmessage, brewstatus, brewmessage

-- Kochen und Brauen mit Kessel und Fass

-- UPDATE common SET com_script='item.id_227_cookingspoon' WHERE com_itemid IN (227);

local general_wood = require("item.general.wood")
local base_crafts = require("item.base.crafts")
-- Kochen und Brauen Initieren Initieren
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;
        
        cooking = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                             LeadSkill = "baking",
                             LeadSkillGroup = 2,
                             DefaultFoodConsumption = 100,
                             DefaultRepair = false,
                             DefaultSfx = { 7, 15 }
                           };
        
        brewing = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                             LeadSkill = "baking",
                             LeadSkillGroup = 2,
                             DefaultFoodConsumption = 100,
                             DefaultRepair = false,
                             DefaultSfx = { 10, 15 }
                           };

		
        cooking:AddTool( 2488 ); -- Kettle
        brewing:AddTool( 339 ); -- Weinfass

        function cooking:LocationFine(User, ltstate, mode)
            local kettle, hasFire
            for _, item in ipairs(common.GetItemsOnField(common.GetFrontPosition(User))) do
                if item.id == 2488 then
                    kettle = item
                elseif item.id == 12 then
                    hasFire = true
                end
            end

            local german, english
            if not kettle then
                german, english = "Hier kannst du nicht arbeiten.", "You cannot work here."
            elseif kettle.quality < 1 then
                german, english = "Das Werkzeug ist kaputt.", "The tool is broken."
            elseif not hasFire then
                german = "Du benötigst ein brennendes Lagerfeuer unter dem Kessel."
                english = "You need a burning campfire under the kettle."
            end

            if german then
                if mode then
                    return 1, common.GetNLS(User, "#w " .. german, "#w " .. english)
                end
                common.TempInformNLS(User, german, english)
                return false
            end
            if mode then
                return 0, ""
            end
            return true
        end
        
        cooking:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        cooking:AddInterruptMessage(
        "Du hältst einen Moment inne und überlegst eine zusätzliche Zutat in das Rezept einbringen sollst, entscheidest dich aber dagegen.",
        "You hesitate and consider to add additional ingredients to the recipe. Finally, you revise your decision.");
        
        cooking:AddInterruptMessage(
        "Du probierst die Speise und überlegst ob du noch etwas nachwürzen solltest.",
        "You taste the dish and consider adding some additional spices.");
        
        cooking:AddInterruptMessage(
        "Du wäscht kurz das benutzte Geschirr ab bevor du weiter machst.",
        "You wash some dishes before continuing.");
        
        brewing:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        brewing:AddInterruptMessage(
        "Du hältst einen Moment inne und überlegst eine zusätzliche Zutat in das Rezept einbringen sollst, entscheidest dich aber dagegen.",
        "You consider adding a secret ingredient to your brew, but can't remember it.");
        
        brewing:AddInterruptMessage(
        "Du rüttelst ein wenig am Gärbehälter um den Gärprozess im Gang zu halten.",
        "You shake slightly at the fermentation vessel.");
        
        brewing:AddInterruptMessage(
        "Du spülst die Flaschen mit heißem Wasser aus damit keine ungewollten 'Zutaten' in das Getränk gelangen.",
        "You scald some bottles in hot water to avoid spoiling the taste.");
        
        --------------------------------------------------------------------------------------------
        cooking:LoadRecipes("cooking")
        brewing:LoadRecipes("brewing")

        ------------------ FLASCHE MIT WEIN - FERTIG --------------------------       
        
        InitDone = true;
    end
    return cooking,brewing;
end

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    Cooking,Brewing = M.InitCraftingTool( );
    common.ResetInterruption( User, ltstate );
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
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.", { showInChat = false });
        Cooking:SwapToInactiveItem( User );
        Brewing:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end
    
    cookstatus,cookmessage = Cooking:LocationFine( User, ltstate, true );
    if (cookstatus == 0) then
        if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
            return
        end
        
        if not common.CheckItem( User, SourceItem ) then
            Cooking:SwapToInactiveItem( User );
            return
        end
        
        if common.Encumbrence(User) then -- Sehr steife Rüstung?
            common.InformNLS( User,
            "Deine Rüstung behindert beim kochen.",
            "Your armor disturbs you while cooking." );
            Cooking:SwapToInactiveItem( User );
            return
        end

        if ( TargetItem.id ~= 0 ) then
            if (TargetItem:getType() == 5) then
                Cooking:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
            end
            return
        end

        if (Param == 0) then
            menstate[ User.id ]=1;
            if ( Cooking:GenerateMenu( User, SourceItem ) ) then
                Cooking:SwapToInactiveItem( User );
                return
            end
        end
        if (menstate[ User.id ] == 1) then
            Cooking:GenerateItemList( User, Param, SourceItem );
            menstate[ User.id ] = 2;
            Cooking:SwapToInactiveItem( User );
            return
        elseif (menstate[ User.id ] == 2) then
            Cooking:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
        end
        return
    end
    
    brewstatus,brewmessage = Brewing:LocationFine( User, ltstate, true );      
    if (brewstatus == 0) then
        if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
            return
        end
        
        if not common.CheckItem( User, SourceItem ) then
            Brewing:SwapToInactiveItem( User );
            return
        end
        
        if common.Encumbrence(User) then -- Sehr steife Rüstung?
            common.InformNLS( User,
            "Deine Rüstung behindert beim brauen.",
            "Your armor disturbs you while brewing." );
            Brewing:SwapToInactiveItem( User );
            return
        end

        if ( TargetItem.id ~= 0 ) then
            if (TargetItem:getType() == 5) then
                Brewing:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
            end
            return
        end

        if (Param == 0) then
            if ( Brewing:GenerateItemList( User, 0, SourceItem ) ) then
                Brewing:SwapToInactiveItem( User );
                return
            end
        end
        Brewing:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
        return
    end
    
    if (cookstatus == 1) then
        User:inform(cookmessage);
    else
        User:inform(brewmessage);
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
