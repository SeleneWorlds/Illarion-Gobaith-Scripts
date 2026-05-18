-- Used by quest 'stomp the bugs'
--  pos -19, -5, 0
local common = require("base.common")
local base_keys = require("base.keys")
module("triggerfield.stompthebugs", package.seeall)

function MoveToField(User)
	local QuestID = 27;
	local MonsterID = 131; -- CHANGE
	local MonsterPosition = position(-16, -8, 0); -- CHANGE
	local DoorPosition = position(10, 10, 1); -- CHANGE
	User:inform("Du bist auf mir drauf");
	if (User:getQuestProgress(QuestID) == 2) then
	    User:inform("Questprogress okay->suche Monster");
		local m = world:getMonstersInRangeOf(MonsterPosition, 10);
		if(#m < 1) then
			User:inform("kein Monster in der N�he gefunden->erschaffene eines");
			world:createMonster(MonsterID, MonsterPosition, 20);
			User:inform("Monster erschaffen");
		end
	--elseif (User:getQuestProgress(QuestID) == 3) then
	--	local door = world:getItemOnField(DoorPosition);
	--	base_keys.LockDoor(door);
	--	door = world:getItemOnField(DoorPosition);
	--	if(base.doors.CheckOpenDoor(door)) then
	--		base.doors.CloseDoor(door);
	--	end
	end
end
