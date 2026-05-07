local parent = require("item.general.wood")
local M = {}
local UseItem

-- I_533 playing the drum

-- UPDATE common SET com_script='item.id_553_drum' WHERE com_itemid=553;

local music = require("item.base.music")
require("item.general.wood")

music.addTalkText("#me hits the drum chaoticly, making a lot of noise.", "#me schl�gt planlos auf die Trommel ein und macht eine Menge L�rm." );
music.addTalkText("#me makes chattering uncoordinated noises on the drum.", "#me macht klappernde, unkoordinierte Ger�usche auf der Trommel.");
music.addTalkText("#me pounds upon the drum in a low sounding monotonous rythm.","#me schl�gt im monotonen Rhythmus klangarm auf die Trommel. ");
music.addTalkText("#me drums a loud though simple rhythm.","#me trommelt einen lauten aber einfachen Rhythmus. ");
music.addTalkText("#me bangs a powerful, coordinated beat upon the drum.","#me trommelt gut klingende mehrteilige Rhythmen. ");
music.addTalkText("#me beats in a wild, frenzied pulse, a deep broad sound emitting from the drum.","#me schl�gt in wilden vielschichtigen Rhythmen, mit vollem, tiefen Kl�ngen auf die Trommel.");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    music.PlayInstrument(User,SourceItem,"drum");
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
