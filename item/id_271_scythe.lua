local parent = require("item.general.metal")
local M = {}
local UseItem

-- Sense ( 271 )

-- reifes Getreide  --> Getreideb�ndel

-- UPDATE common SET com_script='item.id_271_scythe' WHERE com_itemid IN (271);

local common = require("base.common")
require("item.general.metal")
local gathering = require("content.gathering")

function M.UseItem( User, SourceItem, TargetItem, Counter, Param )   
	gathering.InitGathering();
	
    if ((TargetItem == nil) or (TargetItem.id == 0)) then -- Anvisiertes Item Vorhanden
        TargetItem = common.GetFrontItem( User ); -- Wenn nicht Item in Blickrichtung nehmen
    end
    
    if (TargetItem.id ~= 248) then
        return
    end
    
    if common.Encumbrence(User) then -- Durch Steife R�stung behindert
        common.InformNLS( User,
        "Deine R�stung behindert dabei die Feldarbeit zu verrichten.",
        "Your armor disturbes while farming." );
        return
    end
    
    if ( SourceItem:getType() ~= 4 ) then -- Sense in der Hand
        common.InformNLS( User, 
        "Du mu�t die Sense in die H�nde nehmen.", 
        "Take the scythe into your hands." )
        return
    end
    
    if not common.IsLookingAt( User, TargetItem.pos ) then -- Blickrichtung pr�fen
        common.TurnTo( User, TargetItem.pos ); -- notfalls drehen
    end
    
	if not farming:FindRandomItem(User) then
		return
	end
	
    if common.ToolBreaks( User, SourceItem, true ) then -- Sense besch�digen
        common.InformNLS( User, 
        "Die rostige Sense zerbricht.", 
        "The rusty scythe breaks." );
        return
    end
    
    if (TargetItem.data > 1) then
        TargetItem.data = TargetItem.data - 1;
        world:changeItem(TargetItem);
    else
        world:erase( TargetItem, 1 );     -- Getreideitem l�schen
    end
    local notCreated = User:createItem( 249, 1, 333 ,0); -- Getreideb�ndel erstellen
    if ( notCreated > 0 ) then -- Zu viele Items erstellt --> Char �berladen
        world:createItemFromId( 249, notCreated, User.pos, true, 333 ,0);
        common.InformNLS(User,
        "Du kannst nichts mehr halten.",
        "You can't carry any more.");
    end
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
