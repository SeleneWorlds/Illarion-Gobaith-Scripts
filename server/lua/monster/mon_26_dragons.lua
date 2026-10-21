local init
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
local lastGrowl = {}
local growlCooldown = 10 -- seconds per dragon
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me bringt den Boden mit donnernder Wut zum Beben als er sich mit geschmeidiger Eleganz bewegt.", "#me shakes the ground with thunderous rage as it manoeuvres in its intuitive grace.");
msgs:addMessage("#me gräbt die Krallen seiner Hinterläufe fest in den Boden während er die Luft mit einer seiner Vordertatzen bösartig zerteilt.", "#me firmly plants the jagged talons of its back legs into the ground as it maliciously swipes the air with one of its front claws.");
msgs:addMessage("#me peitscht mit seinem verhornten Schwanz rigoros auf den Boden, diesen mit nachhallenden Erschütterungen böse zurichtend.", "#me savagely lashes its horned tail as it batters the ground with reverberating tremors.");
msgs:addMessage("#me schwenkt seinen Kopf rasend vor und zurück, bevor er erfüllt von Bragons Zorn ein markerschütterndes Gebrüll ausstößt.", "#me swivels its head to and fro maniacally before erupting into a blood-curdling roar of Brägon's wrath.");
msgs:addMessage("#me streckt seine echsenhaften Flügel aus um sich bei jedem Flügelschlag mit unerbittlichen Winböen in unzähmbarer Herrlichkeit aufzubäumen.", "#me expands its wings revealing its glorious majesty with vicious and unrelenting gales of wind sent forth by each flap.");
msgs:addMessage("#mes kühne Augen glimmen mit unnachahmbarer Intensität während er den kleinsten Bewegungen und Geräuschen nachgeht.", "#me's keen eyes smoulder with an unparalleled intensity as it perceives the slightest movements or sounds.");
msgs:addMessage("#mes messerscharfe Zähne blitzen in unzähmbarer Wut bevor er eine giftige, verkohlte Rauchwolke hervorschnaubt, die um seine königliche Erscheinung wabert.", "#me flashes its serrated teeth in feral agitation before snorting a venomous cloud of charred smoke that billows about its regal appearance.");
msgs:addMessage("#mes ungestümes Brüllen füllt die Luft einem Wirbel von heißen Blasen gleich und in seinem Maul beginnt ein feuriger Wirbelwind zu tosen.", "#me's obstreperous roar fills the air in a blistering pother of heat as a fiery inferno comes to life in its mouth.");
msgs:addMessage("#mes Erregung schwillt einer aufbrausenden Welle gleich an während er Kopf und Körper verdreht, um in eine defensive Haltung zu kommen.", "#me's agitation swells like a rising tide as it pivots its neck and torso assuming a defensive posture.");
msgs:addMessage("#mes glühende Augen funkeln mit tödlicher Gewissheit während er vor unbezwingbarer Wut schäumt.", "#me's searing eyes glare with baneful intent as its insurmountable rage seethes.");

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
    if (BreathTry==1) and Monster.movepoints >= 21 and (Monster.pos.z==Enemy.pos.z) then
        retVal=true;
        Monster.movepoints=Monster.movepoints-40;
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
            local breathSoundPlayed = false
            for i=1,5 do
                for k=1,5 do
                    if (Looking==0) then
                        BreathPos=position(Monster.pos.x-3+k,Monster.pos.y-6+i,Monster.pos.z);
                    elseif (Looking==2) then
                        BreathPos=position(Monster.pos.x+k,Monster.pos.y-3+i,Monster.pos.z);
                    elseif (Looking==4) then
                        BreathPos=position(Monster.pos.x-3+k,Monster.pos.y+i,Monster.pos.z);
                    elseif (Looking==6) then
                        BreathPos=position(Monster.pos.x-6+k,Monster.pos.y-3+i,Monster.pos.z);
                    end
                    if (BreathShape[i][k]~=0) then
                        world:gfx(BreathShape[i][k],BreathPos);
                        if (math.random(1,5)==1) then
                            world:createItemFromId(359,1,BreathPos,true, 3, {magicStrength = math.random(200, 600)});
                            if not breathSoundPlayed then
                                world:makeSound(5,BreathPos);
                                breathSoundPlayed = true
                            end
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
    local now = world:getTime("unix")
    if (lastGrowl[Monster.id] == nil or now - lastGrowl[Monster.id] >= growlCooldown)
        and math.random(1,8) == 1 then
        world:makeSound(26,Monster.pos);
        lastGrowl[Monster.id] = now
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
    lastGrowl[Monster.id] = nil

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
