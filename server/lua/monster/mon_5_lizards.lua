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
msgs:addMessage("#me sch�ttelt einige Schuppen von seinem R�cken.", "#me loses some scales off his back.");
msgs:addMessage("#me zischt etwas unverst�ndliches.", "#me hisses something unintelligible.");
msgs:addMessage("#mes Schwanz bewegt sich scheinbar unkontrolliert hin und her.", "#me's tail moves rapidly in a back and forth motion");
msgs:addMessage("Ich rieche �rger...", "I smell trouble...");
msgs:addMessage("Sssssssss...", "Sssssssss...");
msgs:addMessage("Unssere Feinde sollen die Macht des Wassssssers zu sp�ren bekommen!", "Our enemiessss ssshould feel the power of water!");
msgs:addMessage("Unssere Rassssse wird �berleben!", "Our race will sssssurvive!");
msgs:addMessage("Zshhel-pheey-arrr sssteht mir bei!", "Zshhel-pheey-arrr sssstands by me!");
msgs:addMessage("#me fl�stert leise: 'Grossse Mutter, bereite mir ein Bad in deinem Tempel, ich werde bald zu dir stossssen!'.", "#me whispers: 'Great mother, prepare a bath for me in your templesss. I will sssoon come to yousss.'.");
msgs:addMessage("#me schl�gt mit dem Schwanz drohend auf den Boden und zeigt seine spitzen Z�hne, die gelben Augen sind zu schmalen Schlitzen verzogen.", "#me slams his tail on the ground and bares his sharp teeth. The yellow eyes are squinted to slits.");

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

    drop.ClearDropping();
    local MonID=Monster:get_mon_type();
   if (MonID==51) then --Lizard, Level: 5, Armourtype: medium, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(2193,1,20,(100*math.random(4,5)+math.random(44,55)),0,1); --hardwood greaves
        if not done then done=drop.AddDropItem(2448,1,10,(100*math.random(4,5)+math.random(44,55)),0,1); end --legionaire's tower shield
        if not done then done=drop.AddDropItem(696,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --lizard armor
        if not done then done=drop.AddDropItem(2360,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --Lor-Angur guardian's armor
        if not done then done=drop.AddDropItem(101,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --chain shirt

        --Category 2: Special loot

        local done=drop.AddDropItem(355,1,20,(100*math.random(4,5)+math.random(44,55)),0,2); --salmon
        if not done then done=drop.AddDropItem(73,1,10,(100*math.random(4,5)+math.random(44,55)),0,2); end --trout
        if not done then done=drop.AddDropItem(556,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --salmon dish
        if not done then done=drop.AddDropItem(2459,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --fish filet dish
        if not done then done=drop.AddDropItem(72,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --fishing rod

        --Category 3: Weapon

        local done=drop.AddDropItem(231,1,20,(100*math.random(4,5)+math.random(44,55)),0,3); --mace
        if not done then done=drop.AddDropItem(2664,1,10,(100*math.random(4,5)+math.random(44,55)),0,3); end --club
        if not done then done=drop.AddDropItem(231,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --morning star
        if not done then done=drop.AddDropItem(2737,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --morning star
        if not done then done=drop.AddDropItem(226,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --warhammer

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(6,18),100,333,0,4); --copper coins


    elseif (MonID==52) then --Lizard Temple Warrior, Level: 6, Armourtype: heavy, Weapontype: slashing

        --Category 1: Armor

        local done=drop.AddDropItem(2117,1,20,(100*math.random(5,6)+math.random(55,66)),0,1); --short red steel greaves
        if not done then done=drop.AddDropItem(94,1,10,(100*math.random(5,6)+math.random(55,66)),0,1); end --pot helmet
        if not done then done=drop.AddDropItem(2364,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --albarian steel plate
        if not done then done=drop.AddDropItem(2364,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --steel plate
        if not done then done=drop.AddDropItem(2393,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --heavy plate armor

        --Category 2: Special loot

        local done=drop.AddDropItem(51,1,20,(100*math.random(5,6)+math.random(55,66)),0,2); --bucket
        if not done then done=drop.AddDropItem(92,1,10,(100*math.random(5,6)+math.random(55,66)),0,2); end --oil lamp
        if not done then done=drop.AddDropItem(390,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --lamp oil
        if not done then done=drop.AddDropItem(355,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --salmon
        if not done then done=drop.AddDropItem(73,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --trout

        --Category 3: Weapon

        local done=drop.AddDropItem(88,1,20,(100*math.random(5,6)+math.random(55,66)),0,3); --long axe
        if not done then done=drop.AddDropItem(77,1,10,(100*math.random(5,6)+math.random(55,66)),0,3); end --halberd
        if not done then done=drop.AddDropItem(204,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --bastard sword
        if not done then done=drop.AddDropItem(2731,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --two handed sword
        if not done then done=drop.AddDropItem(383,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --waraxe

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(18,54),100,333,0,4); --copper coins


    elseif (MonID==53) then --Lizard Mage, Level: 5, Armourtype: cloth, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(831,1,20,(100*math.random(4,5)+math.random(44,55)),0,1); --green hat with feather
        if not done then done=drop.AddDropItem(181,1,10,(100*math.random(4,5)+math.random(44,55)),0,1); end --blue shirt
        if not done then done=drop.AddDropItem(195,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --yellow robe
        if not done then done=drop.AddDropItem(2377,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --red mage robe
        if not done then done=drop.AddDropItem(821,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --blue trousers

        --Category 2: Special loot

        local done=drop.AddDropItem(2745,1,20,(100*math.random(4,5)+math.random(44,55)),0,2); --parchment
        if not done then done=drop.AddDropItem(463,1,10,(100*math.random(4,5)+math.random(44,55)),0,2); end --quill
        if not done then done=drop.AddDropItem(72,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --fishing rod
        if not done then done=drop.AddDropItem(355,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --salmon
        if not done then done=drop.AddDropItem(73,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --trout

        --Category 3: Weapon

        local done=drop.AddDropItem(57,1,20,(100*math.random(4,5)+math.random(44,55)),0,3); --simple mage's staff
        if not done then done=drop.AddDropItem(76,1,10,(100*math.random(4,5)+math.random(44,55)),0,3); end --mage's staff
        if not done then done=drop.AddDropItem(208,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --ornate mage's staff
        if not done then done=drop.AddDropItem(2664,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --club
        if not done then done=drop.AddDropItem(39,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --skull staff

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(6,18),100,333,0,4); --copper coins


    elseif (MonID==54) then --Lizard Priest, Level: 5, Armourtype: cloth, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(809,1,20,(100*math.random(4,5)+math.random(44,55)),0,1); --grey doublet
        if not done then done=drop.AddDropItem(182,1,10,(100*math.random(4,5)+math.random(44,55)),0,1); end --black shirt
        if not done then done=drop.AddDropItem(368,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --yellow priest robe
        if not done then done=drop.AddDropItem(824,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --green trousers
        if not done then done=drop.AddDropItem(2418,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --grey priest robe

        --Category 2: Special loot

        local done=drop.AddDropItem(71,1,20,(100*math.random(4,5)+math.random(44,55)),0,2); --bluestone amulet
        if not done then done=drop.AddDropItem(43,1,10,(100*math.random(4,5)+math.random(44,55)),0,2); end --candles
        if not done then done=drop.AddDropItem(556,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --salmon dish
        if not done then done=drop.AddDropItem(2459,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --fish filet dish
        if not done then done=drop.AddDropItem(51,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --bucket

        --Category 3: Weapon

        local done=drop.AddDropItem(40,1,20,(100*math.random(4,5)+math.random(44,55)),0,3); --cleric's staff
        if not done then done=drop.AddDropItem(230,1,10,(100*math.random(4,5)+math.random(44,55)),0,3); end --mace
        if not done then done=drop.AddDropItem(2664,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --club
        if not done then done=drop.AddDropItem(226,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --warhammer
        if not done then done=drop.AddDropItem(231,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --morning star

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(6,18),100,333,0,4); --copper coins


    elseif (MonID==55) then --Lizard Thief, Level: 4, Armourtype: light, Weapontype: puncture

        --Category 1: Armor

        local done=drop.AddDropItem(53,1,20,(100*math.random(3,4)+math.random(33,44)),0,1); --leather boots
        if not done then done=drop.AddDropItem(366,1,10,(100*math.random(3,4)+math.random(33,44)),0,1); end --leather legs
        if not done then done=drop.AddDropItem(365,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --half leather armor
        if not done then done=drop.AddDropItem(364,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --light hunting armor
        if not done then done=drop.AddDropItem(362,1,1,(100*math.random(3,4)+math.random(33,44)),0,1); end --full leatherarmor

        --Category 2: Special loot

        local done=drop.AddDropItem(284,1,20,(100*math.random(3,4)+math.random(33,44)),0,2); --bluestone
        if not done then done=drop.AddDropItem(71,1,10,(100*math.random(3,4)+math.random(33,44)),0,2); end --bluestone amulet
        if not done then done=drop.AddDropItem(279,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --bluestone ring
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --raw bluestone
        if not done then done=drop.AddDropItem(1858,1,1,(100*math.random(3,4)+math.random(33,44)),0,2); end --goblet

        --Category 3: Weapon

        local done=drop.AddDropItem(27,1,20,(100*math.random(3,4)+math.random(33,44)),0,3); --simple dagger
        if not done then done=drop.AddDropItem(189,1,10,(100*math.random(3,4)+math.random(33,44)),0,3); end --dagger
        if not done then done=drop.AddDropItem(2740,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --red dagger
        if not done then done=drop.AddDropItem(190,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --ornate dagger
        if not done then done=drop.AddDropItem(444,1,1,(100*math.random(3,4)+math.random(33,44)),0,3); end --merinium plated dagger

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(3,9),100,333,0,4); --copper coins

        if not FirstThief then
            drop.AddDropItem(61,StealAmmG[Monster.id],100,333,0,5);
            StealAmmG[Monster.id]=nil;
            drop.AddDropItem(3077,StealAmmS[Monster.id],100,333,0,6);
            StealAmmS[Monster.id]=nil;
            drop.AddDropItem(3076,StealAmmK[Monster.id],100,333,0,7);
            StealAmmK[Monster.id]=nil;
        end
    elseif (MonID==56) then
        -- Drops
    elseif (MonID==57) then
        --Drops
    elseif (MonID==58) then
        --Drops
    elseif (MonID==59) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
