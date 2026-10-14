local init
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

    local MonID=Monster:get_mon_type();
    if (MonID==93) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,8,{500,1000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1,{25,40}) );
    elseif (MonID==333) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,15,{500,1000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1,{25,40}) );
    elseif (MonID==95) then
        return ( drop.Stealing(Monster,Enemy) == true );
    elseif (MonID==335) then
        return ( drop.Stealing(Monster,Enemy) == true );
    else
        return false
    end
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    local MonID=Monster:get_mon_type();
    if drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==93) then
        return ( drop.CastHealing( Monster, 6, {1500,3000}, 8, {16, 13}, 40 ) or drop.CastMonMagic(Monster,Enemy,3,{1200,2000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1,{60,90}) );
    elseif (MonID==333) then
        return ( drop.CastHealing( Monster, 3, {1500,3000}, 8, {16, 13}, 40 ) or drop.CastMonMagic(Monster,Enemy,6,{1200,2000},{{9,5},{36,5},{38,5}},{{359,320,500,0,7}},40,1,{60,90}) );
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
