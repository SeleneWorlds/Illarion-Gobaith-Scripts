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
msgs:addMessage("#me knurrt bedrohlich.", "#me snarls menacingly.");
msgs:addMessage("#me prustet vor Lachen.", "#me snorts with laughter.");
msgs:addMessage("Das ist dein letzter Tag!", "You shall not live to see another day!");
msgs:addMessage("Dein Schicksal ist besiegelt!", "Your fate is sealed!");
msgs:addMessage("Deine Versuche sind erbärmlich!", "Your attempts are pathetic!");
msgs:addMessage("Die Kammerjäger sind da!", "This is pest control!");
msgs:addMessage("Du widerst mich an!", "You disgust me!");
msgs:addMessage("Erwarte keine Gnade!", "Do not expect mercy!");
msgs:addMessage("Ich werde es kurz machen!", "I shall make this quick!");
msgs:addMessage("Irgendwelche letzten Worte?!", "Any last words?!");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    return ( drop.CastMonMagic(Monster,Enemy,10,{},{},{{359,222,555,0,7},{360,222,555,0,7},{372,222,555,0,7}},20,1) == true );
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    if drop.DefaultSlowdown( Monster ) then
        return true
    else
        return ( drop.CastMonMagic(Monster,Enemy,10,{},{},{{359,222,555,0,7},{360,222,555,0,7},{372,222,555,0,7}},20,1) == true );
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
