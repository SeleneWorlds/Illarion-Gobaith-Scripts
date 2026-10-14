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
msgs:addMessage("#me brüllt ohrenbetäubend.", "#me roars deafeningly.");
msgs:addMessage("#me lacht kühn.", "#me laughs audaciously.");
msgs:addMessage("Auf die Knie!", "Kneel before me!");
msgs:addMessage("Das Blut der letzten Sterblichen, die vorbei kamen, ist noch gar nicht richtig getrocket.", "The blood of the last mortals walking by here is not even dry yet.");
msgs:addMessage("Dein Ende ist nah!", "Your end is nigh!");
msgs:addMessage("Dein Fleisch wird ein Festschmaus.", "I will feast on your flesh!");
msgs:addMessage("Du hast keine Chance!", "You don't stand a chance!");
msgs:addMessage("Du hättest nicht herkommen sollen.", "It was foolish to come here.");
msgs:addMessage("Du hättest weglaufen sollen, Sterblicher. Nun ist es zu spät für dich.", "You should be running away, mortal. Now its too late for you.");
msgs:addMessage("Erbärmliche Kreatur!", "Pitiful creature!");
msgs:addMessage("Euch zu töten ist so einfach, gerade zu langweilig. Wieso werft ihr Sterblichen euer Leben so weg?", "Killing you is so simple, it's boring. Why do you mortals throw your lives away like this?");
msgs:addMessage("Flieht, ihr Narren!", "Start running, coward!");
msgs:addMessage("Frischfleisch!", "Fresh meat!");
msgs:addMessage("Heute Nacht speist du an Cherga's Tafel!", "Tonight you dine in Cherga's realm!");
msgs:addMessage("Ihr Sterblichen seid so jämmerlich. Immer wieder versucht ihr euch gegen mich und immer wieder scheitert ihr.", "You mortals are so miserable. Again and again you challenge me and again and again you fail.");
msgs:addMessage("Komm nur Sterblicher, bald werden die Ratten sich an deinem Körper laben. Vielleicht ist dabei sogar noch ein Rest deines Lebensfunken in dir.", "Come, mortal. Soon enough, the rats shall feast upon your flesh, and I will make sure you're still breathing when they start!");
msgs:addMessage("Komm zu mir Sterblicher, ich werde dich in die Dunkelheit führen wo deine Seele ewige Qualen erfahren wird.", "Come to me mortal. I will guide you into the darkness where your soul will suffer for eternity.");
msgs:addMessage("Lass mich dir den Weg zeigen in die Dunkelheit und Kälte.", "Let me show you the way into the darkness and the cold.");
msgs:addMessage("Nieder, kleiner Sterblicher!", "Cower, foolish mortal!");
msgs:addMessage("Sieh dich um, Sterblicher. Dies ist der letzte Ort den deine Augen erblicken werden!", "Look around, mortal. This is the last place you will ever see!");
msgs:addMessage("Spürst du die Kälte, Sterblicher? Spürst du wie das Leben aus dir weicht, jetzt so kurz vor deinem Ende?", "Do you feel the cold, mortal? Do you feel the spark of life vanishing? Soon the end will come.");
msgs:addMessage("Vielleicht solltest du zu deinen Göttern beten. Auch wenn sie dir hier nicht helfen können.", "Maybe you should pray to your gods, though they can't help you anymore.");
msgs:addMessage("Wenn du Dunkelheit und Tod gesucht hast, Sterblicher, dann bist du hier genau richtig.", "If you were looking for darkness and death, mortal, then you are in the right place.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==203) then
        return ( drop.CastMonster(Monster,Enemy,10,{172,173},40) == true );
    else
        return ( drop.CastMonMagic(Monster,Enemy,10,{},{},{{359,222,555,0,7},{360,222,555,0,7},{372,222,555,0,7}},20,1) == true );
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
    elseif (MonID==203) then
        return ( drop.CastMonster(Monster,Enemy,10,{172,173},40) == true );
    else
        return ( drop.CastMonMagic(Monster,Enemy,10,{},{},{{359,222,555,0,7},{360,222,555,0,7},{372,222,555,0,7}},20,1) == true );
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
