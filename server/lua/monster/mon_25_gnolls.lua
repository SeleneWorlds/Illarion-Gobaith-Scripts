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
msgs:addMessage("#me bellt vor Wut.", "#me barks in fury.");
msgs:addMessage("#me fletscht die Zähne.", "#me bares its teeth.");
msgs:addMessage("#me hechelt.", "#me utters a noise, half cackle, half howl.");
msgs:addMessage("#me jault.", "#me howls.");
msgs:addMessage("#me kichert schrill und laut.", "#me cackles with a loud and piercing sound.");
msgs:addMessage("#me kneift seine Augen zusammen.", "#me squints its eyes.");
msgs:addMessage("#me knurrt leise.", "#me snarls quietly.");
msgs:addMessage("#me schnappt.", "#me snaps its jaw.");
msgs:addMessage("#me schnauft laut.", "#me gasps loudly.");
msgs:addMessage("#me's Schwanz sträubt sich.", "#me's tail rises.");
msgs:addMessage("#me zieht die Luft scharf schnüffelnd durch die Nase ein.", "#me breathes through its nose, sniffing.");
msgs:addMessage("#me legt den Kopf in den Nacken und stößt eine Mischung aus Heulen und Gebell hervor.", "#me throws back its head and lets out a mixture of howling and barking.");
msgs:addMessage("#me fährt sich mit seiner rauhen Zunge über die Schnauze, ehe er leise verärgert kläfft.", "#me licks its nose with its rough tongue before it yaps angrily.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==253) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{1000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
    elseif (MonID==254) then
        return ( drop.Stealing(Monster,Enemy) == true );
    else
        return false;
    end
end

function M.enemyOnSight(Monster,Enemy)
    local MonID=Monster:get_mon_type();

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    if drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==253) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{1000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
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
