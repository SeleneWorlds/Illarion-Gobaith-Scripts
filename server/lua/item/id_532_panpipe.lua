local parent = require("item.general.wood")
local M = {}

-- I_532 playing the panpipe

-- UPDATE common SET com_script='item.id_532_panpipe' WHERE com_itemid=532;

local music = require("item.base.music").new()
local general_wood = require("item.general.wood")
music.addTalkText("#me blows hard into the panpipes, making a loud, annoying, screeching sound.", "#me pustet in die Panflöte und erzeugt ein lautes, nerviges, fast schreiendes Geräusch." );
music.addTalkText("#me blows into the panpipes randomly, letting out a few loud uncoordinated sounds.", "#me bläst wirr auf der Panflöte, laute aber unmelodische Töne sind die Folge.");
music.addTalkText("#me blows gently into the panpipes, playing a few short tunes.","#me spielt einige leise Töne sachte auf der Panflöte. ");
music.addTalkText("#me plays a nice, coordinated melody on the panpipes.","#me spielt eine klare Melodie auf der Panflöte. ");
music.addTalkText("#me plays his panpipes, blowing gently and gracefully, playing an impressively beautiful melody.","#me spielt behändig eine beeindruckende Melodie voller Anmut auf der Panflöte. ");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param)
    music.PlayInstrument(User,SourceItem,"panpipe");
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
