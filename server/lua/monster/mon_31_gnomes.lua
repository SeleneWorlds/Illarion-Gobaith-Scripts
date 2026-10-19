local init
local common = require("base.common")
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    return false
end

function M.throwMolotov(Monster,Enemy)
    if (math.random(1,30)==1) and Monster.movepoints >= 21 and (Monster.pos.z==Enemy.pos.z) then --does not throw very often, half the frequency of casting monsters
        local hitPos=position( Enemy.pos.x+math.random(-2,2), Enemy.pos.y+math.random(-2,2), Enemy.pos.z );
        local distance = Monster:distanceMetricToPosition( hitPos );
        if ( distance < 3 ) then
            if( math.random(1,2) == 1 ) then
                hitPos.x = ( hitPos.x > 0 and hitPos.x + 3 - distance or hitPos.x - 3 + distance );
            else
                hitPos.y = ( hitPos.y > 0 and hitPos.y + 3 - distance or hitPos.y - 3 + distance );
            end
        end

        local Strength=math.random(55,88);
        local hitpoints;

        world:gfx(36,hitPos);
        M.HitChar(hitPos,common.Scale(3000,6000,Strength));
        world:makeSound(5,hitPos);
        hitpoints = common.Scale( 1000, 3000, Strength );
        common.CreateCircle( hitPos, 1, function( targetPos )
            world:gfx( 44, targetPos );
            M.HitChar( targetPos, hitpoints );
        end );
        hitpoints = common.Scale( 100, 500, Strength );
        common.CreateCircle( hitPos, 2, function( targetPos )
            world:gfx( 9, targetPos );
            M.HitChar( targetPos, hitpoints );
        end );
        hitpoints = common.Scale( 20, 100, Strength );
        common.CreateCircle( hitPos, 3, function( targetPos )
            world:gfx( 32, targetPos );
            M.HitChar( targetPos, hitpoints );
        end );

        Monster.movepoints=Monster.movepoints-25;
        Monster:talkLanguage( CCharacter.say, CPlayer.german, "#me schmeißt eine weiße Flasche nach "..Enemy.name..".");
        Monster:talkLanguage( CCharacter.say, CPlayer.english, "#me tosses a white bottle at "..Enemy.name..".");
        return true;
    end
    return false;
end

function M.HitChar(Posi,Hitpoints)
    if world:isCharacterOnField(Posi) then world:getCharacterOnField(Posi):increaseAttrib("hitpoints",-Hitpoints) end;
end;

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    local MonID=Monster:get_mon_type();
    if drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==314 or MonID == 324) then
        return ( M.throwMolotov(Monster,Enemy) == true );
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
