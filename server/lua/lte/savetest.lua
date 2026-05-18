local M = {}

function M.addEffect( theEffect, User )
    User:inform("Testeffekt added");
	theEffect:addValue("testvalue2",20);
end

function M.callEffect(theEffect, User )
    theEffect.nextCalled = 5; --erneut in 5 sec
	User:inform("Testeffekt called");
    return true;
end

function M.removeEffect( theEffect, User )
    User:inform("Testeffekt removed");
end

function M.loadEffect( theEffect, User)
    User:inform("Testeffekt loaded");
end

return M
