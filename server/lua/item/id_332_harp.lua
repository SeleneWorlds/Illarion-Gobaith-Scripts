local parent = require("item.general.wood")
local M = {}
local UseItem

-- I_332 Harfe spielen

-- UPDATE common SET com_script='item.id_332_harp' WHERE com_itemid=332;

local music = require("item.base.music")
local general_wood = require("item.general.wood")
music.addTalkText("#me plays the harp with a horrible crash","#me macht ein furchtbares Ger�usch mit der Harfe");
music.addTalkText("#me plays a stilted tune on the harp","#me spielt eine gezierte Melodie auf der Harfe");
music.addTalkText("#me plays a smooth melody on the harp","#me spielt eine gleichbleibende Melodie auf der Harfe");
music.addTalkText("#me plays a pretty tune on the harp","#me spielt eine nette Melodie auf der Harfe");
music.addTalkText("#me plays a beautiful melody on the harp","#me spielt eine wundersch�ne Melodie auf der Harfe");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    music.PlayInstrument(User,SourceItem,"harp");
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
