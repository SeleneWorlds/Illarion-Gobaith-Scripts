local common = require("base.common")
local parent = require("item.general.metal")
local M = {}
local InitStartedOnce, InitDone, smithing, Smithing, menstate
local gText, eText

-- Goldschmieden mit Goldschmiedehammer und Amboss

-- UPDATE common SET com_script='item.id_122_finesmithhammer' WHERE com_itemid IN (122);

local general_metal = require("item.general.metal")
local base_crafts = require("item.base.crafts")
-- Schmiedeprodukte Initieren
function M.InitCraftingTool( )
    if not InitStartedOnce then
        InitStartedOnce = true;
        smithing = base_crafts.Craft:new{ LeadAttrib = "dexterity",
                              LeadSkill = "goldsmithing",
                              LeadSkillGroup = 2,
                              DefaultFoodConsumption = 300,
                              DefaultRepair = true,
                              DefaultSfx = { 8, 15 }
                            };
                            
        smithing:AddTool( 172 ); -- Amboss        
        smithing:AddActiveTool( 172, 13 ); -- Amboss mit glühendem Metall
        
        smithing:AddInterruptMessage(
        "Du wischst dir den Schweiß von der Stirn.",
        "You wipe sweat off your forehead.");
        
        smithing:AddInterruptMessage(
        "Du schlägst dir mit dem Hammer auf den Finger.",
        "You hit your finger with the hammer.");
        
        smithing:AddInterruptMessage(
        "Du betrachtest das Werkstück kurz um die Stellen zu finden welche du noch verbessern möchtest.",
        "You examine your current work, keeping an eye out for any mistakes.");
        
        smithing:AddInterruptMessage(
        "Du schleifst und polierst eine raue Stelle kurz nach.",
        "You correct a very rough area.");
        
        smithing:AddInterruptMessage(
        "Du schüttest etwas Kohle auf das Metall und klopfst sie ein um die Härte zu steigern.",
        "You pour some coal upon the metal and hit it into to increase the hardness.");
        
        smithing:AddInterruptMessage(
        "Du hältst einen Moment inne und überlegst eine zusätzliche Gravur anzubringen, entscheidest dich aber dagegen.",
        "You think about to include a additional gravur a moment, but you decide against.");
        
        smithing:AddInterruptMessage(
        "Du überprüfst kurz die Maße des Werkstücks.",
        "You check the fine details of your work.");
        
        --------------------------------------------------------------------------------------------
        smithing:LoadRecipes("goldsmithing")


        InitDone = true;
    end
    return smithing;
end

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )  -- DONT EDIT THIS LINE!
    common.ResetInterruption( User, ltstate )
    Smithing = M.InitCraftingTool( );
    if not menstate then
        menstate = { };
    end
     
------------------------AB HIER,SKRIPT FÜR DIE PRIESTER SILBERBRANDS(Flammensäule erschaffen aka THOR'S HAMMER)------------    
------------------------Part 1:------- 
  if (User.id==1551888478 or User.id==1322717830) then --for the Priests in Silverbrand(1551888478=Ferin Zwergenblut, 1322717830=Thogrimm)
  	if ( SourceItem:getType() ~= 4 ) then -- Wenn Hammer nicht in der Hand dann
       	if (TargetItem.id~=0) then
			if (User.id==1551888478 or User.id==1322717830) then  --not so strong flame
                world:createItemFromId(359, 1, TargetItem.pos, true, 6, {data = 0, magicStrength = 677}, 77);   --create flame
                world:gfx(36,TargetItem.pos);
        		User:increaseAttrib("hitpoints",-(1600+math.random(500))); --2000HP damage for the Irmorom priest
        	end
		else
			common.InformNLS( User, "Du musst schon die Stelle anvisieren wo die Flamme erscheinen soll",
							 "You have to target a field where the flame shall appear.");
		end    
        
    
    else
    
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
        Smithing:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end
    
    if not Smithing:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        Smithing:SwapToInactiveItem( User );
        return
    end
    
    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim feinschmieden.",
        "Your armor disturbes you while fine smithing." );
        Smithing:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            Smithing:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        menstate[ User.id ]=1;
        if ( Smithing:GenerateMenu( User,SourceItem ) ) then
            Smithing:SwapToInactiveItem( User );
            return
        end
    end
    if (menstate[ User.id ] == 1) then
        Smithing:GenerateItemList( User, Param, SourceItem );
        menstate[ User.id ] = 2;
        Smithing:SwapToInactiveItem( User );
        return
    elseif (menstate[ User.id ] == 2) then
        Smithing:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
    end
	end
	
---------------------------------------------		
  else 
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
        Smithing:SwapToInactiveItem( User );
        return
    end

    if not InitDone then
        User:inform("Error while loading crafting values.");
        return
    end

    if menstate[ User.id ]==nil then                           -- menustatus initialisieren.
        menstate[ User.id ]=0;
    end
    
    if not Smithing:LocationFine( User, ltstate ) then
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        Smithing:SwapToInactiveItem( User );
        return
    end
    
    if common.AutoEquipTool(User, SourceItem) ~= "equipped" then
        return
    end

    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim feinschmieden.",
        "Your armor disturbes you while fine smithing." );
        Smithing:SwapToInactiveItem( User );
        return
    end

    if ( TargetItem.id ~= 0 ) then
        if (TargetItem:getType() == 5) then
            Smithing:ToolCreateItem( User, 0, TargetItem, ltstate, SourceItem );
        end
        return
    end

    if (Param == 0) then
        menstate[ User.id ]=1;
        if ( Smithing:GenerateMenu( User,SourceItem ) ) then
            Smithing:SwapToInactiveItem( User );
            return
        end
    end
    if (menstate[ User.id ] == 1) then
        Smithing:GenerateItemList( User, Param, SourceItem );
        menstate[ User.id ] = 2;
        Smithing:SwapToInactiveItem( User );
        return
    elseif (menstate[ User.id ] == 2) then
        Smithing:ToolCreateItem( User, Param, nil, ltstate, SourceItem );
    end
  end  
end --function

------------------------Part 2:-------
function M.UseItemWithField( User, SourceItem,TargetPos ,Counter , Param)
		if (User.id==1551888478 or User.id==1322717830) then  --not so strong flame
                world:createItemFromId(359, 1, TargetPos, true, 6, {data = 0, magicStrength = 677}, 77);   --create flame
				world:gfx(36,TargetPos);
        		User:increaseAttrib("hitpoints",-(1600+math.random(500))); --2000HP damage for the Irmorom priest
		end
end

function M.UseItemWithCharacter(User,SourceItem,TargetChar,Counter,Param)
		if (User.id==1551888478 or User.id==1322717830) then
			if (TargetChar.id~=User.id) then
				if (User.id==1551888478 or User.id==1322717830) then  --not so strong flame
                    world:createItemFromId(359, 1, TargetChar.pos, true, 6, {data = 0, magicStrength = 677}, 77);   --create flame
					world:gfx(36,TargetChar.pos);
        			User:increaseAttrib("hitpoints",-(1600+math.random(500))); --2000HP damage for the Irmorom priest
        		end
			else
			common.InformNLS( User, "Du kannst dich nicht selber verbrennen",
							 "You can't burn yourself.");
			end
		end
end
--------------------------------------

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
