local parent = require("item.general.wood")
local M = {}
local UseItem, LookAtItem

-- I_2744_pfeife.lua
--
local common = require("base.common")
require("item.general.wood")

-- UPDATE common SET com_script='item.id_2744_pipe' WHERE com_itemid = 2744;

function M.UseItem( Character, SourceItem, TargetItem, Counter, Param)

    if (Character:countItemAt("belt",155)==0) then -- kein Sibanac???
        common.InformNLS( Character,
        "Du ben�tigst Sibanac-Bl�tter um Pfeife rauchen zu k�nnen.",
        "You need sibanac-leafs to smoke a pipe." );
        return
    end

    -- Effekt setzen falls noch nicht vorhanden
    find, stonedEffect = Character.effects:find(19);
    if find then
	found, stonedIndex = stonedEffect:findValue("stonedIndex");
	if found then
	    stonedEffect:addValue("stonedIndex",(stonedIndex+1));
	end
    else

	Character.effects:addEffect( CLongTimeEffect(19,10) );
    end

    Character:talkLanguage(CCharacter.say,CPlayer.german ,"#me nimmt einen tiefen Zug von der Pfeife.");
    Character:talkLanguage(CCharacter.say,CPlayer.english,"#me takes a deep drag from the pipe.");
    
    Character:eraseItem( 155, 1 );

end

function M.LookAtItem(User, Item)
	
	local customText = base.lookat.GetItemDescription(User,Item,2,false,false);
	if Item.data > 2^30 then
		world:itemInform( User, Item, customText );
	else
		world:itemInform( User, Item, User:getPlayerLanguage()==0 and
			"Du siehst "..world:getItemName(Item.id,0) or
			"You see "..world:getItemName(Item.id,1) );
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
