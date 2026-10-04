local M = {}

-- Presse

-- Distel(141) zu Öl (390)
-- Arbeitscyclus: 3s

-- UPDATE common SET com_script='item.id_44_squeezer' WHERE com_itemid IN (44);

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption( User, ltstate );
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert beim arbeiten.",
        "Your armor disturbes while working." );
        return
    end

    if not common.CheckItem( User, SourceItem ) then -- Sicherheitscheck
        return
    end

    if not common.IsLookingAt( User, SourceItem.pos ) then -- Blickrichtung
        common.TurnTo( User, SourceItem.pos ); -- Drehen wenn nötig
    end

    if not common.FitForWork( User ) then -- Kein Hunger
        return
    end

    if ( ltstate == Action.abort ) then -- Arbeit unterbrochen
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
    

    if (User:countItemAt("all",141)>1) then
        if ( ltstate == Action.none ) then -- Arbeit nicht gestartet -> Starten
            User:startAction( 30, 0, 0, 0, 0 );
            User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Öl zu pressen.");
            User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to squeeze out oil.");
            return;
        end
        if common.IsInterrupted( User ) then
            local selectMessage = math.random(1,1);
            if ( selectMessage == 1 ) then
                common.InformNLS(User,
                "Du wischst dir den Schweiß von der Stirn.",
                "You wipe sweat off your forehead.");
            end
            return;
        end
        User:eraseItem(141,2);
        local notCreated = User:createItem(390,1,333,0);
        if ( notCreated > 0 ) then -- Zu viele Items erstellt --> Char überladen
            world:createItemFromId( 390, notCreated, User.pos, true, 333 ,0);
            common.InformNLS(User,
            "Du kannst nichts mehr halten.",
            "You can't carry any more.");
        else
            User:startAction( 30, 0, 0, 0, 0 );
        end
        common.GetHungry( User, 300 );
    else
        common.InformNLS(User,
        "Du benötigst schwarze Disteln um Öl zu pressen.",
        "You need black thistle to sqeeze out oil.");
    end
end

return M
