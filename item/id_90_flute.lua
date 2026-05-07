local parent = require("item.general.wood")
local M = {}
local UseItem

-- I_90 Floete spielen

-- UPDATE common SET com_script='item.id_90_flute' WHERE com_itemid=90;

local music = require("item.base.music")
require("item.general.wood")

music.addTalkText("#me produces some squeaking sounds on the flute","#me macht einige quietschende Ger�usche auf der Fl�te");
music.addTalkText("#me plays a horribly out of tune melody","#me spielt eine f�rchterlich verstimmte Melodie auf der Fl�te");
music.addTalkText("#me plays an out of tune melody","#me spielt eine verstimmte Melodie auf der Fl�te");
music.addTalkText("#me plays an airy tune on the flute","#me spielt eine leichte Melodie auf der Fl�te");
music.addTalkText("#me plays a wild tune on the flute","#me spielt eine wilde Melodie auf der Fl�te");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    music.PlayInstrument(User,SourceItem,"flute");
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
