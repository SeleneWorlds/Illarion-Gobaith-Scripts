local init
local common = require("base.common")
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me gackert bösartig.", "#me cackles softly.");
msgs:addMessage("#me haucht die Worte: 'Ihr werdet sterrrrrrben.'", "#me wheezes the words: 'You will dieee.'");
msgs:addMessage("#me hüpft auf und ab während er schwebt.", "#me bobs up and down as it floats.");
msgs:addMessage("#me keucht erzürnt.", "#me wheezes angrily.");
msgs:addMessage("#me öffnet weit seinen Mund als wolle er etwas essen, heraus kommt jedoch nur ein knarrender Ton.", "#me opens its mouth wide as if to eat, but only a creaking sound follows.");
msgs:addMessage("#me stößt einen hohen und lautet Ton aus.", "#me releases a piercing and haunting shriek.");
msgs:addMessage("#me verströmt eine tödliche kälte.", "#me emanates a deathly chill.");
msgs:addMessage("#me zischt etwas unverständliches.", "#me hisses words incomprehensibly.");
msgs:addMessage("#me zischt: 'Betretet Chergas Reich!'", "#me hisses: 'Enter Cherga's realm!'.");
msgs:addMessage("Der Schatten erwartet dich!", "Shadow followsss.");
msgs:addMessage("Die Dunkelheit wartet.", "Darrrkness awaitsss.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==233) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,8,{250,1000},{{4,5},{9,5},{51,5}},{},40,1,{25,40}) );
    elseif (MonID == 235) then
        return M.EvilLook( Monster, Enemy );
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
    elseif (MonID==233) then
        return ( drop.CastHealing( Monster, 3, {2000,2500}, 8, {16, 13}, 40 ) or drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1,{45,60}) );
    elseif (MonID == 235) then
        return M.EvilLook( Monster, Enemy );
    else
        return false
    end
end

function M.EvilLook( monster, enemy )
    if (math.random(15) ~= 1) then
        return false;
    end

    if not common.IsLookingAt( enemy, monster.pos ) then
        return false;
    end

    common.TalkNLS( monster, CCharacter.say,
    "#me blickt "..enemy.name.." mit einem bösen Blick an.",
    "#me gives "..enemy.name.." an evil look." );

    common.InformNLS( enemy,
    "Der Blick es Skelettes fährt dir ins Mark und lähmt kurz deine Glieder.",
    "The gaze of the skeleton goes to the core and freezes your limps a moment." );

    enemy.movepoints = enemy.movepoints - math.random( 10, 20 );
    monster.movepoints = monster.movepoints - 5;
    return true;
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
