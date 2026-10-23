local M = {}
local common = require("base.common")

function M.LookAtItem(user, item)
    common.InformNLS(user, "Auf der Pergamentrolle ist lediglich das Symbol eines Vogels abgebildet.",
        "Just the symbol of a bird has been painted on this scroll of parchment.")
end

function M.UseItem( Caster, Item )

    local faceto = Caster:get_face_to();

    local dx, dy;
    if (faceto == 0) then
        dy = -1; dx = 0;
    elseif (faceto == 2) then
        dy = 0; dx = 1;
    elseif (faceto == 4) then
        dy = 1; dx = 0;
    elseif (faceto == 6) then
        dy = 0; dx = -1;
    end;
    
    if dx == nil then return end
    local dist = 0;
    local TelePos = position(Caster.pos.x, Caster.pos.y, Caster.pos.z);

    repeat
        TelePos.x = TelePos.x + dx;
        TelePos.y = TelePos.y + dy;
        dist = dist + 1;
    until world:isItemOnField( TelePos ) or world:isCharacterOnField( TelePos ) or (dist >= 8);
    TelePos.x = TelePos.x - dx;
    TelePos.y = TelePos.y - dy;
    
    Caster:talkLanguage( CCharacter.say, CPlayer.german, "#me starrt konzentriert auf eine Pergamentrolle.", { showInChat = false });
    Caster:talkLanguage( CCharacter.say, CPlayer.english, "#me stares at a scroll of parchment intensely.", { showInChat = false });
                   
    world:gfx(41,Caster.pos);
    world:gfx(41,TelePos);
    world:makeSound(13,Caster.pos);
    world:makeSound(13,TelePos);
    
    local oldpos = Caster.pos;
    Caster:warp(TelePos);
    
    world:erase( Item, 1 );
    
    if not equapos(Caster.pos,TelePos) then
        world:sendMonitoringMessage("Possible Bug abuse by "..Caster.name..". Player tried to teleport from pos("..oldpos.x..","..oldpos.y..","..oldpos.z..") to pos("..TelePos.x..","..TelePos.y..","..TelePos.z..") but got placed at pos("..Caster.pos.x..","..Caster.pos.y..","..Caster.pos.z..")");
    end                        
end

return M
