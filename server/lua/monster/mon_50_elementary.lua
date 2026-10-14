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
    if (MonID==501) or (MonID==502) then -- Fire Elementaries
        if (true) then
            world:gfx(36,Monster.pos);
            if (MonID == 502) then
                world:gfx(36,position(Monster.pos.x - 1,Monster.pos.y,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x + 1,Monster.pos.y,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x,Monster.pos.y - 1,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x,Monster.pos.y + 1,Monster.pos.z));
            end
        end
        if (math.random(1,15) == 1) then
            if (MonID == 502) then
                old_mon_pos = Monster.pos;
                drop.SuddenWarp(Monster,Enemy,false);
                CreateLineofFligth(old_mon_pos,Monster.pos,44);
                CreateLineofFligth(position(old_mon_pos.x - 1,old_mon_pos.y,old_mon_pos.z),position(Monster.pos.x - 1,Monster.pos.y,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x + 1,old_mon_pos.y,old_mon_pos.z),position(Monster.pos.x + 1,Monster.pos.y,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x,old_mon_pos.y - 1,old_mon_pos.z),position(Monster.pos.x,Monster.pos.y - 1,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x,old_mon_pos.y + 1,old_mon_pos.z),position(Monster.pos.x,Monster.pos.y + 1,Monster.pos.z),44);
            else
                drop.SuddenWarp(Monster,Enemy,true);
            end
            return true;
        end
        return false;
    elseif (MonID==503) or (MonID==504) then -- Water Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(4,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        return false;
    elseif (MonID==505) or (MonID==506) then -- Wind Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(7,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        return false;
    elseif (MonID==507) or (MonID==508) then -- Earth Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(5,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        return false;
    elseif (MonID==509) or (MonID==510) then -- Spirit Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(46,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        return false;
    else
        return false;
    end
end

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    local MonID=Monster:get_mon_type();
    if (MonID==501) or (MonID==502) then -- Fire Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(36,Monster.pos);
            if (MonID == 502) then
                world:gfx(36,position(Monster.pos.x - 1,Monster.pos.y,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x + 1,Monster.pos.y,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x,Monster.pos.y - 1,Monster.pos.z));
                world:gfx(36,position(Monster.pos.x,Monster.pos.y + 1,Monster.pos.z));
            end
        end
        if (math.random(1,15) == 1) then
            if (MonID == 502) then
                old_mon_pos = Monster.pos;
                drop.SuddenWarp(Monster,Enemy,false);
                CreateLineofFligth(old_mon_pos,Monster.pos,44);
                CreateLineofFligth(position(old_mon_pos.x - 1,old_mon_pos.y,old_mon_pos.z),position(Monster.pos.x - 1,Monster.pos.y,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x + 1,old_mon_pos.y,old_mon_pos.z),position(Monster.pos.x + 1,Monster.pos.y,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x,old_mon_pos.y - 1,old_mon_pos.z),position(Monster.pos.x,Monster.pos.y - 1,Monster.pos.z),44);
                CreateLineofFligth(position(old_mon_pos.x,old_mon_pos.y + 1,old_mon_pos.z),position(Monster.pos.x,Monster.pos.y + 1,Monster.pos.z),44);
            else
                drop.SuddenWarp(Monster,Enemy,true);
            end
            return true;
        end
        if (MonID==502) then
            if (math.random(1,30) == 1) then
                CreateLineofFligth(Monster.pos,Enemy.pos,44);
                Enemy:increaseAttrib("hitpoints",-700);
                Monster.movepoints = Monster.movepoints - 40;
                return true;
            end
        end
        return false;
    elseif (MonID==503) or (MonID==504) then -- Water Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(4,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        if (MonID==504) then
            if (math.random(1,30) == 1) then
                CreateLineofFligth(Monster.pos,Enemy.pos,3);
                Enemy:increaseAttrib("hitpoints",-700);
                Monster.movepoints = Monster.movepoints - 40;
                return true;
            end
        end
        return false;
    elseif (MonID==505) or (MonID==506) then -- Wind Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(7,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        if (MonID==506) then
            if (math.random(1,30) == 1) then
                world:gfx(2,Enemy.pos);
                Enemy:increaseAttrib("hitpoints",-1000);
                Monster.movepoints = Monster.movepoints - 40;
                return true;
            end
        end
        return false;
    elseif (MonID==507) or (MonID==508) then -- Earth Elementaries
        if (math.random(1,2) == 1) then
            world:gfx(5,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        if (MonID==508) then
            if (math.random(1,30) == 1) then
                world:gfx(6,Enemy.pos);
                Enemy.movepoints = Enemy.movepoints - 60;
                Monster.movepoints = Monster.movepoints - 20;
                return true;
            end
        end
        return false;
    elseif (MonID==509) or (MonID==510) then -- Spirit Elementaries
        if ((math.random(1,2) == 1) and (Monster:increaseAttrib("racetyp",0) == 25)) then
            world:gfx(46,Monster.pos);
        end
        if (math.random(1,15) == 1) then
            drop.SuddenWarp(Monster,Enemy,true);
            return true;
        end
        if (MonID==510) then
            if (math.random(1,15) == 1) then
                world:gfx(16,Monster.pos);
                Monster:increaseAttrib("hitpoints",2000);
                Monster.movepoints = Monster.movepoints - 20;
                return true;
            elseif (math.random(1,15) == 1) then
                racelist = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46};
                if (Monster:increaseAttrib("racetyp",0) ~= 25) then
                    Monster:setAttrib("racetyp",25);
                else
                    Monster:setAttrib("racetyp",racelist[math.random(1,#racelist)]);
                end
                oldpos = Monster.pos;
                Monster:warp(position(0,0,0));
                Monster:warp(oldpos);
                world:gfx(41,Monster.pos);
                Monster.movepoints = Monster.movepoints - 40;
                return true;
            end
        end
        return false;
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

    drop.Dropping(Monster);
end

return M
