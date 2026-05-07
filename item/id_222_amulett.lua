local parent = require("item.priest.jewel")
local M = {}
local MoveItemBeforeMove, LookAtItem, UseItem, RingOfPower, RoadToNode, RemoveMuckyLuck, MuckyLuck

-- UPDATE common SET com_script='item.id_222_amulett' WHERE com_itemid IN (222);

require("item.priest.jewel")
local common = require("base.common")

function M.MoveItemBeforeMove( who, sourceItem, targetItem )
    fnd, eff = who.effects:find(9)
    if (fnd) then
        common.InformNLS(who, "Der Einfluss des Daemons hindert dich daran das Amulett ab zu nehmen","the power of the demon hinders you to remove the amulet");
        return false;
    else
        if ( targetItem.data == 777 ) then
		    if ( sourceItem.itempos == 2) then
		    	who:inform("Du kannst das Amulett nicht abnehmen.")
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
            world:itemInform(User,Item,"Du siehst ein sternf�rmiges Amulett in dessen Mitte eine stilisierte Eisflamme eingelassen ist, die sich um eine ebenso stilisierte Feuerflamme windet.");
        else
            world:itemInform(User,Item,"You see a star-shaped amulet with a	stylized iceflame in the middle, which twines about an equal stylized fireflame.");
        end
    else
        world:itemInform(User,Item,GetItemDescription(User,Item,1,false,false ));
    end
end


function M.UseItem(User,SourceItem,TargetItem,counter,param,ltstate)
	if (TargetItem.id == 914) and (TargetItem.data == 666) then
        User:talkLanguage(CCharacter.say,CPlayer.german ,"#me's Hand leuchtet, ebenso wie das Drachenamulett, hell auf und als das Licht verlischt liegt ein seltsam geformter Schl�ssel in der Hand und die Schrift auf dem Steinsockel gl�ht auf.");
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
			RingOfPower(User);
		elseif counter >= 2 and counter <= 5 then
			if not RoadToNode(User, counter-1) then
				User:inform("#w No valid target found.");
			end
		elseif counter == 6 then
			MuckyLuck(User);
		elseif counter == 7 then
			RemoveMuckyLuck(User, TargetItem);
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
	for i,char in charList do
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

function M.RemoveMuckyLuck(User, TargetItem)

	local radius = 2;
	local foodItems = {158,159,162};
	if TargetItem.id ~= 0 then
		for i,id in foodItems do
			if id == TargetItem.id and TargetItem.wear == 255 then
				world:erase(TargetItem,1);
			end
		end
	else
		local item;
		local event;
		event = function(pos)
			item = world:getItemOnField(pos);
			for i,id in foodItems do
				if id == item.id and item.wear == 255 then
					world:erase(item,1);
					return;
				end
			end
		end
		for i=1,radius do
			common.CreateCircle(User.pos,i,event);
		end
	end
end

function M.MuckyLuck(User)

	local radius = 2;
	local foodItems = {158,159,162};
	local pos = common.GetFrontPosition(User);
	if world:createDynamicNPC("Mucky Luck Sheep",18,pos,0,"npc_mucky_luck_sheep.lua") then
		world:makeSound(13,User.pos);
		local event;
		local item;
		local count = 1;
		event = function(posi)
			item = world:getItemOnField(posi);
			if item.id == 0 then
				count = (count > #foodItems) and 1 or count;
				item = world:createItemFromId(foodItems[count],1,posi,false,333,0);
				item.wear = 255;
				world:changeItem(item);
				count = count + 1;
			end
		end
		for i=1,radius do
			common.CreateCircle(pos,i,event);
		end
	else
		common.TempInformNLS(User,
			"Irgendetwas verhindert die Ausf�hrung des Rituals.",
			"Something inhibits performing the ritual.");
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
