local init
local drop = require("monster.base.drop")
local base_lookat = require("monster.base.lookat")
local base_messages = require("base.messages")
local M = {}
function M.ini(Monster)

init=true;
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base_messages.Messages();
msgs:addMessage("Bei der Macht des Waldes!", "By the power of nature!");
msgs:addMessage("Die Götter mögen mir beistehen.", "May the gods be with me.");
msgs:addMessage("#mes Augen blitzen vor verzweifelter Wut auf.", "#me's eyes flash in desperate fury.");
msgs:addMessage("#me bewegt sich mit geschwinden Schritten über den Boden.", "#me moves with wide steps over the ground.");
msgs:addMessage("Oh, welch Schicksal, dass ich eine Waffe gegen euch erheben muss. Verzeiht mir.", "Oh, what fate is this that I have to raise a weapon against you. Forgive me!");
msgs:addMessage("Die Gerechtigkeit wird euch einholen, sei es heute, sei es in hundert Jahren.", "Justice will overcome you, be it now, be it in a hundred years.");
msgs:addMessage("Ich fürchte den Tod nicht, er kann auch eine Erlösung sein, verglichen mit einem Leben in Feigheit.", "I do not fear death, for it is far superior to a life in fear.");
msgs:addMessage("Ihr mögt mich heute niederstrecken, doch wird man meine Taten besingen, wenn der Name eures Volkes bereits vergessen wurde.", "You may slay me today, but my deeds will be sung about when the name of your people will be long forgotten.");
msgs:addMessage("Mein Volk wird Rache an eurem Stamm nehmen bis die siebte Generation eurer Brut vertilgt ist.", "My people will take revenge on your tribe until the seventh generation of your offspring has passed.");
msgs:addMessage("Die, die ihre Hand gegen das unsterbliche Volk erheben, bringen Unheil über sich.", "Those who raise their weapon against the eternal people bring doom upon themselves.");

end

function M.enemyNear(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if (MonID==33) then
        return ( drop.SuddenWarp(Monster,Enemy,true) or drop.SuddenWarp(Monster,Enemy,true) or drop.SuddenWarp(Monster,Enemy,true) or drop.CastMonMagic(Monster,Enemy,6,{1000,2000},{{4,5},{9,5},{51,5}},{},40,1,{25,60}) );
    elseif (MonID==34) then
        return ( drop.CastMonster(Monster,Enemy,10,{121,121,121,121,121,121,121,81,81,81,81,225,222,222},30) );
    else
        return false;
    end
end

--

function M.enemyOnSight(Monster,Enemy)

    if init==nil then
        M.ini(Monster);
    end

    drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    local MonID=Monster:get_mon_type();
    if drop.DefaultSlowdown( Monster ) then
        return true
    elseif (MonID==33) then
        return ( drop.CastMonMagic(Monster,Enemy,3,{1200,2500},{{4,5},{9,5},{51,5}},{},40,1,{25,60}) );
    elseif (MonID==34) then
        return ( drop.CastMonster(Monster,Enemy,5,{121,121,121,121,121,121,121,81,81,81,81,225,222,222},30) );
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
