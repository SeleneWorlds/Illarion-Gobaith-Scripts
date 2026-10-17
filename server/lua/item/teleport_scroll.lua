local M = {}
local common = require("base.common")

function M.LookAtItem(user, item)
    user:inform(M.teleportLookAt(user, item))
end

function M.UseItem(user, item, target, counter, param, state)
    return M.teleportUseItem(user, item, target, counter, param, state)
end

function M.teleportTarget( Item )
    local x, y, z;
    local dat = Item.data;
    z = dat - math.floor(dat/1024)*1024 - 500;    
    dat = math.floor(dat / 1024);
    y = dat - math.floor(dat/1024)*1024 - 500;
    dat = math.floor(dat / 1024);
    x = dat - math.floor(dat/1024)*1024 - 500;
    return position(x, y, z);
end

function M.teleportLookAt( User, Item )
    
    local dat = Item.data;
    local dz = dat - math.floor(dat/1024)*1024 - 500 - User.pos.z;
    
    if ( math.abs(dz) > 15) then
        return common.GetNLS( User, "Die Pergamentrolle glüht bläulich.", "The scroll of parchment glows blueish." );
    end;
    
    dat = math.floor(dat / 1024);
    local dy = User.pos.y - dat + math.floor(dat/1024)*1024 + 500;
    dat = math.floor(dat / 1024);
    local dx = dat - math.floor(dat/1024)*1024 - 500 - User.pos.x;

    local heightTxt, phi, dirTxt;
    if ( dz == 0 ) then
        heightTxt = common.GetNLS( User, "schwarze", "black" );
    elseif ( dz < 0 ) then
        heightTxt = common.GetNLS( User, "rote", "red" );
    else
        heightTxt = common.GetNLS( User, "blaue", "blue" );
    end;

    if ( dx == 0 ) and ( dy == 0 ) then
        return common.GetNLS( User, "Auf der Pergamentrolle ist lediglich ein "..heightTxt.."s Kreuz zu sehen.", "The scroll of parchment just displays a "..heightTxt.." cross." );
    end;

    if ( dx == 0 ) then
        if ( dy > 0 ) then
            phi = math.pi/2;
        else
            phi = math.pi + math.pi/2;
        end;
    elseif ( dx > 0 ) then
        if ( dy >= 0 ) then
            phi = math.atan( dy/dx );
        else
            phi = math.atan( dy/dx ) + 2*math.pi;
        end;
    else
        phi = math.atan( dy/dx ) + math.pi;
    end;
    
    if ( phi < math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Osten", "east" );
    elseif ( phi < 3*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Nordosten", "northeast" );
    elseif ( phi < 5*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Norden", "north" );
    elseif ( phi < 7*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Nordwesten", "northwest" );
    elseif ( phi < 9*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Westen", "west" );
    elseif ( phi < 11*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Südwesten", "southwest" );
    elseif ( phi < 13*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Süden", "south" );
    elseif ( phi < 15*math.pi/8 ) then
        dirTxt = common.GetNLS( User, "Südosten", "southeast" );
    else
        dirTxt = common.GetNLS( User, "Osten", "east" );
    end;
    
    return common.GetNLS( User, "Auf der Pergamentrolle ist lediglich ein "..heightTxt.."r Pfeil zu sehen, welcher gen "..dirTxt.." weist.", "The scroll of parchment just displays a "..heightTxt.." arrow, which points to the "..dirTxt.."." );
        
end

function M.teleportUseItem( User, SourceItem, TargetItem, Counter, Param , ltstate )
            if ( ltstate == nil or ltstate == Action.success ) then
                
                    local destination = M.teleportTarget( SourceItem );
                    User:warp(destination);
                    world:gfx(41,destination);
                    world:erase( SourceItem, 1 );

            elseif ( ltstate == Action.none ) then
                
                User:startAction( 100, 41, 10, 0, 0);
                
                local destination = M.teleportTarget( SourceItem );
                world:gfx(41,destination);
                    
                User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt konzentriert auf eine Pergamentrolle zu starren.");
                User:talkLanguage( CCharacter.say, CPlayer.english, "#me begins to stare at a scroll of parchment intensely.");
            
            elseif ( ltstate == Action.abort ) then
                
                User:talkLanguage(CCharacter.say, CPlayer.german, "#me wird abgelenkt.");
                User:talkLanguage(CCharacter.say, CPlayer.english,"#me gets distracted.");
                
            end
end

return M
