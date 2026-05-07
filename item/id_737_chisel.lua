local common = require("base.common")
local parent = require("item.general.metal")
local M = {}
local UseItem, LookAtItem

-- Chisel ( 737 )

-- raw stones  --> stone blocks + small stones
-- stone blocks --> small stones

-- Arbeitscyclus: 4s - 5s

-- UPDATE common SET com_script='item.id_737_chisel' WHERE com_itemid IN (737);

require("item.general.metal")
require("item.base.crafts")

function M.UseItem( User, SourceItem, TargetItem, Counter, Param, ltstate )
    common.ResetInterruption( User, ltstate )
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
        "Deine R�stung behindert Dich beim behauen der Steine",
        "Your armor disturbes you while working the stones" );
        return
    end
    
    if (SourceItem:getType() ~= 4) then -- Dreschflegel in der Hand
        common.InformNLS( User,
        "Du musst den Meisel in der Hand haben!",
        "You need to hold the chisel in your hand!" );
        return
    end
    
    if ( User:countItemAt( "body", 23 ) == 0 ) then
        common.InformNLS( User,
        "Du brauchst einen Hammer in der Hand um die Steine zu behauen.",
        "You need a hammer in your hand to work the stones." );
        return
    end
    
    if not common.FitForWork( User ) then -- Nicht ersch�pft
        return
    end
    
    if (User:countItemAt("belt",735)==0) and (User:countItemAt("belt",733)==0) then -- Getreideb�ndel im G�rtel
        if (ltstate ~= Action.success) then
            common.InformNLS( User, 
            "Wenn du keine Steine hast, kannst du auch keine behauen.", 
            "In case you have not stones, you can't work stones." );
        end
        return
    end
    
    if ( ltstate == Action.none ) then -- Arbeit noch nicht begonnen -> Los gehts
        if (User:countItemAt("belt",735)>0) then
            User:startAction( 50-math.floor( 10 * ( User:increaseAttrib( "strength", 0 ) / 10 ) ), 0, 0, 8, 15);
        else
            User:startAction( 60-math.floor( 10 * ( User:increaseAttrib( "strength", 0 ) / 10 ) ), 0, 0, 8, 15);
        end
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Steine zu behauen");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to work stones"); 
        return
    end
    
    if common.IsInterrupted( User ) then
        common.InformNLS(User,
        "Du schl�gst daneben und triffst mit dem Hammer deine Finger.",
        "You miss the chisel and hit your fingers.");
        return
    end
    
    if common.ToolBreaks( User, SourceItem ) then -- Dreschflegen besch�digen
        common.InformNLS(User,
        "Der Meisel zerbricht.",
        "The chisel breaks.");
        return
    end
               
    if (User:countItemAt("belt",735)>0) then
        User:eraseItem( 735, 1 ); -- roher Stein weg.
        local notCreated = User:createItem( 733, 1, 333 ,0); -- behauener Stein her.
        local stop_working = false;
        if ( notCreated > 0 ) then
            world:createItemFromId( 733, 1, User.pos, true, 333 ,0);
            common.InformNLS(User,
            "Du kannst nichts mehr halten.",
            "You can't carry any more.");
            stop_working = true;
        end
        if not stop_working and (User:countItemAt("belt",735)>0) then
            User:startAction( 50-math.floor( 10 * ( User:increaseAttrib( "strength", 0 ) / 10 ) ), 0, 0, 8, 15);
        end
    elseif (User:countItemAt("belt",733)>0) then
        User:eraseItem( 733, 1 ); -- roher Stein weg.
        local notCreated = User:createItem( 1266, 25, 333 ,0); -- kleine Steiner erstellen.
        if ( notCreated > 0 ) then
            world:createItemFromId( 1266, notCreated, User.pos, true, 333 ,0);
            common.InformNLS(User,
            "Du kannst nichts mehr halten.",
            "You can't carry any more.");
        elseif (User:countItemAt("belt",733)>0) then
            User:startAction( 60-math.floor( 10 * ( User:increaseAttrib( "strength", 0 ) / 10 ) ), 0, 0, 8, 15);
        end
    end     
                  
    --User:learn( 2, "peasantry", 2, 100 ); -- Lernen
    common.GetHungry( User, 200 ); -- Hungrig werden
end

function M.LookAtItem( User, Item )
    world:itemInform( User, Item, base.lookat.GetItemDescription( User, Item, 1, false, false) );
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
