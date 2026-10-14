local init
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me grinst breit.", "#me grins widely.");
msgs:addMessage("#me kichert.", "#me giggles.");
msgs:addMessage("#me lacht.", "#me laughs.");
msgs:addMessage("Bei Adron's Laute!", "By Adron's lute!");
msgs:addMessage("Der lauteste Tyrann stirbt mit einer Faust im Gemächt!", "The worst tyrant dies by a fist in his sleep!");
msgs:addMessage("Du bekommst keinen Kuchen von mir!", "You don't get a cake from me!");
msgs:addMessage("Einen toten Halbling ehren Hunderte!", "A dead halfling is honoured by hundreds!");
msgs:addMessage("Ich geb dir 'nen Nachschlag!", "Here, let me give you a second helping!");
msgs:addMessage("Lange Beine, kleines Hirn. Hau ab!", "Long legs, little brain. Go away!");
msgs:addMessage("Von deinem Gesicht wird ja die Milch sauer!", "Milk goes sour after seeing your face!");
msgs:addMessage("Von dir kann man sich eine Scheibe abschneiden!", "I'll cut a slice off of you!");

end


function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==23) then
        return ( drop.Stealing(Monster,Enemy) == true );
    else
        return false;
    end
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();

    if drop.DefaultSlowdown( Monster ) then
        return true
    else
        return false
    end
end

function M.onAttacked(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function M.onCasted(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function M.onDeath(Monster)

    if killer[Monster.id] ~= nil then

        murderer=getCharForId(killer[Monster.id]);
    
        if murderer then
            killer[Monster.id]=nil;
            murderer=nil;

        end
    end

    drop.Dropping(Monster);
end

return M
