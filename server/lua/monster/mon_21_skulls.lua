local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#mes Augenh�hlen flammen mit einem Male vor blauen Flammen auf, die sich schnell �ber den ganzen Sch�del ausbreiten. Sie strahlen eine unheimliche K�lte aus.", "#me's eye sockets suddenly glare up with blue flames which spread quickly across the entire skull. They exude an eerie coldness.");
msgs:addMessage("#mes Unterkiefer klappt runter und eine kurze Stichflamme schiesst zwischen den gef�hrlich spitzen Z�hnen hervor.", "#me's jaw drops and and a short tongue of flames shoots out from between the dangerously sharp teeth.");
msgs:addMessage("#me �ffnet sein gewaltiges Maul und ein f�rchterliches Lachen schallt aus den Untiefen des Sch�dels empor.", "#me opens its huge mouth and a terrible laughter echoes from the depths of the skull.");
msgs:addMessage("Ah, sie k�pften mich, doch die wahrlich klugen K�pfe sind nicht unterzubringen�hahahaha!", "Ah, they beheaded me, but wisest heads are invincible... hahahaha!");
msgs:addMessage("Achtung, Sterblicher� niemals kopflos handeln.", "Remember, mortal... never lose your head.");
msgs:addMessage("Ihr wagt es, vor mein Antlitz zu treten� ihr bewahrt f�rwahr einen k�hlen Kopf.", "You dare to face my face... you really need to keep a cool head.");
msgs:addMessage("#me knackt mit dem Kiefer.", "#me clacks its jaw.");
msgs:addMessage("#me singt Unverst�ndliches.", "#me chants unintelligibly.");
msgs:addMessage("#me klappert mit den Z�hnen.", "#me rattles its teeth.");
msgs:addMessage("#me st�hnt vor sich hin.", "#me moans to itself.");
msgs:addMessage("#mes Augen, der F�higkeit zu blinzeln beraubt, sind von einer klebrigen Fl�ssigkeit erf�llt.", "#me's eyes drip with liquid, unable to blink.");
msgs:addMessage("#me starrt d�ster drein.", "#me stares forward sadly.");
msgs:addMessage("#mes Augen sind erf�llt von Leid und Boshaftigkeit.", "#me's eyes are filled with suffering and malice.");
msgs:addMessage("#me zischt: 'Lasst mich alleine�'", "#me hisses: 'Leave me�'");
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

    drop.ClearDropping();
    local MonID=Monster:get_mon_type();
    if (MonID==211) then --Skull, Level: 2, Armourtype: medium, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(324,1,20,(100*math.random(1,2)+math.random(11,22)),0,1); --chain helmet
        if not done then done=drop.AddDropItem(2302,1,10,(100*math.random(1,2)+math.random(11,22)),0,1); end --gynkese mercenarie's helmet
        if not done then done=drop.AddDropItem(7,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --horned helmet
        if not done then done=drop.AddDropItem(2290,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --round steel hat
        if not done then done=drop.AddDropItem(202,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --steel cap

        --Category 2: Special loot

        local done=drop.AddDropItem(255,1,20,(100*math.random(1,2)+math.random(11,22)),0,2); --raw ruby
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw topaz
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw blackstone
        if not done then done=drop.AddDropItem(256,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw emerald

        --Category 3: Weapon

        local done=drop.AddDropItem(46,1,20,(100*math.random(1,2)+math.random(11,22)),0,3); --ruby
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(1,2)+math.random(11,22)),0,3); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --topaz
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --blackstone
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --emerald

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(1,3),100,333,0,4); --copper coins


    elseif (MonID==212) then --Evil Skull, Level: 2, Armourtype: light, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(356,1,20,(100*math.random(1,2)+math.random(11,22)),0,1); --slouch hat
        if not done then done=drop.AddDropItem(7,1,10,(100*math.random(1,2)+math.random(11,22)),0,1); end --horned helmet
        if not done then done=drop.AddDropItem(324,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --chain helmet
        if not done then done=drop.AddDropItem(2290,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --round steel hat
        if not done then done=drop.AddDropItem(2302,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --gynkese mercenarie's helmet

        --Category 2: Special loot

        local done=drop.AddDropItem(251,1,20,(100*math.random(1,2)+math.random(11,22)),0,2); --raw amethyst
        if not done then done=drop.AddDropItem(256,1,10,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw emerald
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw ruby
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw diamond
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw topaz

        --Category 3: Weapon

        local done=drop.AddDropItem(197,1,20,(100*math.random(1,2)+math.random(11,22)),0,3); --amethyst
        if not done then done=drop.AddDropItem(45,1,10,(100*math.random(1,2)+math.random(11,22)),0,3); end --emerald
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --ruby
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --diamond
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --topaz

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(1,3),100,333,0,4); --copper coins


    elseif (MonID==213) then --Skull Ram, Level: 2, Armourtype: heavy, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(2290,1,20,(100*math.random(1,2)+math.random(11,22)),0,1); --round steel hat
        if not done then done=drop.AddDropItem(202,1,10,(100*math.random(1,2)+math.random(11,22)),0,1); end --steel cap
        if not done then done=drop.AddDropItem(324,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --chain helmet
        if not done then done=drop.AddDropItem(7,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --horned helmet
        if not done then done=drop.AddDropItem(2302,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --gynkese mercenarie's helmet

        --Category 2: Special loot

        local done=drop.AddDropItem(256,1,20,(100*math.random(1,2)+math.random(11,22)),0,2); --raw emerald
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw blackstone
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw topaz
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw diamond

        --Category 3: Weapon

        local done=drop.AddDropItem(45,1,20,(100*math.random(1,2)+math.random(11,22)),0,3); --emerald
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(1,2)+math.random(11,22)),0,3); end --blackstone
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --topaz
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --diamond

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(1,3),100,333,0,4); --copper coins


    elseif (MonID==214) then --Skull Mage, Level: 2, Armourtype: cloth, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(357,1,20,(100*math.random(1,2)+math.random(11,22)),0,1); --blue wizard hat
        if not done then done=drop.AddDropItem(358,1,10,(100*math.random(1,2)+math.random(11,22)),0,1); end --red wizard hat
        if not done then done=drop.AddDropItem(7,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --horned helmet
        if not done then done=drop.AddDropItem(356,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --slouch hat
        if not done then done=drop.AddDropItem(324,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --chain helmet

        --Category 2: Special loot

        local done=drop.AddDropItem(257,1,20,(100*math.random(1,2)+math.random(11,22)),0,2); --raw topaz
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw bluestone
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw amethyst
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(198,1,20,(100*math.random(1,2)+math.random(11,22)),0,3); --topaz
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(1,2)+math.random(11,22)),0,3); end --bluestone
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --amethyst
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --ruby

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(1,3),100,333,0,4); --copper coins


    elseif (MonID==215) then --Fire Spitting Skull, Level: 3, Armourtype: heavy, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(187,1,20,(100*math.random(2,3)+math.random(22,33)),0,1); --steel hat
        if not done then done=drop.AddDropItem(2290,1,10,(100*math.random(2,3)+math.random(22,33)),0,1); end --round steel hat
        if not done then done=drop.AddDropItem(202,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --steel cap
        if not done then done=drop.AddDropItem(324,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --chain helmet
        if not done then done=drop.AddDropItem(7,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --horned helmet

        --Category 2: Special loot

        local done=drop.AddDropItem(254,1,20,(100*math.random(2,3)+math.random(22,33)),0,2); --raw diamond
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw ruby
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw amethyst
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(285,1,20,(100*math.random(2,3)+math.random(22,33)),0,3); --diamond
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(2,3)+math.random(22,33)),0,3); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --ruby
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --amethyst
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --bluestone

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(2,6),100,333,0,4); --copper coins

    elseif (MonID==216) then
        -- Drops
    elseif (MonID==217) then
        --Drops
    elseif (MonID==218) then
        --Drops
    elseif (MonID==219) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
