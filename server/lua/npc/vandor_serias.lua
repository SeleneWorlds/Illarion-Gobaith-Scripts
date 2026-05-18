local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,169,108,100,2,false,'Vandor Serias','npc_vandor_serias.lua',0);

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

    -- general
    -- small talk
    autonpcfunctions.AddTraderTrigger("Hallo","Grüße, mein Freund. Wenn du etwas übers Glasblasen lernen willst, bist du bei mir genau richtig.");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("Hey");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddAdditionalText("Seid gegrüßt. Wenn du etwas übers Glasblasen lernen willst, bist du bei mir genau richtig.");
    autonpcfunctions.AddTraderTrigger("hello","Greetings, my friend. If you want to learn something about glass blowing, then I am the right man.");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("hey");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",0);
    autonpcfunctions.AddAdditionalText("Be greeted. If you want to learn something about glass blowing, then I am the right man.");
    autonpcfunctions.AddTraderTrigger("Hallo","Grüße, mein Freund. Wo waren wir gerade...?");
    autonpcfunctions.AddAdditionalTrigger("gr[üu][sß]");
    autonpcfunctions.AddAdditionalTrigger("Hey");
    autonpcfunctions.AddAdditionalTrigger("grue[sß]");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state",">",0);
    autonpcfunctions.AddAdditionalText("Sei gegrüßt. Wo waren wir gerade...?");
    autonpcfunctions.AddTraderTrigger("hello","Greetings, my friend. Where were we...?");
    autonpcfunctions.AddAdditionalTrigger("greet");
    autonpcfunctions.AddAdditionalTrigger("hey");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state",">",0);
    autonpcfunctions.AddAdditionalText("Be greeted. Where were we...?");
    autonpcfunctions.AddTraderTrigger("mein name ist","Freut mich euch kennen zulernen. Ich bin "..thisNPC.name..".");
    autonpcfunctions.AddAdditionalTrigger("ich bin");
    autonpcfunctions.AddTraderTrigger("my name is","Nice to meet you. I am "..thisNPC.name..".");
    autonpcfunctions.AddAdditionalTrigger("i am");
    autonpcfunctions.AddAdditionalTrigger("i'm");
    autonpcfunctions.AddTraderTrigger("wie ist dein name","Ich bin der Glasbläser "..thisNPC.name..".");
    autonpcfunctions.AddAdditionalTrigger("wie ist euer name");
    autonpcfunctions.AddAdditionalTrigger("wie hei[sß]t");
    autonpcfunctions.AddAdditionalText("Ich heiße "..thisNPC.name..".");
    autonpcfunctions.AddTraderTrigger("what is your name","I am the glassblower "..thisNPC.name..".");
    autonpcfunctions.AddAdditionalTrigger("what's your name");
    autonpcfunctions.AddAdditionalTrigger("who are you");
    autonpcfunctions.AddAdditionalText("I am "..thisNPC.name..".");
    autonpcfunctions.AddTraderTrigger("dein beruf","Ich bin Glasbläser.");
    autonpcfunctions.AddAdditionalTrigger("deine aufgabe");
    autonpcfunctions.AddAdditionalTrigger("euer beruf");
    autonpcfunctions.AddAdditionalTrigger("eure aufgabe");
    autonpcfunctions.AddAdditionalTrigger("was machst du");
    autonpcfunctions.AddAdditionalTrigger("was tust du");
    autonpcfunctions.AddAdditionalText("Ich fertige Flaschen an.");
    autonpcfunctions.AddTraderTrigger("your job","I am a glassblower.");
    autonpcfunctions.AddAdditionalTrigger("what do you do");
    autonpcfunctions.AddAdditionalTrigger("your profession");
    autonpcfunctions.AddAdditionalTrigger("what are you doing");
    autonpcfunctions.AddAdditionalText("I make bottels.");
    autonpcfunctions.AddTraderTrigger("was verkauf","Ich verkaufe nichts. Aber ich kann dir das Glasblasen beibringen.");
    autonpcfunctions.AddTraderTrigger("was kauf","Ich kaufe nichts. Aber ich kann dir das Glasblasen beibringen.");
    autonpcfunctions.AddTraderTrigger("what sell","I sell nothing. But I can teach you how to make glass.");
    autonpcfunctions.AddTraderTrigger("What buy","I buy nothing. But I can teach you how to make glass.");
    autonpcfunctions.AddTraderTrigger("bye","Be well.");
    autonpcfunctions.AddAdditionalTrigger("farewell");
    autonpcfunctions.AddAdditionalTrigger("be well");
    autonpcfunctions.AddAdditionalText("Farewell.");
    autonpcfunctions.AddAdditionalText("Good bye.");
    autonpcfunctions.AddTraderTrigger("auf bald","Auf bald.");
    autonpcfunctions.AddAdditionalTrigger("bis bald");
    autonpcfunctions.AddAdditionalTrigger("leb wohl");
    autonpcfunctions.AddAdditionalTrigger("tsch[üu][ßs]");
    autonpcfunctions.AddAdditionalTrigger("mach gut");
    autonpcfunctions.AddAdditionalText("Bis bald.");
    autonpcfunctions.AddAdditionalText("Lebt wohl.");
    -- start teaching
    autonpcfunctions.AddTraderTrigger("glasbläserei","Oh ja, damit kenn' ich mich aus. Soll ich dich in die Kunst des Glasblasens einweihen?");
    autonpcfunctions.AddAdditionalTrigger("glas blasen");
    autonpcfunctions.AddAdditionalTrigger("glasblasen");
    autonpcfunctions.AddAdditionalText("Ich kann dir das Glasblasen beibringen. Möchtest du das?");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("bei bringen","Ich kann dir das Glasblasen beibringen. Möchtest du das?");
    autonpcfunctions.AddAdditionalTrigger("beibringen");
    autonpcfunctions.AddAdditionalTrigger("zeigen");
    autonpcfunctions.AddAdditionalTrigger("lern");
    autonpcfunctions.AddAdditionalTrigger("hilfe");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("aufgabe","Eine Aufgabe für dich habe ich nicht, doch kann ich dir das Glasblasen zeigen. Willst du das?");
    autonpcfunctions.AddAdditionalTrigger("quest");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("glass blow","Oh yes, glassblowing is my business. Shall I show you how to do it?");
    autonpcfunctions.AddAdditionalTrigger("glassblow");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("teach","Do you want me to teach you how to blow glass?");
    autonpcfunctions.AddAdditionalTrigger("show");
    autonpcfunctions.AddAdditionalTrigger("learn");
    autonpcfunctions.AddAdditionalTrigger("help");
    autonpcfunctions.AddConsequence("state","=",1);
    autonpcfunctions.AddTraderTrigger("mission","I have no task for you, but I can show you how to blow glass. Do you want it?");
    autonpcfunctions.AddAdditionalTrigger("task");
    autonpcfunctions.AddAdditionalTrigger("quest");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddConsequence("state","=",1);
    -- STATE 1
    autonpcfunctions.AddTraderTrigger("nein","Nagut, dann komm einfach wieder, wenn du es willst.");
    autonpcfunctions.AddAdditionalTrigger("nicht");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("no","Well, then come back when you want to learn it.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger("ja","Dann gebe ich dir erstmal alles was du brauchst. Packe den Sand und die Pottasche in deinen Gürtel und halte das Glasblasrohr in der Hand. Nun gehe zum Glasschmelzofen und 'benutze' ihn, um Glasblöcke herzustellen. Komm wieder, wenn du mindestens einen Glasblock hast.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("item",316,10,333,0);
    autonpcfunctions.AddConsequence("item",314,10,333,0);
    autonpcfunctions.AddConsequence("item",311,1,999,0);
    autonpcfunctions.AddConsequence("state","=",2);
    autonpcfunctions.AddTraderTrigger("yes","Then I will give you everything you need. Put the sand and the pott ash in the belt and hold the glass blow pipe in your hand. Then go to the glass melting oven and 'use' it in order to make glass ingots. Come again, when you have at least one ingot.");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddConsequence("item",316,10,333,0);
    autonpcfunctions.AddConsequence("item",314,10,333,0);
    autonpcfunctions.AddConsequence("item",311,1,999,0);
    autonpcfunctions.AddConsequence("state","=",2);
    -- STATE 2
    autonpcfunctions.AddTraderTrigger("asche","Du hast ja gar keine Pottasche mehr! Na dann, hier hast du noch welche.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("item",314,"all","=",0);
    autonpcfunctions.AddConsequence("item",314,5,333,0);
    autonpcfunctions.AddTraderTrigger("ash","You don't have any ash any more! Well then, here is some more.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("item",314,"all","=",0);
    autonpcfunctions.AddConsequence("item",314,5,333,0);
    autonpcfunctions.AddTraderTrigger("sand","Du hast ja gar keinen Sand mehr! Na dann, hier hast du noch welchen.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("item",316,"all","=",0);
    autonpcfunctions.AddConsequence("item",316,5,333,0);
    autonpcfunctions.AddTraderTrigger("sand","You don't have any sand any more! Well then, here is some more.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("item",314,"all","=",0);
    autonpcfunctions.AddConsequence("item",316,5,333,0);
    autonpcfunctions.AddTraderTrigger("rohr","Du hast ja gar kein Glasblasrohr mehr! Na dann, hier hast du noch eines.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("item",311,"all","=",0);
    autonpcfunctions.AddConsequence("item",311,1,999,0);
    autonpcfunctions.AddTraderTrigger("pipe","You don't have a glass blowing pipe any more! Well then, here is one more.");
    autonpcfunctions.AddCondition("state",">",1);
    autonpcfunctions.AddCondition("item",311,"all","=",0);
    autonpcfunctions.AddConsequence("item",311,1,999,0);
    -- STATE 3
    autonpcfunctions.AddTraderTrigger("bl[öo]ck","Du hast ja gar keinen Glasblock mehr! Na dann, hier hast du noch welche.");
    autonpcfunctions.AddAdditionalTrigger("bloeck");
    autonpcfunctions.AddCondition("state",">",2);
    autonpcfunctions.AddCondition("item",41,"all","=",0);
    autonpcfunctions.AddConsequence("item",41,5,333,0);
    autonpcfunctions.AddTraderTrigger("ingot","You don't have any glass ingots any more! Well then, here are some more.");
    autonpcfunctions.AddCondition("state",">",2);
    autonpcfunctions.AddCondition("item",41,"all","=",0);
    autonpcfunctions.AddConsequence("item",41,5,333,0);
    autonpcfunctions.AddCondition("state",">",2);
    autonpcfunctions.AddTraderTrigger("ingot","Glass ingots are a necessity for glass blowing. You just need pott ash, sand and a glass melting oven to produce them. If you have no ingots any more and you want to continue, I can give you a couple.");
    autonpcfunctions.AddCondition("state",">",2);
    -- last catch
    -- STATE 1
    autonpcfunctions.AddTraderTrigger(".+","Ich habe gefragt, ob ich dir das Glasblasen beibringen soll. Ja oder nein?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("state","=",1);
    autonpcfunctions.AddTraderTrigger(".+","I've asked if I shall teach you how to make glass. Yes or no?");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("state","=",1);
    -- STATE 2
    autonpcfunctions.AddTraderTrigger(".+","Du hast es hinbekommen, sehr gut. Dann gehen wir einen Schritt weiter. Lass das Glasblasrohr in der Hand, die Glasblöcke bleiben am Gürtel. Gehe wieder zum Glasschmelzofen und 'benutze' diesmal das Glasblasrohr und wähle dann die kleine leere Flasche, um diese herzustellen. Komm wieder, wenn du mindestens eine kleine leere Flasche hast.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("item",41,"all",">",0);
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddTraderTrigger(".+","You did it, very good. Now we come to the next step. Keep the glass blowing pipe in your hand and the glass ingots at your belt. Now go back to the glass melting oven and 'use' the glass blow pipe and then choose the small empty bottle in order to produce it. Come again when you have at least one small empty bottle.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("item",41,"all",">",0);
    autonpcfunctions.AddConsequence("state","=",3);
    autonpcfunctions.AddTraderTrigger(".+","Packe den Sand und die Pottasche in deinen Gürtel und halte das Glasblasrohr in deiner Hand. Nun gehe zum Glasschmelzofen und 'benutze' ihn, um Glasblöcke herzustellen. Komm wieder, wenn du mindestens einen Glasblock hast.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger(".+","Put the sand and the pott ash in the belt and hold the glass blow pipe in your hand. Then go to the glass melting oven and 'use' it in order to make glass ingots. Come again, when you have at least one ingot.");
    autonpcfunctions.AddCondition("state","=",2);
    autonpcfunctions.AddCondition("lang","english");
    -- STATE 3
    autonpcfunctions.AddTraderTrigger(".+","Du hast es hinbekommen, wunderbar! Mehr brauchst du auch nicht zu wissen, der Rest kommt mit der Übung. Viel Glück und auf bald!");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddCondition("item",1317,"all",">",0);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger(".+","You did it, great! I can't teach you anything anymore, you will learn the rest by practising. Good luck and farewell!");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddCondition("item",1317,"all",">",0);
    autonpcfunctions.AddConsequence("state","=",0);
    autonpcfunctions.AddTraderTrigger(".+","Lass das Glasblasrohr in der Hand, die Glasblöcke bleiben am Gürtel. Gehe wieder zum Glasschmelzofen und 'benutze' diesmal das Glasblasrohr und wähle dann die kleine leere Flasche, um diese herzustellen. Komm wieder, wenn du mindestens eine kleine leere Flasche hast.");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger(".+","Keep the glass blowing pipe in your hand and the glass ingots at your belt. Now go back to the glass melting oven and 'use' the glass blow pipe and then choose the small empty bottle in order to produce it. Come again when you have at least one small empty bottle.");
    autonpcfunctions.AddCondition("state","=",3);
    autonpcfunctions.AddCondition("lang","english");

    -- standard explanations
    autonpcfunctions.AddTraderTrigger("asche","Pottasche bleibt nach einem Feuer übrig, wenn es ausgebrannt ist. Aber lösch es nicht mit Wasser, denn dann gibt's auch keine Pottasche!");
    autonpcfunctions.AddTraderTrigger("ash","When a fire has burnt out, you can find pott ash as leftover. But don't extinguish it with water, because you won't get any pott ash this way!");
    autonpcfunctions.AddTraderTrigger("sand","Ich denke, man muss in der Wüste nach groben Sand graben und diesen dann sieben, um den Sand zu erhalten, den wir zum Glasblasen brauchen.");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("sand","I think one has to dig in the desert for coarse sand and then sieve it in order to get the sand we need for glass blowing.");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("bl[öo]ck","Glasblöcke sind die Grundlage für das Glasblasen. Du brauchst nur Pottasche, Sand, ein Glasblasrohr und einen Glasschmelzofen, um welche herzustellen.");
    autonpcfunctions.AddAdditionalTrigger("bloeck");
    autonpcfunctions.AddTraderTrigger("ingot","Glass ingots are a necessity for glass blowing. You just need pott ash, sand, a glass blowing pipe and a glass melting oven to produce them.");
    autonpcfunctions.AddTraderTrigger("rohr","Man braucht ein Glasblasrohr, um Glasblöcke und schließlich alle Glaswaren herzustellen. Ein guter Schmied kann wohl ein Glasblasrohr anfertigen.");
    autonpcfunctions.AddTraderTrigger("pipe","One needs a glass blowing pipe in order to produce glass ingots and finally glass goods. A good smith an surely make a glass blowing pipe.");
    autonpcfunctions.AddTraderTrigger("ofen","Für jeden Schritt braucht man einen Glasschmelzofen. Das ist das große Teil aus Ziegeln da drüben. Jede größere Stadt hat einen. Aber ich hab gleich zwei auf einmal!");
    autonpcfunctions.AddTraderTrigger("oven","For each step one needs a glass melting oven. It is this huge thing over there made of bricks. Every major town has one. But I have two at once!");
    
    -- cycle texts
    autonpcfunctions.AddCycleText("#me dreht ein Glasblasrohr in seiner rechten Hand.","#me turns a glass blow pipe in his right hand.");
    autonpcfunctions.AddCycleText("#me betrachtet eine Flasche in seinen Händen: 'Schönes und klares Glas. So soll es sein!'","#me examines a bottle in his hands: 'Nice and clear glass. This is how it should be!'");
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
