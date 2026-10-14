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
msgs:addMessage("#me fährt mit einer Hand durch sein Haar, ein grausames Grinsen liegt auf seinem Gesicht.", "#me runs a hand through his hair, a cruel smirk covering his face.");
msgs:addMessage("#me fasst seine Waffe fester.", "#me tightly grips his weapon.");
msgs:addMessage("#me schließt seine Augen und beginnt wie wahnsinnig zu lachen.", "#me closes his eyes and begins to laugh maniacally.");
msgs:addMessage("#mes Mund ist an den Mundwinkeln zu einem verdrehten Lächeln verzogen.", "#me's mouth curles up into a twisted smile.");
msgs:addMessage("#mes verengte Augen starren geradeaus.", "#me's narrow eyes stare straight ahead.");
msgs:addMessage("Brüder! Lasst uns Jagd auf die Schwachen machen.", "Brothers! Let us prey upon the weak.");
msgs:addMessage("Dein Unbehagen amüsiert mich.", "Your discomfort amuses me.");
msgs:addMessage("Deine Schmerzen sind meine Freude.", "Your pain; my pleasure.");
msgs:addMessage("Deine Schreie werden wie Musik in meinen Ohren klingen.", "Your screams shall be music to my ears.");
msgs:addMessage("Der Blutgott soll heute nacht nicht hungrig bleiben.", "The Blood-God shall not hunger on this night.");
msgs:addMessage("Du hast jahrelang darauf gewartet vom Tod begrüßt zu werden... was machen da ein paar Stunden mehr?", "You have waited years for death to greet you... what is a few more hours?");
msgs:addMessage("Geduld, Sterblicher... Geduld. Du wirst früh genug mit der Gegenwart des Blutgottes gesegnet werden.", "Patience, mortal… patience. You shall be blessed with the Blood-God's company soon enough.");
msgs:addMessage("Ich finde dein Leiden... unterhaltsam.", "I find your suffering... enchanting.");
msgs:addMessage("Langsam und schmerzhaft, so wird dein Tod sein.", "Slow and painful, so your death shall be.");
msgs:addMessage("Moshran! Empfange diesen Sterblichen!", "Moshran! Receive this mortal!");
msgs:addMessage("Schreist du etwa? Das solltest du.", "Do you scream? You shall.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==273) then
        return ( drop.CastMonMagic(Monster,Enemy,3,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
    elseif (MonID==274) then
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
    elseif (MonID==273) then
        return ( drop.CastMonMagic(Monster,Enemy,3,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
    elseif (MonID==274) then
        return ( drop.CastMonster(Monster,Enemy,8,{101,111},40) == true );
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
