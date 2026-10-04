local M = {}

--Name:        Jenny Copperneedle
--Race:        Halbling
--Town:        Newbie Insel
--Function:    Schneidern beibringen
--Position:    x=-76 y=-101 z=0
--Facing:      south
--Last Update: 05/07/2008
--Update by:   pharse

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
    autonpcfunctions.AddTraderTrigger("hello","Hello my friend! I am "..thisNPC.name..", the best tailor of this island. If you want, I show you how to become a good tailor.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("hallo","Hallo mein Freund! Ich bin "..thisNPC.name..", die beste Schneiderin auf der Insel. Wenn du möchtest zeige ich dir, wie du ein guter Schneider wirst.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddTraderTrigger("who you","I am "..thisNPC.name..", the best tailor of this island. If you want, I show you how to become a good tailor.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddTraderTrigger("wer du","Hallo mein Freund! Ich bin "..thisNPC.name..", die beste Schneiderin auf der Insel. Wenn du möchtest zeige ich dir, wie du ein guter Schneider wirst.");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("was ihr");
    autonpcfunctions.AddTraderTrigger("dank","Bitte sehr.");
    autonpcfunctions.AddTraderTrigger("thank","You're welcome");
    autonpcfunctions.AddTraderTrigger("bye","Bye, bye.");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalText("Be well, my friend!");
    autonpcfunctions.AddAdditionalText("Farewell, until we meet again.");
    autonpcfunctions.AddTraderTrigger("tsch[üu][ßs]","Auf Wiedersehen, mein Freund!");
    autonpcfunctions.AddAdditionalTrigger("tschue[sß]");
    autonpcfunctions.AddAdditionalTrigger("leb wohl");
    autonpcfunctions.AddAdditionalTrigger("wiederseh");
    autonpcfunctions.AddAdditionalTrigger("auf bald");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalText("Tschüss auch.");
    autonpcfunctions.AddAdditionalText("Leb wohl, bis zum nächsten Mal.");
    autonpcfunctions.AddTraderTrigger("hilf","Wenn du möchtest kann ich dir zeigen, wie man schneidert. Möchtest du?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("help","If you want, I can show you how to tailor. Want you?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","<",10);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("reset","Status reset!");
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 0 - 1 (start teaching)
    --
    autonpcfunctions.AddTraderTrigger("tailor","You want to learn how to tailor? I am very pleased to hear that. Want to start right away?");
    autonpcfunctions.AddAdditionalTrigger("craft");
    autonpcfunctions.AddAdditionalTrigger("teach");
    autonpcfunctions.AddAdditionalTrigger("learn");
    autonpcfunctions.AddAdditionalTrigger("show");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("schneider","Du möchtest also lernen, wie man schneidert? Das freut mich sehr. Wollen wir gleich anfangen?");
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

    -- Status: 1 -> 10 (Schere zum Wolle holen)
    --
    autonpcfunctions.AddTraderTrigger("yes","Excellent. Firstly, we need some wool. There are some sheeps over there. Stay directly in front of a sheep and 'use' the scissors. Come again when you have have at least 15 pieces of wool.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",6,1,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Hervorragend! Als erstes brauchen wir Wolle. Da vorne grasen ein paar Schafe. Du musst dich direkt vor eines der Schafe stellen und die Schere 'benutzen'. Komm wieder wenn du mindestens 15 Einheiten Wolle hast.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddConsequence("item",6,1,999,0);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);

    -- Status: 1 (eine andere Anwort)
    --
    autonpcfunctions.AddTraderTrigger(".+","I ask you if I should teach you tailoring. Just say \"yes\" or \"no\".");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger(".+","Ich habe dich gefragt, ob ich dir das Schneidern beibringen soll...sag einfach \"ja\", oder \"nein\".");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",1);

    -- Status: 10 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must stay facing the sheep and then 'use' the scissors. This needs much dexterity from time to time, because the sheeps move, but with a bit training it works fine. Otherwise I can give you some wool. Want you?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du musst dich direkt neben das Schaf stellen und dann die Schere 'benutzen. Das erfordert manchmal viel geschickt, weil die Schafe sich bewegen, aber mit etwas Übung wirst du es sicher schaffen. Ich kann dir aber auch einfach etwas Wolle geben. Möchtest du das?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddConsequence("state","=",11);

    -- Status: 11 (Auf Wunsch wird Wolle gegeben)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here you go. This should be enough for now. Should we continue?");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",170,15,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Hier, bitte sehr. Das sollte erstmal reichen. Wollen wir dann weitermachen?");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("item",170,15,999,0);
    autonpcfunctions.AddTraderTrigger("no","Yes, retry it. That is the right way.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);
    autonpcfunctions.AddTraderTrigger("nein","Ja, versuch es ruhig selbst nochmal. Das ist der richtige Weg.");
    autonpcfunctions.AddCondition("state","=",11);
    autonpcfunctions.AddConsequence("state","=",10);

    -- Status: >=1 (Eine neue Schere)
    --
    autonpcfunctions.AddTraderTrigger("scissors","Did you need a new scissors? Here you have one.");
    autonpcfunctions.AddCondition("state",">=",1);
    autonpcfunctions.AddCondition("item",6,"all","=",0);
    autonpcfunctions.AddConsequence("item",6,1,999,0);
    autonpcfunctions.AddTraderTrigger("schere","Brauchst du eine neue Schere? Hier hast du eine.");
    autonpcfunctions.AddCondition("state",">=",1);
    autonpcfunctions.AddCondition("item",6,"all","=",0);
    autonpcfunctions.AddConsequence("item",6,1,999,0);

    -- Status: >=1 (Keine Schafe mehr da)
    --
    autonpcfunctions.AddTraderTrigger("schaf","Es sind keine Schafe mehr da? Warte einfach einen Augenblick, es kommen bestimmt gleich neue.");
    autonpcfunctions.AddCondition("state",">=",1);
    autonpcfunctions.AddTraderTrigger("sheep","There are no more sheeps arround? Just wait a minute, I'm sure, that they come some new soon.");
    autonpcfunctions.AddCondition("state",">=",1);

    -- Status: 10 (Noch zu wenig Wolle)
    --
    autonpcfunctions.AddTraderTrigger(".+","You still have to little wool. Come back, when you have at least 15 pieces of wool.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",170,"all","<",15);
    autonpcfunctions.AddTraderTrigger(".+","Du hast noch zu wenig Wolle. Komm wieder, wenn du mindestens 15 Einheiten hast.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",170,"all","<",15);

    -- Status: 10 -> 2 (Die Wolle ist da - weitermachen?)
    --
    autonpcfunctions.AddTraderTrigger(".+","Great! You did it! One more hint: It is possible to get wool when you kill sheep , but it's much more productive when you just shear the living sheep. Well, next I will explain to you how you can work up wool to a ball of wool. Ready?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",170,"all",">",14);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Du hast's geschafft! Ein Hinweis noch: Du bekommst auch Wolle, wenn du die Schafe angreifst und tötest. Aber es ist viel effektiver das lebende Schaf zu scheren. Gut, als nächstes erkläre ich dir, wie du die Wolle zu einem Wollknäuel verarbeiten kannst. Bereit?");
    autonpcfunctions.AddCondition("state","=",10);
    autonpcfunctions.AddCondition("item",170,"all",">",14);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",2);

    -- Status: 2 -> 20 (Wolle spinnen)
    --
    autonpcfunctions.AddTraderTrigger("yes","Fine. The next is to spin the wool. You see that spinning wheel over there? Take the scissors in your hand, the wool at your belt and go in front of it. When you 'use' the spinning weel you start automatically to spin. Come back, when you have spun all your wool to balls.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",20);
    autonpcfunctions.AddTraderTrigger("ja","Fein! Als nächstes muss die Wolle gesponnen werden. Siehst du das Spinnrad da vorne? Nimm die Schere in die Hand und die Wolle an den Gürtel und stell dich davor. Wenn du nun das Spinnrad 'benutzt' beginnst du zu spinnen. Komm zurück, wenn du all deine Wolle zu Wollknäulen versponnen hast.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddConsequence("state","=",20);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",2);

    -- Status: 20 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must hold the scissors in your hand and the wool 'in' your belt. Stay directly in front of the spinning weel and 'use' it. Otherwise I can give you some balls of wool. Want you?");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddConsequence("state","=",21);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du must die Schere in der Hand halten und die Wolle 'im' Gürtel haben. Stell dich direkt vor das Spinnrad und 'benute' das Spinnrad. Ich kann dir aber auch einfach etwas Wolle geben. Möchtest du das?");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddConsequence("state","=",21);

    -- Status: 21 (Auf Wunsch werden Wollknäule gegeben)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here you go. This should be enough for now. Should we continue?");
    autonpcfunctions.AddCondition("state","=",21);
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddConsequence("item",168,15,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Hier, bitte sehr. Das sollte erstmal reichen. Wollen wir dann weitermachen?");
    autonpcfunctions.AddCondition("state","=",21);
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddConsequence("item",168,15,999,0);
    autonpcfunctions.AddTraderTrigger("no","Yes, retry it. That is the right way.");
    autonpcfunctions.AddCondition("state","=",21);
    autonpcfunctions.AddConsequence("state","=",20);
    autonpcfunctions.AddTraderTrigger("nein","Ja, versuch es ruhig selbst noch einmal. Das ist der richtige Weg.");
    autonpcfunctions.AddCondition("state","=",21);
    autonpcfunctions.AddConsequence("state","=",20);

    -- Status: 20 (Noch zu wenig Wolle)
    --
    autonpcfunctions.AddTraderTrigger(".+","You still have to little balls of wool. Come back, when you have at least 15 pieces.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",168,"all","<",15);
    autonpcfunctions.AddTraderTrigger(".+","Du hast noch zu wenig Wollknäule. Komm wieder, wenn du mindestens 15 Stück hast.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",168,"all","<",15);

    -- Status: 20 -> 3 (Die Wollknäule ist da - weitermachen?)
    --
    autonpcfunctions.AddTraderTrigger(".+","Great! Now I show you how to produce cloth with this balls of wool. Ready?");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",168,"all",">",14);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Dann zeig ich dir jetzt, wie du aus den Wollknäulen Stoffe herstellen kannst. Bist du soweit?");
    autonpcfunctions.AddCondition("state","=",20);
    autonpcfunctions.AddCondition("item",168,"all",">",14);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",3);

    -- Status: 3 -> 30 (Wollknäule weben)
    --
    autonpcfunctions.AddTraderTrigger("yes","With a loom you can weave the ball of wools to cloth. For this, stay in front of the loom and 'use' it. You should have the scissors in your hand and the balls of wool 'in' your belt for this. Come back, when you have finished.");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",30);
    autonpcfunctions.AddTraderTrigger("ja","Mit einem Webstuhl kannst du nun die Wollknäule zu Stoff weben. Stell dich einfach vor den Webstuhl und 'benutze' ihn. Du solltest dafür die Schere in der Hand und die Wollknäule 'im' Gürtel haben. Wenn du fertig bist, dann komm wieder.");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",30);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",3);

    -- Status: 30 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must hold the scissors in your hand and the balls of wool 'in' your belt. Stay directly in front of the loom weel and 'use' it. Otherwise I can give you some cloth. Want you?");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddConsequence("state","=",31);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du must die Schere in der Hand halten und die Wollknäule 'im' Gürtel haben. Stell dich direkt vor den Webstuhl und 'benute' den Webstuhl. Ich kann dir aber auch einfach etwas Stoff geben. Möchtest du das?");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddConsequence("state","=",31);

    -- Status: 	31 (Auf Wunsch wird grauer Stoff gegeben)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here you go. This should be enough for now. Should we continue?");
    autonpcfunctions.AddCondition("state","=",31);
    autonpcfunctions.AddConsequence("state","=",4);
    autonpcfunctions.AddConsequence("item",176,5,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Hier, bitte sehr. Das sollte erstmal reichen. Wollen wir dann weitermachen?");
    autonpcfunctions.AddCondition("state","=",31);
    autonpcfunctions.AddConsequence("state","=",4);
    autonpcfunctions.AddConsequence("item",176,5,999,0);
    autonpcfunctions.AddTraderTrigger("no","Yes, retry it. That is the right way.");
    autonpcfunctions.AddCondition("state","=",31);
    autonpcfunctions.AddConsequence("state","=",30);
    autonpcfunctions.AddTraderTrigger("nein","Ja, versuch es ruhig selbst noch einmal. Das ist der richtige Weg.");
    autonpcfunctions.AddCondition("state","=",31);
    autonpcfunctions.AddConsequence("state","=",30);

    -- Status: 30 (Noch kein Stoff da)
    --
    autonpcfunctions.AddTraderTrigger(".+","Before we can continue you need some cloth. Tell me, if you need help.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("item",176,"all","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Bevor wir weitermachen brauchst du erst Stoff. Wenn du hilfe brauchst, dann sag mir einfach bescheid.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("item",176,"all","=",0);

    -- Status: 30 -> 4 (Grauer Stoff ist da - weitermachen?)
    --
    autonpcfunctions.AddTraderTrigger(".+","Excellent work! Now we can continue with the next step. Ready?");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("item",176,"all",">",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",4);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Jetzt können wir mit dem nächsten Schritt weitermachen. Bist du soweit?");
    autonpcfunctions.AddCondition("state","=",30);
    autonpcfunctions.AddCondition("item",176,"all",">",0);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",4);

    -- Status: 4 -> 40 (Garn herstellen)
    --
    autonpcfunctions.AddTraderTrigger("yes","For tailoring you need among cloth some thread. You can produce it by yourself, when you work up the entrails of animals with a scissors. The best is to try it: Kill one of the animals around, put the entrails 'into' your belt and 'use' the scissors.");
    autonpcfunctions.AddCondition("state","=",4);
    autonpcfunctions.AddConsequence("state","=",40);
    autonpcfunctions.AddTraderTrigger("ja","Zum schneidern brauchst du neben Stoff auch noch Garn. Das kannst du einfach selbst herstellen, indem du die Eingeweide von Tieren mit einer Schere bearbeitest. Versuche es doch am besten gleich einmal selbst. Töte eines der Tiere, die hier herumlaufen, lege die Eingeweide 'in' deinen Gürtel und benutze die Schere.");
    autonpcfunctions.AddCondition("state","=",4);
    autonpcfunctions.AddConsequence("state","=",40);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",4);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",4);

    -- Status: 40 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must hold the scissors in your hand and the entrails in' your belt. Then just 'use' the scissors. Otherwise I can give you some thread. Want you?");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddConsequence("state","=",41);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du must die Schere in der Hand halten und die Eingeweide 'im' Gürtel haben. Dann einfach die Schere 'benutzen'. Ich kann dir aber auch einfach etwas Stoff geben. Möchtest du das?");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddConsequence("state","=",41);

  -- Status: 41 (Auf Wunsch wird Garn gegeben)
  --
    autonpcfunctions.AddTraderTrigger("yes","Here you go. This should be enough for now. Should we continue?");
    autonpcfunctions.AddCondition("state","=",41);
    autonpcfunctions.AddConsequence("state","=",5);
    autonpcfunctions.AddConsequence("item",50,5,999,0);
    autonpcfunctions.AddTraderTrigger("ja","Hier, bitte sehr. Das sollte erstmal reichen. Wollen wir dann weitermachen?");
    autonpcfunctions.AddCondition("state","=",41);
    autonpcfunctions.AddConsequence("state","=",5);
    autonpcfunctions.AddConsequence("item",50,5,999,0);
    autonpcfunctions.AddTraderTrigger("no","Yes, retry it. That is the right way.");
    autonpcfunctions.AddCondition("state","=",41);
    autonpcfunctions.AddConsequence("state","=",40);
    autonpcfunctions.AddTraderTrigger("nein","Ja, versuch es ruhig selbst noch einmal. Das ist der richtige Weg.");
    autonpcfunctions.AddCondition("state","=",41);
    autonpcfunctions.AddConsequence("state","=",40);

    -- Status 40 (Noch kein Garn da)
    --
    autonpcfunctions.AddTraderTrigger(".+","Before we can continue you need some thread. Tell me, if you need help.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("item",50,"all","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Bevor wir weitermachen brauchst du erst Garn. Wenn du hilfe brauchst, dann sag mir einfach bescheid.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("item",50,"all","=",0);

    -- Status: 40 (Garn ist da - weitermachen?)
    --
    autonpcfunctions.AddTraderTrigger(".+","Excellent work! Now we can start with tailoring cloth. Ready?");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("item",50,"all",">",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",5);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Jetzt können wir anfangen mit dem nähen von Kleidung. Bist du soweit?");
    autonpcfunctions.AddCondition("state","=",40);
    autonpcfunctions.AddCondition("item",50,"all",">",0);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",5);

    -- Status: 5 -> 50 (Schneidern)
    --
    autonpcfunctions.AddTraderTrigger("yes","Here, take this needle. You should have all for tailoring you need for tailor your first clothing. If you need more cloth or thread just ask me. I give you more. Take the needle in your hand and the cloth and the thread 'in' your belt. Stay in front of the tailor table and 'use' the scissors. A menu open, where you can choose what do you want tailor. Please choose the \"grey coat\".");
    autonpcfunctions.AddCondition("state","=",5);
    autonpcfunctions.AddConsequence("item",47,1,999,0);
    autonpcfunctions.AddConsequence("state","=",50);
    autonpcfunctions.AddTraderTrigger("ja","Hier, nimm diese Nadel. Du solltest nun alles haben, was du brauchst um dein erstes Kleidungsstück zu nähen. Wenn du noch mehr Stoff oder Garn brauchst, dann sag mir einfach bescheid. Ich kann dir auch noch was davon geben. Nimm die Nadel in die Hand und den Stoff und das Garn 'in' den Gürtel. Stell dich dann vor den Schneidertisch und 'benutze' die Nadel. In dem Menü, welches sich dann öffnet kannst du auswählen, was du nähen willst. Wähle bitte den \"grauen Mantel.\"");
    autonpcfunctions.AddCondition("state","=",5);
    autonpcfunctions.AddConsequence("item",47,1,999,0);
    autonpcfunctions.AddConsequence("state","=",50);
    autonpcfunctions.AddTraderTrigger("no","It's a pity, but maybe later. You can come back whenever you want.");
    autonpcfunctions.AddCondition("state","=",5);
    autonpcfunctions.AddTraderTrigger("nein","Schade, aber vielleicht später. Komm zurück wann immer du willst.");
    autonpcfunctions.AddCondition("state","=",5);

    -- Status: 50 (Mehr Garn)
    --
    autonpcfunctions.AddTraderTrigger("garn","Du brauchst mehr Garn, richtig? Hier bitte sehr.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",50,"all","<",2);
    autonpcfunctions.AddConsequence("item",50,5,333,0);
    autonpcfunctions.AddTraderTrigger("thread","You need more thread, right? Here you are.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",50,"all","<",2);
    autonpcfunctions.AddConsequence("item",50,5,333,0);

    -- Status: 50 (Mehr Stoff)
    --
    autonpcfunctions.AddTraderTrigger("stoff","Du brauchst mehr grauen Stoff, richtig? Hier bitte sehr.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",176,"all","<",2);
    autonpcfunctions.AddConsequence("item",176,5,333,0);
    autonpcfunctions.AddTraderTrigger("cloth","You need more grey cloth, right? Here you are.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",176,"all","<",2);
    autonpcfunctions.AddConsequence("item",176,5,333,0);

    -- Status: 50 (Neue Nadel)
    --
    autonpcfunctions.AddTraderTrigger("needle","Did you need an new needle? Here you have one.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",47,"all","=",0);
    autonpcfunctions.AddConsequence("item",47,1,999,0);
    autonpcfunctions.AddTraderTrigger("nadel","Brauchst du eine neue Nadel? Hier hast du eine.");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("item",47,"all","=",0);
    autonpcfunctions.AddConsequence("item",47,1,999,0);

    -- Status: 50 (Hilfe)
    --
    autonpcfunctions.AddTraderTrigger("help","Does it not work? You must hold the needle in your hand and the grey cloth and the thread  in' your belt. Then 'use' the needle to open the main menu. The red shirt is the symbol for clothing. Klick on the shirt to open the clothing-menu. In this menu choose the \"grey coat\".");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("state","<",52);
    autonpcfunctions.AddTraderTrigger("hilf","Klappt etwas nicht? Du must die Nadel in der Hand halten und den Stoff und das Garn am Gürtel tragen. Dann 'benutze' die Nadel um das Haupmenü zu öffnen. Das rote Hemd ist das Symbol für Kleidung. Klick darauf um das Kleidungsmenü zu öffnen. In diesem Menü wähle dann \"Grauer Mantel\".");
    autonpcfunctions.AddCondition("state",">=",50);
    autonpcfunctions.AddCondition("state","<",52);

    -- Status: 50 (Kein Mantel da)
    --
    autonpcfunctions.AddTraderTrigger(".+","Go to the tailor table and produce a grey coat. Come back, when you have finished.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",50);
    autonpcfunctions.AddCondition("item",196,"all","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Geh zum Schneidertisch und nähe einen grauen Mantel. Komm wieder, wenn du fertig bist.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",50);
    autonpcfunctions.AddCondition("item",196,"all","=",0);

    -- Status 51 (Mantel ist unfertig)
    --
    autonpcfunctions.AddTraderTrigger(".+","Oh...this coat isn't finished. If you want to continue the work on an unfinished article of clothing good, just 'use' the needle with that clothing, having it placed at the belt of course.");
    autonpcfunctions.AddCondition("state","=",51);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",50);
    autonpcfunctions.AddTraderTrigger(".+","Oh...dieser Mantel ist noch nicht fertig. Wenn du die Arbeit an einem unfertigen Kleidungsstück weiterführen willst, dann 'benutze' die Nadel mit diesem Kleidungsstück, das du natürlich am Gürtel trägst.");
    autonpcfunctions.AddCondition("state","=",51);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",50);

    -- Status: 52 (Mantel ist fertig)
    --
    autonpcfunctions.AddTraderTrigger(".+","Great! This coat looks fantastic. Now you know all you must to know about tailoring. For some clothings you need dyed clothes. If you want to know how to dye cloth ask my sister Penny. She is over there by the barrel. I wish you good luck. Farewell!");
    autonpcfunctions.AddCondition("state","=",52);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Großartig! Der Mantel ist wirklich schön geworden. Du weißt nun alles, was man über das Schneidern wissen muss. Für viele Kleidungsstücke wirst du farbige Stoffe brauchen. Wenn du wissen willst, wie man Stoffe färbt, dann frag am besten meine Schwester Penny. Sie steht dort drüben neben dem Fass. Ich wünsche dir viel Erfolg. Leb wohl!");
    autonpcfunctions.AddCondition("state","=",52);
    autonpcfunctions.AddCondition("lang","german");
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
