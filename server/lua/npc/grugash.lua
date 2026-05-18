local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),4,194,-334,0,4,false,'Grugash','npc_grugash.lua',0);

local autonpcfunctions = require("npc.base.autonpcfunctions")
function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Don't you touch me!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

    -- Orc guard
    autonpcfunctions.AddTraderTrigger("Gobaith","Gobaith?  Dis liddle Island?  I hate it!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Gobaith","Gobaith?  Diese kleine Insel? Ich hasse es!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Greenbriar","Are joo hungry? Halflings make gud snacks, yubba!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Greenbriar","Haben Sie Hunger? Halblenge machen gute Imbisse!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Orc","Yubba!  Meh mighty Orc!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Orc","Ich bin ein mächtiger Ork!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Ork","Ich bin ein mächtiger Ork!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Orc Cave","Just go North and see Tihgorac.  Go through Cave and up ladder.  Keep North and see Higdish.");
    autonpcfunctions.AddTraderTrigger("Orc Cave"," Gehen Sie gerade Norden und sieh Tihgorac. Gehen Sie Höhle und Leiter durch. Behalten Sie Norden und sieh Higdish.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Varshikar","Oomie desert town.  Just go East, joo cant miss it.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Varshikar"," Menschliche Wüste-Stadt. Gehen Sie gerade Osten, Sie können nicht es verpassen!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("I am","Nice to meet joo.");
    autonpcfunctions.AddTraderTrigger("I'm","Nice to meet joo.");
    autonpcfunctions.AddTraderTrigger("Ich bin","Nett dich kennen su lernen.");
    autonpcfunctions.AddTraderTrigger("Silberbrand","#me spuckt auf dem Grund und bleibt still.");
    autonpcfunctions.AddTraderTrigger("Silverbrand","#me spits on the ground and remains silent.");
    autonpcfunctions.AddTraderTrigger("Troll Bane","It beh in middle ob Island.  Big Oomie town it beh.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Troll Bane","Es ist in der Mitte der Insel. Es ist eine große menschliche Stadt.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Hallo! Was wollen Sie?");
    autonpcfunctions.AddTraderTrigger("greetings","Greebas! Whub joo want?");
    autonpcfunctions.AddTraderTrigger("greets","Greebas! Whub joo want?");
    autonpcfunctions.AddTraderTrigger("greeb+[a]+s","Greebas friend!  How can meh help joo?");
    autonpcfunctions.AddTraderTrigger("hail","Greebas!  Whub joo want?");
    autonpcfunctions.AddTraderTrigger("hallo","Hallo! Was wollen Sie?");
    autonpcfunctions.AddTraderTrigger("hello","Greebas! Whub joo want?");
    autonpcfunctions.AddTraderTrigger("auf bald","Tchuss!");
    autonpcfunctions.AddTraderTrigger("farewell","Farrebas!");
    autonpcfunctions.AddTraderTrigger("bye","Farrebas!");
    autonpcfunctions.AddTraderTrigger("mission","Meh mission is to guard dis Border.");
    autonpcfunctions.AddTraderTrigger("beruf","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("deine aufgabe","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("eure aufgabe","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("job","Meh job is to guard dis border!");
    autonpcfunctions.AddTraderTrigger("t[äae]+tigkeit","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("was tust du","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("was tut ihr","Meine Mission ist, diese Grenze zu schützen.");
    autonpcfunctions.AddTraderTrigger("what you do","Meh job is to guard dis border!");
    autonpcfunctions.AddTraderTrigger("dein name","Mein name? Ich heiße %npcname");
    autonpcfunctions.AddTraderTrigger("you name","My name?  I beh %npcname");
    autonpcfunctions.AddTraderTrigger("mein name","Sehr angenem. Ich heiße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("my name","Keh, gud to meet joo.  Meh beh %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("wie hei[sß]+t du","Ich heißße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("helfen","Ihr wolld mir helfen? Gud, bringt mir eine Flasche Bier!");
    autonpcfunctions.AddTraderTrigger("help","Joo wanna help me?  Gud, bring meh a bottle ob Beer!");
    autonpcfunctions.AddTraderTrigger("hilfe","Ihr wolld mir helfen? Gud, bringt mir eine Flasche Bier!");
    autonpcfunctions.AddTraderTrigger("how are you","Gud.");
    autonpcfunctions.AddTraderTrigger("wie geht es","Gut.");
    autonpcfunctions.AddTraderTrigger("buy","Meh nub buy anyding!");
    autonpcfunctions.AddTraderTrigger("kaufen","Ich kaufe gar nix!");
    autonpcfunctions.AddTraderTrigger("sell","Meh nub sell anyding.");
    autonpcfunctions.AddTraderTrigger("verkaufen","Ich verkaufe gar nix!");
    autonpcfunctions.AddTraderTrigger("neu","Du bist neu hier? Geh am besten in die Stadt Osten, Varshikar, und suche nach Leuten, die dir helfen können.");
    autonpcfunctions.AddTraderTrigger("I[ a']+m new","You are new to Illarion? You should visit the town to the East, Varshikar. Search for people who can help you.");
    autonpcfunctions.AddTraderTrigger("newbie","You are new to Illarion? You should visit the town to the East, Varshikar. Search for people who can help you.");
    autonpcfunctions.AddTraderTrigger("where am I","Joo are on da Border to da Orcs lands!");
    autonpcfunctions.AddTraderTrigger("wo bin ich"," Sie sind auf der Grenze zu den Orks lande!");
    autonpcfunctions.AddTraderTrigger("who","Meh job is to guard dis Border");
    autonpcfunctions.AddTraderTrigger("wer seid","Mein Job soll diese Grenze schützen.");
    autonpcfunctions.AddTraderTrigger("wer","Mein Job soll diese Grenze schützen.");
    autonpcfunctions.AddTraderTrigger("quest","Nubba Quest here.  Ask anudder Guard.");
    autonpcfunctions.AddTraderTrigger("wache","Die Wache? Wir sind besten!");
    autonpcfunctions.AddTraderTrigger("guard","The Guards?  Weh are da best!");
    autonpcfunctions.AddCycleText("#me rülpst","#me burps");
    autonpcfunctions.AddCycleText("#me zieht eine kleine Flasche aus der Tasche und trinkt einen Schluck","#me pulls a bottle out of his pocket and takes a sip");
    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
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

return M
