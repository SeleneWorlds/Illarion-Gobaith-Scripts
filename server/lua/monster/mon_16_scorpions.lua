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
msgs:addMessage("#me klappert drohend mit den Scheren.", "#me clatters angrily with its claws.");
msgs:addMessage("#me sieht sich mit tief schwarzen Augen um.", "#me looks around with deep black eyes.");
msgs:addMessage("#me tänzelt erregt vor und zurück, der Stachel zittert in der Luft und etwas Gift tropft schon zu Boden, so angriffslustig scheint das Tier zu sein", "#me prances excitedly back and forth, shaking its sting in the air and some venom drips to the ground. The animal seems to be aggressive.");
msgs:addMessage("#me sticht wütend mehrfach in die Luft, um dann flink auf die Füße des Feindes zuzukrabbeln", "#me stings the air angrily, then crawls nimbly towards the feet of the enemy.");
msgs:addMessage("#me ist ein pechschwarzes Ungetüm, ein Räuber der Wüste.", "#me is a pitch black beast, a predator of the desert.");
msgs:addMessage("#mes gefühlslosen Augen machen es schwer zu glaube, dass dieses Wesen etwas anderes als Mordlust verspürt.", "#me's lifeless eyes make it hard to believe that this beast is driven by something else but bloodlust.");
msgs:addMessage("#me läßt seine Scheren blitzschnell zuschnappen, ein klickendes Geräusch zeugt von der Gefährlichkeit dieser Mordinstrumente.", "#me closes its claws rapidly, a clicking noise introduces the danger of the killing tools.");
msgs:addMessage("#me schießt mit so ungeheurer Geschwindigkeit vor, dass die Bewegungen zu verschwimmen scheinen.", "#me darts forward with such great a speed that the movement becomes indistinct.");
msgs:addMessage("#mes Scheren zucken wild vor und zurück.", "#me's claws twitch back and forth swiftly.");
msgs:addMessage("#me kriecht mit acht feingeliederten Beinen über den Boden.", "#me crawls on the ground with eight segmented legs.");

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

--No drops

    drop.Dropping(Monster);
end

return M
