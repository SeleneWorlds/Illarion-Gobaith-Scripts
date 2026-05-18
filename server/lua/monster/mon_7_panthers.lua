local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me blinzelt mit beiden Augen, l�sst seinen Blick jedoch keinen Moment von seinem Ziel abschweifen.", "#me blinks with both eyes still not moving its gaze from its target for even one second.");
msgs:addMessage("#me duckt sich, bereit zum Sprung.", "#me crouches, ready to jump.");
msgs:addMessage("#me faucht angriffslustig und schnellt vorw�rts.", "#me hisses aggressively and rushes forward.");
msgs:addMessage("#me ist ein schneller, wendiger und unberechenbarer Gegner, dessen Bewegungen in ihrer Ger�uschlosigkeit �berraschen.", "#me is a fast, agile and unpredictable enemy, whose movements surprise in their silence.");
msgs:addMessage("#me l�sst ein drohendes Grollen tief in seiner Kehle ert�nen.", "#me sends out a menacing growl from deep within its throat.");
msgs:addMessage("#me legt murrend die Ohren an.", "#me grumbling flattens its ears.");
msgs:addMessage("#me miaut jammernd, aber der Schmerz scheint ihn eher noch w�tender zu machen.", "#me whines, but the pain seems to make it even angrier.");
msgs:addMessage("#me peitscht mit seinem Schwanz duch die Luft.", "#me lashes its tail through the air.");
msgs:addMessage("#me schleicht auf samtigen Pfoten.", "#me sneaks on velvet paws.");
msgs:addMessage("#me springt ohne Vorwarnung, die Z�hne zum t�dlichen Biss gebleckt.", "#me jumps without warning; fangs prepared for a deadly bite.");
msgs:addMessage("#mes Fell gl�nzt wie schwarzer Samt, aber sein Schwanz zornig gestr�ubt wie eine B�rste.", "#me's fur shines like black velvet, but its tail is viciously bristled like a brush.");
msgs:addMessage("#mes wei�e Z�hne bilden einen scharfen Kontrast zu seinem schwarzen Fell, als er sie fauchend zeigt.", "#me�s white teeth contrast hard with its black fur, as it hisses and bares them.");

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
