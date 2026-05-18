local M = {}

--Name:        Farrel Schleifer
--Race:        Mensch
--Town:        Newbie Insel
--Function:    Edelsteinschleifen beibringen
--Position:    x=? y=? z=?
--Facing:      south
--Last Update: 18/06/08
--Update by:   Silverwolf

local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Bitte nicht anfassen");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Please don't touch.");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end
 
    autonpcfunctions.InitTalkLists()

    thisNPC:increaseSkill(1,"common language",100);

	-- ********* START DYNAMIC PART ********

    -- Small talk
    --
    autonpcfunctions.AddTraderTrigger("hello","Be greeted stranger! I'm "..thisNPC.name..", the gem-cutter of this island. If you want, I show you how to become a gem-tailer.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("hallo","Sei gegrüßt Fremder! Ich bin "..thisNPC.name..", der beste Edelsteinschleifer auf der Insel. Wenn du möchtest, zeige ich dir, wie du ein guter Edelsteinschleifer wirst.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddTraderTrigger("who you","I am "..thisNPC.name..", the best gem-cutter of this island. If you want, I show you how to become a good gem-trailer.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddTraderTrigger("wer du","Sei gegrüßt Fremder! Ich bin "..thisNPC.name..", der beste Edelstenerscheifer auf der Insel. Wenn du möchtest, zeige ich dir, wie du ein guter Edelsteinschleifer wirst.");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("was ihr");
    autonpcfunctions.AddTraderTrigger("bye","Bye, bye.");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalText("Be well!");
    autonpcfunctions.AddAdditionalText("Farewell, until we meet again.");
    autonpcfunctions.AddTraderTrigger("tsch[üu][ßs]","Auf Wiedersehen.");
    autonpcfunctions.AddAdditionalTrigger("tschue[sß]");
    autonpcfunctions.AddAdditionalTrigger("leb wohl");
    autonpcfunctions.AddAdditionalTrigger("wiederseh");
    autonpcfunctions.AddAdditionalTrigger("auf bald");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalText("Tschüss auch.");
    autonpcfunctions.AddAdditionalText("Leb wohl, bis zum nächsten Mal.");
    autonpcfunctions.AddTraderTrigger("hilf","Wenn du möchtest kann ich dir zeigen, wie man Edelsteine schleift. Möchtest du das?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("help","If you want, I can show you how to cut gems. D'you want that?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("reset","Status reset!");
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 0 - 1 (start teaching)
    --
    autonpcfunctions.AddTraderTrigger("trail(?)","You want to learn how to cut gems? I am very pleased to hear that. Want to start right away?");
    autonpcfunctions.AddAdditionalTrigger("craft");
    autonpcfunctions.AddAdditionalTrigger("teach");
    autonpcfunctions.AddAdditionalTrigger("learn");
    autonpcfunctions.AddAdditionalTrigger("show");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("schleifer","Du möchtest also lernen, wie man Edelsteine schleift? Das freut mich sehr. Wollen wir gleich anfangen?");
    autonpcfunctions.AddAdditionalTrigger("handwerk");
    autonpcfunctions.AddAdditionalTrigger("lern");
    autonpcfunctions.AddAdditionalTrigger("lehr");
    autonpcfunctions.AddAdditionalTrigger("zeig");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",1);

    -- Starthilfe
    --
    autonpcfunctions.AddTraderTrigger(".+","Sag \"Hilfe\" wenn du nicht weiter weißt.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Say \"help\" if you don't know, what to do.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",0);

    -- Status: 1 -> 10 (Zange zumm Edelstein schleifen)
    --
    autonpcfunctions.AddTraderTrigger("yes","Excellent. Firstly, we need tongs to hold the gems into and for sure gems. Stay directly in front of a gem-cutter and 'use' the tongs. Just try it! Come again when you have at least 10 cutted gems.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",2140);
    autonpcfunctions.AddConsequence("item",197);
    autonpcfunctions.AddTraderTrigger("ja","Hervorragend! Als erstes brauchen wir eine Zange, um die Edelsteine darin zu halten und nätürlich rohe Edelsteine. Stell dich einfach direkt vor den Edelsteinschleifer und 'benutze' die Zange. Komm wieder wenn du mindestens 10 geschiffene Edelsteine hast.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",2140);
    autonpcfunctions.AddConsequence("item",197);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 1 (eine andere Anwort)
    --
    autonpcfunctions.AddTraderTrigger(".+","I ask you if I should teach you to cut gems. Just say \"yes\" or \"no\".");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger(".+","Ich habe dich gefragt, ob ich dir das Edelsteinschleifen beibringen soll...sag einfach \"ja\", oder \"nein\".");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",1);

    -- Status: 10 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must stay directly in front of the gem-cutter and then 'use' the tongs. With a bit training it would work fine.");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du musst dich direkt vor den Edelsteinschleifer stellen und dann die Zange 'benutzen'. Mit etwas Übung wirst du es sicher schaffen.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",11);

    -- Status: 11 (Auf Wunsch wirden Edelsteine gegeben)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here you go. This should be enough for now. If you want to learn the melt ore and coal to ingots, just go to my friend the blacksmith. His name is Arax Ironheart. You'll friend him in his blacksmith over there.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",22);
    autonpcfunctions.AddConsequence("item",21);
    autonpcfunctions.AddTraderTrigger("ja","Hier, bitte sehr. Das sollte erstmal reichen. Wenn du lernen willst, das Erz und die Kohle zu Eisenbarren zu schmelzen, geh einfach zu meinem Freund dem Schmied. Sein Name ist Arax Ironheart. Du wirstt ihn in seiner Schmiede dort drüben finden.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",22);
    autonpcfunctions.AddConsequence("item",21);
    autonpcfunctions.AddTraderTrigger("no","Yes, retry it. That is the right way.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddTraderTrigger("nein","Ja, versuch es ruhig selbst nochmal. Das ist der richtige Weg.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);
	
        -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
    TradStdLang=0;
    --common language=0
    --human language=1
    --dwarf language=2
    --elf language=3
    --lizard language=4
    --orc language=5
    --halfling language=6
    --fairy language=7
    --gnome language=8
    --goblin language=9
    --ancient language=10

    autonpcfunctions.increaseLangSkill(TradSpeakLang);
    thisNPC.activeLanguage=TradStdLang;
end

function M.nextCycle()  -- ~10 times per second
    M.initializeNpc();
    autonpcfunctions.SpeakerCycle();
end

function M.receiveText(texttype, message, originator)
    if autonpcfunctions.BasicNPCChecks(originator,2) then
        if autonpcfunctions.LangOK(originator,TradSpeakLang) then
             local state = NPCStatus[originator.id];
             if (state == 50) or (state == 51) then
                 if M.CountItemsWithQuality(originator,196,100,-1) > 0 then
                     NPCStatus[originator.id] = 51;		-- unfinished
                 elseif M.CountItemsWithQuality(originator,196,99,1) > 0 then
                     NPCStatus[originator.id] = 52;		-- finished
		 else
		     NPCStatus[originator.id] = 50;
                 end
            end
            autonpcfunctions.TellSmallTalk(message,originator);
    	else
            autonpcfunctions.Confused(
            	"#me sieht dich leicht verwirrt an",
            	"#me looks at you a little confused"
            );
        end
    end
end

function M.CountItemsWithQuality( Character, ItemID, Quality, Compare )
    local count = 0;
    local i;
    local item;
    for i=0,17 do
        item = Character:getItemAt(i);
    	if item.id == ItemID then
    	    if Compare == 0 or Compare == nil then
    	        if item.quality == Quality then
    	            count = count+1;
    	        end
    	    elseif Compare == 1 then
    	        if item.quality > Quality then
    	            count = count+1;
    	        end
    	    elseif Compare == -1 then
    	        if item.quality < Quality then
    	            count = count+1;
    	        end
    	    end
    	end
    end
    local container = nil;
    container = Character:getBackPack();
    if container then
        local worked = false;
        for i=1,100 do
            worked, item = container:viewItemNr(i);
            if worked then
                if item.id == ItemID then
                    if Compare == 0 or Compare == nil then
                        if item.quality == Quality then
                            count = count+1;
                        end
                    elseif Compare == 1 then
                        if item.quality > Quality then
                            count = count+1;
                        end
                    elseif Compare == -1 then
                        if item.quality < Quality then
                            count = count+1;
                        end
                    end
                end
            else
                break;
            end
        end
    end
    return count;
end

return M
