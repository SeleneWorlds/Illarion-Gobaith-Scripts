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
msgs:addMessage("#me bewegt sich flink auf und ab.", "#me moves up and down in an agile manner.");
msgs:addMessage("#me faucht agressiv.", "#me spits aggressively.");
msgs:addMessage("#me schüttelt einige Schuppen von seinem Rücken.", "#me loses some scales off his back.");
msgs:addMessage("#me zischt etwas unverständliches.", "#me hisses something unintelligible.");
msgs:addMessage("#mes Schwanz bewegt sich scheinbar unkontrolliert hin und her.", "#me's tail moves rapidly in a back and forth motion");
msgs:addMessage("Ich rieche Ärger...", "I smell trouble...");
msgs:addMessage("Sssssssss...", "Sssssssss...");
msgs:addMessage("Unssere Feinde sollen die Macht des Wassssssers zu spüren bekommen!", "Our enemiessss ssshould feel the power of water!");
msgs:addMessage("Unssere Rassssse wird überleben!", "Our race will sssssurvive!");
msgs:addMessage("Zshhel-pheey-arrr sssteht mir bei!", "Zshhel-pheey-arrr sssstands by me!");
msgs:addMessage("#me flüstert leise: 'Grossse Mutter, bereite mir ein Bad in deinem Tempel, ich werde bald zu dir stossssen!'.", "#me whispers: 'Great mother, prepare a bath for me in your templesss. I will sssoon come to yousss.'.");
msgs:addMessage("#me schlägt mit dem Schwanz drohend auf den Boden und zeigt seine spitzen Zähne, die gelben Augen sind zu schmalen Schlitzen verzogen.", "#me slams his tail on the ground and bares his sharp teeth. The yellow eyes are squinted to slits.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==53) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,6,{1200,2400},{{4,5}},{},40,1,{25,60}) );
    elseif (MonID==54) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{16,0},{37,0}},{{360,320,500,0,0}},40,0) == true );
    elseif (MonID==55) then
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
    elseif (MonID==53) then
        return ( drop.CastMonMagic(Monster,Enemy,6,{1500,3000},{{4,5}},{},40,1,{25,60}) or drop.CastHealing( Monster, 4, {2000,3500}, 8, {16, 13}, 40 ) or drop.CastParalyze( Monster, Enemy, 5, {-10,-20}, 5, {6,1}, 10 ,{25,60} ) );
    elseif (MonID==54) then
        return ( drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{16,0},{37,0}},{{360,320,500,0,0}},40,0) == true );
    else
        return false;
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
