local M = {}

-- NPC by Sirius- (Forum: Das Auge)
-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-40,-95,0,0,false,'Aeron Ranthir','npc_aeron_ranthir.lua',0);

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

    -- Botenquest - Sender
    autonpcfunctions.SetRadius(10);
    autonpcfunctions.AddTraderTrigger("hallo","Ich grüße doch herzlich.");
    autonpcfunctions.AddTraderTrigger("grüße","Ich grüße doch herzlich.");
    autonpcfunctions.AddTraderTrigger("tach","Ich grüße doch herzlich.");
    autonpcfunctions.AddTraderTrigger("hiho","Ich grüße doch herzlich.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("hello","Greetings, my friend.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("greetings","Greetings, my friend.");
    autonpcfunctions.AddTraderTrigger("hiho","Greetings, my friend.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("greets","Greetings, my friend.");
    autonpcfunctions.AddTraderTrigger("wer bist","Mich nennt man %NPCNAME, aber nun lenkt mich nicht ab, ich suche jemanden der mir helfen kann.");
    autonpcfunctions.AddTraderTrigger("wer seid","Mich nennt man %NPCNAME, aber nun lenkt mich nicht ab, ich suche jemanden der mir helfen kann.");
    autonpcfunctions.AddTraderTrigger("who are you","My name is %NPCNAME. Are you by any chance looking for work?");
    autonpcfunctions.AddTraderTrigger("ich bin","Freut mich, Euch kennen zu lernen. Sucht Ihr nach Arbeit?");
    autonpcfunctions.AddTraderTrigger("man nennt mich","Freut mich, Euch kennen zu lernen. Suchst Ihr nach Arbeit?");
    autonpcfunctions.AddTraderTrigger("i am","Nice to meet you. Are you looking for work?");
    autonpcfunctions.AddTraderTrigger("auf bald","Wir werden uns sehen. Mögest du von Eldan begleitet werden.");
    autonpcfunctions.AddTraderTrigger("bis dann","Wir werden uns sehen. Mögest du von Eldan begleitet werden.");
    autonpcfunctions.AddTraderTrigger("bis bald","Wir werden uns sehen. Mögest du von Eldan begleitet werden.");
    autonpcfunctions.AddTraderTrigger("gehabt euch wohl","Wir werden uns sehen. Mögest du von Eldan begleitet werden.");
    autonpcfunctions.AddTraderTrigger("gehabet euch wohl","Wir werden uns sehen. Mögest du von Eldan begleitet werden.");
    autonpcfunctions.AddTraderTrigger("bye","We will see. Eldan with you!");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("farewell","We will see. May Eldan be with you!");
    autonpcfunctions.AddTraderTrigger("how are you","Well, I'm looking for someone who can help me.");
    autonpcfunctions.AddTraderTrigger("wie geht","Mir? Nunja, ich suche jemanden der mir helfen kann, aber sonst ganz gut, danke.");
    autonpcfunctions.AddTraderTrigger("was verkaufst","Ich verkaufe nichts");
    autonpcfunctions.AddTraderTrigger("was verkauft","Ich verkaufe nichts");
    autonpcfunctions.AddTraderTrigger("list wares"," I sell nothing.");
    autonpcfunctions.AddTraderTrigger("sell"," I sell nothing.");
    autonpcfunctions.AddTraderTrigger("was kaufst","Ich kaufe nichts.");
    autonpcfunctions.AddTraderTrigger("was kauft","Ich kaufe nichts.");
    autonpcfunctions.AddTraderTrigger("buy","I'm not a merchant.");
    autonpcfunctions.AddTraderTrigger("helfen","Natürlich, ich brauche immer Hilfe! Könnt ihr dieses Pergament zu Silya Terelorn nach Varshikar bringen?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("hilfe","Natürlich, ich brauche immer Hilfe! Könnt ihr dieses Pergament zu Silya Terelorn nach Varshikar bringen?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("arbeit","Natürlich, ich brauche immer Hilfe! Könnt ihr dieses Pergament zu Silya Terelorn nach Varshikar bringen?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("help","Sure, can you take this parchment to Silya Terelorn in Varshikar?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("work","Sure, can you take this parchment to Silya Terelorn in Varshikar?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("ja","Vielen Dank. Ich würde ja selbst nach Varshikar gehen, jedoch bin ich zurzeit viel zu sehr beschäftigt.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("item",3109,1,333,2);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("yes","Thank you. I would go there by myself, but I am too busy currently.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("item",3109,1,333,2);
    autonpcfunctions.AddConsequence("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("arbeit","Ah, du hast den Brief überliefert? Vielen Dank. Hier, deine Belohnung.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("item",399,2,333,0);
    autonpcfunctions.AddConsequence("item",2851,20,333,0);
    autonpcfunctions.AddTraderTrigger("job","Ah, you've given her the message? Thank you. Here is your payment.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("item",399,2,333,0);
    autonpcfunctions.AddConsequence("item",2851,20,333,0);
    autonpcfunctions.AddTraderTrigger("work","Ah, you've given her the message? Thank you. Here is your payment.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddConsequence("item",399,2,333,0);
    autonpcfunctions.AddConsequence("item",2851,20,333,0);
    autonpcfunctions.AddCycleText("#me blickt sich um, er scheint nach jemandem zu suchen.","#me looks around, he seems to be looking for someone.");
    autonpcfunctions.AddCycleText("#me holt einige Pergamente heraus, notiert etwas und legt sie wieder in seine Tasche.","#me takes out a couple of parchments, scribbles down some notes and puts the parchments back into his bag.");
    autonpcfunctions.AddCycleText("#me streicht sich mit einer Feder am Kopf, als würde er ?berlegen.","#me strokes his forehead with a quill, lost in thought.");
    autonpcfunctions.AddCycleText("#me streicht wild etwas auf einem Pergament durch.","#me furiously crosses out something he has written.");
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
