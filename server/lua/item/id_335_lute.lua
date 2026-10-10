local parent = require("item.general.wood")
local M = {}

-- I_335 Laute spielen

-- UPDATE common SET com_script='item.id_335_lute' WHERE com_itemid=335;

local music = require("item.base.music").new()
local general_wood = require("item.general.wood")
music.addTalkText("#me makes a terrible noise on the lute","#me macht ein furchtbares Geräusch mit der Laute");
music.addTalkText("#me plays some halting tunes","#me spielt einige unsichere Töne auf der Laute");
music.addTalkText("#me plays some nice tunes on the lute","#me spielt einige schöne Töne auf der Laute");
music.addTalkText("#me plays some nice sounding tunes on a lute","#me spielt einige gut klingende Töne auf der Laute");
music.addTalkText("#me plays a lilting melody on a lute","#me spielt eine trällernde Melodie auf der Laute");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    music.PlayInstrument(User,SourceItem,"lute");
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
