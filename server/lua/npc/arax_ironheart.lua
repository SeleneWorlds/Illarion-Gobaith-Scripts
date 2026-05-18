local M = {}

--Name:        Arax Ironheart 
--Race:        Zwerg
--Town:        Newbie Insel
--Function:    Schmieden beibringen
--Position:    x=-112 y=-128 z=0
--Facing:      south
--Last Update: 13/06/2008
--Update by:   Kadiya

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
    autonpcfunctions.AddTraderTrigger("#me","");
    autonpcfunctions.AddTraderTrigger("hello","G'day stranger! I am "..thisNPC.name..", a retired blacksmith from Silverbrand. I can teach ye' some things' of my craft, smithing, aye!");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("hallo","Tag Fremder! Ich bin "..thisNPC.name..", 'n Schmied im Ruhestand aus Silberbrand, der Stadt der Zwerge. Ich kann dir n' paar Sachen von meinem Handwerk beibringn, aye!");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddTraderTrigger("who you","I am "..thisNPC.name..", a retired blacksmith from Silverbrand. I can teach ye' some things' of my craft, smithing, aye!");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddTraderTrigger("wer du","Ich bin "..thisNPC.name..", 'n Schmied im Ruhestand aus Silberbrand, der Stadt der Zwerge. Ich kann dir n' paar Sachen von meinem Handwerk beibringn, aye!");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("was ihr");
    autonpcfunctions.AddTraderTrigger("dank","Bitte sehr.");
    autonpcfunctions.AddTraderTrigger("thank","You're welcome.");
    autonpcfunctions.AddTraderTrigger("bye","Arr...Bye.");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalText("Farewell");
    autonpcfunctions.AddAdditionalText("Farewell, until we meet again.");
    autonpcfunctions.AddTraderTrigger("tsch[üu][ßs]","Mach's gut, bis zum nächstn Mal, aye.");
    autonpcfunctions.AddAdditionalTrigger("tschue[sß]");
    autonpcfunctions.AddAdditionalTrigger("leb wohl");
    autonpcfunctions.AddAdditionalTrigger("wiederseh");
    autonpcfunctions.AddAdditionalTrigger("auf bald");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalText("Tschüss auch.");
    autonpcfunctions.AddAdditionalText("Wiedersehn!.");
    autonpcfunctions.AddTraderTrigger("hilf","Hilfe? Ick könnt dir zeigen, wie man schmiedet...Interesse?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("help","Help? I could show you how to smith. Interested?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("reset","Status reset!");
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 0 - 1 (start teaching)
    --
    autonpcfunctions.AddTraderTrigger("smith","What? You want to learn how to smith? Arr...a pleasure to hear that! Let's start right away, ready?");
    autonpcfunctions.AddAdditionalTrigger("craft");
    autonpcfunctions.AddAdditionalTrigger("teach");
    autonpcfunctions.AddAdditionalTrigger("learn");
    autonpcfunctions.AddAdditionalTrigger("show");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("schmied","Was? Du willst wissen wie man schmiedet? Arr...das freu mich zu hören! Lass uns gleich anfangen, bereit?");
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

    -- Status: 1 -> 10 (Schmelzzange, Eisen und Kohle geben. Schmelzen erklären.)
    --
    autonpcfunctions.AddTraderTrigger("yes","First I show you how to smelt ore. Here you can have a crucible-pincer and a handfull of coal and iron ore. Put the crucible-pincer in your hands and the coal and the ore 'in' your belt. Stand in front of the furnace and 'use' the furnace. Come back, when you have at least 10 iron ingots. If you already know how to smelt ore just say \"continue\".");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",2751,1,999,0);
    autonpcfunctions.AddConsequence("item",21,10,333,0);
    autonpcfunctions.AddConsequence("item",22,10,333,0);
    autonpcfunctions.AddTraderTrigger("ja","Das erste, was ein Schmied lernen muss ist, wie man Erze einschmilzt. Hier hast du eine Tiegelzange und eine handvoll Kohle und Eisenerz. Nimm die Tiegelzange in die Hand und die Kohle und das Eisenerz 'in' den Gürtel. Dann stell dich vor die Esse dort und 'benutze' die Esse. Komm wieder, wenn du 10 Eisenbarren geschmolzen hast. Wenn du schon weißt, wie man Eisenbarren einschmilzt sag \"Weiter\".");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",2751,1,999,0);
    autonpcfunctions.AddConsequence("item",21,10,333,0);
    autonpcfunctions.AddConsequence("item",22,10,333,0);
    autonpcfunctions.AddTraderTrigger("no","Arr...Allright. Come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("nein","Arr...In Ordnung. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 1 (eine andere Anwort)
    --
    autonpcfunctions.AddTraderTrigger(".+","I asked you whether I should teach you smithing. Just say \"yes\" or \"no\".");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger(".+","Ich habe dich gefragt, ob ich dir das Schmieden beibringen soll...sag einfach \"ja\", oder \"nein\".");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",1);

    -- Status: 10 (Weiter)
    --
    autonpcfunctions.AddTraderTrigger("continue","Arr...you already know how to smelt ironore? Well, I can give you iron ingots instead, you'll be needing them. Agreed?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);
    autonpcfunctions.AddTraderTrigger("weiter","Arr...du weiß also schon, wie man Eisenbarren herstellt? Auch gut, ich geb dir einfach die Eisenbarren, die du für das Schmieden brauchst. Einverstanden?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);

    -- Status: 10 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Arr...doesn't the furnace want to work? Check that you have the crucible-pincer in your hands and the coal and the ore 'in' your belt. Stand directly in front of the furnace and 'use' the furnace to start smelting. If it still doesn't work, I can give you some iron ingots, so that we can continue. Do you want?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);
    autonpcfunctions.AddTraderTrigger("hilf","Arr...will die Esse nicht so wie du, mein Freund? Überprüf nochmal, ob du wirklich die Tiegelzange in der Hand und Kohle sowie Eisenerz 'im' Gürtel hast. Dann einfach einmal die Esse 'benutzen' und schon sollte das Einschmelzen wie von selbst gehen. Wenns gar net klappen will, kann ich dir aber auch einfach ein paar Eisenbarren geben. Willste welche haben?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);

    -- Status: 11 (Auf Wunsch wird Eisenbarren gegeben)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here you have some. Well...can we continue then?");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",2535,10,333,0);
    autonpcfunctions.AddTraderTrigger("ja","Hier, haste welche. Wollen wir dann weitermachen?");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",2535,10,333,0);
    autonpcfunctions.AddTraderTrigger("no","It's up to you, try again if you want..");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddTraderTrigger("nein","Wie du willst, versuch es ruhig selbst nochmal.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);

    -- Status: >=1 (Eine neue Tiegelzange)
    --
    autonpcfunctions.AddTraderTrigger("pincer","Did you need another crucible-pincer ? Here you can have one.");
    autonpcfunctions.AddAdditionalTrigger("crucible");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",2751,"all","=",0);
    autonpcfunctions.AddConsequence("item",2751,1,999,0);
    autonpcfunctions.AddTraderTrigger("zange","Brauchst du eine neue Tiegelzange? Hier hast du eine.");
    autonpcfunctions.AddAdditionalTrigger("tiegel");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",2751,"all","=",0);
    autonpcfunctions.AddConsequence("item",2751,1,999,0);

    -- Status: 10 Mehr Eisenerz
    --
    autonpcfunctions.AddTraderTrigger("eisen","Du brauchst mehr Eisenerz, richtig? Hier bitte sehr.");
    autonpcfunctions.AddAdditionalTrigger("erz");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",22,"all","<",2);
    autonpcfunctions.AddConsequence("item",22,10,333,0);
    autonpcfunctions.AddTraderTrigger("iron","You need more iron ore, right? Here you are.");
    autonpcfunctions.AddAdditionalTrigger("ore");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",22,"all","<",2);
    autonpcfunctions.AddConsequence("item",22,10,333,0);

    -- Status: 11 Mehr Kohle
    --
    autonpcfunctions.AddTraderTrigger("kohle","Du brauchst mehr Kohle, richtig? Hier bitte sehr.");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",21,"all","<",2);
    autonpcfunctions.AddConsequence("item",21,10,333,0);
    autonpcfunctions.AddTraderTrigger("coal","You need more coal, right? Here you are.");
    autonpcfunctions.AddAdditionalTrigger("ore");
    autonpcfunctions.AddCondition("state",">=",10);
    autonpcfunctions.AddCondition("item",21,"all","<",2);
    autonpcfunctions.AddConsequence("item",21,10,333,0);

    -- Status: 10 (Noch zu wenig Eisenbarren)
    --
    autonpcfunctions.AddTraderTrigger(".+","You still have too few iron ingots. Come back, when you have smelted at least 10 ingots.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",2535,"all","<",10);
    autonpcfunctions.AddTraderTrigger(".+","Du hast noch zu wenig Eisenbarren. Komm wieder, wenn du mindestens 10 Barren geschmolzen hast.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",2535,"all","<",10);
    
    -- Status: 10 -> 2 (Die Eisenbarren sind da - weitermachen?)
    --
    autonpcfunctions.AddTraderTrigger(".+","Great! Ye did it! One more hint: It also possible to smelt copper, gold and merinium ingots. But at first you need mostly iron ingots. The next step is to smith the iron ingot. Are ye ready to continue?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",2535,"all",">",9);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Du hast's geschafft! Ein Hinweis noch: Es ist auch möglich Kupfer-, Gold- oder Meriniumbarren zu schmelzen. Aber zu Beginn wirst du meistens Eisenbarren brauchen. Als nächstes wird der Eisenbarren geschmiedet, bereit?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",2535,"all",">",9);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",2);

    -- Status: 2 -> 20 (Hammer geben - Nägel schmieden)
    --
    autonpcfunctions.AddTraderTrigger("yes","Arr, there ye' are. Make 10 pins out of the iron ingots and come back! Stay on front of the anvil and 'use' this hammer. Once you do that, you can choose between several categories. The pins are represented by a hammer! Choose this category and click on the pins. Try it out!");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",20);
    autonpcfunctions.AddConsequence("item",23,1,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Jetzt solltest du erstmal zum Amboß gehn. Stell dich davor und 'benutzte' diesen Hammer. Es öffnet sich dann ein Menü, wo du auswähln kannst, in welcher Kategorie du etwas schmieden willst. Wähl den Hammer für die Kategorie 'Werkzeuge' und dann die Nägel aus. Komm wieder wenn du 10 Nägel hast!");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",20);
    autonpcfunctions.AddConsequence("item",23,1,999,0);
    autonpcfunctions.AddTraderTrigger("no","Arr...Allright. Come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddTraderTrigger("nein","Arr...In Ordnung. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",2);

    -- Status: 20 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","moep");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddTraderTrigger("hilf","Arr...will der Hammer nicht so wie du, mein Freund? Überprüfe noch einmal, ob du den Hammer auch wirklich in der Hand und die Eisenbarren 'im' Gürtel hast. Dann einmal den Hammer 'benutzen' und in dem Menü, welches sich dann öffnet erst den Hammer für \"Werkzeuge\" und dann die Nägel auswählen. Wenn du noch mehr Eisenbarren brauchst, sag mir einfach Bescheid. Ich hab noch genug.");
    autonpcfunctions.AddCondition("state","=",20);

    -- Status: 20 (Mehr Eisenbarren)
    --
    autonpcfunctions.AddTraderTrigger("barren","Du brauchst mehr Eisenbarren, richtig? Hier bitte sehr.");
    autonpcfunctions.AddCondition("state",">=",20);
    autonpcfunctions.AddCondition("item",2535,"all","<",2);
    autonpcfunctions.AddConsequence("item",2535,10,333,0);
    autonpcfunctions.AddTraderTrigger("ingots","You need more iron ingots, right? Here you are.");
    autonpcfunctions.AddCondition("state",">=",20);
    autonpcfunctions.AddCondition("item",2535,"all","<",2);
    autonpcfunctions.AddConsequence("item",2535,10,333,0);

    -- Status: 20 (Neuer Hammer)
    --
    autonpcfunctions.AddTraderTrigger("hammer","Ye need another hammer, aye?? Here ye are.");
    autonpcfunctions.AddCondition("state",">=",20);
    autonpcfunctions.AddCondition("item",23,"all","=",0);
    autonpcfunctions.AddConsequence("item",23,1,999,0);
    autonpcfunctions.AddTraderTrigger("nadel","Du brauchst 'nen neuen Hammer, aye? Hier haste einen.");
    autonpcfunctions.AddCondition("state",">=",20);
    autonpcfunctions.AddCondition("item",23,"all","=",0);
    autonpcfunctions.AddConsequence("item",23,1,999,0);

    -- Status: 20 (Zu wenig Nägel da)
    --
    autonpcfunctions.AddTraderTrigger(".+","Come again when ye have smithed at least 10 pins. If you need help or more ingots, ask me!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",2738,"all","<",10);
    autonpcfunctions.AddTraderTrigger(".+","Komm wieder, wenn du mindestens 10 Nägel geschmiedet hast. Wenn du Hilfe oder mehr Eisenbarren brauchst, dann frag mich!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",2738,"all","<",10);

    -- Status: 52 (Nägel sind fertig)
    --
    autonpcfunctions.AddTraderTrigger(".+","Great! Ye' did it! One more hint: More complex items may leave 'unfinished items' , continue the work by 'using' the hammer with the item, having it placed at the belt of course.");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("item",2738,"all",">=",10);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Jetzt hast du's geschafft! En Hinweis noch: Es kann passiern, dat 'unfertige Sachen' übrigbleiben, du kannst die Arbeit an ihnen fortsetzen, indem du den Hammer mit diesem Gegenstand, den du natürlich am Gürtel trägst, 'benutzt'. Du weiß nun alles Nötige über's Schmieden. Viel Glück und leb wohl!");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("item",2738,"all",">=",10);
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: >10 (Unterricht wurde unterbrochen und wird nun fortgesetzt)
    --
    autonpcfunctions.AddTraderTrigger(".+","Should we continue? Just say \"yes\" or \"no\".");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddTraderTrigger(".+","Sollen wir weitermachen? Sag einfach \"ja\" oder \"nein\".");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","<",10);

	
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
