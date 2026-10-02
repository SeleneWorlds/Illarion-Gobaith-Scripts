-- INSERT INTO triggerfields VALUES (x,y,z,'triggerfield.gangeffekt');

local M = {}

function M.InitTriggers()
	M.AddCreateEffect(position(10, 10, 0), 1, { position(15,10,0), position(5,10,0) }, { 2553, 2553 });
	M.AddRemoveEffect(position(10, 15, 0), { position(15,10,0), position(5,10,0) }, { 2553, 2553 });
end

function M.AddCreateEffect(TriggerPos, TriggerSound, ItemPos, ItemID)
	table.insert(EItemPos, ItemPos);
	table.insert(EItemID, ItemID);
	table.insert(ETriggerPos, TriggerPos);
	table.insert(ETriggerSound, TriggerSound);
	table.insert(ERemove, false);
end

function M.AddRemoveEffect(TriggerPos, ItemPos, ItemID)
	table.insert(EItemPos, ItemPos);
	table.insert(EItemID, ItemID);
	table.insert(ETriggerPos, TriggerPos);
	table.insert(ETriggerSound, nil);
	table.insert(ERemove, true);
end

function M.MoveToField(User)
	if(Init == nil) then
		EItemPos = {{}};
		EItemID = {{}};
		ETriggerPos = {};
		ETriggerSound = {};
		ERemove = {};

		M.InitTriggers();

		Init = 1;
	end
	for i,v in pairs(ETriggerPos) do
		if(ETriggerPos[i] == User.pos) then
			for a,b in pairs(EItemPos) do
				local item = world:getItemOnField(EItemPos[i][a]);
				if(item.id ~= EItemID[i][a]) then
					if(not ERemove) then
						local citem = world:createItemFromId(EItemID[i][a], 1, EItemPos[i][a], true, 333, 0);
						citem.wear = 255;
						world:changeItem(citem);
					end
				else
					if(ERemove) then
						world:erase(item, 1);
					end
				end
			end
			if(not ERemove) then
				world:makeSound(ETriggerSound[i], User.pos);
			end
		end
	end
end

return M
