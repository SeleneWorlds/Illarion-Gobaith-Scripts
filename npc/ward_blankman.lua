local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,68,62,100,4,false,'Ward Blankman','npc_ward_blankman.lua',0);

local autonpcfunctions = require("npc.base.autonpcfunctions")
-- dofile("/usr/share/servers/illarionserver/scripts/npc_autonpcfunctions.lua");

function M.useNPC(user,counter,param)
    thisNPC:increaseSkill(1,"common language",100);
    thisNPC:talkLanguage(CCharacter.say, CPlayer.german, "Finger weg!");
    thisNPC:talkLanguage(CCharacter.say, CPlayer.english, "Dont you touch me!");
end

function M.initializeNpc()
    if TraderFirst then
        return true;
    end

    autonpcfunctions.InitTalkLists();

    -- ********* START DYNAMIC PART ********

    autonpcfunctions.AddTraderTrigger("greet","Greetings to you. My name is "..thisNPC.name..". I'm guarding the undead right there.");
    autonpcfunctions.AddAdditionalTrigger("hello");
    autonpcfunctions.AddTraderTrigger("gr[üu][sß]","Grüß' dich. Mein Name ist "..thisNPC.name..". Ich bewache die Untoten dort drüben.");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddAdditionalTrigger("hallo");
    autonpcfunctions.AddTraderTrigger("bye","Be well.");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalText("Farewell.");
    autonpcfunctions.AddAdditionalText("Good bye.");
    autonpcfunctions.AddTraderTrigger("auf bald","Auf bald.");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("leb.+wohl");
    autonpcfunctions.AddAdditionalTrigger("tsch[üu][ßs]");
    autonpcfunctions.AddAdditionalTrigger("mach.+gut");
    autonpcfunctions.AddAdditionalText("Bis bald.");
    autonpcfunctions.AddAdditionalText("Leb wohl.");
    autonpcfunctions.AddAdditionalText("Mach's gut.");
    autonpcfunctions.AddTraderTrigger("who you","I'm "..thisNPC.name..", the guard of the undead on this isle.");
    autonpcfunctions.AddAdditionalTrigger("what you");
    autonpcfunctions.AddTraderTrigger("wer du","Ich bin "..thisNPC.name..", der Wächter der Untoten auf dieser Insel.");
    autonpcfunctions.AddAdditionalTrigger("was du");
    autonpcfunctions.AddAdditionalTrigger("wer ihr");
    autonpcfunctions.AddAdditionalTrigger("was ihr");
    autonpcfunctions.AddTraderTrigger("guardian","I don't know any guardian of the undead. Perhaps you'll meet one on Gobaith. But now hurry up, you've talked long enough. Move on, climb up the ladder and enter Findecano's castle.");
    autonpcfunctions.AddTraderTrigger("h[uü]ter","Ich kenne keinen Hüter der Untoten. Aber vielleicht triffst du einen auf Gobaith. Aber jetzt spute dich, du hast schon lange genug geredet. Geh weiter, kletter die Leiter hoch und betrete das Schloss von Findecano.");
    autonpcfunctions.AddAdditionalTrigger("hueter");
    autonpcfunctions.AddTraderTrigger("guard","I am a guard of the undead. It is my duty to ensure that both the living and the undead do not endanger the other group.");
    autonpcfunctions.AddTraderTrigger("w[äa]chter","Ich bin ein Wächter der Untoten. Es ist meine Pflicht sicherzustellen, dass sowohl die Lebenden als auch die Untoten nicht die andere Gruppe gefährden.");
    autonpcfunctions.AddAdditionalTrigger("waechter");
    autonpcfunctions.AddTraderTrigger("creature","Those creatures are undead.");
    autonpcfunctions.AddTraderTrigger("kreatur","Diese Kreaturen sind Untote.");
    autonpcfunctions.AddTraderTrigger("undead","I've trapped the undead in this cave. Mummies and skeletons. May Cherga release their souls.");
    autonpcfunctions.AddTraderTrigger("untot","Ich habe die Untoten in diese Höhle gesperrt. Mumien und Skelette. Möge Cherga ihre Seelen freigeben.");
	autonpcfunctions.AddTraderTrigger("living","The living should not disturb the undead. They are at a difficult stage on the way to Cherga's realm.");
    autonpcfunctions.AddTraderTrigger("lebend","Die Lebenden sollten die Untoten nicht stören. Sie sind in einem schwierigen Abschnitt auf dem Weg zu Chergas Reich.");
    autonpcfunctions.AddTraderTrigger("cherga","Cherga is the Goddess of Spirits and the Underworld. Those undead probably still have to fulfill a certain task. Only then their souls will find peace.");
    autonpcfunctions.AddAdditionalTrigger("realm");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("cherga","Cherga ist die Göttin der Geister und der Unterwelt. Diese Untoten haben wahrscheinlich noch ein bestimmte Aufgabe zu erfüllen. Erst dann werden ihre Seelen Frieden finden.");
    autonpcfunctions.AddAdditionalTrigger("reich");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("soul","These souls can only find peace when they have fulfilled their task.");
    autonpcfunctions.AddAdditionalTrigger("peace");
    autonpcfunctions.AddTraderTrigger("seele","Jene Seelen können nur Frieden finden, wenn sie ihre Aufgabe erledigt haben.");
    autonpcfunctions.AddAdditionalTrigger("friede");
    autonpcfunctions.AddTraderTrigger("task","I don't know what task they have to do. Usually only the Gods know this. However some chosen ones - the guardians of the undead - are told to help them. They might know more.");
    autonpcfunctions.AddTraderTrigger("aufgabe","Ich weiß nicht, was für eine Aufgabe sie erledigen müssen. Normalerweise wissen das nur die Götter. Jedoch sind einige Auserwählte - die Hüter der Untoten - damit beauftragt, ihnen zu helfen. Diese wissen möglicherweise mehr.");
    autonpcfunctions.AddTraderTrigger("ladder","Yes, climb up that ladder. Just step on it and you'll be on the other side of the ladder.");
    autonpcfunctions.AddTraderTrigger("leiter","Ja, kletter diese Leiter hoch. Tret einfach darauf und du wirst am anderen Ende der leiter sein.");
    autonpcfunctions.AddTraderTrigger("findecano","Go to Findecano. He's waiting for you.");
    autonpcfunctions.AddAdditionalTrigger("castle");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("findecano","Geh zu Findecano. Er wartet auf dich.");
    autonpcfunctions.AddAdditionalTrigger("schlo[sß]");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCycleText("#me reibt sich die Hände.","#me rubs his hands.");
    autonpcfunctions.AddCycleText("#me schüttelt den Kopf 'Arme Kreaturen.'","#me shakes his head 'Poor creatures.'");
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

function M.lookAtNpc(Char, mode)
    if initLook==nil then
        output={};
        output[0]="Ein recht alter Mann, gehüllt in einen dunklen Mantel mit Kapuze, der mit trüben Augen zu den Kreaturen auf der anderen Seite der Höhle hinübersieht.";
        output[1]="A quite old man, covered in a dark hooded cloak, who looks with bleary eyes to the creatures on the other side of the cave.";
        initLook=1;
    end
    lang=Char:getPlayerLanguage();
    Char:sendCharDescription( thisNPC.id , output[lang] );
end

return M
