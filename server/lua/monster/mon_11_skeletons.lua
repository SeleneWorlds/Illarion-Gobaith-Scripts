local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me fehlt bei genauerer Betrachtung wohl der Unterkiefer.", "#me is missing its lower jaw on closer inspection.");
msgs:addMessage("#me greift nach oben zu seinem eigenen Sch�del und verdreht ihn mit einem lauten, knackenden Ger�usch.", "#me reaches up, grabs it's own skull and twists, making a loud cracking noise.");
msgs:addMessage("#me grinst wie ein Narr.", "#me grins like a fool.");
msgs:addMessage("#me hebt seine Waffe in die H�he und klappert mit den Z�hnen.", "#me raises his weapon and rattles with its tooth.");
msgs:addMessage("#me kichert still, die Schultern schwanken und knacken.", "#me cackles silently, shoulders heaving and creaking.");
msgs:addMessage("#me klappert, die Knochen rasseln.", "#me clatters, bones rattling.");
msgs:addMessage("#me klappt seinen Kiefer zu um b�sartig zu grinsen.", "#me snaps its jaw shut, grinning wickedly.");
msgs:addMessage("#me kriecht qualvoll �ber den Boden..", "#me shuffles painfully across the floor.");
msgs:addMessage("#me macht langsame und m�hsame Schritte... Click...clack...click...clack...", "#me takes slow, tedious steps... Click...clack...click...clack...");
msgs:addMessage("#me schlurft vorw�rts, Gelenke knarren und knacken.", "#me shambles forward, joints clicking and creaking...");
msgs:addMessage("#me schwingt eine uralte Waffe, verrostet und verbeult.", "#me brandishes an ancient weapon, rusted and battered.");
msgs:addMessage("#me schwingt gewaltsam seine verfallene Waffe.", "#me swings its decayed weapon violently.");
msgs:addMessage("#me streckt eine knochige Hand aus.", "#me reaches out a bony hand.");
msgs:addMessage("#me taumelt, beinahe zusammenst�rzend.", "#me staggers, nearly toppling over.");
msgs:addMessage("#mes Kiefer �ffnet sich zu einem lautlosen Schrei.", "#me's jaw swivels in a silent scream...");
msgs:addMessage("#mes Knochen schlagen klappernd und rasselnd aneinander.", "#me's bones clinks clacking and rattling together.");
msgs:addMessage("#mes Kopf h�ngt herab, leere Augenh�hlen starren geradeaus.", "#me's head lolls around, empty eye sockets staring.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==115) then
        return ( drop.CastMonMagic(Monster,Enemy,8,{900,1000},{{4,5},{9,5},{51,5}},{},40,1,{25,65}) == true );
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
    elseif (MonID==115) then
        return ( drop.CastHealing( Monster, 3, {1500,3000}, 8, {16, 13}, 40 ) or drop.CastMonMagic(Monster,Enemy,5,{1000,1700},{{4,5},{9,5},{51,5}},{},40,1,{25,65}));
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

    if (MonID==111) then --Skeleton, Level: 3, Armourtype: medium, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(324,1,20,(100*math.random(2,3)+math.random(22,33)),0,1); --chain helmet
        if not done then done=drop.AddDropItem(2295,1,10,(100*math.random(2,3)+math.random(22,33)),0,1); end --cloth gloves
        if not done then done=drop.AddDropItem(2367,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --albarian noble's armor
        if not done then done=drop.AddDropItem(2445,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --small wooden shield
        if not done then done=drop.AddDropItem(101,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --chain shirt

        --Category 2: Special loot

        local done=drop.AddDropItem(391,1,20,(100*math.random(2,3)+math.random(22,33)),0,2); --torch
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw blackstone
        if not done then done=drop.AddDropItem(2746,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --razor blade
        if not done then done=drop.AddDropItem(223,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --iron goblet
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --blackstone

        --Category 3: Weapon

        local done=drop.AddDropItem(2664,1,20,(100*math.random(2,3)+math.random(22,33)),0,3); --club
        if not done then done=drop.AddDropItem(230,1,10,(100*math.random(2,3)+math.random(22,33)),0,3); end --mace
        if not done then done=drop.AddDropItem(231,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --morning star
        if not done then done=drop.AddDropItem(2737,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --morning star
        if not done then done=drop.AddDropItem(23,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --hammer

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(2,6),100,333,0,4); --copper coins


    elseif (MonID==112) then --Rusted Skeleton, Level: 3, Armourtype: medium, Weapontype: slashing

        --Category 1: Armor

        local done=drop.AddDropItem(2302,1,20,(100*math.random(2,3)+math.random(22,33)),0,1); --gynkese mercenarie's helmet
        if not done then done=drop.AddDropItem(2194,1,10,(100*math.random(2,3)+math.random(22,33)),0,1); end --short hardwood greaves
        if not done then done=drop.AddDropItem(917,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --cursed shield
        if not done then done=drop.AddDropItem(2360,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --Lor-Angur guardian's armor
        if not done then done=drop.AddDropItem(101,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --chain shirt

        --Category 2: Special loot

        local done=drop.AddDropItem(2745,1,20,(100*math.random(2,3)+math.random(22,33)),0,2); --parchment
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw bluestone
        if not done then done=drop.AddDropItem(6,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --scissors
        if not done then done=drop.AddDropItem(224,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --golden goblet
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(2711,1,20,(100*math.random(2,3)+math.random(22,33)),0,3); --barbarian axe
        if not done then done=drop.AddDropItem(2946,1,10,(100*math.random(2,3)+math.random(22,33)),0,3); end --battleaxe
        if not done then done=drop.AddDropItem(2723,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --executioner's axe
        if not done then done=drop.AddDropItem(88,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --long axe
        if not done then done=drop.AddDropItem(2642,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --orc axe

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(2,6),100,333,0,4); --copper coins


    elseif (MonID==113) then --Strong Skeleton, Level: 3, Armourtype: heavy, Weapontype: puncture

        --Category 1: Armor

        local done=drop.AddDropItem(2290,1,20,(100*math.random(2,3)+math.random(22,33)),0,1); --round steel hat
        if not done then done=drop.AddDropItem(2112,1,10,(100*math.random(2,3)+math.random(22,33)),0,1); end --short blue steel greaves
        if not done then done=drop.AddDropItem(2364,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --albarian steel plate
        if not done then done=drop.AddDropItem(2364,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --steel plate
        if not done then done=drop.AddDropItem(4,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --plate armor

        --Category 2: Special loot

        local done=drop.AddDropItem(1317,1,20,(100*math.random(2,3)+math.random(22,33)),0,2); --bottle
        if not done then done=drop.AddDropItem(255,1,10,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw rubies
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw topaz
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --topaz
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(190,1,20,(100*math.random(2,3)+math.random(22,33)),0,3); --ornate dagger
        if not done then done=drop.AddDropItem(27,1,10,(100*math.random(2,3)+math.random(22,33)),0,3); end --simple dagger
        if not done then done=drop.AddDropItem(189,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --dagger
        if not done then done=drop.AddDropItem(398,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --coppered dagger
        if not done then done=drop.AddDropItem(389,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --silvered dagger

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(2,6),100,333,0,4); --copper coins


    elseif (MonID==114) then --Crippled Skeleton, Level: 2, Armourtype: light, Weapontype: slashing

        --Category 1: Armor

        local done=drop.AddDropItem(7,1,20,(100*math.random(1,2)+math.random(11,22)),0,1); --horned helmet
        if not done then done=drop.AddDropItem(2445,1,10,(100*math.random(1,2)+math.random(11,22)),0,1); end --small wooden shield
        if not done then done=drop.AddDropItem(363,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --leather scale armor
        if not done then done=drop.AddDropItem(365,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --half leather armor
        if not done then done=drop.AddDropItem(367,1,1,(100*math.random(1,2)+math.random(11,22)),0,1); end --short leather legs

        --Category 2: Special loot

        local done=drop.AddDropItem(314,1,20,(100*math.random(1,2)+math.random(11,22)),0,2); --pot ash
        if not done then done=drop.AddDropItem(251,1,10,(100*math.random(1,2)+math.random(11,22)),0,2); end --raw amethysts
        if not done then done=drop.AddDropItem(2647,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --curtlery
        if not done then done=drop.AddDropItem(222,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --amulet
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(1,2)+math.random(11,22)),0,2); end --amethyst

        --Category 3: Weapon

        local done=drop.AddDropItem(1,1,20,(100*math.random(1,2)+math.random(11,22)),0,3); --serinjah sword
        if not done then done=drop.AddDropItem(78,1,10,(100*math.random(1,2)+math.random(11,22)),0,3); end --short sword
        if not done then done=drop.AddDropItem(445,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --wooden sword
        if not done then done=drop.AddDropItem(2711,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --barbarian axe
        if not done then done=drop.AddDropItem(25,1,1,(100*math.random(1,2)+math.random(11,22)),0,3); end --sabre

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(1,3),100,333,0,4); --copper coins


    elseif (MonID==115) then --Skeleton Mage, Level: 3, Armourtype: cloth, Weapontype: concussion

        --Category 1: Armor

        local done=drop.AddDropItem(34,1,20,(100*math.random(2,3)+math.random(22,33)),0,1); --black trousers
        if not done then done=drop.AddDropItem(810,1,10,(100*math.random(2,3)+math.random(22,33)),0,1); end --green doublet
        if not done then done=drop.AddDropItem(816,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --grey tunic
        if not done then done=drop.AddDropItem(193,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --blue robe
        if not done then done=drop.AddDropItem(194,1,1,(100*math.random(2,3)+math.random(22,33)),0,1); end --black robe

        --Category 2: Special loot

        local done=drop.AddDropItem(164,1,20,(100*math.random(2,3)+math.random(22,33)),0,2); --empty bottle
        if not done then done=drop.AddDropItem(256,1,10,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw emerald
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --raw diamond
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --diamond
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(2,3)+math.random(22,33)),0,2); end --emerald

        --Category 3: Weapon

        local done=drop.AddDropItem(39,1,20,(100*math.random(2,3)+math.random(22,33)),0,3); --skull staff
        if not done then done=drop.AddDropItem(40,1,10,(100*math.random(2,3)+math.random(22,33)),0,3); end --cleric's staff
        if not done then done=drop.AddDropItem(57,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --simple mage's staff
        if not done then done=drop.AddDropItem(2664,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --club
        if not done then done=drop.AddDropItem(230,1,1,(100*math.random(2,3)+math.random(22,33)),0,3); end --mace

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(2,6),100,333,0,4); --copper coins


    elseif (MonID==116) then
        -- Drops
    elseif (MonID==117) then
        --Drops
    elseif (MonID==118) then
        --Drops
    elseif (MonID==119) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
