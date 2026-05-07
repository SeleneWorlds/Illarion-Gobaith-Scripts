local drop = require("monster.base.drop")
require("monster.base.lookat")
require("base.messages");
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base.messages.Messages();
msgs:addMessage("#me bringt den Boden mit donnernder Wut zum Beben als er sich mit geschmeidiger Eleganz bewegt.", "#me shakes the ground with thunderous rage as it manoeuvres in its intuitive grace.");
msgs:addMessage("#me gr�bt die Krallen seiner Hinterl�ufe fest in den Boden w�hrend er die Luft mit einer seiner Vordertatzen b�sartig zerteilt.", "#me firmly plants the jagged talons of its back legs into the ground as it maliciously swipes the air with one of its front claws.");
msgs:addMessage("#me peitscht mit seinem verhornten Schwanz rigoros auf den Boden, diesen mit nachhallenden Ersch�tterungen b�se zurichtend.", "#me savagely lashes its horned tail as it batters the ground with reverberating tremors.");
msgs:addMessage("#me schwenkt seinen Kopf rasend vor und zur�ck, bevor er erf�llt von Bragons Zorn ein markersch�tterndes Gebr�ll ausst��t.", "#me swivels its head to and fro maniacally before erupting into a blood-curdling roar of Br�gon's wrath.");
msgs:addMessage("#me streckt seine echsenhaften Fl�gel aus um sich bei jedem Fl�gelschlag mit unerbittlichen Winb�en in unz�hmbarer Herrlichkeit aufzub�umen.", "#me expands its wings revealing its glorious majesty with vicious and unrelenting gales of wind sent forth by each flap.");
msgs:addMessage("#mes k�hne Augen glimmen mit unnachahmbarer Intensit�t w�hrend er den kleinsten Bewegungen und Ger�uschen nachgeht.", "#me's keen eyes smoulder with an unparalleled intensity as it perceives the slightest movements or sounds.");
msgs:addMessage("#mes messerscharfe Z�hne blitzen in unz�hmbarer Wut bevor er eine giftige, verkohlte Rauchwolke hervorschnaubt, die um seine k�nigliche Erscheinung wabert.", "#me flashes its serrated teeth in feral agitation before snorting a venomous cloud of charred smoke that billows about its regal appearance.");
msgs:addMessage("#mes ungest�mes Br�llen f�llt die Luft einem Wirbel von hei�en Blasen gleich und in seinem Maul beginnt ein feuriger Wirbelwind zu tosen.", "#me's obstreperous roar fills the air in a blistering pother of heat as a fiery inferno comes to life in its mouth.");
msgs:addMessage("#mes Erregung schwillt einer aufbrausenden Welle gleich an w�hrend er Kopf und K�rper verdreht, um in eine defensive Haltung zu kommen.", "#me's agitation swells like a rising tide as it pivots its neck and torso assuming a defensive posture.");
msgs:addMessage("#mes gl�hende Augen funkeln mit t�dlicher Gewissheit w�hrend er vor unbezwingbarer Wut sch�umt.", "#me's searing eyes glare with baneful intent as its insurmountable rage seethes.");

end

function M.FireBreath(Monster,Enemy)
    if (firstBreath==nil) then
        NearBreathShape={};
        NearBreathShape[1]={9,9,9,9,9};
        NearBreathShape[2]={0,9,9,9,0};
        NearBreathShape[3]={0,9,9,9,0};
        NearBreathShape[4]={0,0,9,0,0};
        NearBreathShape[5]={0,0,9,0,0};
        firstBreath=true;
    end
    local retVal=false;
    BreathTry=math.random(1,12);
    if (BreathTry==1) and (Monster.pos.z==Enemy.pos.z) then
        retVal=true;
        Monster.fightpoints=Monster.fightpoints-40;
        if (Monster:distanceMetric(Enemy)<=4) then
            Looking=Monster:get_face_to()
            if (Looking==0) then
                BreathShape=NearBreathShape;
            elseif (Looking==2) then
                BreathShape=M.ShapeDrehen(NearBreathShape);
            elseif (Looking==4) then
                BreathShape=M.ShapeDrehen(M.ShapeDrehen(NearBreathShape));
            elseif (Looking==6) then
                BreathShape=M.ShapeDrehen(M.ShapeDrehen(M.ShapeDrehen(NearBreathShape)));
            end
            for i=1,5 do
                for k=1,5 do
                    if (Looking==0) then
                        BreathPos=position(Monster.pos.x-3+k,Monster.pos.y-7+i,Monster.pos.z);
                    elseif (Looking==2) then
                        BreathPos=position(Monster.pos.x+k,Monster.pos.y-3+i,Monster.pos.z);
                    elseif (Looking==4) then
                        BreathPos=position(Monster.pos.x-3+k,Monster.pos.y+i,Monster.pos.z);
                    elseif (Looking==6) then
                        BreathPos=position(Monster.pos.x-7+k,Monster.pos.y-3+i,Monster.pos.z);
                    end
                    if (BreathShape[i][k]~=0) then
                        world:gfx(BreathShape[i][k],BreathPos);
                        if (math.random(1,5)==1) then
                            world:createItemFromId(359,1,BreathPos,true,math.random(200,600),0);
                            world:makeSound(5,BreathPos);
                        end
                        if world:isCharacterOnField(BreathPos) then
                            HitChar=world:getCharacterOnField(BreathPos);
                            HitChar:increaseAttrib("hitpoints",-2000)
                        end
                    end
                end
            end
        else
            drop.CastMonMagic(Monster,Enemy,1,{2500,2500},{{9,5}},{},0,1)
        end
    end
    growltry=math.random(1,8);
    if (growltry==1) then
        world:makeSound(26,Monster.pos);
    end
    return retVal
end

function M.ShapeDrehen(Shape)
    retShape={};
    for i=1,5 do
        retShape[i]={Shape[5][i],Shape[4][i],Shape[3][i],Shape[2][i],Shape[1][i]};
    end
    return retShape
end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    return ( M.FireBreath(Monster,Enemy) == true );
end

function M.enemyOnSight(Monster,Enemy)
    local MonID=Monster:get_mon_type();

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    if drop.DefaultSlowdown( Monster ) then
        return true
    else
        return ( M.FireBreath(Monster,Enemy) == true );
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
    if (MonID==261) then --Fire Dragon, Level: 8, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(447,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --ruby powder
        if not done then done=drop.AddDropItem(449,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --blackstone powder
        if not done then done=drop.AddDropItem(738,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --dragon egg
        if not done then done=drop.AddDropItem(505,1,1,(100*math.random(7,8)+math.random(77,88)),nil,1); end --treasure map
        if not done then done=drop.AddDropItem(450,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --amethyst powder

        --Category 2: Special loot

        local done=drop.AddDropItem(45,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --emerald
        if not done then done=drop.AddDropItem(285,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --diamond
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --ruby
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --topaz
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic amethyst

        --Category 3: Weapon

        local done=drop.AddDropItem(281,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --emerald ring
        if not done then done=drop.AddDropItem(280,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --diamond ring
        if not done then done=drop.AddDropItem(68,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --ruby ring
        if not done then done=drop.AddDropItem(282,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --topaz ring
        if not done then done=drop.AddDropItem(277,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --amethyst ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins


    elseif (MonID==262) then --Fire Dragon Cub, Level: 7, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(450,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --amethyst powder
        if not done then done=drop.AddDropItem(446,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --bluestone powder
        if not done then done=drop.AddDropItem(236,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --gold ingot
        if not done then done=drop.AddDropItem(2745,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --parchment
        if not done then done=drop.AddDropItem(447,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --ruby powder

        --Category 2: Special loot

        local done=drop.AddDropItem(284,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --bluestone
        if not done then done=drop.AddDropItem(45,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --emerald
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --diamond
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone

        --Category 3: Weapon

        local done=drop.AddDropItem(279,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --bluestone ring
        if not done then done=drop.AddDropItem(281,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --emerald ring
        if not done then done=drop.AddDropItem(277,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --amethyst ring
        if not done then done=drop.AddDropItem(280,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --diamond ring
        if not done then done=drop.AddDropItem(278,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --blackstone ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(1,3),100,333,0,4); --silver coins


    elseif (MonID==263) then --Big Red Dragon, Level: 8, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(451,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --topaz powder
        if not done then done=drop.AddDropItem(448,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --emerald powder
        if not done then done=drop.AddDropItem(738,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --dragon egg
        if not done then done=drop.AddDropItem(505,1,1,(100*math.random(7,8)+math.random(77,88)),nil,1); end --treasure map
        if not done then done=drop.AddDropItem(446,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --bluestone powder

        --Category 2: Special loot

        local done=drop.AddDropItem(198,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --topaz
        if not done then done=drop.AddDropItem(284,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(283,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --emerald
        if not done then done=drop.AddDropItem(46,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic ruby

        --Category 3: Weapon

        local done=drop.AddDropItem(282,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --topaz ring
        if not done then done=drop.AddDropItem(279,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --bluestone ring
        if not done then done=drop.AddDropItem(278,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(281,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --emerald ring
        if not done then done=drop.AddDropItem(68,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --ruby ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins


    elseif (MonID==264) then --Ancient Fire Dragon, Level: 8, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(452,1,20,(100*math.random(7,8)+math.random(77,88)),0,1); --diamond powder
        if not done then done=drop.AddDropItem(225,1,10,(100*math.random(7,8)+math.random(77,88)),0,1); end --crown
        if not done then done=drop.AddDropItem(738,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --dragon egg
        if not done then done=drop.AddDropItem(505,1,1,(100*math.random(7,8)+math.random(77,88)),nil,1); end --treasure map
        if not done then done=drop.AddDropItem(449,1,1,(100*math.random(7,8)+math.random(77,88)),0,1); end --blackstone powder

        --Category 2: Special loot

        local done=drop.AddDropItem(285,1,20,(100*math.random(7,8)+math.random(77,88)),0,2); --diamond
        if not done then done=drop.AddDropItem(198,1,10,(100*math.random(7,8)+math.random(77,88)),0,2); end --topaz
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --bluestone
        if not done then done=drop.AddDropItem(197,1,1,(100*math.random(7,8)+math.random(77,88)),0,2); end --amethyst
        if not done then done=drop.AddDropItem(45,1,1,(100*math.random(7,8)+math.random(77,88)),1,2); end --magic emerald

        --Category 3: Weapon

        local done=drop.AddDropItem(280,1,20,(100*math.random(7,8)+math.random(77,88)),0,3); --diamond ring
        if not done then done=drop.AddDropItem(282,1,10,(100*math.random(7,8)+math.random(77,88)),0,3); end --topaz ring
        if not done then done=drop.AddDropItem(279,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --bluestone ring
        if not done then done=drop.AddDropItem(277,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --amethyst ring
        if not done then done=drop.AddDropItem(281,1,1,(100*math.random(7,8)+math.random(77,88)),0,3); end --emerald ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(3,9),100,333,0,4); --silver coins


    elseif (MonID==265) then --Son of Bragon, Level: 9, Armourtype: -, Weapontype: wrestling

        --Category 1: Armor

        local done=drop.AddDropItem(738,1,20,(100*math.random(8,9)+math.random(88,99)),0,1); --dragon egg
        if not done then done=drop.AddDropItem(505,1,10,(100*math.random(8,9)+math.random(88,99)),nil,1); end --treasure map
        if not done then done=drop.AddDropItem(448,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --emerald powder
        if not done then done=drop.AddDropItem(451,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --topaz powder
        if not done then done=drop.AddDropItem(452,1,1,(100*math.random(8,9)+math.random(88,99)),0,1); end --diamond powder

        --Category 2: Special loot

        local done=drop.AddDropItem(46,1,20,(100*math.random(8,9)+math.random(88,99)),0,2); --ruby
        if not done then done=drop.AddDropItem(283,1,10,(100*math.random(8,9)+math.random(88,99)),0,2); end --blackstone
        if not done then done=drop.AddDropItem(285,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic diamond
        if not done then done=drop.AddDropItem(198,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic topaz
        if not done then done=drop.AddDropItem(284,1,1,(100*math.random(8,9)+math.random(88,99)),1,2); end --magic bluestone

        --Category 3: Weapon

        local done=drop.AddDropItem(68,1,20,(100*math.random(8,9)+math.random(88,99)),0,3); --ruby ring
        if not done then done=drop.AddDropItem(278,1,10,(100*math.random(8,9)+math.random(88,99)),0,3); end --blackstone ring
        if not done then done=drop.AddDropItem(280,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --diamond ring
        if not done then done=drop.AddDropItem(282,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --topaz ring
        if not done then done=drop.AddDropItem(279,1,1,(100*math.random(8,9)+math.random(88,99)),0,3); end --bluestone ring

        --Category 4: Perma Loot
        drop.AddDropItem(3077,math.random(9,27),100,333,0,4); --silver coins

    elseif (MonID==266) then
        -- Drops
    elseif (MonID==267) then
        --Drops
    elseif (MonID==268) then
        --Drops
    elseif (MonID==269) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
