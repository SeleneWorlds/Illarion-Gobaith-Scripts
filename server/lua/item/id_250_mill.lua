local M = {}

-- Mühlstein ( 250 )

-- Getreidekörner  --> Mehl

-- Arbeitscyclus: 0.5s - 3s

-- UPDATE common SET com_script='item.id_250_mill' WHERE com_itemid IN (250);

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
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.", { showInChat = false });
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.", { showInChat = false });
        return
    end
    
    if common.Encumbrence(User) then -- Durch Steife Rüstung behindert
        common.InformNLS( User,
        "Deine Rüstung behindert Dich beim Mehl Mahlen.",
        "Your armor disturbs you when grinding grain" );
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then
        common.TurnTo( User, SourceItem.pos );
    end
    
    if not common.FitForWork( User ) then
        return
    end
    
    if (User:countItemAt("belt",259) == 0) then
        if (ltstate ~= Action.success) then
            common.InformNLS( User, 
            "Du hast nichts was du hier zermahlen könntest.", 
            "You have nothing that you can grind here." );
        end
        return
    end 
    
    if ( ltstate == Action.none ) then
        User:startAction( M.GenWorkTime(User), 0, 0, 0, 0);
        User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Getreide zu mahlen.", { showInChat = false });
        User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to grind grain.", { showInChat = false });
        return
    end
    
    if common.IsInterrupted( User ) then
        local selectMessage = math.random(1,4);
        if ( selectMessage == 1 ) then
            common.InformNLS(User,
            "Du wischst dir den Schweiß von der Stirn.",
            "You wipe sweat off your forehead.");
        elseif ( selectMessage == 2 ) then
            common.InformNLS(User,
            "Du klopfst dir das Mehl aus der Kleidung, da du das Gefühl hast wie ein Geist auszusehen.",
            "You beat the flour out of your clothes, since you were starting to look like a ghost.");
        elseif ( selectMessage == 3 ) then
            common.InformNLS(User,
            "Du säuberst kurz den Mühlstein um eine bessere Qualität des Mehls zu erreichen.",
            "You clean the millstone to ensure good quality flour.");
        else
            common.InformNLS(User,
            "Gerade noch kannst du verhindern, dass ein Stein, der sich wohl ins Korn gemogelt hatte, in den Mühlstein fällt.",
            "You just barely manage to stop a little rock amongst the grains from falling into the millstone.");
        end
        
        return
    end
    
    User:eraseItem(259,1);
    notCreated = User:createItem(2,1,3,0, 33);
    if (notCreated > 0) then
        world:createItemFromId( 2, 1, User.pos, true, 3 ,0, 33);
        common.InformNLS(User,
        "Du kannst nichts mehr halten.",
        "You can't carry any more.");
    else
        User:startAction( M.GenWorkTime(User), 0, 0, 0, 0);
    end
    common.GetHungry( User, 200 );
    User:learn( 2, "baking", 2, 10 );
end -- function UseItem()

-- Arbeitszeit Generieren
function M.GenWorkTime(User)
    local Skill  = math.min(100,User:getSkill("baking")*10);
    local Attrib = User:increaseAttrib( "dexterity", 0 );
    
    return math.floor( -0.2 * (Skill+Attrib) + 30);
end

return M
