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
msgs:addMessage("#me brüllt laut und kraftvoll.", "#me roars loudly and powerfully.");
msgs:addMessage("#me fletscht grässliche gelbe Zähne.", "#me bares ugly yellow teeth.");
msgs:addMessage("#me grunzt bösartig.", "#me grunts angrily.");
msgs:addMessage("#me knurrt leise und bedrohlich.", "#me snarls quietly and threateningly.");
msgs:addMessage("#me lacht heiser.", "#me laughs hoarsely.");
msgs:addMessage("#me spuckt auf den Boden, ein boßhaftes Grinsen auf dem Gesicht.", "#me spits at the ground, an evil grin stands in the face.");
msgs:addMessage("Bluuuuut!", "Bloooood!");
msgs:addMessage("D' Vatherr mit mirr ist!", "Da Fadha beh whib me!");
msgs:addMessage("Für d'n Vatherr von alle Orks!", "For da Fadha op all orcis!");
msgs:addMessage("Mirr zermatsch! Hurr! Hässliche Fresse!", "Me smash! Hurr! Ugly fais!");
msgs:addMessage("Renn wie Feigling, renn!", "Run coward, run!");
msgs:addMessage("Starr mirr nischt so an!", "Nub stare at me like dat!");
msgs:addMessage("Mir wütend. Mir dir nun auseinandernehmen wie Spinne! Mir dir zertreten wie Made!", "Me angry! Me smash yoos like spider. Mes stomp yoos like maggot!");
msgs:addMessage("#me schlägt sich an die Brust und röhrt heiser: 'In den Kampf, ein Ork drückt sich nicht!'", "#me slams his fist on his chest and roars: 'On dem! Orcis nub retreat!'");
msgs:addMessage("#me ist grün.", "#me is green.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==45) then
        return ( drop.CastMonMagic(Monster,Enemy,6,{1500,2000},{{51,5}},{},40,1,{50,60}) or drop.CastHealing( Monster, 6, {2000,3500}, 8, {16, 13}, 40 ) );
    elseif (MonID==43) then
        return ( drop.Stealing(Monster,Enemy) == true );
    else
        return false
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
    elseif (MonID==45) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{1500,2000},{{51,5}},{},40,1,{50,60}) or drop.CastHealing( Monster, 5, {2000,3500}, 8, {16, 13}, 40 ) );
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
