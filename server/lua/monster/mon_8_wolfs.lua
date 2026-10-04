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
msgs:addMessage("#me bleibt steifbeinig und aufgerichtet stehen.", "#me stands stiff legged and tall.");
msgs:addMessage("#me duckt sich, bereit anzugreifen.", "#me crouches, ready to strike.");
msgs:addMessage("#me hat Schaum vor dem Maul.", "#me foams at the mouth.");
msgs:addMessage("#me hebt seinen Kopf und heult.", "#me raises its head and howls.");
msgs:addMessage("#me kläfft laut.", "#me barks loudly.");
msgs:addMessage("#me knirscht mit den Zähnen.", "#me gnashes its teeth.");
msgs:addMessage("#me knurrt, das Geräusch ist kaum hörbar.", "#me growls, the noise barely audible.");
msgs:addMessage("#me krümmt seinen Rücken.", "#me arches its back.");
msgs:addMessage("#me lässt ein böses Knurren hören.", "#me lets out a vicious snarl.");
msgs:addMessage("#me stellt seine Ohren auf.", "#me's ears perk up.");
msgs:addMessage("#me bleckt die Zähne.", "#me bares its teeth.");
msgs:addMessage("#mes Fell sträubt sich.", "#me's fur bristles");
msgs:addMessage("#mes Schwanz streckt sich hinter seinem Körper gerade aus.", "#me's tail extends straight out from its body.");

end


function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    return false
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

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

    drop.ClearDropping();
    drop.AddDropItem(63,1,50,333,0,1); --inners
    drop.AddDropItem(2586,1,100,333,0,2); --fur
    drop.Dropping(Monster);
end

return M
