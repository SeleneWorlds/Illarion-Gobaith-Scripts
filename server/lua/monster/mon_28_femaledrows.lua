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
msgs:addMessage("#me fährt langsam mit ihrer Zunge über ihre Oberlippe.", "#me slowly runs her tongue along her upper lip.");
msgs:addMessage("#me hebt ihre Waffe und küsst sie dann sanft.", "#me raises her weapon and places a gentle kiss upon it.");
msgs:addMessage("#me lacht hysterisch.", "#me laughs hysterically.");
msgs:addMessage("#me schließt ihre Augen und beginnt wie wahnsinnig zu lachen.", "#me closes her eyes and begins to laugh maniacally.");
msgs:addMessage("#me tanzt wild, wie im Rausch, umher, vom krampfhaften Zucken ihres Körpers untermalt.", "#me dances around in a wild frenzy, her body violently pulsating.");
msgs:addMessage("#me wirft ihren Kopf zurück und schreit in Ekstase.", "#me throws her head back and screams in ecstasy.");
msgs:addMessage("#mes Augen rollen nach hinten in ihren Schädel, bis nur noch das Weiße sichtbar bleibt.", "#me's eyes rolls her eyes back, only the whites now visible.");
msgs:addMessage("Ah... ein weiteres Spielzeug für den Blutgott.", "Ah… another toy for the Blood-God.");
msgs:addMessage("Also du suchst nach dem Tod? Ich werde dir deinen Wunsch erfüllen... letzten Endes.", "So it is death you seek? I shall grant your wish... eventually.");
msgs:addMessage("Dein Blut wird meinen Durst stillen.", "Your blood shall quench my thirst.");
msgs:addMessage("Du bist nichts als Fleisch und Knochen, eine Opfergabe für den Blutgott.", "You are but flesh and bone, an offering to the Blood-God.");
msgs:addMessage("Du kennst keine Schmerzen... noch nicht.", "You have not known pain...not yet.");
msgs:addMessage("Ein langsamer Tod ist ein schöner Tod.", "A slow death is a beautiful one.");
msgs:addMessage("Mich hungert nach deinen Schreien.", "I hunger for your scream.");
msgs:addMessage("Moshran! Erfreue dich an unseren Opfern!", "Moshran! Feast upon our victims!");
msgs:addMessage("Schmerzen? Dies ist nichts... dich erwartet eine Ewigkeit in den Händen Moshrans!", "Pain? This is nothing...an eternity at the hands of Moshran awaits you.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==283) then
        return ( drop.CastMonMagic(Monster,Enemy,3,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
    elseif (MonID==284) then
        return ( drop.CastMonster(Monster,Enemy,8,{101,111},40) == true );
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
    elseif (MonID==283) then
        return ( drop.CastMonMagic(Monster,Enemy,3,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
    elseif (MonID==284) then
        return ( drop.CastMonster(Monster,Enemy,8,{101,111},40) == true );
    else
        return true;
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
