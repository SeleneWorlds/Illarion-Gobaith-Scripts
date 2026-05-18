local M = {}
local MoveItemAfterMove

-- UPDATE common SET com_script='item.id_456_snowball' WHERE com_itemid IN (456);

function M.MoveItemAfterMove(User, SourceItem, TargetItem)
	if Round==nil then
		Round=1;
	end
	if Round==1 then
        User:talkLanguage(CCharacter.say,CPlayer.german,"#me wirft einen Schneeball.");
        User:talkLanguage(CCharacter.say,CPlayer.english,"#me throws a snowball.");
		Round=2;
	else
		Round=nil;
	end
end

return M
