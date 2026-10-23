local M = {}

-- Schleifstein ( 270 )

-- Rohe Edelsteine  --> geschliffene Edelsteine

-- Arbeitscyclus: 1s - 5s

-- UPDATE common SET com_script='item.id_270_grindstone' WHERE com_itemid IN (270);

local common = require("base.common");

function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption( User, ltstate )
    if (GemList==nil) then
        GemList= { };
        GemList[251]={ 7,197}; --Amethyst
        GemList[252]={ 5,283}; --Schwarzstein
        GemList[253]={10,284}; --Blaustein
        GemList[254]={60,285}; --Diamant
        GemList[255]={30, 46}; --Rubine
        GemList[256]={15, 45}; --Smaragd
        GemList[257]={45,198}; --Topas
    end
    
    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert dabei Edelsteine zu schleifen.",
        "Your armor disturbes you grinding gems." );
        return
    end
    
    if not common.CheckItem( User, SourceItem ) then -- Sicherheitscheck
        return
    end
    
    if not common.IsLookingAt( User, SourceItem.pos ) then -- Blickrichtung
        common.TurnTo( User, SourceItem.pos ); -- Drehen wenn nötig
    end
    
    if ( ltstate == Action.abort ) then -- Arbeit unterbrochen
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

    if not common.FitForWork( User ) then -- Kein Hunger
        return
    end
    
    for i, Gem in pairs(GemList) do -- Edelsteine Absuchen
        if (User:countItemAt("belt",i)>0) then -- Edelsteine gefunden
            if ( ltstate == Action.none ) then -- Arbeit nicht gestartet -> Starten
                User:startAction( M.GenWorkTime(User,Gem[1]), 0, 0, 0, 0 );
                User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Edelsteine zu schleifen.", { showInChat = false });
                User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to cut gemstones.", { showInChat = false });
                return                
            end
            if common.IsInterrupted( User ) then
                common.InformNLS(User,
                "Der "..world:getItemName(Gem[2],0).." rutscht dir aus der Hand und fällt zu Boden. Du musst kurz suchen ehe du den Stein wieder findest.",
                "The "..world:getItemName(Gem[2],1).." slips out of your hand and falls down to the ground. You have to search for a moment to find it again.");
                return
            end
            User:eraseItem(i,1); -- Rohen Edelstein entfernen
            if M.CheckSuccess(User,Gem[1]) then -- Erfolgsprüfung
                local notCreated = User:createItem(Gem[2],1,3,0, 33); -- geschliffenen Edelstein erstellen
                if ( notCreated > 0 ) then -- Zu viele Items erstellt --> Char überladen
                    world:createItemFromId( Gem[2], notCreated, User.pos, true, 3 ,0, 33);
                    common.InformNLS(User,
                    "Du kannst nichts mehr halten.",
                    "You can't carry any more.");
                else
                    User:startAction( M.GenWorkTime(User,Gem[1]), 0, 0, 0, 0 );
                end
            else -- kein Erfolg
                common.InformNLS(User,
                "Der "..world:getItemName(Gem[2],0).." zerbröckelt in deinen Händen",
                "The "..world:getItemName(Gem[2],1).." breaks in your hands.");
                User:startAction( M.GenWorkTime(User,Gem[1]), 0, 0, 0, 0 );
            end
            User:learn(2,"gemcutting",2,100); -- Lernen
            common.GetHungry( User, 200 ); -- Hunger
            return
        end
    end
    if (ltstate ~= Action.success) then
        common.InformNLS( User, 
        "Du hast keinen Rohen Edelstein den du schleifen könntest.", 
        "You don't have a raw gemstone you could cut." );
    end
end

-- Erfolgsprüfung
function M.CheckSuccess(User,Difficulty) -- Erfolgsprüfung
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
    local Skill  = User:getSkill("gemcutting");     -- Edelstein schleifen: 0 - 100
    
    local Try = 0.5 * (Attrib + Skill - Difficulty) + 20;
    
    if (math.random(0,100) <= Try) then
        return true;
    else
        return false;
    end
end

-- Arbeitszeit generieren
function M.GenWorkTime(User,Difficulty)
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
    local Skill  = User:getSkill("gemcutting");     -- Edelstein schleifen: 0 - 100
    
    return math.floor(-0.3 * (Attrib + Skill - Difficulty) + 50);
end

return M
