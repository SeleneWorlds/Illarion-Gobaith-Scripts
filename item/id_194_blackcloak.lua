local parent = require("item.priest.cloth")
local M = {}
local MoveItemAfterMove

-- UPDATE common SET com_script='item.id_194_blackcloak' WHERE com_itemid IN (194);

require("item.priest.cloth")
require("base.common")

function M.MoveItemAfterMove( User, SourceItem, TargetItem )
    --anlegen des schattenmantels
    if ( TargetItem:getType() == 4 and (TargetItem.itempos == 7 or TargetItem.itempos == 8) and TargetItem.data == 100 ) then
        --unsichtbarkeitseffekt hinzu fuegen
        User.effects:addEffect( CLongTimeEffect(11,10) );
    --ablegen des schattenmantels
    elseif ( TargetItem.data == 100 ) then
        fnd, eff = User.effects:find( 11 );
        if ( fnd ) then
            User.effects:removeEffect( 11 );
        end
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
