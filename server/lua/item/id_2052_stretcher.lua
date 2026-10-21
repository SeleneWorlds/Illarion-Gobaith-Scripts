local M = {}

-- Spannrahmen

-- Rohleder und Felle zu Leder

-- Arbeitscyclus: 2s - 5s

-- UPDATE common SET com_script='item.id_2052_stretcher' WHERE com_itemid = 2052;

local common = require("base.common")

function M.UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
    common.ResetInterruption( User, ltstate );
    if (Leatherlist==nil) then
        Leatherlist= { };
        Leatherlist[  69]=2547; --Rohleder in Leder
        Leatherlist[2586]=2547; --Fell in Leder
    end

    if common.Encumbrence(User) then -- Sehr streife Rüstung?
        common.InformNLS( User,
        "Deine Rüstung behindert am Leder gerben.",
        "Your armor disturbes while tanning leather." );
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
        User:talkLanguage(CCharacter.say, CPlayer.german, "#me unterbricht "..gText.." Arbeit.");
        User:talkLanguage(CCharacter.say, CPlayer.english,"#me interrupts "..eText.." work.");
        return
    end

    if not common.FitForWork( User ) then -- Kein Hunger
        return
    end

    for i, Leather in pairs(Leatherlist) do -- nach Rohleder und Fellen Absuchen
        if (User:countItemAt("belt",i)>0) then -- Rohmaterial gefunden
            if ( ltstate == Action.none ) then -- Arbeit nicht gestartet -> Starten
                --User:startAction( GenWorkTime(User), 0, 0, 0, 0 );
                User:startAction( M.GenWorkTime(User), 0, 0, 14, 25 );
                User:talkLanguage( CCharacter.say, CPlayer.german, "#me beginnt Leder zu gerben.");
                User:talkLanguage( CCharacter.say, CPlayer.english, "#me starts to tan leather.");
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
                    "Du bekommst ein paar feine Haare in den Mund und mußt husten.",
                    "A cloud of fine hairs makes you cough.");
                elseif ( selectMessage == 3 ) then
                    common.InformNLS(User,
                    "Du überprüfst kurz die bereits gegerbte Stelle auf Unebenheiten",
                    "You briefly check the quality of the leather.");
                else
                    common.InformNLS(User,
                    "Du entfernst kurz Fell- und Knochenreste vom Leder bevor du weitermachst.",
                    "You briefly removes hair- and bonesplits from the leather, before you continue.");
                end
                return
            end;

            User:eraseItem(i,1); -- Rohleder oder Felle entfernen
            notCreated = User:createItem(Leather,1,3,0, 33); -- Leder erstellen
            if ( notCreated > 0 ) then -- Zu viele Items erstellt --> Char überladen
                world:createItemFromId( Leather, notCreated, User.pos, true, 3 ,0, 33);
                common.InformNLS(User,
                "Du kannst nichts mehr halten.",
                "You can't carry any more.");
            else
                User:startAction( M.GenWorkTime(User), 0, 0, 0, 0 );
            end
			-- Lernen wird noch eingebaut
            --User:learn(2,"dying and tanning",2,20); -- Lernen
            common.GetHungry( User, 200 ); -- Hunger
            return
        end
    end
    if (ltstate ~= Action.success) then
        common.InformNLS( User,
        "Du hast kein Rohleder und keine Felle die du gerben könntest.",
        "You don't have any rawleather or furs you could tan." );
    end
end

-- Arbeitszeit generieren
function M.GenWorkTime(User)
    local Attrib = User:increaseAttrib("dexterity",0); -- Geschicklichkeit: 0 - 20
	local Skill = 1;
    --local Skill  = User:getSkill("dying and tanning");     -- Färben und Gerben: 0 - 100

    return math.floor(-0.3 * (Attrib + Skill) + 100);
end

return M
