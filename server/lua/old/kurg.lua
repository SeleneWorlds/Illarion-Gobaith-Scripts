local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),4,183,-447,1,4,false,'Kurg','npc_kurg.lua',0);

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

    -- Kurg the butcher
    autonpcfunctions.AddTraderTrigger(" ","Tut mir leid, ich bin beschäftigt. Warte bitte einen Moment bis ich mein Gespräch beendet habe.");
    autonpcfunctions.AddCondition("idlestate","busy");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger(" ","Meh sorry, but meh busy at da moment. Wait till meh finished meh speech?");
    autonpcfunctions.AddCondition("idlestate","busy");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("gr[üue]+[sß]+e","Schön dich zu sehen! Wie gehts dir?  Ich bin Kurg der Metzger. Wie kann ich Ihnen helfen?");
    autonpcfunctions.AddAdditionalTrigger("Hallo");
    autonpcfunctions.AddAdditionalTrigger("Guten Tag");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("greetings","Greebas! How are joo?  Meh is Kurg da Butcher.  How may meh help joo?");
    autonpcfunctions.AddAdditionalTrigger("hello");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("was verkaufe","Ich verkaufe alle Arten von Fleisch: Kaninchen, Lamm, Rehe und Schweinefleisch für nur 2 Kupfer jeder. Schinken, Steak und Würste kosten 3 jeder.");
    autonpcfunctions.AddTraderTrigger("what sell","Meh sells all kinds ob meats: Rabbit, Lamb, Deer and Pork for only 2 coppers each.  Ham, Steak and sausages cost 3 each.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("was kaufe","Ich kaufe alle Arten von Fleisch: Kaninchen, Lamm, Rehe und Schweinefleisch für nur 1 Kupfer jeder. Schinken, Steak und Würste sind 2 jeder wert.");
    autonpcfunctions.AddTraderTrigger("what buy","Meh buys all kinds ob meats: Rabbit, Lamb, Deer and Pork for only 1 copper each.  Ham, Steak and Sausages are worth 2 each.");
    autonpcfunctions.AddCondition("lang","english");
    -- selling section
    autonpcfunctions.AddTraderTrigger("verkaufe kaninchen"," Ausgezeichnet, ist hier eine Münze für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",553,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",553,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell rabbit","Wunderful, here beh a coin for joor trubble.");
    autonpcfunctions.AddCondition("item",553,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",553,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe lamm"," Ausgezeichnet, ist hier eine Münze für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",2934,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",2934,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell Lamb","Wunderful, here beh a coin for joor trubble.");
    autonpcfunctions.AddCondition("item",2934,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",2934,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe rehe"," Ausgezeichnet, ist hier eine Münze für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",552,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",552,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell deer","Wunderful, here beh a coin for joor trubble.");
    autonpcfunctions.AddCondition("item",552,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",552,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe schweinefleisch"," Ausgezeichnet, ist hier eine Münze für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",307,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",307,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell pork","Wunderful, here beh a coin for joor trubble.");
    autonpcfunctions.AddCondition("item",307,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",307,1);
    autonpcfunctions.AddConsequence("money","+",1);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe schinken"," Ausgezeichnet, ist hier 2 Münzen für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",306,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",306,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell ham","Wunderful, here beh 2 coins for joor trubble.");
    autonpcfunctions.AddCondition("item",306,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",306,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe steak"," Ausgezeichnet, ist hier 2 Münzen für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",2940,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",2940,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell steak"," Wunderful, here beh 2 coins for joor trubble.");
    autonpcfunctions.AddCondition("item",2940,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",2940,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("verkaufe würste"," Ausgezeichnet, ist hier 2 Münzen für Ihre Schwierigkeiten.");
    autonpcfunctions.AddCondition("item",3051,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("deleteitem",3051,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("sell sausage"," Wunderful, here beh 2 coins for joor trubble.");
    autonpcfunctions.AddCondition("item",3051,"belt",">=",1);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("deleteitem",3051,1);
    autonpcfunctions.AddConsequence("money","+",2);
    autonpcfunctions.AddConsequence("talk","end");
    -- buying section
    autonpcfunctions.AddTraderTrigger("kaufe"," Kommen Sie zurück, wenn Sie etwas gewähren können!");
    autonpcfunctions.AddCondition("money","=",0);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy","Cum Back when joo can afford sumding!");
    autonpcfunctions.AddCondition("money","=",0);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe kaninchen","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",553,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy rabbit","Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",553,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe lamm","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",2934,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy lamb"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",2934,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe rehe","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",552,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy deer"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",552,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe schweinefleisch","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",307,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy pork"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",2);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",307,1,333,0);
    autonpcfunctions.AddConsequence("money","-",2);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe schinken","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",306,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy ham"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",306,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe steak","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",2940,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy steak"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",2940,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("kaufe würste","Ausgezeichnet, ist hier ein auserlesenes Stück von Fleisch.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("item",3051,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("buy sausage"," Wunderful, here beh a gud piece ob meat.");
    autonpcfunctions.AddCondition("money",">=",3);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("item",3051,1,333,0);
    autonpcfunctions.AddConsequence("money","-",3);
    autonpcfunctions.AddConsequence("talk","end");
    autonpcfunctions.AddTraderTrigger("auf bald","Bis bald!");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("tschüss");
    autonpcfunctions.AddTraderTrigger("farewell","Farrebas!");
    autonpcfunctions.AddAdditionalTrigger("bye");
    autonpcfunctions.AddAdditionalTrigger("good day");
    autonpcfunctions.AddCycleText("#me sieht sich für Kunden um","#me looks around for customers");
    autonpcfunctions.AddCycleText("#me haut etwas Fleisch ab und hängt es ","#me chops up some meat and hangs it");
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
