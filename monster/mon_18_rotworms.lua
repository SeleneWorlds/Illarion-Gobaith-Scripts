local drop = require("monster.base.drop")
require("monster.base.lookat")
require("base.messages");
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base.messages.Messages();
msgs:addMessage("Dieses Monster wird mit NewIllarion abgeschafft. Bitte f�r Ersatz sorgen, um die Zahl der Bossmonster und die Balance der Monsterdrops beibehalten zu k�nnen!", "This monster will be discontinued with NewIllarion. Please create a replacement to maintain the number of boss monsters and the balance of drops!");

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
    local MonID=Monster:get_mon_type();
    if (MonID==181) then --Rotworm, Level: 7, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(255,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --raw ruby
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw topaz
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(256,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw emerald

        --Category 2: Special loot

        local done=drop.AddDropItem(46,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --ruby
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --topaz
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --emerald

        --Category 3: Weapon

        local done=drop.AddDropItem(68,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --ruby ring
        if not done then done=drop.AddDropItem(279,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --bluestone ring
        if not done then done=drop.AddDropItem(282,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --topaz ring
        if not done then done=drop.AddDropItem(278,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(281,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --emerald ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==182) then --Small Rotworm, Level: 6, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(251,1,20,(100*math.random(5,6)+math.random(55,66)),0,1); --raw amethyst
        if not done then done=drop.AddDropItem(256,1,10,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw emerald
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw diamond
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw topaz

        --Category 2: Special loot

        local done=drop.AddDropItem(197,1,20,(100*math.random(5,6)+math.random(55,66)),0,2); --amethyst
        if not done then done=drop.AddDropItem(45,1,10,(100*math.random(5,6)+math.random(55,66)),0,2); end --emerald
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --ruby
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --diamond
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --topaz

        --Category 3: Weapon

        local done=drop.AddDropItem(277,1,20,(100*math.random(5,6)+math.random(55,66)),0,3); --amethyst ring
        if not done then done=drop.AddDropItem(281,1,10,(100*math.random(5,6)+math.random(55,66)),0,3); end --emerald ring
        if not done then done=drop.AddDropItem(68,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --ruby ring
        if not done then done=drop.AddDropItem(280,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --diamond ring
        if not done then done=drop.AddDropItem(282,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --topaz ring

        --Category 4: Perma Loot
        drop.AddDropItem(3076,math.random(18,54),100,333,0,4); --copper coins


    elseif (MonID==183) then --Stoneworm, Level: 7, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(256,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --raw emerald
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw topaz
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw diamond

        --Category 2: Special loot

        local done=drop.AddDropItem(45,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --emerald
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --topaz
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --diamond

        --Category 3: Weapon

        local done=drop.AddDropItem(281,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --emerald ring
        if not done then done=drop.AddDropItem(278,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(279,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --bluestone ring
        if not done then done=drop.AddDropItem(282,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --topaz ring
        if not done then done=drop.AddDropItem(280,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --diamond ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==184) then --Agressive Rotworm, Level: 7, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(257,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --raw topaz
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw ruby

        --Category 2: Special loot

        local done=drop.AddDropItem(198,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --topaz
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(282,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --topaz ring
        if not done then done=drop.AddDropItem(279,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --bluestone ring
        if not done then done=drop.AddDropItem(277,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --amethyst ring
        if not done then done=drop.AddDropItem(278,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(68,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --ruby ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==185) then --Giant Earthworm, Level: 8, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(254,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --raw diamond
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw bluestone

        --Category 2: Special loot

        local done=drop.AddDropItem(285,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --diamond
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic ruby
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(280,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --diamond ring
        if not done then done=drop.AddDropItem(278,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(68,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --ruby ring
        if not done then done=drop.AddDropItem(277,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --amethyst ring
        if not done then done=drop.AddDropItem(279,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --bluestone ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins

    elseif (MonID==186) then
        -- Drops
    elseif (MonID==187) then
        --Drops
    elseif (MonID==188) then
        --Drops
    elseif (MonID==189) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
