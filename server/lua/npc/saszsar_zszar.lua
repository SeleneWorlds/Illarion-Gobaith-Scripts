local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),5,-113,-121,0,6,false,'Saszsar Zszar','npc_saszsar_zszar.lua',0);
-- newbie island NPC
-- telling about the cross
-- for lizards: how to fish

local autonpcfunctions = require("npc.base.autonpcfunctions")

function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Ssss! Wass wollt Ihr?");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Ssss! What do you want?");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

    autonpcfunctions.AddTraderTrigger("hello","Hello my friend. Maybe I can help you to learn fishing. Or have a look at thisss beautiful column!");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("hallo","Ssseid gegrüssst mein Freund. Vielleicht kann ich Euch dasss Fischen beibringen. Oder ssschaut Euch einfach diesse wundersschöne Säule an!");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("my name","Ah, my pleasssure! I am "..thisNPC.name..". Jussst assk if I shall teach you how to catch ssome fisssh. Or have a look at thisss beautiful column!");
    autonpcfunctions.AddAdditionalTrigger("i am");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("mein name","Ah, issst mir ein Vergnügen! Ich bin "..thisNPC.name..". Fragt einfach, wenn ich Euch beibringen ssoll, wie man Fissche fängt. Oder ssschaut Euch einfach diesse wundersschöne Säule an!");
    autonpcfunctions.AddAdditionalTrigger("ich bin");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("hello","Hello ssstranger, issn't that crosss beautiful? Sssure it iss.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("hallo","Ssseid gegrüssst, Fremder. Issst diessess Kreuz nicht sschön? Natürlich issst ess dass.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddTraderTrigger("my name","Ah, my pleasssure! I am "..thisNPC.name..". Jussst assk if I shall teach you how to catch ssome fisssh. Or have a look at thisss beautiful column!");
    autonpcfunctions.AddAdditionalTrigger("i am");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("mein name","Ah, issst mir ein Vergnügen! Ich bin "..thisNPC.name..". Fragt einfach, wenn ich Euch beibringen ssoll, wie man Fissche fängt. Oder ssschaut Euch einfach diesse wundersschöne Säule an!");
    autonpcfunctions.AddAdditionalTrigger("ich bin");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    -- STATE ~= 0
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME, nice to sssee you again. Do you want to know how to fish? I could tell you.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("hallo","Ssseid gegrüssst, %CHARNAME. Schön Euch wiederzusssehen. Wollt Ihr wisssen wie man fischt? Ich könnte esss Euch ssagen.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("my name","Yesss, I know your name.");
    autonpcfunctions.AddAdditionalTrigger("i am");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("mein name","Ja, ich weisss Euren Namen.");
    autonpcfunctions.AddAdditionalTrigger("ich bin");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("hello","Hello %CHARNAME, nice to sssee you again.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddTraderTrigger("hallo","Ssseid gegrüssst, %CHARNAME. Schön Euch wiederzusssehen.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddTraderTrigger("my name","Yesss, I know your name.");
    autonpcfunctions.AddAdditionalTrigger("i am");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("mein name","Ja, ich weisss Euren Namen.");
    autonpcfunctions.AddAdditionalTrigger("ich bin");
    autonpcfunctions.AddConsequence("state","=",1);
    -- small talk
    autonpcfunctions.AddTraderTrigger("how are you","I'm fine, thanksss. And you?");
    autonpcfunctions.AddTraderTrigger("wie geht dir","Mir geht esss gut, danke. Und Euch?");
    autonpcfunctions.AddAdditionalTrigger("wie geht euch");
    autonpcfunctions.AddTraderTrigger("who you","My name isss "..thisNPC.name..". I take care for the Holy Crossss here. Jussst assk if I shall teach you how to catch ssome fisssh.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("wer du","Mein Name issst "..thisNPC.name..". Ich kümmere mich um dasss Heilige Kreuz hier. Fragt einfach, wenn ich Euch beibringen ssoll, wie man Fische fängt.");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("who you","My name isss "..thisNPC.name..". I take care for the Holy Crossss here.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("wer du","Mein Name issst "..thisNPC.name..". Ich kümmere mich um dasss Heilige Kreuz hier.");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("what is","Thiss isss a Column of Revival. If you fall in battle, go to a Column of Revival to come back to life. Every major town hasss one. But now go on to Amelia, jussst follow the sstreet into the wood.");
    autonpcfunctions.AddAdditionalTrigger("column");
    autonpcfunctions.AddAdditionalTrigger("revival");
    autonpcfunctions.AddTraderTrigger("was ist","Dass issst eine Säule der Wiederbelebung. Wenn Ihr im Kampf fallen ssolltet, geht zu einer Säule der Wiederbelebung, um wieder neue Lebensskraft zu bekommen. Jede grösssere Stadt hat einess. Aber jetzt geht weiter zu Amelia, folgt einfach der Ssstraße in den Wald.");
    autonpcfunctions.AddAdditionalTrigger("s[äa]ule");
    autonpcfunctions.AddAdditionalTrigger("saeule");
    autonpcfunctions.AddAdditionalTrigger("wiederbelebung");
    -- fishing
    autonpcfunctions.AddTraderTrigger("fish","Oh, you want to learn how to fissh? It isss very ssimple: Jusst go to the water and 'use' it.");
    autonpcfunctions.AddAdditionalTrigger("teach");
    autonpcfunctions.AddAdditionalTrigger("learn");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("fisch","Oh, Ihr wollt lernen, wie man Fische fängt? Esss isst ganz ssimpel: Geht einfach zum Wasssser und 'benutzt' esss.");
    autonpcfunctions.AddAdditionalTrigger("beibringen");
    autonpcfunctions.AddAdditionalTrigger("bring bei");
    autonpcfunctions.AddAdditionalTrigger("lern");
    autonpcfunctions.AddAdditionalTrigger("lehr");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    -- help
    autonpcfunctions.AddTraderTrigger("help","If you want to know how to fisssh with your clawss, assk me 'How to fish' and if you want to know more about the Column of Revival, asssk me 'What is the Column of Revival'.");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("hilf","Wenn Ihr wissssen wollt, wie Ihr mit Euren Klauen fisscht, fragt mich 'Wie fische ich' und wenn Ihr mehr über die Säule der Wiederbelebung wisssen wollt, fragt mich 'Was ist die Säule der Wiederbelebung'.");
    autonpcfunctions.AddAdditionalTrigger("helf");
    autonpcfunctions.AddCondition("race", CCharacter.lizardman);
    autonpcfunctions.AddTraderTrigger("help","If you want to know more about the Holy Crossss, asssk me 'What is the Column of Revival'.");
    autonpcfunctions.AddTraderTrigger("hilf","Wenn Ihr mehr über dasss Heilige Kreuz wisssen wollt, fragt mich 'Was ist die Säule der Wiederbelebung'.");
    autonpcfunctions.AddAdditionalTrigger("helf");
    -- bye bye
    autonpcfunctions.AddTraderTrigger("farewell","Good bye.");
    autonpcfunctions.AddAdditionalTrigger("bye");
    autonpcfunctions.AddAdditionalText("Be well");
    autonpcfunctions.AddAdditionalText("Zelphia with you.");
    autonpcfunctions.AddTraderTrigger("leb wohl","Auf bald.");
    autonpcfunctions.AddAdditionalTrigger("auf bald");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("tschue[sß]");
    autonpcfunctions.AddAdditionalTrigger("tsch[uü][sß]");
    autonpcfunctions.AddAdditionalText("Bisss bald");
    autonpcfunctions.AddAdditionalText("Zelphia mit Euch.");
    -- cycle
    autonpcfunctions.AddCycleText("#me starrt fasziniert die glänzende Säule an.","#me stares fascinated at the shiny column.");
    autonpcfunctions.AddCycleText("#me lässt seinen Schwanz hin und her schnalzen","#me flicks his tail");
    -- ********* END DYNAMIC PART ********

    TradSpeakLang={0,4};
    TradStdLang=0;

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
            autonpcfunctions.TellSmallTalk(message,originator);
        else
            autonpcfunctions.Confused(
               "#me sieht dich leicht verwirrt an",
               "#me looks at you a little confused"
            );
        end
    end
end

function M.lookAtNpc(Char, mode)
    if initLook==nil then
        output={};
        output[0]="Ein schuppiger junger Echsenmann. Er sitzt im Schneidersitz auf den Boden und betrachtet mit seinen grünleuchtenden Augen fasziniert die Säule.";
        output[1]="A flaked young lizardman. He sits cross-legged on the ground and watches fascinated with his green glowing eyes the column.";
        initLook=1;
    end

    lang=Char:getPlayerLanguage();
    Char:sendCharDescription( thisNPC.id , output[lang] );
end

return M
