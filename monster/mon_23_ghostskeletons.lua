local common = require("base.common")
local drop = require("monster.base.drop")
require("monster.base.lookat")
require("base.messages");
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base.messages.Messages();
msgs:addMessage("#me gackert b�sartig.", "#me cackles softly.");
msgs:addMessage("#me haucht die Worte: 'Ihr werdet sterrrrrrben.'", "#me wheezes the words: 'You will dieee.'");
msgs:addMessage("#me h�pft auf und ab w�hrend er schwebt.", "#me bobs up and down as it floats.");
msgs:addMessage("#me keucht erz�rnt.", "#me wheezes angrily.");
msgs:addMessage("#me �ffnet weit seinen Mund als wolle er etwas essen, heraus kommt jedoch nur ein knarrender Ton.", "#me opens its mouth wide as if to eat, but only a creaking sound follows.");
msgs:addMessage("#me st��t einen hohen und lautet Ton aus.", "#me releases a piercing and haunting shriek.");
msgs:addMessage("#me verstr�mt eine t�dliche k�lte.", "#me emanates a deathly chill.");
msgs:addMessage("#me zischt etwas unverst�ndliches.", "#me hisses words incomprehensibly.");
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
    "#me blickt "..enemy.name.." mit einem b�sen Blick an.",
    "#me gives "..enemy.name.." an evil look." );

    common.InformNLS( enemy,
    "Der Blick es Skelettes f�hrt dir ins Mark und l�hmt kurz deine Glieder.",
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

    drop.ClearDropping();
    local MonID=Monster:get_mon_type();
    if (MonID==231) then --Shadow Skeleton, Level: 4, Armourtype: -, Weapontype: puncture (wrestling)

        --Category 1: Armor

        local done=drop.AddDropItem(255,1,20,(100*math.random(3,4)+math.random(33,44)),0,1); --raw ruby
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw topaz
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(256,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw emerald

        --Category 2: Special loot

        local done=drop.AddDropItem(46,1,20,(100*math.random(3,4)+math.random(33,44)),0,2); --ruby
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(3,4)+math.random(33,44)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --topaz
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --emerald

        --Category 3: Weapon

        local done=drop.AddDropItem(189,1,20,(100*math.random(3,4)+math.random(33,44)),0,3); --dagger
        if not done then done=drop.AddDropItem(27,1,10,(100*math.random(3,4)+math.random(33,44)),0,3); end --simple dagger
        if not done then done=drop.AddDropItem(398,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --coppered dagger
        if not done then done=drop.AddDropItem(389,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --silvered dagger
        if not done then done=drop.AddDropItem(2671,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --magic dagger

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(3,9),100,333,0,4); --copper coins


    elseif (MonID==232) then --Poltergeist, Level: 4, Armourtype: -, Weapontype: concussion (wrestling)

        --Category 1: Armor

        local done=drop.AddDropItem(251,1,20,(100*math.random(3,4)+math.random(33,44)),0,1); --raw amethyst
        if not done then done=drop.AddDropItem(256,1,10,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw emerald
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw diamond
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw topaz

        --Category 2: Special loot

        local done=drop.AddDropItem(197,1,20,(100*math.random(3,4)+math.random(33,44)),0,2); --amethyst
        if not done then done=drop.AddDropItem(45,1,10,(100*math.random(3,4)+math.random(33,44)),0,2); end --emerald
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --ruby
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --diamond
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --topaz

        --Category 3: Weapon

        local done=drop.AddDropItem(2664,1,20,(100*math.random(3,4)+math.random(33,44)),0,3); --club
        if not done then done=drop.AddDropItem(231,1,10,(100*math.random(3,4)+math.random(33,44)),0,3); end --mace
        if not done then done=drop.AddDropItem(231,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --morning star
        if not done then done=drop.AddDropItem(2737,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --morning star
        if not done then done=drop.AddDropItem(226,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --warhammer

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(3,9),100,333,0,4); --copper coins


    elseif (MonID==233) then --Shadow Skeleton Mage, Level: 4, Armourtype: -, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(256,1,20,(100*math.random(3,4)+math.random(33,44)),0,1); --raw emerald
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw topaz
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw diamond

        --Category 2: Special loot

        local done=drop.AddDropItem(45,1,20,(100*math.random(3,4)+math.random(33,44)),0,2); --emerald
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(3,4)+math.random(33,44)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --topaz
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --diamond

        --Category 3: Weapon

        local done=drop.AddDropItem(57,1,20,(100*math.random(3,4)+math.random(33,44)),0,3); --simple mage's staff
        if not done then done=drop.AddDropItem(76,1,10,(100*math.random(3,4)+math.random(33,44)),0,3); end --mage's staff
        if not done then done=drop.AddDropItem(208,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --ornate mage's staff
        if not done then done=drop.AddDropItem(2664,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --club
        if not done then done=drop.AddDropItem(39,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --skull staff

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(3,9),100,333,0,4); --copper coins


    elseif (MonID==234) then --Shadow Skeleton Warrior, Level: 5, Armourtype: -, Weapontype: slashing

        --Category 1: Armor

        local done=drop.AddDropItem(254,1,20,(100*math.random(4,5)+math.random(44,55)),0,1); --raw diamond
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(4,5)+math.random(44,55)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --raw bluestone

        --Category 2: Special loot

        local done=drop.AddDropItem(285,1,20,(100*math.random(4,5)+math.random(44,55)),0,2); --diamond
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(4,5)+math.random(44,55)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --ruby
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(2701,1,20,(100*math.random(4,5)+math.random(44,55)),0,3); --longsword
        if not done then done=drop.AddDropItem(78,1,10,(100*math.random(4,5)+math.random(44,55)),0,3); end --short sword
        if not done then done=drop.AddDropItem(2660,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --dwarven axe
        if not done then done=drop.AddDropItem(2788,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --snake sword
        if not done then done=drop.AddDropItem(1,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --serinjah sword

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(6,18),100,333,0,4); --copper coins


    elseif (MonID==235) then --Evil Shadow Skeleton, Level: 4, Armourtype: -, Weapontype: puncture (wrestling)

        --Category 1: Armor

        local done=drop.AddDropItem(257,1,20,(100*math.random(3,4)+math.random(33,44)),0,1); --raw topaz
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --raw ruby

        --Category 2: Special loot

        local done=drop.AddDropItem(198,1,20,(100*math.random(3,4)+math.random(33,44)),0,2); --topaz
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(3,4)+math.random(33,44)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(190,1,20,(100*math.random(3,4)+math.random(33,44)),0,3); --ornate dagger
        if not done then done=drop.AddDropItem(2740,1,10,(100*math.random(3,4)+math.random(33,44)),0,3); end --red dagger
        if not done then done=drop.AddDropItem(297,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --golden dagger
        if not done then done=drop.AddDropItem(444,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --merinium plated dagger
        if not done then done=drop.AddDropItem(2742,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --fire dagger

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(3,9),100,333,0,4); --copper coins

    elseif (MonID==236) then
        -- Drops
    elseif (MonID==237) then
        --Drops
    elseif (MonID==238) then
        --Drops
    elseif (MonID==239) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
