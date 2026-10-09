local M = {}

-- INSERT INTO npc VALUES (nextval('npc_seq'),0,-54,-218,0,2,false,'Artoss Ishem','npc_artoss_ishem.lua',0);

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

    autonpcfunctions.SetRadius(0);
    autonpcfunctions.AddCycleText("#me richtet seine Rüstung.","#me adjusts his armor.");
    autonpcfunctions.AddCycleText("#me poliert seine Rüstung mit einem sauberen Tuch.","#me polishes his armor with a clean cloth.");
    autonpcfunctions.AddCycleText("#me beißt in einen Apfel.","#me bites into an apple.");
    autonpcfunctions.AddCycleText("Willkommen in der Grauen Zuflucht!","Welcome to the Grey Refuge!");
    autonpcfunctions.AddCycleText("#me blickt sich mit wachsamen Augen um.","#me looks around with an observant gaze.");
    autonpcfunctions.AddCycleText("#me strafft seine Schultern.","#me squares his shoulders.");
    autonpcfunctions.AddCycleText("#me gähnt verhalten.","#me yawns retained.");
    autonpcfunctions.AddCycleText("#mes Rüstung strahlt vor glanz.","#mes armor is shining of brightness.");
    autonpcfunctions.AddCycleText("#me kämmt gepflegt sein Haar.","#me combs his hair.");
    
    autonpcfunctions.AddTraderTrigger("Hallo","Ich grüße euch.");
    autonpcfunctions.AddAdditionalTrigger("Grüße");
    autonpcfunctions.AddAdditionalTrigger("Seid gegrüßt");
    autonpcfunctions.AddAdditionalTrigger("Guten Tag");
    autonpcfunctions.AddAdditionalTrigger("Tag");
    autonpcfunctions.AddAdditionalTrigger("Moin");
    autonpcfunctions.AddAdditionalText("Guten Tag.");
    autonpcfunctions.AddAdditionalText("Seid gegrüßt");
    autonpcfunctions.AddTraderTrigger("Wer seid ihr?","Ich bin Artoss Ishem, Ritter der Grauen Rose.");
    autonpcfunctions.AddAdditionalTrigger("Wer bist du?");
    autonpcfunctions.AddTraderTrigger("Wo bin ich?","Ihr befindet euch bei der Grauen Zuflucht.");
    autonpcfunctions.AddAdditionalTrigger("Was ist das hier?");
    autonpcfunctions.AddAdditionalText("Das ist die Graue Zuflucht");
    autonpcfunctions.AddAdditionalText("Das ist die Graue Zuflucht, Heimat der Ritter der Grauen Rose!");
    autonpcfunctions.AddTraderTrigger("Was macht ihr?","Ich stehe hier Wache.");
    autonpcfunctions.AddTraderTrigger("Was verkaufst du?","Ich verkaufe nichts, tut mir leid. Sam verkauft etwas in der Burg.");
    autonpcfunctions.AddAdditionalTrigger("Was verkauft ihr?");
    autonpcfunctions.AddAdditionalText("Geht zu Sam.");
    autonpcfunctions.AddAdditionalText("Ich verkaufe nichts.");
    autonpcfunctions.AddTraderTrigger("Sam","Sam ist ein einfacher Händler hier in der Burg. Er verkauft Kleidung, Werkzeuge, Kerzen und Lampenöl.");
    autonpcfunctions.AddAdditionalTrigger("Wer ist Sam?");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Wo ist die Nordmark?","Die Nordmark findet ihr wenn ihr von hier aus nach Westen geht. Sobald ihr am Meer angekommen seid, geht nach Norden. Passt aber auf, die haben harte Gesetze.");
    autonpcfunctions.AddAdditionalTrigger("Nordmark");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Wo ist Trolls Bane?","Troll's Bane ist leicht zu finden. Ihr folgt den Weg einfach über die südliche Brücke. Dort den Weg folgen und schon steht ihr vor den Stadtmauern. Seid aber auf der Hut! Es gibt dort viele Kriminelle!");
    autonpcfunctions.AddAdditionalTrigger("Trolls Bane");
    autonpcfunctions.AddAdditionalTrigger("Bane");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Wo ist Greenbriar?","Oh. Wenn ihr nach Greenbriar wollt seid ihr hier falsch. Am besten folgt ihr dem Weg südlich nach Troll's Bane. Von dort aus geht ihr weiterhin südlich zur Union. Dort angekommen lauft ihr gen Westen, vorbei an dem Hafen, bis zu einer Brücke. Dort geht ihr rüber und dann nach Süden. Die Halblinge sind immer freundlich. Dort lässt es sich leben.");
    autonpcfunctions.AddAdditionalTrigger("Greenbriar");
    autonpcfunctions.AddAdditionalTrigger("Briar");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Wo ist Varshikar?","Die Wüstenstadt findet ihr wenn ihr von hier aus nach Troll's Bane lauft. Von dort aus den Weg vorbei an Garon's Werkstatt immer nach Osten den Weg folgen. Es ist sehr heiß dort aber man hat nette Gesellschaft! Und passt auf, in der nähe hausen Orks!");
    autonpcfunctions.AddAdditionalTrigger("Varshikar");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Wo ist Silberbrand?","Zu den zwergen kommt ihr am schnellsten wenn ihr die Brücke überquert und dann dem Fairy Tear's nach Osten folgt. Die Zwerge sind manchmal richtig mürrisch. Aber ihr Bier ist das Beste weit und breit!");
    autonpcfunctions.AddAdditionalTrigger("Silberbrand");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Hilfe","[Spielhilfe] Dies ist ein NPC welcher dir etwas über die Graue Rose erzählen kann. Außerdem kann er dir sagen wo du verschiedene Städte findest.");
    autonpcfunctions.AddTraderTrigger("Was ist die Graue Rose?","Die Grause Rose ist der älteste Ritterzirkel auf Gobaith. Er besteht in der Regel aus dem hohen Zirkel, den Rittern und dem Gefolge. Die Graue Rose ist stets nach Gleichgewicht bestrebt und nimmt gerne neues Gefolge auf.");
    autonpcfunctions.AddAdditionalTrigger("Graue Rose");
    autonpcfunctions.AddAdditionalTrigger("Rose");
    autonpcfunctions.AddAdditionalTrigger("Graue Zuflucht");
    autonpcfunctions.AddCondition("lang","german");
    autonpcfunctions.AddTraderTrigger("Hello","Be greeted!");
    autonpcfunctions.AddAdditionalTrigger("Greetings");
    autonpcfunctions.AddAdditionalTrigger("Be greeted");
    autonpcfunctions.AddAdditionalTrigger("Good day");
    autonpcfunctions.AddAdditionalText("Good day.");
    autonpcfunctions.AddAdditionalText("I greet you.");
    autonpcfunctions.AddTraderTrigger("Who are you?","I am Artoss Ishem, Knight of the Grey Rose.");
    autonpcfunctions.AddTraderTrigger("Where am I?","You are at the Grey Refuge.");
    autonpcfunctions.AddAdditionalTrigger("What is this?");
    autonpcfunctions.AddAdditionalText("This is the Grey Refuge.");
    autonpcfunctions.AddAdditionalText(" This is the Grey Refuge, home of the knights of the Grey Rose.");
    autonpcfunctions.AddTraderTrigger("What are you doing?","I am guarding.");
    autonpcfunctions.AddTraderTrigger("What do you sell?","I don't sell anything. Ask Sam in the castle.");
    autonpcfunctions.AddAdditionalText("Go to Sam.");
    autonpcfunctions.AddAdditionalText("I don't sell anything.");
    autonpcfunctions.AddTraderTrigger("Who ist Sam?","Sam is a simply merchant in the castle. There you can buy clothes, tools, candles and lampoil.");
    autonpcfunctions.AddAdditionalTrigger("Sam");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Where is the Nordmark?","You'll find the Nordmark if you go west. Once you reach the sea walk north. But beware, they have hard laws.");
    autonpcfunctions.AddAdditionalTrigger("Nordmark");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Where is Trolls Bane?","Troll's Bane is easy to find. Just follow the path over the bridge. Follow the path south and you already see the town walls.");
    autonpcfunctions.AddAdditionalTrigger("Trolls Bane");
    autonpcfunctions.AddAdditionalTrigger("Bane");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Where is Greenbriar?","Oh. If you want to go to Greenbriar, you're totally wrong here. The best way is that you first go to Troll's Bane. From there you have to go south to the union. At the union you have to go west, pass the habor and walk over the bridge. From there just go south. The halflings are always friendly and it is a good place to live.");
    autonpcfunctions.AddAdditionalTrigger("Greenbriar");
    autonpcfunctions.AddAdditionalTrigger("Briar");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Where is Varshikar?","You'll find the desert town if you go to Troll's Bane and turn east. Pass Garon's workshop and follow the way east. It is very hot there but you'll find some nice people. And pay attention, in the mountains are some strong creatures!");
    autonpcfunctions.AddAdditionalTrigger("Varshikar");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Where is Silverbrand?","The fastest way to the dwarves is if you pass the bridge and follow the Fairy Tear's on the other side of the river. Sometime the dwarfs are grumbly but their beer is the best on Gobaith!");
    autonpcfunctions.AddAdditionalTrigger("Silverbrand");
    autonpcfunctions.AddAdditionalTrigger("Silberbrand");
    autonpcfunctions.AddCondition("lang","english");
    autonpcfunctions.AddTraderTrigger("Help","[Gamehelp] This is an NPC who can tell you something about the Grey Rose and where you can find the other towns.");
    autonpcfunctions.AddTraderTrigger("What is the Grey Rose?","The Grey Rose is the oldest knight circle on Gobaith. Usually it consists of the high circle, the knights and the following. The Grey Rose is always striving for balance on Gobaith and is always looking for followers.");
    autonpcfunctions.AddAdditionalTrigger("Grey Rose");
    autonpcfunctions.AddAdditionalTrigger("Rose");
    autonpcfunctions.AddAdditionalTrigger("Grey Refuge");
    autonpcfunctions.AddCondition("lang","english");
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
