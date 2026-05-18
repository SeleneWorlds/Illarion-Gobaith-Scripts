local M = {}
local UseItem, GenWorkTime

-- Webstuhl ( 169 )

-- Wollkn�ule  --> grauer Stoff

-- Arbeitscyclus: 1s - 4s
-- Zus�tzliches Werkzeug: Schere ( 6 )

-- UPDATE common SET com_script='item.id_169_loom' WHERE com_itemid IN (169);

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption( User, ltstate );
    if ( ltstate == Action.abort ) then
        if (User:increaseAttrib("sex",0) == 0) then
            gText = "seine";
            eText = "his";
        else
            gText = "ihre";
            eText = "her";
        end
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.");
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.");
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        return
    end
    
    if common.Encumbrence(User) then -- Sehr streife R�stung?
        common.InformNLS( User,
        "Deine R�stung behindert dich bei deiner Arbeit.",
        "Your armor disturbs you while working." );
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then
        common.TurnTo( User, SourceItem.pos );
    end
    
    if not common.FitForWork( User ) then
        return
    end
    
    if (User:countItemAt("body",6)==0) then -- Schere
        common.InformNLS( User,
        "Du brauchst eine Schere, um hir zu arbeiten.",
        "You need scissors to work here." );
        return
    end
    
    local Tool = User:getItemAt(CCharacter.left_tool); -- Item in Linker Hand auslesen
    if ((Tool == nil) or (Tool.id ~= 6)) then -- Wenn das Item nicht die Zange ist
        Tool = User:getItemAt(CCharacter.right_tool); -- In anderer Hand nachsehen
    end
    
    if common.ToolBreaks( User, Tool, true ) then -- Schere
        common.InformNLS( User, 
        "Die Schere wird stumpf.", 
        "The scissors went blunt." );
        return
    end
    
    if (User:countItemAt("belt",170) < 5) then
        common.InformNLS( User, 
        "Du brauchst ein B�del Wolle in deinem G�rtel, um Stoff herzustellen.", 
        "You need some wool in your belt to make cloth." );
        return
    end
    
    if ( ltstate == Action.none ) then
        User:startAction( GenWorkTime(User), 0, 0, 0, 0 );
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt, Stoff zu weben.");
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to weave cloth.");
        return
    end
    
    if common.IsInterrupted( User ) then
        common.InformNLS(User,
        "Dir reisst der Faden beim weben durch.",
        "The yarn rips while weaving");
        return
    end
    
    User:eraseItem(170,5); --takes 5 wool to produce 1 unit of cloth
    local notcreated = User:createItem(176,1,333,0);
    if (notcreated > 0) then
        world:createItemFromId( 176, 1, User.pos, true, 333 ,0);
        common.InformNLS(User,
        "Du kannst nichts mehr halten.",
        "You can't carry any more.");
    else
        User:startAction( GenWorkTime(User), 0, 0, 0, 0 );
    end
    
    common.GetHungry( User, 100 );
    User:learn( 2, "tailoring", 2, 10 );
    
end -- function

-- Arbeitszeit generieren
function M.GenWorkTime(User)
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
    local Skill  = math.min(100,User:getSkill("tailoring")*10);     -- Schneidern: 0 - 100
    
    return math.floor(-0.25 * (Attrib + Skill) + 40);
end

return M
