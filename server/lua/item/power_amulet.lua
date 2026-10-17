local parent = require("item.id_222_amulett")
local common = require("base.common")
local M = setmetatable({}, { __index = parent })

function M.MoveItemBeforeMove(user, sourceItem, targetItem)
    if sourceItem:getType() == scriptItem.field then
        common.TempInformNLS(user,
            "Etwas hindert dich daran, das Amulett auch nur anzufassen.",
            "Something won't let you even touch the amulet.")
    end
    return true
end

function M.UseItem(User, SourceItem, TargetItem, counter, param, ltstate)
    if SourceItem:getType() ~= scriptItem.inventory or SourceItem.itempos ~= 2 then return end
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

return M
