local common = require("base.common")
local parent = require("item.general.wood")
local M = {}
local UseItem, GenAmount, GenWorkTime

-- Dreschflegel ( 258 )

-- Getreideb�ndel  --> Getreidek�rner

-- Arbeitscyclus: 0.5s - 4s

-- UPDATE common SET com_script='item.id_258_flail' WHERE com_itemid IN (258);

local general_wood = require("item.general.wood")
function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
    common.ResetInterruption( User, ltstate );
    if ( ltstate == Action.abort ) then -- Arbeit unterbrochen
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
      
    if not common.CheckItem( User, SourceItem ) then -- Sicherheitscheck
        return
    end
    
    if common.Encumbrence(User) then -- Durch Steife R�stung behindert
        common.InformNLS( User,
        "Deine R�stung behindert Dich beim Getreide dreschen.",
        "Your armor disturbes you when flailing grain" );
        return
    end
    
    if (SourceItem:getType() ~= 4) then -- Dreschflegel in der Hand
        common.InformNLS( User,
        "Du musst den Dreschflegel in der Hand haben!",
        "You need to hold the flail in your hand!" );
        return
    end
    
    if not common.FitForWork( User ) then -- Nicht ersch�pft
        return
    end
    
    if (User:countItemAt("belt",249)==0) then -- Getreideb�ndel im G�rtel
        if (ltstate ~= Action.success) then
            common.InformNLS( User, 
            "Was willst du mich dem Dreschflegel bearbeiten? Dich selbst?", 
            "What do you want to flail? Yourself?" );
        end
        return
    end
    
    if ( ltstate == Action.none ) then -- Arbeit noch nicht begonnen -> Los gehts
        User:startAction( GenWorkTime(User), 0, 0, 0, 0);
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Getreide zu dreschen");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to flail grain"); 
        return
    end
    
    if common.IsInterrupted( User ) then
        local selectMessage = math.random(1,5);
        if ( selectMessage == 1 ) then
            common.InformNLS(User,
            "Du wischst dir den Schwei� von der Stirn.",
            "You wipe sweat off your forehead.");
        elseif ( selectMessage == 2 ) then
            common.InformNLS(User,
            "Die Dreschstange des Flegels l�st sich und du musst sie erneut festbinden.",
            "The flail's chain appears to be stuck, it takes you some time to fix it.");
        elseif ( selectMessage == 3 ) then
            common.InformNLS(User,
            "Du schaffst das Stroh weg um wieder mehr Platz zu haben.",
            "You tie a few straw bundles together.");
        elseif ( selectMessage == 4 ) then
            common.InformNLS(User,
            "Du kehrst kurz die Spreu zusammen und bringst sie weg.",
            "You sweep the husk into a pile and carry it away.");
        else
            common.InformNLS(User,
            "Deine H�nde brennen wie Feuer, deshalb machst du eine kurze Pause. Hoffentlich gibt das keine Blase...",
            "Your arms appear to be getting very tired, you decide on a short break.");
        end
        return
    end
    
    if common.ToolBreaks( User, SourceItem, true ) then -- Dreschflegen besch�digen
        common.InformNLS(User,
        "Dein alter Dreschflegel zerbricht.",
        "Your old flail breaks.");
        return
    end
                 
    User:eraseItem( 249, 1 ); -- Getreideb�ndel wegnehmen
    amount = GenAmount(User);                
    local notCreated = User:createItem( 259, amount, 333 ,0); -- Getreidek�rner erstellen
		if ( amount==0) then
			common.InformNLS(User,
			"Du versch�ttest etwas Getreide.",
			"You spill some grain.");
		else
    		if ( notCreated > 0 ) then -- Zu viele Items erstellt --> Char �berladen
        		world:createItemFromId( 259, notCreated, User.pos, true, 333 ,0);
        		common.InformNLS(User,
        		"Du kannst nichts mehr halten.",
        		"You can't carry any more.");
    		else -- Nicht �berladen -> Neue aktion Starten
        		User:startAction( GenWorkTime(User), 0, 0, 0, 0);
    		end      
    end              
    User:learn( 2, "peasantry", 2, 100 ); -- Lernen
    common.GetHungry( User, 200 ); -- Hungrig werden
end

-- Menge der Items die erstellt werden festlegen
function M.GenAmount(User)
    local Skill  = User:getSkill( "peasantry" );
    local Attrib = User:increaseAttrib( "dexterity", 0 );
    
    local chance = math.random( 100 );
    
    if     ( chance < (Skill+Attrib) - 10 ) then return 4;
    elseif ( chance < (Skill+Attrib)      ) then return 3;
    elseif ( chance < (Skill+Attrib) + 25 ) then return 2;
    elseif ( chance < (Skill+Attrib) + 50 ) then return 1;
    end
end

-- Arbeitszeit Generieren
function M.GenWorkTime(User)
    local Skill  = User:getSkill( "peasantry" );
    local Attrib = User:increaseAttrib( "dexterity", 0 );
    
    return math.floor( -0.3 * (Skill+Attrib) + 40);
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
