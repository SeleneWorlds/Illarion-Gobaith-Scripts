local M = {}

-- Long time effect script for paralysing
-- effect ID: 23

function M.addEffect( Paralysis, Target )
	
	Target.movepoints = -500;
	Paralysis.nextCalled = 1;
end

function M.callEffect( Paralysis, Target )
	
	foundTime, timeLeft = Paralysis:findValue("timeLeft");
	
	if not foundTime then
		return false;
	end
	
	if timeLeft>0 then
		Target.movepoints = -500;
		Paralysis.nextCalled = 10;
		Paralysis:addValue("timeLeft", math.max(0, timeLeft-1));
		return true;
	end
	
	return false;
end

function M.loadEffect( Paralysis, Target )
	
	Target.movepoints = -500;
	Paralysis.nextCalled = 10;
end

function M.removeEffect( Paralysis, Target )
	
	Target.movepoints = 21;
end

return M
