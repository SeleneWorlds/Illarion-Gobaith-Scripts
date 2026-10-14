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

msgs:addMessage("#me flucht vor sich hin.", "#me swears to himself.");
msgs:addMessage("#me grinst siegessicher.", "#me grins, certain of success.");
msgs:addMessage("#me ist in Schweiß gebadet.", "#me is bathed in sweat.");
msgs:addMessage("#me lacht laut.", "#me laughs.");
msgs:addMessage("#me spuckt auf den Boden.", "#me spits at the ground.");
msgs:addMessage("#me tippelt hin und her.", "#me hops on the spot.");
msgs:addMessage("Achtung! Alarm!", "Careful! Alert!");
msgs:addMessage("Das war's!", "That does it!");
msgs:addMessage("Die Leute werden auch immer schwächer!", "People get weaker every day!");
msgs:addMessage("Dieses Gebiet gehört mir!", "This area belongs to me!");
msgs:addMessage("Ein Drache ist nichts gegen mich!", "A dragon is nothing compared to me!");
msgs:addMessage("Fressen oder gefressen werden, so läuft das.", "Kill or be killed, that's the way it is");
msgs:addMessage("Für die Götter!", "For the gods!");
msgs:addMessage("Geld oder Leben!", "Money or life!");
msgs:addMessage("Heute ist ein guter Tag zum Töten.", "This day is a good day for killing.");
msgs:addMessage("Ich bin der Stärkste!", "I am the strongest!");
msgs:addMessage("Ich zerquetsche jeden Feind wie 'ne kleine Fee!", "I crush every enemy like a little fairy!");
msgs:addMessage("Niemand wird mich je besiegen!", "No one will ever defeat me!");
msgs:addMessage("Rollende Köpfe sind immer eine schöne Abwechslung.", "Rolling heads are always welcome.");
msgs:addMessage("Verboten!", "Verboten!");
msgs:addMessage("Wer wagt es mich zu stören?", "Who dares to bother me?");

end

function M.enemyNear(Monster,Enemy)
    local MonID=Monster:get_mon_type();

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    if (MonID==3) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,7,{1000,2000},{{4,5},{9,5},{51,5}},{},40,1,{35,50}) );
    elseif (MonID==4) then
        return ( drop.CastMonster(Monster,Enemy,10,{101,111},40) == true );
    elseif (MonID==5) then
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
    drop.Dropping(Monster);
end

return M
