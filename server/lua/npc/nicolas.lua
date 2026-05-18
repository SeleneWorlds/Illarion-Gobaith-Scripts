local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-281, 40, 0,6,false,'Nicolas','npc_nicolas.lua',0);

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
-- QS=1: comes to npc
-- QS=2: got to find thief
QuestID=557;
    autonpcfunctions.AddTraderTrigger("schinken","Die Lieferung mit Schinken habe ich doch schon dem einarmigen Boten gegeben. Ist sie angekommen?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("schinken","Den Schinken für Marcus habe ich dem eigenartigen Boten gegeben.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("liefer","Die Lieferung mit Schinken habe ich doch schon dem einarmigen Boten gegeben. Ist sie angekommen?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("liefer","Den Schinken für Marcus habe ich dem eigenartigen Boten gegeben.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("ja","Sehr gut. Wie kann ich euch helfen?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("nein","Nicht? Wie kann das sein, dieser Bote wurde doch von Marcus geschickt, oder? Jedenfalls sagte er das. Er ist Richtung Westen gegangen.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("bote","Hm. Irgendwie kam er mir eigenartig vor, er kannte Marcus' Namen nicht. Und er wußte glaube ich auch nicht so recht, in welche Richtung er eigentlich sollte.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddTraderTrigger("dieb","Meint ihr, der Bote war ein Dieb? Irgendwie würde das wohl passen, stimmt.");
    autonpcfunctions.AddCondition("state",">",0);
    autonpcfunctions.AddTraderTrigger("marcus","Marcus ist ein Händler in Troll's Bane, ich sollte ihm zehn Stück Schinken liefern.");
    autonpcfunctions.AddCondition("qpg",">",0);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("westen","Ja. Dieser Bote ging nach Westen. Obwohl es doch nach Osten nach Trollsbane geht. Ich hoffe nur das war kein Dieb.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("ham","I gave the delivery with ham to a one-armed carrier already. Did it arrive?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("ham","I gave that ham for Marcus to that strange carrier he sent.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("deliver","I gave the delivery with ham to a one-armed carrier already. Did it arrive?");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("deliver","I gave that ham for Marcus to that strange carrier he sent.");
    autonpcfunctions.AddCondition("qpg","=",1);
    autonpcfunctions.AddTraderTrigger("yes","Very good. How can I help you?");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("no","It didn't? How could that happen, Marcus sent that carrier, didn't he?At least that's what he said. He left heading west.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddConsequence("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("carrier","Hm. Somehow he appeared a little bit strange to me, he didn't know Marcus' name. And it seemed as if he didn't know in which direction to go.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddTraderTrigger("thief","You believe that this carrier was a thief in reality? That would fit somehow, right.");
    autonpcfunctions.AddCondition("state",">",0);
    autonpcfunctions.AddTraderTrigger("marcus","Marcus is a trader in Troll's Bane. I should deliver ten pieces of ham to him.");
    autonpcfunctions.AddCondition("qpg",">",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("west","Yes. The carrier headed west. While Trollsbane is in the east. I hope this was no thief.");
    autonpcfunctions.AddCondition("qpg","=",2);
    autonpcfunctions.AddTraderTrigger("Hafen","Genau, das hier ist der Hafen. Ein netter Platz, wenn man den Ozean zu schätzen weiß!");
    autonpcfunctions.AddTraderTrigger("Harbo[u]*r","Exactly, this is the harbor. A nice spot if you like the ocean!");
    autonpcfunctions.AddTraderTrigger("I am","Greetings, %CHARNAME, nice to meet you.");
    autonpcfunctions.AddTraderTrigger("I'm","Greetings, %CHARNAME, nice to meet you.");
    autonpcfunctions.AddTraderTrigger("Ich bin","Seid gegrüßt, %CHARNAME, schön euch zu treffen.");
    autonpcfunctions.AddTraderTrigger("auf bald","Gehabt euch wohl!");
    autonpcfunctions.AddTraderTrigger("beruf","Ich bin Kapitän eines Handelsschiffes. Ich treibe Handel mit Troll's Bane und anderen Städten hier.");
    autonpcfunctions.AddTraderTrigger("buy","I don't buy anything.");
    autonpcfunctions.AddTraderTrigger("bye","Farewell!");
    autonpcfunctions.AddTraderTrigger("dein name","Ich heiße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("deine aufgabe","Ich bin Kapitän eines Handelsschiffes. Ich treibe Handel mit Troll's Bane und anderen Städten hier.");
    autonpcfunctions.AddTraderTrigger("eure aufgabe","Ich bin Kapitän eines Handelsschiffes. Ich treibe Handel mit Troll's Bane und anderen Städten hier.");
    autonpcfunctions.AddTraderTrigger("farewell","Farewell, thanks for visiting me!");
    autonpcfunctions.AddTraderTrigger("good day","Hello.");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Seid gegrüßt!");
    autonpcfunctions.AddTraderTrigger("greetings","Be greeted.");
    autonpcfunctions.AddTraderTrigger("greets","Be greeted.");
    autonpcfunctions.AddTraderTrigger("guten tag","Seid gegrüßt!");
    autonpcfunctions.AddTraderTrigger("hail","Be greeted.");
    autonpcfunctions.AddTraderTrigger("hallo","Seid gegrüßt!");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("hallo","Be greeted.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("helfen","Wenn du Hilfe brauchst, geh nach Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("hello","Be greeted.");
    autonpcfunctions.AddTraderTrigger("help","If you need help, visit Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("hilfe","Wenn du Hilfe brauchst, geh nach Troll's Bane.");
    autonpcfunctions.AddTraderTrigger("how are you","I am fine, thanks. How are you?");
    autonpcfunctions.AddTraderTrigger("job","I am just a simple farmer.");
    autonpcfunctions.AddTraderTrigger("kaufen","Ich kaufe nichts.");
    autonpcfunctions.AddTraderTrigger("mein name","Sehr angenehm.");
    autonpcfunctions.AddTraderTrigger("my name","Nice to meet you.");
    autonpcfunctions.AddTraderTrigger("sell","I don't sell anything");
    autonpcfunctions.AddTraderTrigger("verkaufen","Ich handle nicht.");
    autonpcfunctions.AddTraderTrigger("was kaufst","Ich handle nicht.");
    autonpcfunctions.AddTraderTrigger("was tust du","Ich warte auf Händler, die ihre Ware hier abholen.");
    autonpcfunctions.AddTraderTrigger("was tut ihr","Ich warte auf Händler, die ihre Ware hier abholen.");
    autonpcfunctions.AddTraderTrigger("was verkaufst","Ich handle nicht mit euch.");
    autonpcfunctions.AddTraderTrigger("wer seid","Ich bin %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("what buy","I don't trade with you.");
    autonpcfunctions.AddTraderTrigger("what sell","I don't trade with you.");
    autonpcfunctions.AddTraderTrigger("what you do","I wait for traders who pick up their wares here.");
    autonpcfunctions.AddTraderTrigger("who","I am %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("wie geht es","Danke, mir geht es gut.");
    autonpcfunctions.AddTraderTrigger("wie hei[sß]+t du","Ich heiße %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("you name","My name is %NPCNAME.");
    autonpcfunctions.AddTraderTrigger("you Nicolas","Indeed. I'm Nicolas. What can i do for you?");
    autonpcfunctions.AddTraderTrigger("du Nicolas","In der Tat. Ich bin Nicolas. Was kann ich für euch tun?");
    autonpcfunctions.AddTraderTrigger("ihr Nicolas","In der Tat. Ich bin Nicolas. Was kann ich für euch tun?");
    -- ********* END DYNAMIC PART ********
    TradSpeakLang={0,1};
    TradStdLang=0;
    
    autonpcfunctions.increaseLangSkill(TradSpeakLang)
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
