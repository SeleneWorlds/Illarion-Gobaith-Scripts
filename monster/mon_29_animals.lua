local drop = require("monster.base.drop")
require("monster.base.lookat")
require("base.messages");
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

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

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

    if (MonID==291) then --sheep

        drop.AddDropItem(63,1,50,333,0,1); --inners
        drop.AddDropItem(170,10,50,333,0,2); --wool
        drop.AddDropItem(2934,1,100,333,0,3); --lamb meat

    elseif (MonID==292) then --pig

        drop.AddDropItem(63,1,50,333,0,1); --inners
        drop.AddDropItem(69,1,50,333,0,2); --leather
        drop.AddDropItem(307,1,100,333,0,3); --pork

    elseif (MonID==293) then --cow

        drop.AddDropItem(69,1,50,333,0,1); --leather
        drop.AddDropItem(333,1,50,333,0,2); --horn
        drop.AddDropItem(2940,1,100,333,0,3); --steak

    elseif (MonID==294) then --deer

        drop.AddDropItem(63,1,50,333,0,1); --inners
        drop.AddDropItem(552,1,100,333,0,2); --deer meat

    elseif (MonID==295) then --bunny

        drop.AddDropItem(63,1,50,333,0,1); --inners
        drop.AddDropItem(553,1,100,333,0,2); --rabbit meat

    end
    drop.Dropping(Monster);
end

return M
