local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local quest_aquest28 = require("quest_aquest28") -- the quest file for the Farmer quest
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("#me bewegen sich in der Luft auf und ab.", "#me hang in the air bobbing up and down.");
msgs:addMessage("#me brummen einfach herum, wie es Insekten mit Fl�geln so tun.", "#me's simple buzzing drone leads one to consider the life of a winged insect.");
msgs:addMessage("#me fliegen ziellos vor und zur�ck.", "#me fly back and forth aimlessly.");
msgs:addMessage("#me kreisen wild umher.", "#me spin furiously.");
msgs:addMessage("#me landen auf der Erde und bleiben dort nur f�r einen Augenblick.", "#me land on the ground for a moment");
msgs:addMessage("#me schwirren umher.", "#me buzz around.");
msgs:addMessage("#me sind auf Streifzug.", "#me prowl around.");
msgs:addMessage("Bzzzzz!", "Bzzzzz!");
msgs:addMessage("Summ, summ.", "Buzz, buzz.");

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
    if (MonID==131) then
        -- Drops
    elseif (MonID==132) then
        -- Drops
    elseif (MonID==133) then
        player_list = world:getPlayersInRangeOf(Monster.pos, 5);
        if (player_list[1]~=nil) then
            User = getCharForId(player_list[1].id);  --create a save copy of the char struct
			User:inform("blub, monster dead");
			local cow, task, counter = quest_aquest28.split_questdata(User);
			counter = counter - 1;
			task = 0; --reset task
			quest_aquest28.glue_questdata(User, cow,task,counter); --put the quest data with changes together

			aquest28Effect = CLongTimeEffect(32,100); -- create new effect and initialize with nextcalled = 1s
			User.effects:addEffect(aquest28Effect); -- add effect #3         2
		end
		--Drops
    elseif (MonID==134) then
        --Drops
    elseif (MonID==135) then
        --Drops
    elseif (MonID==136) then
        -- Drops
    elseif (MonID==137) then
        --Drops
    elseif (MonID==138) then
        --Drops
    elseif (MonID==139) then
        --Drops
    else
        --Drops
    end
    drop.Dropping(Monster);
end

return M
