local M = {}
npc = npc or {}
npc.testwp = M
local _ENV = setmetatable(M, { __index = _G })

function M.initializeNpc()
    TraderFirst = false;
	thisNPC:increaseSkill(1,"common language",100);
	thisNPC.activeLanguage=0;
    thisNPC.waypoints:addWaypoint(position(-110,-117,0));
	thisNPC.waypoints:addWaypoint(position(-113,-111,0));
	thisNPC:setOnRoute(true);
end
    
function M.nextCycle()  -- ~10 times per second
    if (TraderFirst == nil) then
        initializeNpc();
    end
end	

function M.characterOnSight(npc,Enemy)
    waypoints = thisNPC.waypoints:getWaypoints();
	wp = waypoints[1];
	if ( wp == nil ) then
		Enemy:inform("no current waypoint");
	else
        Enemy:inform("npc on Waypoint x:" .. wp.x .. " y:" .. wp.y .. " z:" .. wp.z);
    end
end

function M.abortRoute(npc)
	thisNPC:talk(CCharacter.say,"Route abgebrochen");
	thisNPC.waypoints:clear();
	waypoints = {position(-110,-117,0),position(-113,-111,0)};
	thisNPC.waypoints:addFromList(waypoints);
	thisNPC:setOnRoute(true);
end

return M
