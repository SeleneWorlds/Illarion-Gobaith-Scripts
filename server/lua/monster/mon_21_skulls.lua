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
msgs:addMessage("#mes Augenhöhlen flammen mit einem Male vor blauen Flammen auf, die sich schnell über den ganzen Schädel ausbreiten. Sie strahlen eine unheimliche Kälte aus.", "#me's eye sockets suddenly glare up with blue flames which spread quickly across the entire skull. They exude an eerie coldness.");
msgs:addMessage("#mes Unterkiefer klappt runter und eine kurze Stichflamme schiesst zwischen den gefährlich spitzen Zähnen hervor.", "#me's jaw drops and and a short tongue of flames shoots out from between the dangerously sharp teeth.");
msgs:addMessage("#me öffnet sein gewaltiges Maul und ein fürchterliches Lachen schallt aus den Untiefen des Schädels empor.", "#me opens its huge mouth and a terrible laughter echoes from the depths of the skull.");
msgs:addMessage("Ah, sie köpften mich, doch die wahrlich klugen Köpfe sind nicht unterzubringen…hahahaha!", "Ah, they beheaded me, but wisest heads are invincible... hahahaha!");
msgs:addMessage("Achtung, Sterblicher… niemals kopflos handeln.", "Remember, mortal... never lose your head.");
msgs:addMessage("Ihr wagt es, vor mein Antlitz zu treten… ihr bewahrt fürwahr einen kühlen Kopf.", "You dare to face my face... you really need to keep a cool head.");
msgs:addMessage("#me knackt mit dem Kiefer.", "#me clacks its jaw.");
msgs:addMessage("#me singt Unverständliches.", "#me chants unintelligibly.");
msgs:addMessage("#me klappert mit den Zähnen.", "#me rattles its teeth.");
msgs:addMessage("#me stöhnt vor sich hin.", "#me moans to itself.");
msgs:addMessage("#mes Augen, der Fähigkeit zu blinzeln beraubt, sind von einer klebrigen Flüssigkeit erfüllt.", "#me's eyes drip with liquid, unable to blink.");
msgs:addMessage("#me starrt düster drein.", "#me stares forward sadly.");
msgs:addMessage("#mes Augen sind erfüllt von Leid und Boshaftigkeit.", "#me's eyes are filled with suffering and malice.");
msgs:addMessage("#me zischt: 'Lasst mich alleine…'", "#me hisses: 'Leave me…'");
msgs:addMessage("Toood!", "Deaaath...");
msgs:addMessage("Er verbleibt - nichts.", "Nothing... left...");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==214) then
        return ( drop.CastMonMagic(Monster,Enemy,10,{300,500},{{9,5}},{},40,9,{0,40}) == true );
    elseif (MonID==215) then
        return ( drop.CastMonMagic(Monster,Enemy,6,{800,1500},{{9,5}},{},40,9,{20,60}) == true );
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
    elseif (MonID==214) then
        return ( drop.CastMonMagic(Monster,Enemy,7,{300,500},{{9,5}},{},40,9,{0,40}) == true );
    elseif (MonID==215) then
        return ( drop.CastMonMagic(Monster,Enemy,4,{800,1900},{{9,5}},{},40,9,{20,60}) == true );
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
