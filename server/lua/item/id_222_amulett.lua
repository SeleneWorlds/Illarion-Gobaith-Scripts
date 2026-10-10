local parent = require("item.priest.jewel")
local M = {}

-- UPDATE common SET com_script='item.id_222_amulett' WHERE com_itemid IN (222);

local priest_jewel = require("item.priest.jewel")
local common = require("base.common")

function M.MoveItemBeforeMove( who, sourceItem, targetItem )
    fnd, eff = who.effects:find(9)
    if (fnd) then
        common.InformNLS(who, "Der Einfluss des Daemons hindert dich daran das Amulett ab zu nehmen","the power of the demon hinders you to remove the amulet");
        return false;
    else
        if ( targetItem.data == 777 ) then
		    if ( sourceItem.itempos == 2) then
                common.InformNLS(who, "Du kannst das Amulett nicht abnehmen.", "You cannot remove the amulet.")
		        return false;
	 	    else
		    	return true;
		    end
		elseif targetItem.data == 111 then
			if sourceItem:getType() == 3 then
				common.TempInformNLS(who,
					"Etwas hindert dich daran, das Amulett auch nur anzufassen.",
					"Something won't let you even touch the amulet.");
				--return false;
			end
		end
    end
	return true;
end

function M.LookAtItem(User, Item)
    if ( Item.data == 666 ) then
        if (User:getPlayerLanguage() == 0) then
            world:itemInform(User,Item,"Du siehst ein verfluchtes Amulett des Sukkubus");
        else
            world:itemInform(User,Item,"You see the cursed amulet of the Succubus");
        end
    elseif ( Item.data == 777 ) then
		if (User:getPlayerLanguage() == 0) then
            world:itemInform(User,Item,"Du siehst Leeven's Amulett");
        else
            world:itemInform(User,Item,"You see Leeven's amulet");
        end
	elseif ( Item.data == 778 ) then
		if (User:getPlayerLanguage() == 0) then
            world:itemInform(User,Item,"Du siehst ein sternförmiges Amulett in dessen Mitte eine stilisierte Eisflamme eingelassen ist, die sich um eine ebenso stilisierte Feuerflamme windet.");
        else
            world:itemInform(User,Item,"You see a star-shaped amulet with a	stylized iceflame in the middle, which twines about an equal stylized fireflame.");
        end
    else
        world:itemInform(User,Item,GetItemDescription(User,Item,1,false,false ));
    end
end


function M.UseItem(User,SourceItem,TargetItem,counter,param,ltstate)
	if (TargetItem.id == 914) and (TargetItem.data == 666) then
        User:talkLanguage(CCharacter.say,CPlayer.german ,"#me's Hand leuchtet, ebenso wie das Drachenamulett, hell auf und als das Licht verlischt liegt ein seltsam geformter Schlüssel in der Hand und die Schrift auf dem Steinsockel glüht auf.");
        User:talkLanguage(CCharacter.say,CPlayer.english,"#me's Hand, as well as the dragon amulet, starts to glow brightly and as the light is gone there is a strange formed key inside the hand and the letters on the stone socket starts to shine.");
		world:gfx(8,TargetItem.pos);
		world:gfx(11,TargetItem.pos);
		world:gfx(31,TargetItem.pos);
		world:swap(TargetItem,3105,333);
		world:makeSound(7,TargetItem.pos);
		world:makeSound(26,TargetItem.pos);
		Keydata=0;
		if (User.pos.z == -6) then
			Keydata=666;
		elseif (User.pos.z == 1) then
			Keydata=667;
		elseif (User.pos.z == 3) then
			Keydata=668;
		elseif (User.pos.z == 0) then
			Keydata=669;
		end
		User:createItem( 2144, 1, 333, Keydata );

	elseif SourceItem.data == 111 and SourceItem.itempos == 2 then
		if counter == 1 then
			M.RingOfPower(User);
		elseif counter >= 2 and counter <= 5 then
			if not M.RoadToNode(User, counter-1) then
				common.TempInformNLS(User, "Kein gültiges Ziel gefunden.", "No valid target found.");
			end
		elseif counter == 8 and ((TargetItem ~= nil) and (TargetItem.id ~= 0)) then
			world:erase(TargetItem,255);
		end
	end

end

function M.RingOfPower(User)

	local pos = common.GetFrontPosition(User);
	world:gfx(2,pos);
	world:makeSound(4,pos);
	local flame = world:createItemFromId(359,1,pos,true,333,0);
	flame.wear = 1;
	world:changeItem(flame);
	world:makeSound(7,pos);
end

function M.RoadToNode(User, effectType)

	local charList = world:getPlayersInRangeOf(User.pos, 5);
	local validChars = {};
	local retVal = false;
	for i,char in pairs(charList) do
		if char.id ~= User.id and char.pos.z == User.pos.z then
			if not char.effects:find(29) then
				table.insert(validChars, char);
				retVal = true;
			end
		end
	end
	if retVal then
		local target = validChars[math.random(1,#validChars)];
		local effect = CLongTimeEffect(29,1);
		effect:addValue("effectType", effectType);
		target.effects:addEffect(effect);
	end
	return retVal;
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
