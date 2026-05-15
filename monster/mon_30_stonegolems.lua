local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#mes imposante Erscheinung wirft einen finsteren Schatten und der Boden erbebt mit jedem Schritt.", "#me's colossal presence casts an eclipsing shadow and shakes the ground with each step.");
msgs:addMessage("#me mag einem diamantgleichen Bollwerk aus Fels und Stein gleichen, aber jene mit scharfen Blick k�nnen den eingelassenen Herzstein in der Brust des W�chters ausmachen.", "#me's adamantine bulwark of rocks and gems may seem impervious, but those with a keen eye might notice the crystalline heart-stone embedded in the guardian's chest.");
msgs:addMessage("#me stampft mit einer solchen Geschwindigkeit auf den Boden, dass die Ersch�tterung tiefe Risse hinterl��t.", "#me pounds the ground with such velocity that tremors split and crack across the ground.");
msgs:addMessage("#mes kehliges Grollen durchdringt Ohr und Mark wie eine kreischender Schleifstein.", "#me's guttural roar pierces the ear like an amplified grindstone.");
msgs:addMessage("#me steht r�cksichtslos in seinem Hoheitsgebiet Wache, jene, die die F�den der Natur ergr�ndet haben, machen abstruse Managewebe als Anstiftung seiner Wut aus.", "#me ruthlessly guards its territory, those clairvoyant to the threads of nature may sense the abstruse webs of mana inciting its rage.");
msgs:addMessage("#me richtet seine diamantenen Augen ganz und gar auf sein Ziel,  vollkommens sich der Beseitigung der Eindringlingen hingebend.", "#me trains its diamond eyes on its target utterly enraptured with eliminating intruders.");
msgs:addMessage("#me bewegt sich mit einer solchen Heftigkeit, dass der Steine Scherben aus dem Boden br�ckeln.", "#me moves with such ferocity that shards of gems and rocks crumble to the ground.");
msgs:addMessage("#me schl�gt seine steinernen F�uste zusammen, den Boden mit Fragmenten von Edelsteinen und rohem Fels bedeckend.", "#me smashes its stone fists together littering the ground with fragments of precious jewels and raw stone.");
msgs:addMessage("#me hinterl�sst beim herumtrampeln tiefe Erdpfurchen und widerhallendes Beben.", "#me leaves behind hollow pits and reverberating tremors as it tramples around.");
msgs:addMessage("#me hebt seine imposanten F�uste und st��t einen donnernden Kriegsschrei aus, der die Erde beben l�sst.", "#me raises its enormous fist and yells a terrifying warcry that makes the ground quake.");

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
if (MonID==301) then --Stone Golem, Level: 7, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(251,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --raw amethyst
        if not done then done=drop.AddDropItem(256,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw emerald
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(254,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw diamond
        if not done then done=drop.AddDropItem(257,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw topaz

        --Category 2: Special loot

        local done=drop.AddDropItem(197,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --amethyst
        if not done then done=drop.AddDropItem(45,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --emerald
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --ruby
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --diamond
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --topaz

        --Category 3: Weapon

        local done=drop.AddDropItem(735,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --raw stone
        if not done then done=drop.AddDropItem(733,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --stone block
        if not done then done=drop.AddDropItem(22,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --iron ore
        if not done then done=drop.AddDropItem(2536,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --copper ore
        if not done then done=drop.AddDropItem(1266,10,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --stone

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==302) then --Copper Golem, Level: 7, Armourtype: -, Weapontype: wrestling

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

        local done=drop.AddDropItem(22,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --iron ore
        if not done then done=drop.AddDropItem(733,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --stone block
        if not done then done=drop.AddDropItem(234,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --gold nugget
        if not done then done=drop.AddDropItem(2534,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --merinium ore
        if not done then done=drop.AddDropItem(2536,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --copper ore

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==303) then --Iron Golem, Level: 7, Armourtype: -, Weapontype: wrestling

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

        local done=drop.AddDropItem(2536,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --copper ore
        if not done then done=drop.AddDropItem(735,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --raw stone
        if not done then done=drop.AddDropItem(234,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --gold nugget
        if not done then done=drop.AddDropItem(2534,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --merinium ore
        if not done then done=drop.AddDropItem(22,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --iron ore

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==304) then --Gold Golem, Level: 8, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(257,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --raw topaz
        if not done then done=drop.AddDropItem(253,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw bluestone
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(252,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --raw ruby

        --Category 2: Special loot

        local done=drop.AddDropItem(198,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --topaz
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(234,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --gold nugget
        if not done then done=drop.AddDropItem(733,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --stone block
        if not done then done=drop.AddDropItem(22,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --iron ore
        if not done then done=drop.AddDropItem(2536,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --copper ore
        if not done then done=drop.AddDropItem(1266,10,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --stone

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins


    elseif (MonID==305) then --Merinium Golem, Level: 9, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(254,1,20,(100*math.random(8,9)+math.random(88,99)),0,1); --raw diamond
        if not done then done=drop.AddDropItem(252,1,10,(100*math.random(8,9)+math.random(88,99)),0,1); end --raw blackstone
        if not done then done=drop.AddDropItem(255,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --raw ruby
        if not done then done=drop.AddDropItem(251,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --raw amethyst
        if not done then done=drop.AddDropItem(253,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --raw bluestone

        --Category 2: Special loot

        local done=drop.AddDropItem(285,1,20,(100*math.random(8,9)+math.random(88,99)),0,2); --diamond
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(8,9)+math.random(88,99)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic ruby
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic amethyst
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(2534,1,20,(100*math.random(8,9)+math.random(88,99)),0,3); --merinium ore
        if not done then done=drop.AddDropItem(735,1,10,(100*math.random(8,9)+math.random(88,99)),0,3); end --raw stone
        if not done then done=drop.AddDropItem(22,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --iron ore
        if not done then done=drop.AddDropItem(2536,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --copper ore
        if not done then done=drop.AddDropItem(733,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --stone block

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(9,27),100,333,0,4); --silver coins

    end
    drop.Dropping(Monster);
end

return M
