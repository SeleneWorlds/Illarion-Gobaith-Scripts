local M = {}
local UseItem

-- Kerzenziehertisch

-- Honigwaben (2529) zu Wachs (431)
-- Arbeitscyclus: 2s
-- Zus�tzliches Werkzeug: Zange mit Tiegel ( 2751 )

-- UPDATE common SET com_script='item.id_428_candletable' WHERE com_itemid IN (428);

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
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
    
    if not common.CheckItem( User, SourceItem ) then
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife R�stung?
        common.InformNLS( User,
        "Deine R�stung behindert beim Arbeiten.",
        "Your armor disturbes you while working." );
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then
        common.TurnTo( User, SourceItem.pos );
    end
    
    if not common.FitForWork( User ) then
        return
    end
    
    if (User:countItemAt("body",2751)==0) then -- Tiegelzange
        common.InformNLS( User,
        "Du ben�tigst eine Tiegelzange um Wachs zu schmelzen.",
        "You need a crucible-pincers to smelt wax." );
        return
    end
    
    local Tool = User:getItemAt(CCharacter.left_tool); -- Item in Linker Hand auslesen
    if ((Tool == nil) or (Tool.id ~= 2751)) then -- Wenn das Item nicht die Tiegelzange ist
        Tool = User:getItemAt(CCharacter.right_tool); -- In anderer Hand nachsehen
    end
    
    if common.ToolBreaks( User, Tool, true) then -- Tiegelzange besch�digen
        common.InformNLS( User, 
        "Die Zange geht zu Bruch.", 
        "The pincers break." );
        return
    end
    
    if ((User:countItemAt("belt",2529) < 1)) then     -- Hongwaben vorhanden?
        if (ltstate ~= Action.success) then
            common.InformNLS( User, 
            "Du ben�tigst Honigwaben um Wachs daraus herzustellen.", 
            "You need honeycomb to make some wax." );
        end
        return
    end
    
    if ( ltstate == Action.none ) then
        User:startAction( 20, 0, 0, 0, 0 );
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Wachs zu schmelzen.");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to smelt wax.");
        return
    end
    
    if common.IsInterrupted( User ) then
        local selectMessage = math.random(1,2);
        if ( selectMessage == 1 ) then
            common.InformNLS(User,
            "Du wischst dir den Schwei� von der Stirn.",
            "You wipe sweat off your forehead.");
        elseif ( selectMessage == 2 ) then
            common.InformNLS(User,
            "Du versch�ttest hei�es Wachs, aber gl�cklicherweise nicht �ber deine Finger. Trotzdem musst du von Neuem beginnen.",
            "You overwhelm some hot wax and need to repeat your work. Lucky that the wax did not hit your fingers.");
        end
        return
    end
    
    if (User:countItemAt("belt",2529) > 0) then
        User:eraseItem( 2529, 1 ); --Honigwabe wird gel�scht
        local notcreated = User:createItem(431, 1, 333 ,0 );
        if (notcreated > 0) then
            world:createItemFromId( 431, 1, User.pos, true, 333 ,0); -- Wachs wird erstellt
            common.InformNLS(User,
            "Du kannst nichts mehr halten.",
            "You can't carry any more.");
        else
            User:startAction( 20, 0, 0, 0, 0 );
        end
    end

    common.GetHungry( User, 100 );
    
end -- function

return M
