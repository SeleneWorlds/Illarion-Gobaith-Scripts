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
msgs:addMessage("#me bleckt die von Fleischstückchen bedeckten Zähne.", "#me bares his teeth, which are piled with chunks of flesh.");
msgs:addMessage("#me brüllt etwas in einer unverständlichen Sprache.", "#me growls something in an inscrutable tongue.");
msgs:addMessage("#me gibt ein Geräusch von sich, das einem Grunzen ähnelt.", "#me makes a noise similar to a grunt.");
msgs:addMessage("#me murmelt ein Gebet.", "#me murmurs a prayer.");
msgs:addMessage("#me neigt bedrohlich den Kopf und damit die spitzen Hörner.", "#me lowers the head, his horns look threatening.");
msgs:addMessage("#me schwingt seine Keule.", "#me swings his club.");
msgs:addMessage("#me zieht die Nase hoch.", "#me sniffs deeply.");
msgs:addMessage("#me’s Knochenschmuck klappert laut als er baumelt.", "#me’s bone jewellery dangles and clatters loudly.");
msgs:addMessage("#me bleckt die von Fleischstückchen bedeckten Zähne und kauderwelscht glücklich: 'Mmh… saftich süßes Ding.'.", "#me bares its teeth, covered with pieces of meat: 'Mmm... tasty sweet thing.'.");
msgs:addMessage("#me brüllt etwas in einer unverständlichen Sprache.", "#me yells something in an incomprehensible language.");
msgs:addMessage("#me schlägt mit der Keule auf den Boden, dass der Grund unter den Füßen bebt: 'Niemand so stark wie ich, werde dich jetzt zermalmen und dann deine Knochen abnagen!'", "#me strikes the ground with his mace, shaking the growl: 'No one so strong as I, I will crush you now and then gnaw your bones!'");
msgs:addMessage("#me malt mit einem schlammigen Finger ein krummes Dreieck auf seine Brust: 'Niemand fordert mich, ich wird deine Eingeweide dir ausreißen!'", "#me paints a muddy pattern with crooked fingers on its chest: 'Nobody challenges me, me will rip out your entrails!'");
msgs:addMessage("#me schnauft und kleine grüne Flocken stieben aus seiner Nase, ehe er seine Keule mit einem Röhren erhebt.", "#me snorts and little green flakes scurry out of his nose, before it raises its club with a growl.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==243) then
        return ( drop.CastMonMagic(Monster,Enemy,10,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
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
    elseif (MonID==243) then
        return ( drop.CastMonMagic(Monster,Enemy,10,{2000,3000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1) == true );
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
