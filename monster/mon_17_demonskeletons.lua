require("monster.base.drop")
require("monster.base.lookat")
require("base.messages");
module("monster.mon_17_demonskeletons")


function ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base.messages.Messages();
msgs:addMessage("Die Toten dulden keine Lebenden in ihrer Mitte. Die Strafe f�r euer Eindringen ist der Tod.", "The undead shall not allow the living to dwell here. The punishment for such insolence shall be death!");
msgs:addMessage("Die Toten verlangen nach frischem Blut. Deinem Blut!", "The undead demand fresh blood, your blood!");
msgs:addMessage("Es ist gut das ihr hier seid, Sterblicher. Die Stimmung hier war irgendwie tot.", "It's good that you are here, mortal. Now you can entertain me.");
msgs:addMessage("Selbst wenn du meinen K�rper zerschl�gst, werde ich zur�ck kommen. Wie ist es bei dir?", "Even if you destroy my body, I will return. How about you?");
msgs:addMessage("Wie t�tet man etwas was schon tot ist? Das h�ttest du dir eher �berlegen sollen!", "How do you expect to kill something that is already dead? You should have thought about that earlier!");
msgs:addMessage("#me unternimmt nichts um die blutbefleckten Folterinstrumente zu verstecken die von seiner knochigen H�fte baumeln: eine rostige Schere, gezackte Metallscherben, Zangen, und verschiedene Phiolen mit Fl�ssigkeiten.", "#me does nothing to conceal the blood soaked devices of torture clanging from its bony hip: rusted scissors, jagged shards of metal, tongs, and various vials of liquid.");
msgs:addMessage("#mes schreckliche Aura zerst�rt das nat�rliche Gleichgewicht. Jene, denen die h�heren, geistigen Ebenen offen stehen, sp�ren vielleicht seine ruchlose Gier.", "#me's unholy aura corrupts the natural balance, even those oblivious to the ethereal planes might sense its heinous lust.");
msgs:addMessage("#mes Durst nach Zerst�rung ist unerbittlich, und so benutzt es seine h�llische Macht um seine verderbliche Wut zu entfesseln.", "#me is unrelenting in its thirst for destruction, using its infernal powers to unleash its baleful wrath.");
msgs:addMessage("#mes Knochen krachen und knirschen bedrohlich mit jeder lebhaften Bewegung.", "#me's bones grind and crack ominously with its animated movements.");
msgs:addMessage("#mes teuflisch ger�tete Knochen tropfen von geronnenem Blut w�hrend ein abscheulicher Gestank die Luft vergiftet.", "#me's fiendishly reddened bones drip with clotted blood as an abhorrent stench pollutes the air.");
msgs:addMessage("#me bewegt seinen deformierten Unterkiefer als wolle es sprechen, aber stattdessen rasselt ein beunruhigendes Krachen durch die Luft.", "#me moves its mangled jaw as if to speak, but instead an unsettling crackle rattles through the air.");
msgs:addMessage("#me weicht wie in Trance erstarrt aus, niemals z�gerlich oder locker, sein einziges Ziel ist es die zerst�rerische Gier zu befriedigen.", "#me manoeuvres in a rigid trance, never hesitant or lax, its only purpose is to devour.");
msgs:addMessage("#me beugt sich in verwirrtem Irrsinn nieder, all sein K�nnen benutzend um in elendem Zorn Leben zu verschlingen.", "#me bears down with a deranged frenzy using everything in its r�pertoire to consume life in its blighted rage.");
msgs:addMessage("#mes scheinbar zerbrechliches �u�eres stellt sich als t�uschend heraus, verschleiert es doch die tats�chliche Macht der schwarzen Magie, die das Skelett umgibt, auf verr�terische Weise.", "#me's seemingly fragile exterior proves to be deceiving as he mutters words of black magic.");
msgs:addMessage("#me streift eine l�stige Sammlung blutverkrusteter, ineinander verwickelter Ketten �ber seine Schultern und seinen Oberk�rper.", "#me drags a cumbersome set of blood encrusted chains that intertwine around its shoulders and torso.");
msgs:addMessage("#me zischt erbost: 'Ich bin nicht auferstanden, um mir von euch erneut ein Ende bereiten zu lassen. Sterbt!'", "#me hisses in fury: 'I did not rise from the dead just to get finished off by you. Die!'");
msgs:addMessage("#me lacht mit krachenden Kiefern und kleine Flammen z�ngeln aus seinen Augenh�hlen.", "#me laughs with snapping jaw, small flames glowing from its eyeholes.");
msgs:addMessage("Du kannst mich nicht bezwingen, das vermochte nicht einmal der Tod zu erreichen.", "You will not succeed in what death failed in.");
msgs:addMessage("Ich werde dich t�ten, Sterblicher, auf dass du die Qualen erleiden m�gest, die ich durchgestanden habe!", "I will slay you, mortal, for you shall suffer as I did.");
msgs:addMessage("#me schnarrt drohend und dreht den Kopf von einer Seite zur anderen.", "#me snares evilly and turns its head from side to side.");
msgs:addMessage("#me kreischt hysterisch mit schriller Stimme 'Na los, erl�se mich von meinem unseligen Dasein!'.", "#me screams in a shrill voice: 'Come on, relive me from my puny existance!'.");
msgs:addMessage("#me breitet die Arme aus und ein blutrotes Leuchten geht von seinen Knochen aus. Ein Schaudern scheint das Skelett zu erf�llen, ehe es sich wie im Rausch auf sein Opfer st�rzt.", "#me spreads its arms and a blood red glow is radiated from its bones. A shiver seems to overcome the skeleton before it charges its victim.");
msgs:addMessage("Geht in die Knie, Sterblicher, und ich werde euch vielleicht verschonen� vielleicht werd ich euer Ende aber auch nur schneller bereiten!", "Kneel down, mortal, and I will spare you... or just make the end approach faster.");
msgs:addMessage("#me kr�chzt verworren: 'Du dachtest, du h�ttest mich erledigt. Das wirst du nun b��en!'", "#me croaks abstrusely: 'You thought you were done with me. You shall regret this!'");
msgs:addMessage("#me fl�stert lockend: 'Begib dich in Cherga's Umarmung und werde einer von uns�'.", "#me whispers alluringly: 'Embrace Cherga and become one of us�'.");

end

function enemyNear(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==172) then
        return ( monster.base.drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
    elseif (MonID==175) then
        if monster.base.drop.SuddenWarp(Monster,Enemy,true) then
            return true
        end
        if monster.base.drop.CastMonster(Monster,Enemy,10,{111,115},40) then
            return true
        end
        if monster.base.drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) then
            return true
        end
        return false
    else
        return false;
    end
end

function enemyOnSight(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if monster.base.drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==172) then
        return ( monster.base.drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) == true );
    elseif (MonID==175) then
        if monster.base.drop.CastMonster(Monster,Enemy,10,{111,115},40) then
            return true
        end
        if monster.base.drop.CastMonMagic(Monster,Enemy,5,{2000,3000},{{4,5},{9,5},{51,5}},{},40,1) then
            return true
        end
        return false
    else
        return false;
    end
end

function onAttacked(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onCasted(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onDeath(Monster)

    if killer[Monster.id] ~= nil then

        murderer=getCharForId(killer[Monster.id]);
    
        if murderer then
            killer[Monster.id]=nil;
            murderer=nil;

        end
    end

    monster.base.drop.Clearmonster.base.drop.Dropping();
    local MonID=Monster:get_mon_type();
    
if (MonID==171) then --Demon Skeleton, Level: 6, Armourtype: heavy, Weapontype: slashing

        --Category 1: Armor

        local done=monster.base.drop.AddDropItem(2172,1,20,(100*math.random(5,6)+math.random(55,66)),0,1); --steel greaves
        if not done then done=monster.base.drop.AddDropItem(917,1,10,(100*math.random(5,6)+math.random(55,66)),0,1); end --cursed shield
        if not done then done=monster.base.drop.AddDropItem(2364,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --steel plate
        if not done then done=monster.base.drop.AddDropItem(2363,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --nightplate
        if not done then done=monster.base.drop.AddDropItem(2357,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --shadowplate

        --Category 2: Special loot

        local done=monster.base.drop.AddDropItem(277,1,20,(100*math.random(5,6)+math.random(55,66)),0,2); --amethyst ring
        if not done then done=monster.base.drop.AddDropItem(235,1,10,(100*math.random(5,6)+math.random(55,66)),0,2); end --gold ring
        if not done then done=monster.base.drop.AddDropItem(47,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --needle
        if not done then done=monster.base.drop.AddDropItem(6,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --scissors
        if not done then done=monster.base.drop.AddDropItem(197,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --amethyst

        --Category 3: Weapon

        local done=monster.base.drop.AddDropItem(2701,1,20,(100*math.random(5,6)+math.random(55,66)),0,3); --long sword
        if not done then done=monster.base.drop.AddDropItem(2658,1,10,(100*math.random(5,6)+math.random(55,66)),0,3); end --broad sword
        if not done then done=monster.base.drop.AddDropItem(2757,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --scimitar
        if not done then done=monster.base.drop.AddDropItem(25,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --sabre
        if not done then done=monster.base.drop.AddDropItem(1,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --serinjah sword

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(3076,math.random(18,54),100,333,0,4); --copper coins


    elseif (MonID==172) then --Demon Skeleton Mage, Level: 7, Armourtype: cloth, Weapontype: concussion (wrestling)

        --Category 1: Armor

        local done=monster.base.drop.AddDropItem(357,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --blue wizard hat
        if not done then done=monster.base.drop.AddDropItem(371,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --expensive wizard hat
        if not done then done=monster.base.drop.AddDropItem(547,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --novice mage robe
        if not done then done=monster.base.drop.AddDropItem(548,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --mage robe
        if not done then done=monster.base.drop.AddDropItem(558,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --master mage robe

        --Category 2: Special loot

        local done=monster.base.drop.AddDropItem(68,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --ruby ring
        if not done then done=monster.base.drop.AddDropItem(278,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone ring
        if not done then done=monster.base.drop.AddDropItem(336,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --mirror
        if not done then done=monster.base.drop.AddDropItem(223,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --iron goblet
        if not done then done=monster.base.drop.AddDropItem(46,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --ruby

        --Category 3: Weapon

        local done=monster.base.drop.AddDropItem(76,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --mage's staff
        if not done then done=monster.base.drop.AddDropItem(208,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --ornate mage's staff
        if not done then done=monster.base.drop.AddDropItem(323,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --wand
        if not done then done=monster.base.drop.AddDropItem(207,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --battle staff
        if not done then done=monster.base.drop.AddDropItem(39,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --skull staff

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==173) then --Demon Skeleton Warrior, Level: 7, Armourtype: heavy, Weapontype: slashing

        --Category 1: Armor

        local done=monster.base.drop.AddDropItem(2363,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --nightplate
        if not done then done=monster.base.drop.AddDropItem(326,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --steel boots
        if not done then done=monster.base.drop.AddDropItem(2393,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --heavy plate armor
        if not done then done=monster.base.drop.AddDropItem(185,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --black visor helmet
        if not done then done=monster.base.drop.AddDropItem(2111,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --blue steel greaves

        --Category 2: Special loot

        local done=monster.base.drop.AddDropItem(281,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --emerald ring
        if not done then done=monster.base.drop.AddDropItem(279,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --bluestone ring
        if not done then done=monster.base.drop.AddDropItem(2647,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --cutlery
        if not done then done=monster.base.drop.AddDropItem(1840,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --copper goblet
        if not done then done=monster.base.drop.AddDropItem(45,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --emerald

        --Category 3: Weapon

        local done=monster.base.drop.AddDropItem(2731,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --two handed sword
        if not done then done=monster.base.drop.AddDropItem(204,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --bastard sword
        if not done then done=monster.base.drop.AddDropItem(2640,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --fireaxe
        if not done then done=monster.base.drop.AddDropItem(383,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --waraxe
        if not done then done=monster.base.drop.AddDropItem(205,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --double axe

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==174) then --Old Demon Skeleton, Level: 7, Armourtype: medium, Weapontype: concussion

        --Category 1: Armor

        local done=monster.base.drop.AddDropItem(2389,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --salkamaerian armor
        if not done then done=monster.base.drop.AddDropItem(2287,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --albarian  soldier's helmet
        if not done then done=monster.base.drop.AddDropItem(2302,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --gynkese mercenarie's helmet
        if not done then done=monster.base.drop.AddDropItem(2194,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --short hardwood greaves
        if not done then done=monster.base.drop.AddDropItem(916,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --ornate tower shield

        --Category 2: Special loot

        local done=monster.base.drop.AddDropItem(282,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --topaz ring
        if not done then done=monster.base.drop.AddDropItem(278,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone ring
        if not done then done=monster.base.drop.AddDropItem(2185,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --wooden cup
        if not done then done=monster.base.drop.AddDropItem(1858,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --goblet
        if not done then done=monster.base.drop.AddDropItem(198,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --topaz

        --Category 3: Weapon

        local done=monster.base.drop.AddDropItem(231,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --morning star
        if not done then done=monster.base.drop.AddDropItem(2737,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --morning star
        if not done then done=monster.base.drop.AddDropItem(226,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --warhammer
        if not done then done=monster.base.drop.AddDropItem(207,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --battle staff
        if not done then done=monster.base.drop.AddDropItem(230,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --mace

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==175) then --Lich, Level: 8, Armourtype: cloth, Weapontype: concussion

        --Category 1: Armor

        local done=monster.base.drop.AddDropItem(548,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --mage robe
        if not done then done=monster.base.drop.AddDropItem(547,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --novice mage robe
        if not done then done=monster.base.drop.AddDropItem(558,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --master mage robe
        if not done then done=monster.base.drop.AddDropItem(370,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --colourful wizard hat
        if not done then done=monster.base.drop.AddDropItem(358,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --red wizard hat

        --Category 2: Special loot

        local done=monster.base.drop.AddDropItem(280,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --diamond ring
        if not done then done=monster.base.drop.AddDropItem(279,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --bluestone ring
        if not done then done=monster.base.drop.AddDropItem(314,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --pot ash
        if not done then done=monster.base.drop.AddDropItem(224,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --golden goblet
        if not done then done=monster.base.drop.AddDropItem(285,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic diamond

        --Category 3: Weapon

        local done=monster.base.drop.AddDropItem(207,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --battle staff
        if not done then done=monster.base.drop.AddDropItem(208,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --ornate mage's staff
        if not done then done=monster.base.drop.AddDropItem(323,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --wand
        if not done then done=monster.base.drop.AddDropItem(2782,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --wand of earth
        if not done then done=monster.base.drop.AddDropItem(2783,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --wand of fire

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins

    elseif (MonID==176) then
        -- Drops
    elseif (MonID==177) then
        --Drops
    elseif (MonID==178) then
        --Drops
    elseif (MonID==179) then
        --Drops
    else
        --Drops
    end
    monster.base.drop.Dropping(Monster);
end